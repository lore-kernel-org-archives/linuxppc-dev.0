Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484831A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 17:34:53 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BD858140082
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 17:34:52 +1000 (AEST)
Date: Tue, 23 Jun 2015 09:34:44 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF 4/5] disk-label: add support for booting from GPT
 FAT partition
Message-ID: <20150623093444.18481f04@thh440s>
In-Reply-To: <1434959987-8530-5-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-5-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Mon, 22 Jun 2015 13:29:46 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> For a GPT+LVM combination disk, older bootloader that does not support
> LVM, cannot load kernel from LVM.
> 
> The patch add support to read from BASIC_DATA UUID
> partition. Installer has installed CHRP-BOOT config on a FAT file
> system.

Maybe better: The patch adds support to read from BASIC_DATA UUID
partitions for the case that the OS installer has installed
the CHRP-BOOT config on a FAT file system.

?

> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/packages/disk-label.fs | 54 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index e317e93..821e959 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -266,7 +266,10 @@ CONSTANT /gpt-part-entry
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
> @@ -381,18 +384,38 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>     TRUE
>  ;
>  
> -: load-from-gpt-prep-partition ( addr -- size )
> +\ Check for GPT MSFT BASIC DATA GUID - fat based
> +EBD0A0A2            CONSTANT GPT-BASIC-DATA-PARTITION-1
> +B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
> +4433                CONSTANT GPT-BASIC-DATA-PARTITION-3
> +87C068B6B72699C7    CONSTANT GPT-BASIC-DATA-PARTITION-4
> +
> +: gpt-basic-data-partition? ( -- true|false )
> +   block gpt-part-entry>part-type-guid
> +   dup l@-le     GPT-BASIC-DATA-PARTITION-1 <> IF DROP FALSE EXIT THEN
> +   dup 4 + w@-le GPT-BASIC-DATA-PARTITION-2 <> IF DROP FALSE EXIT THEN
> +   dup 6 + w@-le GPT-BASIC-DATA-PARTITION-3 <> IF DROP FALSE EXIT THEN
> +       8 + x@    GPT-BASIC-DATA-PARTITION-4 <> IF FALSE EXIT THEN
> +   TRUE
> +;
> +
> +\ Can be called from two path
> +\ 1) load-from-boot-partition for GPT PReP partition
> +\ 2) try-partitions for gpt basic data partition having fat chrp-boot

What did you want to achieve with the above comment? Caller locations
can change with later patches, but it's unlikely that everybody
remembers to update such comments in that case. So unlikely you've got
a good reason for above comment (but in that case, it maybe should be
written in a different way), I'd suggest to drop it.

> +: load-from-gpt-partition ( [ addr ] -- size | TRUE )

What do you mean with addr in square brackets? Is it optional?

>     no-gpt? IF drop FALSE EXIT THEN
>     debug-disk-label? IF
>        cr ." GPT partition found " cr
>     THEN
> -   1 read-sector block gpt>part-entry-lba l@-le
> +   1 read-sector block gpt>part-entry-lba x@-le
>     block-size * to seek-pos
>     block gpt>part-entry-size l@-le to gpt-part-size
>     block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
>     1+ 1 ?DO
>        seek-pos 0 seek drop
> -      block gpt-part-size read drop gpt-prep-partition? IF
> +       block gpt-part-size read drop
> +       gpt-prep-partition? IF

You've changed the level of indentation here. Please try to avoid that
(unless you've got a good reason, e.g. because the previous indentation
was obviously wrong)

>           debug-disk-label? IF
>              ." GPT PReP partition found " cr
>           THEN
> @@ -404,6 +427,24 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>           0 0 seek drop             ( addr len )
>           block-size * read         ( size )
>           UNLOOP EXIT
> +     THEN
> +     gpt-basic-data-partition? IF

Hmm, I wonder whether we need a proper coding conventions spec for
writing Forth code ... (at least about the indentation depths ...) ;-)

> +         debug-disk-label? IF
> +            ." GPT LINUX DATA partition found " cr
> +         THEN
> +         block gpt-part-entry>first-lba x@ xbflip
> +         dup to part-start
> +         block gpt-part-entry>last-lba x@ xbflip
> +         over - 1+                 ( addr offset len )
> +         dup block-size * to part-size
> +         swap                      ( addr len offset )
> +         block-size * to part-offset
> +         0 0 seek
> +         block block-size read
> +         3drop
> +         block has-fat-filesystem 0= IF false UNLOOP EXIT THEN
> +         TRUE
> +         UNLOOP EXIT
>        THEN
>        seek-pos gpt-part-size i * + to seek-pos
>     LOOP
> @@ -495,11 +536,11 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>     debug-disk-label? IF ." Trying CHRP boot " .s cr THEN
>     1 disk-chrp-boot !
> -   dup load-chrp-boot-file ?dup 0 <> IF .s cr nip EXIT THEN
> +   dup load-chrp-boot-file ?dup 0 <> IF nip EXIT THEN
>     0 disk-chrp-boot !
>  
>     debug-disk-label? IF ." Trying GPT boot " .s cr THEN
> -   load-from-gpt-prep-partition
> +   load-from-gpt-partition

So here the function is called with an "addr" parameter on the stack ...

>     \ More boot partition formats ...
>  ;
>  
> @@ -594,6 +635,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  
>  : try-partitions ( -- found? )
>     try-dos-partition IF try-files EXIT THEN
> +   load-from-gpt-partition IF try-files EXIT THEN

... but here it is called without an "addr" parameter? *Confusing*
How does this work?

 Thomas
