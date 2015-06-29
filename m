Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A13491A0D30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 19:17:34 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2D14114076D
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2015 19:17:33 +1000 (AEST)
Date: Mon, 29 Jun 2015 11:17:24 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, segher@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF v2 5/5] disk-label: add support for booting from
 GPT FAT partition
Message-ID: <20150629111724.3931a864@thh440s>
In-Reply-To: <1435214729-15952-6-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435214729-15952-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435214729-15952-6-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Thu, 25 Jun 2015 12:15:29 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> For a GPT+LVM combination disk, older bootloader that does not support
> LVM, cannot load kernel from LVM.
> 
> The patch adds support to read from BASIC_DATA UUID partitions for the
> case that the OS installer has installed the CHRP-BOOT config on a FAT
> file system.
> 
> Makes GPT detection robust
> * Check for Protective MBR Magic
> * Check for valid GPT Signature
> * Boundary check for allocated block size before reading into the
>   buffer
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/packages/disk-label.fs | 96 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 20 deletions(-)
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index 7ed5526..e5759a3 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
...
> @@ -378,29 +382,80 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>     true
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
> +       8 + x@    GPT-BASIC-DATA-PARTITION-4 <> IF false EXIT THEN
> +   true
> +;

You could remove the "<> IF false EXIT THEN true" at the end and
replace it with a simple "=".

> +\
> +\ GPT Signature
> +\ ("EFI PART", 45h 46h 49h 20h 50h 41h 52h 54h)
> +\
> +4546492050415254 CONSTANT GPT-SIGNATURE
> +
> +: verify-gpt-partition ( -- true | false )

I'd prefer if you could write "true|false" without spaces around the
"|" so that it is clear at a glance that there is only one item on the
stack.

Could you maybe also add a comment above the function that it sets up
gpt-part-size with the size of partition entry and seek-pos with the
position of the partition entry? ...since these are non-obvious
side-effect of this function... All in all, maybe you should also name
the function differently, since it does more than just verifying.

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
> +   verify-gpt-partition 0= IF false EXIT THEN
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
> +         swap                                 ( addr blocks )

The stack comment looks wrong here, should this be:

 ( addr blocks first-lba )

?

> +         block-size * to part-offset          ( addr blocks )
> +         0 0 seek drop                        ( addr blocks )
> +         block-size * read                    ( size )
>           UNLOOP EXIT
> +     THEN
> +     seek-pos gpt-part-size i * + to seek-pos
> +   LOOP
> +   false
> +;
> +
> +: try-gpt-dos-partition ( -- true | false )

"true | false" --> "true|false" ?

> +   verify-gpt-partition 0= IF false EXIT THEN
> +   disk-buf gpt>num-part-entry l@-le dup 0= IF false EXIT THEN
> +   1+ 1 ?DO
> +      seek-pos 0 seek drop
> +      disk-buf gpt-part-size read drop
> +      gpt-basic-data-partition? IF
> +         debug-disk-label? IF ." GPT LINUX DATA partition found " cr THEN

I think that string should maybe rather talk about "basic data
partition" instead of "LINUX data partition" ?

> +         disk-buf gpt-part-entry>first-lba x@-le       ( first-lba )
> +         dup to part-start                          ( first-lba )
> +         disk-buf gpt-part-entry>last-lba x@-le        ( first-lba last-lba )
> +         over - 1+                                  ( first-lba s1 )
> +         block-size * to part-size                  ( first-lba )
> +         block-size * to part-offset                ( )
> +         0 0 seek drop                              ( )
> +         disk-buf block-size read drop                 ( )
> +         disk-buf fat-bootblock? 0= IF false UNLOOP EXIT THEN
> +         true UNLOOP EXIT

You could simplify the above two lines to:

            disk-buf fat-bootblock?
            UNLOOP EXIT

>        THEN
>        seek-pos gpt-part-size i * + to seek-pos
>     LOOP
> @@ -492,7 +547,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>     debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
>     1 disk-chrp-boot !
> -   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
> +   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
>     0 disk-chrp-boot !
>  
>     debug-disk-label? IF ." Trying GPT boot " .s cr THEN
> @@ -592,6 +647,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>  : try-partitions ( -- found? )
>     try-dos-partition IF try-files EXIT THEN
> +   try-gpt-dos-partition IF try-files EXIT THEN
>     \ try-iso9660-partition IF try-files EXIT THEN
>     \ ... more partition types here...
>     false

 Thomas
