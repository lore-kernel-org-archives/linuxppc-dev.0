Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 554BA14031A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 09:35:08 +1000 (EST)
Message-ID: <1399332886.15726.161.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/6] powerpc/corenet: Add DPAA FMan support to the SoC
 device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 5 May 2014 18:34:46 -0500
In-Reply-To: <53661DAB.10808@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-5-git-send-email-Shruti@Freescale.com>
 <1398118442.1694.190.camel__272.432543761347$1398129129$gmane$org@snotra.buserror.net>
 <53661DAB.10808@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Kanetkar Shruti-B44454 <Shruti@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-05-04 at 05:59 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 04/21/2014 05:14 PM, Scott Wood wrote:
> > On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
> >> FMan 1 Gb/s MACs (dTSEC and mEMAC) have support for SGMII PHYs.
> >> Add support for the internal SerDes TBI PHYs
> >>
> >> Based on prior work by Andy Fleming <afleming@gmail.com>
> >>
> >> Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
> >> ---
> >>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  28 +++++
> >>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  51 +++++++++
> >>  arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  14 +++
> >>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  64 ++++++++++++
> >>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  64 ++++++++++++
> >>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 104 +++++++++++++++++++
> >>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  64 ++++++++++++
> >>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 128 +++++++++++++++++++++++
> >>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 154 ++++++++++++++++++++++++++++
> >>  9 files changed, 671 insertions(+)
> >>
> >> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> >> index cbc354b..45b0ff5 100644
> >> --- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> >> +++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> >> @@ -172,6 +172,34 @@
> >>  		compatible = "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2.0";
> >>  	};
> >>  
> >> +/include/ "qoriq-fman3-0-1g-4.dtsi"
> >> +/include/ "qoriq-fman3-0-1g-5.dtsi"
> >> +/include/ "qoriq-fman3-0-10g-0.dtsi"
> >> +/include/ "qoriq-fman3-0-10g-1.dtsi"
> >> +	fman@400000 {
> >> +		ethernet@e8000 {
> >> +			tbi-handle = <&tbi4>;
> >> +		};
> > 
> > Binding needed
> > 
> > Where is the "reg" for these unit addresses?
> 
> As I said, the bulk of the FMan work comes from another team. Here we
> need just enough to hook up the MDIO and PHY nodes.

Unit addresses must match reg.  No reg, no unit address.

> I'd really like to be able to make progress on this without waiting for that moment in time
> we can get the entire FMan binding in place

Why is the fman binding such a big deal?

> >> +		mdio@e9000 {
> >> +			tbi4: tbi-phy@8 {
> >> +				reg = <0x8>;
> >> +				device_type = "tbi-phy";
> >> +			};
> >> +		};
> > 
> > Binding needed for tbi-phy device_type
> 
> I guess that's fair (BTW, you accepted tbi-phy nodes/device-type before
> without a binding)

It's existing practice on eTSEC.  FMan seemed like an opportunity to
avoid carrying cruft forward.

> > Why are we using device_type at all for this?
> 
> That's what the upstream driver is looking for.

Drivers should look for what the binding says -- not the other way
around.

>  Anyway, most days PHYs can be discovered so they don't use/need
> compatible properties. That's I guess part of the reason we don't have
> bindings for them PHY nodes

I don't see why there couldn't be a compatible that describes the
standard programming interface.

> However, what you can't discover is how they are wired to the MAC(s) so
> we still need some nodes in the device tree to convey that. Also, when
> looking for a specific kind of PHY, such as TBI, device_type works
> easier then parsing compatibles from various vendors or so

Don't you find the TBI by following the tbi-handle property?  That said,
I don't object to having a way to label a PHY as attached via TBI if
that's useful.  I'm giving a mild, non-nacking (given the history)
objection to using device_type for that (given other history).

-Scott
