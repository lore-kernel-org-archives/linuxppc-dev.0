Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id E1F132BF0E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2005 05:14:31 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 36so327546wra
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 10:14:29 -0800 (PST)
Message-ID: <4240b9160501101014317b8d85@mail.gmail.com>
Date: Mon, 10 Jan 2005 19:14:28 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050110145219.GB2226@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> --- 1.40/arch/ppc/boot/simple/Makefile  2005-01-03 16:49:19 -07:00
> +++ edited/arch/ppc/boot/simple/Makefile        2005-01-10 07:51:34 -07:00
> @@ -112,11 +112,15 @@
>           end-$(pcore)                  := pcore
>     cacheflag-$(pcore)                  := -include $(clear_L2_L3)
> 
> +# PPC_PREP can be set to y on a PPC970 configuration, which isn't a real
> +# machine.
> +ifeq ($(CONFIG_6xx),y)
>        zimage-$(CONFIG_PPC_PREP)                := zImage-PPLUS
>  zimageinitrd-$(CONFIG_PPC_PREP)                := zImage.initrd-PPLUS
>       extra.o-$(CONFIG_PPC_PREP)                := prepmap.o
>          misc-$(CONFIG_PPC_PREP)                += misc-prep.o mpc10x_memory.o
>           end-$(CONFIG_PPC_PREP)                := prep
> +endif
> 
>           end-$(CONFIG_SANDPOINT)       := sandpoint
>     cacheflag-$(CONFIG_SANDPOINT)       := -include $(clear_L2_L3)
> 

This do not compile with this patch maybe need also to define
CONFIG_6xx if PPC970 is selected as processor ?

The errors are:
undefined reference for cols, lines, vidmems, scroll, orig_x, orig_y
in functions puts, ClearVideoMemory, putc

Jerome Glisse
