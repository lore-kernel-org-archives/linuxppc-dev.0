Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19F252C0345
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:30:36 +1000 (EST)
Message-ID: <1380159028.24959.243.camel@snotra.buserror.net>
Subject: Re: Device tree node for Freescale Gianfar PTP reference clock
 source selection
From: Scott Wood <scottwood@freescale.com>
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Date: Wed, 25 Sep 2013 20:30:28 -0500
In-Reply-To: <523FEFCD.70409@skitlab.ru>
References: <523FEFCD.70409@skitlab.ru>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Claudiu Manoil <claudiu.manoil@freescale.com>,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-23 at 11:37 +0400, Aida Mynzhasova wrote:
> Hi,
> 
> Currently, Freescale Gianfar PTP reference clock source is determined 
> through hard-coded value in gianfar_ptp driver. I don't think that 
> recompilation of the entire module (or even worse - the kernel) is a god 
> idea when we want to change one clock source to another. So, I want to 
> add new device tree binding, which can be used as:

Is this describing the hardware or how you're using it?  If the latter,
it should be a module parameter or some sort of runtime knob instead.

> 	ptp_clock@24E00 {
> 		compatible = "fsl,etsec-ptp";
> 		reg = <0x24E00 0xB0>;
> 		interrupts = <12 0x8 13 0x8>;
> 		interrupt-parent = < &ipic >;
> 		fsl,cksel = <0>; /* <-- New entry */
> 		fsl,tclk-period = <10>;
> 		fsl,tmr-prsc    = <100>;
> 		fsl,tmr-add     = <0x999999A4>;
> 		fsl,tmr-fiper1  = <0x3B9AC9F6>;
> 		fsl,tmr-fiper2  = <0x00018696>;
> 		fsl,max-adj     = <659999998>;
> 	};
> 
> fsl,cksel acceptable values:
> 
> <0> for external clock;
> <1> for eTSEC system clock;
> <2> for eTSEC1 transmit clock;
> <3> for RTC clock input.
> 
> I am new in this mailing list, and as far as I know, I have to discuss 
> all updates for device tree files here before sending patch, which uses 
> new attributes.
> 
> Also, should I define new bindings in some special way? I want to add 
> description of cksel attribute in 
> /Documentation/devicetree/bindings/net/fsl-tsec-phy.txt. Is it enough or 
> not?

Assuming this is actually describing how the hardware is wired up, yes,
that's how you'd document it (making sure that device trees without that
property are interpreted the same as today).

-Scott
