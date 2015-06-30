Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F11251A0FFE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 04:57:57 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7886514030A
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2015 04:57:56 +1000 (AEST)
Date: Tue, 30 Jun 2015 20:57:45 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, dvaleev@suse.com
Subject: Re: [PATCH SLOF v3 5/5] disk-label: add support for booting from
 GPT FAT partition
Message-ID: <20150630205745.76a4c25e@thh440s>
In-Reply-To: <87h9ppz8nl.fsf@linux.vnet.ibm.com>
References: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435662081-4293-6-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150630132834.16643eb5@thh440s>
 <87h9ppz8nl.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 30 Jun 2015 17:54:14 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> 
>     disk-label: add support for booting from GPT FAT partition
>     
>     For a GPT+LVM combination disk, older bootloader that does not support
>     LVM, cannot load kernel from LVM.
>     
>     The patch adds support to read from BASIC_DATA UUID partitions for the
>     case that the OS installer has installed the CHRP-BOOT config on a FAT
>     file system.
>     
>     Makes GPT detection robust
>     * Fix bug in seek-pos updation code
>     * Check for Protective MBR Magic
>     * Check for valid GPT Signature
>     * Boundary check for allocated block size before reading into the
>       buffer
>     
>     Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index 347dc5d..fa5df27 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -179,7 +179,8 @@ CONSTANT /gpt-part-entry
>  \ This word returns true if the currently loaded disk-buf has _NO_ GPT partition id
>  : no-gpt? ( -- true|false )
>     0 read-disk-buf
> -   1 partition>part-entry part-entry>id c@ ee <>
> +   1 partition>part-entry part-entry>id c@ ee <> IF true EXIT THEN
> +   disk-buf mbr>magic w@-le aa55 <>
>  ;
>  
>  : pc-extended-partition? ( part-entry-addr -- true|false )
> @@ -267,7 +268,10 @@ CONSTANT /gpt-part-entry
>  
>  : try-dos-partition ( -- okay? )
>     \ Read partition table and check magic.
> -   no-mbr? IF cr ." No DOS disk-label found." cr false EXIT THEN
> +   no-mbr? IF
> +       debug-disk-label? IF cr ." No DOS disk-label found." cr THEN
> +       false EXIT
> +   THEN
>  
>     count-dos-logical-partitions TO dos-logical-partitions
>  
> @@ -377,31 +381,85 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>         8 + x@    GPT-PREP-PARTITION-4 =
>  ;
>  
> -: load-from-gpt-prep-partition ( addr -- size )
> -   no-gpt? IF drop false EXIT THEN
> -   debug-disk-label? IF
> -      cr ." GPT partition found " cr
> -   THEN
> -   1 read-disk-buf disk-buf gpt>part-entry-lba l@-le
> +\ Check for GPT MSFT BASIC DATA GUID - fat based
> +EBD0A0A2            CONSTANT GPT-BASIC-DATA-PARTITION-1
> +B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
> +4433                CONSTANT GPT-BASIC-DATA-PARTITION-3
> +87C068B6B72699C7    CONSTANT GPT-BASIC-DATA-PARTITION-4
> +
> +: gpt-basic-data-partition? ( -- true|false )
> +   disk-buf gpt-part-entry>part-type-guid
> +   dup l@-le     GPT-BASIC-DATA-PARTITION-1 <> IF drop false EXIT THEN
> +   dup 4 + w@-le GPT-BASIC-DATA-PARTITION-2 <> IF drop false EXIT THEN
> +   dup 6 + w@-le GPT-BASIC-DATA-PARTITION-3 <> IF drop false EXIT THEN
> +       8 + x@    GPT-BASIC-DATA-PARTITION-4 =
> +;
> +
> +\
> +\ GPT Signature
> +\ ("EFI PART", 45h 46h 49h 20h 50h 41h 52h 54h)
> +\
> +4546492050415254 CONSTANT GPT-SIGNATURE
> +
> +\ The routine checks whether the protective MBR has GPT ID and then
> +\ reads the gpt data from the sector. Also set the seek position and
> +\ the partition size used in caller routines.
> +
> +: get-gpt-partition ( -- true|false )
> +   no-gpt? IF false EXIT THEN
> +   debug-disk-label? IF cr ." GPT partition found " cr  THEN
> +   1 read-disk-buf
> +   disk-buf gpt>part-entry-lba x@-le
>     block-size * to seek-pos
>     disk-buf gpt>part-entry-size l@-le to gpt-part-size
> -   disk-buf gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
> +   gpt-part-size disk-buf-size > IF
> +      cr ." GPT part size exceeds buffer allocated " cr
> +      false exit
> +   THEN
> +   disk-buf gpt>signature x@ GPT-SIGNATURE =
> +;
> +
> +: load-from-gpt-prep-partition ( addr -- size )
> +   get-gpt-partition 0= IF false EXIT THEN
> +   disk-buf gpt>num-part-entry l@-le dup 0= IF false exit THEN
>     1+ 1 ?DO
>        seek-pos 0 seek drop
>        disk-buf gpt-part-size read drop gpt-prep-partition? IF
> -         debug-disk-label? IF
> -            ." GPT PReP partition found " cr
> -         THEN
> -         disk-buf gpt-part-entry>first-lba x@-le
> -         disk-buf gpt-part-entry>last-lba x@-le
> -         over - 1+                 ( addr offset len )
> -         swap                      ( addr len offset )
> -         block-size * to part-offset
> -         0 0 seek drop             ( addr len )
> -         block-size * read         ( size )
> +         debug-disk-label? IF  ." GPT PReP partition found " cr THEN
> +         disk-buf gpt-part-entry>first-lba x@-le ( addr first-lba )
> +         disk-buf gpt-part-entry>last-lba x@-le  ( addr first-lba last-lba)
> +         over - 1+                            ( addr first-lba blocks )
> +         swap                                 ( addr blocks first-lba )
> +         block-size * to part-offset          ( addr blocks )
> +         0 0 seek drop                        ( addr blocks )
> +         block-size * read                    ( size )
> +         UNLOOP EXIT
> +     THEN
> +     seek-pos gpt-part-size + to seek-pos
> +   LOOP
> +   false
> +;
> +
> +: try-gpt-dos-partition ( -- true|false )
> +   get-gpt-partition 0= IF false EXIT THEN
> +   disk-buf gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
> +   1+ 1 ?DO
> +      seek-pos 0 seek drop
> +      disk-buf gpt-part-size read drop
> +      gpt-basic-data-partition? IF
> +         debug-disk-label? IF ." GPT BASIC DATA partition found " cr THEN
> +         disk-buf gpt-part-entry>first-lba x@-le       ( first-lba )
> +         dup to part-start                          ( first-lba )
> +         disk-buf gpt-part-entry>last-lba x@-le        ( first-lba last-lba )
> +         over - 1+                                  ( first-lba s1 )
> +         block-size * to part-size                  ( first-lba )
> +         block-size * to part-offset                ( )
> +         0 0 seek drop
> +         disk-buf block-size read drop
> +         disk-buf fat-bootblock?                    ( true|false )
>           UNLOOP EXIT
>        THEN
> -      seek-pos gpt-part-size i * + to seek-pos
> +      seek-pos gpt-part-size + to seek-pos
>     LOOP
>     false
>  ;
> @@ -491,7 +549,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>     debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
>     1 disk-chrp-boot !
> -   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
> +   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
>     0 disk-chrp-boot !
>  
>     debug-disk-label? IF ." Trying GPT boot " .s cr THEN
> @@ -591,6 +649,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>  : try-partitions ( -- found? )
>     try-dos-partition IF try-files EXIT THEN
> +   try-gpt-dos-partition IF try-files EXIT THEN
>     \ try-iso9660-partition IF try-files EXIT THEN
>     \ ... more partition types here...
>     false

This version now looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
