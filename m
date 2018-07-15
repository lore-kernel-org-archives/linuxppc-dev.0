Return-Path: <srs0=o7v3=j7=infradead.org=rdunlap@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TH2q3XBxzF36W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 05:40:51 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41TH2q1mHHz8v1Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 05:40:51 +1000 (AEST)
Subject: Re: [PATCH 2/2] powerpc: Add ppc64le and ppc64_book3e allmodconfig
 targets
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, malat@debian.org, Felipe Balbi <balbi@kernel.org>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <20180709142426.26999-2-mpe@ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0965451-620f-7d19-eacb-64179ee21a3b@infradead.org>
Date: Sun, 15 Jul 2018 12:40:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180709142426.26999-2-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/18 07:24, Michael Ellerman wrote:
> Similarly as we just did for 32-bit, add phony targets for generating
> a little endian and Book3E allmodconfig. These aren't covered by the
> regular allmodconfig, which is big endian and Book3S due to the way
> the Kconfig symbols are structured.

[adding Felipe Balbi]


Is book3e allmodconfig not seen/used very much?

Besides the patches that I have already sent, I am seeing a build problem
with ppc64_book3e_allmodconfig, where we have:

CONFIG_USB_PHY=y
CONFIG_FSL_USB2_OTG=y
but
CONFIG_USB_OTG_FSM=m

In drivers/usb/phy/Kconfig, FSL_USB2_OTG depends on USB_OTG_FSM (among
other things), but!  FSL_USB2_OTG is a bool symbol, depending on a
tristate symbol.  This often causes problems.  In this case it causes errors
with a builtin driver trying to use symbols that are built in a loadable module:

drivers/usb/phy/phy-fsl-usb.o: In function `.fsl_otg_ioctl':
phy-fsl-usb.c:(.text.fsl_otg_ioctl+0xb4): undefined reference to `.otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `.fsl_otg_start_srp':
phy-fsl-usb.c:(.text.fsl_otg_start_srp+0x4c): undefined reference to `.otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `.fsl_otg_set_host':
phy-fsl-usb.c:(.text.fsl_otg_set_host+0xd0): undefined reference to `.otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `.fsl_otg_start_hnp':
phy-fsl-usb.c:(.text.fsl_otg_start_hnp+0x68): undefined reference to `.otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `.show_fsl_usb2_otg_state':
phy-fsl-usb.c:(.text.show_fsl_usb2_otg_state+0x154): undefined reference to `.usb_otg_state_string'
drivers/usb/phy/phy-fsl-usb.o: In function `.a_wait_enum':
(.text.a_wait_enum+0x4c): undefined reference to `.otg_statemachine'
drivers/usb/phy/phy-fsl-usb.o: In function `.fsl_otg_set_peripheral':
phy-fsl-usb.c:(.text.fsl_otg_set_peripheral+0x84): undefined reference to `.usb_gadget_vbus_disconnect'
phy-fsl-usb.c:(.text.fsl_otg_set_peripheral+0x9c): undefined reference to `.otg_statemachine'



> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 2556c2182789..48e887f03a6c 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -359,6 +359,16 @@ ppc32_allmodconfig:
>  	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
>  		-f $(srctree)/Makefile allmodconfig
>  
> +PHONY += ppc64le_allmodconfig
> +ppc64le_allmodconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/le.config \
> +		-f $(srctree)/Makefile allmodconfig
> +
> +PHONY += ppc64_book3e_allmodconfig
> +ppc64_book3e_allmodconfig:
> +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.config \
> +		-f $(srctree)/Makefile allmodconfig
> +
>  define archhelp
>    @echo '* zImage          - Build default images selected by kernel config'
>    @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
> 

thanks,
-- 
~Randy
