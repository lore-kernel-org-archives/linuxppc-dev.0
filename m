Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X8P66BPlzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 21:51:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, malat@debian.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 2/2] powerpc: Add ppc64le and ppc64_book3e allmodconfig
 targets
In-Reply-To: <b0965451-620f-7d19-eacb-64179ee21a3b@infradead.org>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <20180709142426.26999-2-mpe@ellerman.id.au>
 <b0965451-620f-7d19-eacb-64179ee21a3b@infradead.org>
Date: Fri, 20 Jul 2018 21:51:34 +1000
Message-ID: <87y3e686rd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Randy,

Randy Dunlap <rdunlap@infradead.org> writes:
> On 07/09/18 07:24, Michael Ellerman wrote:
>> Similarly as we just did for 32-bit, add phony targets for generating
>> a little endian and Book3E allmodconfig. These aren't covered by the
>> regular allmodconfig, which is big endian and Book3S due to the way
>> the Kconfig symbols are structured.
>
> [adding Felipe Balbi]
>
> Is book3e allmodconfig not seen/used very much?

Seems so :)

> Besides the patches that I have already sent, I am seeing a build problem
> with ppc64_book3e_allmodconfig, where we have:
>
> CONFIG_USB_PHY=y
> CONFIG_FSL_USB2_OTG=y
> but
> CONFIG_USB_OTG_FSM=m
>
> In drivers/usb/phy/Kconfig, FSL_USB2_OTG depends on USB_OTG_FSM (among
> other things), but!  FSL_USB2_OTG is a bool symbol, depending on a
> tristate symbol.  This often causes problems.  In this case it causes errors
> with a builtin driver trying to use symbols that are built in a loadable module:
>
> drivers/usb/phy/phy-fsl-usb.o: In function `.fsl_otg_ioctl':
> phy-fsl-usb.c:(.text.fsl_otg_ioctl+0xb4): undefined reference to `.otg_statemachine'


Do we just need something like?

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index d7312eed6088..91ea3083e7ad 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -21,7 +21,7 @@ config AB8500_USB
 
 config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
-	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
+	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM=y && PM
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
 	help


cheers
