Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D59C1A1949
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:30:48 +1000 (AEST)
Date: Thu, 28 May 2015 15:30:38 +0200
From: Thomas Huth <thuth@redhat.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/3] fbuffer: simplify address computations in
 fb8-toggle-cursor
Message-ID: <20150528153038.0f885adf@thh440s>
In-Reply-To: <20150528131314.5240.44784.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20150528131309.5240.71135.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20150528131314.5240.44784.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
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

On Thu, 28 May 2015 15:13:14 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> The inner loop deals with a contiguous region. It could easily be replaced
> by faster board specific functions like hv-logical-memop in board-qemu.
> Since hv-logical-memop does not return an address, let's have the enclosing
> loop compute the next line address by itself and drop the confusing
> "char-width screen-depth * -" address adjustment.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  slof/fs/fbuffer.fs |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/slof/fs/fbuffer.fs b/slof/fs/fbuffer.fs
> index 756f05a..faae6a9 100644
> --- a/slof/fs/fbuffer.fs
> +++ b/slof/fs/fbuffer.fs
> @@ -99,8 +99,8 @@ CREATE bitmap-buffer 400 4 * allot
>  : fb8-toggle-cursor ( -- )
>  	line# fb8-line2addr column# fb8-columns2bytes +
>  	char-height 0 ?DO
> -		char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP
> -		screen-width screen-depth * + char-width screen-depth * -
> +		dup char-width screen-depth * 0 ?DO dup dup rb@ -1 xor swap rb! 1+ LOOP drop
> +		screen-width screen-depth * +
>  	LOOP drop
>  ;

Reviewed-by: Thomas Huth <thuth@redhat.com>
