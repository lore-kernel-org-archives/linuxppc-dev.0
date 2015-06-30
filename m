Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3C781A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 21:28:43 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48A301402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 21:28:42 +1000 (AEST)
Date: Tue, 30 Jun 2015 13:28:34 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, segher@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF v3 5/5] disk-label: add support for booting from
 GPT FAT partition
Message-ID: <20150630132834.16643eb5@thh440s>
In-Reply-To: <1435662081-4293-6-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435662081-4293-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435662081-4293-6-git-send-email-nikunj@linux.vnet.ibm.com>
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


Sorry, every time I look at this gpt stuff, my eyes stumble
over something new ...

On Tue, 30 Jun 2015 16:31:21 +0530
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
>  slof/fs/packages/disk-label.fs | 99 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 79 insertions(+), 20 deletions(-)
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index 347dc5d..5267ddb 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
...
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
> +     seek-pos gpt-part-size i * + to seek-pos

Is this the right way to update the seek pos? Looks somewhat suspicious
to me, shouldn't this rather be:

	seek-pos gpt-part-size + to seek-pos

or maybe if you store the base value somewhere instead, something like:

	seek-pos-base gpt-part-size i * + to seek-pos

?

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
>        seek-pos gpt-part-size i * + to seek-pos

dito (so this bug was likely there before?)

 Thomas
