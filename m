Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 28532DDF39
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:05:05 +1100 (EST)
Message-ID: <45D1EFBC.7040805@am.sony.com>
Date: Tue, 13 Feb 2007 09:05:00 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 11/16] zImage wrapper for Ebony
References: <20070213061025.6EB43DDD0C@ozlabs.org>
In-Reply-To: <20070213061025.6EB43DDD0C@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This patch adds support for building a zImage wrapper suitable for the
> Ebony (440GP) evaluation board.  This supports booting both from uboot
> (old versions which don't supply a flattened device tree) and IBM
> Openbios (aka "treeboot").

> +++ working-2.6/arch/powerpc/boot/Makefile	2007-02-12 14:22:17.000000000 +1100
> -src-plat := of.c
> +src-plat := of.c ebony.c
>  src-boot := crt0.S $(src-wlib) $(src-plat) empty.c


Could this be better as:

src-plat-$(CONFIG_44x) += ebony.c
src-plat := of.c $(src-plat-y)


>  src-boot := $(addprefix $(obj)/, $(src-boot))
> @@ -94,6 +94,12 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
>  $(obj)/wrapper.a: $(obj-wlib)
>  	$(call cmd,bootar)
>  
> +quiet_cmd_dtc = DTC     $@
> +      cmd_dtc = $(dtc) -O dtb -o $@ -b 0 -V 16 $<
> +
> +$(obj)/%.dtb: $(srctree)/$(src)/dts/%.dts
> +	$(call if_changed,dtc)
> +


If dtc is not installed will this create an empty dtb file that ends
up getting used?  If so, try something like this:

cmd_dtc = $(dtc) -O dtb -o $@ -b 0 -V 16 $< $@.tmp && mv $@.tmp $@


I think you need to clean your dtb, so something like this also:

clean-files += $(obj)/%.dtb 


-Geoff
