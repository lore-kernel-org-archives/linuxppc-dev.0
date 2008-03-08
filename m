Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4863BDDF32
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 12:46:59 +1100 (EST)
Message-ID: <47D1EF73.7030200@am.sony.com>
Date: Fri, 07 Mar 2008 17:44:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] bootwrapper: Allow specifying of image physical
	offset
References: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 03/07/2008 08:55 AM, Kumar Gala wrote:
> Normally we assume kernel images will be loaded at offset 0. However
> there are situations, like when the kernel itself is running at a non-zero
> physical address, that we don't want to load it at 0.
> 
> Allow the wrapper to take an offset.  We use this when building u-boot images.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/Makefile |    7 +++++++
>  arch/powerpc/boot/wrapper  |   12 ++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index f43dd6e..1b4bfc6 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -35,6 +35,12 @@ endif
> 
>  BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj) -I$(srctree)/$(src)/libfdt
> 
> +ifdef CONFIG_MEMORY_START
> +MEMBASE=$(CONFIG_MEMORY_START)

We have the powerpc config option CONFIG_KERNEL_START.  I'm
wondering  how this CONFIG_MEMORY_START is different.  I just
did a quick search, and it seems that CONFIG_MEMORY_START is
only defined for the renesas arch's.

-Geoff
