Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 629C41A0D0B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 15:59:50 +1000 (AEST)
Date: Wed, 27 May 2015 07:59:34 +0200
From: Thomas Huth <thuth@redhat.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] fbuffer: improve toggle cursor performance
Message-ID: <20150527075934.1d3a49db@thh440s>
In-Reply-To: <20150527001113.2506.23159.stgit@bahia.huguette.org>
References: <20150527001113.2506.23159.stgit@bahia.huguette.org>
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

On Wed, 27 May 2015 02:11:13 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> SLOF currently calls hv-logical-load and hv-logical-store for every pixel
> when enabling or disabling the cursor. This is suboptimal when writing one
> char at a time to the console since terminal-write always toggles the cursor.
> And this is precisely what grub is doing when the user wants to edit a menu
> entry... the result is an incredibly slow and barely usable interface.
> 
> The inner loop in fb8-toggle-cursor handles a contiguous region: it can be
> converted to hv-logical-memop. The result is 32 times less hcalls per char
> and a serious improvement in grub usability.

Good idea for an optimization!

> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  slof/fs/fbuffer.fs |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index 756f05a..46b59bf 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
>  : fb8-toggle-cursor ( -- )
>  	line# fb8-line2addr column# fb8-columns2bytes +
>  	char-height 0 ?DO
> -		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
> -		screen-width screen-depth * + char-width screen-depth * -
> +		dup dup 0 char-width screen-depth * 1 hv-logical-memop drop
> +		screen-width screen-depth * +
>  	LOOP drop
>  ;

If you use hv-logical-memop in this file here, you definitely break
board-js2x, since this is bare metal and hv-logical-memop is not
defined there.

I think you should either move the new function to board-qemu and handle
it there like it is done for hcall-invert-screen already, or we could
think of introducing a helper function that is defined by each board
which does the xor operation on a memory region (that way we could
maybe also unify hcall-invert-screen and fb8-invert-screen again).

 Thomas
