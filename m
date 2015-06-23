Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E86311A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 17:47:04 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 789EB140157
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 17:47:04 +1000 (AEST)
Date: Tue, 23 Jun 2015 09:46:54 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF 5/5] disk-label: make gpt detection code more robust
Message-ID: <20150623094654.413b3c29@thh440s>
In-Reply-To: <1434959987-8530-6-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1434959987-8530-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1434959987-8530-6-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Mon, 22 Jun 2015 13:29:47 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> * Check for Protective MBR Magic
> * Check for valid GPT Signature
> * Boundary check for allocated block size before reading into the
>   buffer
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/packages/disk-label.fs | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index 821e959..d9c3a8d 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -20,6 +20,7 @@ false VALUE debug-disk-label?
>  \ If we ever want to put a large kernel with initramfs from a PREP partition
>  \ we might need to increase this value. The default value is 65536 blocks (32MB)
>  d# 65536 value max-prep-partition-blocks
> +d# 4096 value block-array-size
>  
>  s" disk-label" device-name
>  
> @@ -152,8 +153,8 @@ CONSTANT /gpt-part-entry
>  : init-block ( -- )
>     s" block-size" ['] $call-parent CATCH IF ABORT" parent has no block-size." THEN
>     to block-size
> -   d# 4096 alloc-mem
> -   dup d# 4096 erase
> +   block-array-size alloc-mem
> +   dup block-array-size erase
>     to block
>     debug-disk-label? IF
>        ." init-block: block-size=" block-size .d ." block=0x" block u. cr
> @@ -175,10 +176,18 @@ CONSTANT /gpt-part-entry
>     block mbr>magic w@-le aa55 <>
>  ;
>  
> +\
> +\ GPT Signature
> +\ ("EFI PART", 45h 46h 49h 20h 50h 41h 52h 54h)
> +\
> +4546492050415254 CONSTANT GPT-SIGNATURE
> +
>  \ This word returns true if the currently loaded block has _NO_ GPT partition id
>  : no-gpt? ( -- true|false )
>     0 read-sector
> -   1 partition>part-entry part-entry>id c@ ee <>
> +   1 partition>part-entry part-entry>id c@ ee <> IF TRUE EXIT THEN
> +   block mbr>magic w@-le aa55 <> IF TRUE EXIT THEN
> +   1 read-sector block gpt>signature x@ GPT-SIGNATURE <>

The comment above the function talks about the "currently loaded
block", so I'd maybe avoid to load another sector here.
Maybe move this gpt>signature check to "load-from-gpt-partition" where
this block gets loaded anyway?

>  ;
>  
>  : pc-extended-partition? ( part-entry-addr -- true|false )
> @@ -411,6 +420,10 @@ B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
>     1 read-sector block gpt>part-entry-lba x@-le
>     block-size * to seek-pos
>     block gpt>part-entry-size l@-le to gpt-part-size
> +   gpt-part-size block-array-size > IF
> +       cr ." GPT part size exceeds buffer allocated " cr

Isn't there this "addr" parameter on the stack which you might need to
drop here?

> +       FALSE EXIT
> +   THEN
>     block gpt>num-part-entry l@-le dup 0= IF FALSE EXIT THEN
>     1+ 1 ?DO
>        seek-pos 0 seek drop
> @@ -646,7 +659,7 @@ B9E5                CONSTANT GPT-BASIC-DATA-PARTITION-2
>  
>  : close ( -- )
>     debug-disk-label? IF ." Closing disk-label: block=0x" block u. ." block-size=" block-size .d cr THEN
> -   block d# 4096 free-mem
> +   block block-array-size free-mem
>  ;

 Thomas
