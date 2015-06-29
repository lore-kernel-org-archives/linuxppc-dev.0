Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A82B41A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 18:47:23 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6576B14076D
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2015 18:47:23 +1000 (AEST)
Date: Mon, 29 Jun 2015 10:47:16 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, segher@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF v2 4/5] disk-label: introduce helper to check fat
 filesystem
Message-ID: <20150629104716.61aced97@thh440s>
In-Reply-To: <1435214729-15952-5-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435214729-15952-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435214729-15952-5-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Thu, 25 Jun 2015 12:15:28 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/packages/disk-label.fs | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/slof/fs/packages/disk-label.fs b/slof/fs/packages/disk-label.fs
> index 0995808..7ed5526 100644
> --- a/slof/fs/packages/disk-label.fs
> +++ b/slof/fs/packages/disk-label.fs
> @@ -321,6 +321,14 @@ CONSTANT /gpt-part-entry
>  
>  \ Load from first active DOS boot partition.
>  
> +: fat-bootblock? ( addr -- flag )
> +   \ byte 0-2 of the bootblock is a jump instruction in
> +   \ all FAT filesystems.
> +   \ e9 and eb are jump instructions in x86 assembler.
> +   dup c@ e9 = IF drop true EXIT THEN
> +   dup c@ eb = swap 2+ c@ 90 = and
> +;
> +
>  \ NOTE: block-size is always 512 bytes for DOS partition tables.
>  
>  : load-from-dos-boot-partition ( addr -- size )
> @@ -549,14 +557,7 @@ AA268B49521E5A8B    CONSTANT GPT-PREP-PARTITION-4
>  : try-dos-files ( -- found? )
>     no-mbr? IF false EXIT THEN
>  
> -   \ disk-buf 0 byte 0-2 is a jump instruction in all FAT
> -   \ filesystems.
> -   \ e9 and eb are jump instructions in x86 assembler.
> -   disk-buf c@ e9 <> IF
> -      disk-buf c@ eb <>
> -      disk-buf 2+ c@ 90 <> or
> -      IF false EXIT THEN
> -   THEN
> +   disk-buf fat-bootblock? 0= IF false EXIT THEN
>     s" fat-files" (interpose-filesystem)
>     true
>  ;

Reviewed-by: Thomas Huth <thuth@redhat.com>
