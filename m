Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 3C7F8B7010
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 04:13:00 +1000 (EST)
Date: Thu, 11 Aug 2011 13:12:58 -0500
From: Robin Holt <holt@sgi.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v11 6/6] powerpc: Add flexcan device support for p1010rdb.
Message-ID: <20110811181258.GG4926@sgi.com>
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-7-git-send-email-holt@sgi.com>
	<9C81E6C0-D278-40BF-8F32-445F870F845A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9C81E6C0-D278-40BF-8F32-445F870F845A@kernel.crashing.org>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2011 at 12:41:34PM -0500, Kumar Gala wrote:
> 
> On Aug 11, 2011, at 11:07 AM, Robin Holt wrote:
> 
> > Allow the p1010 processor to select the flexcan network driver.
> > 
> > Signed-off-by: Robin Holt <holt@sgi.com>
> > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
> > Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
> > Cc: U Bhaskar-B22300 <B22300@freescale.com>
> > Cc: socketcan-core@lists.berlios.de,
> > Cc: netdev@vger.kernel.org,
> > Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> > Cc: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > arch/powerpc/boot/dts/p1010rdb.dts  |    8 ++++++++
> > arch/powerpc/platforms/85xx/Kconfig |    2 ++
> > 2 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
> > index d6c669c..df89b60 100644
> > --- a/arch/powerpc/boot/dts/p1010rdb.dts
> > +++ b/arch/powerpc/boot/dts/p1010rdb.dts
> > @@ -171,6 +171,14 @@
> > 			};
> > 		};
> > 
> > +		can@1c000 {
> > +			clock-frequency = <0x0bebc1fc>;
> > +		};
> > +
> > +		can1: can@1d000 {
> > +			clock-frequency = <0x0bebc1fc>;
> > +		};
> > +
> 
> set them to 0, as we expect u-boot to fill them in.

Done.

> 
> > 		usb@22000 {
> > 			phy_type = "utmi";
> > 		};
> > diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> > index 498534c..c4304ae 100644
> > --- a/arch/powerpc/platforms/85xx/Kconfig
> > +++ b/arch/powerpc/platforms/85xx/Kconfig
> > @@ -70,6 +70,8 @@ config MPC85xx_RDB
> > config P1010_RDB
> > 	bool "Freescale P1010RDB"
> > 	select DEFAULT_UIMAGE
> > +	select HAVE_CAN_FLEXCAN if NET && CAN
> > +	select PPC_CLOCK if CAN_FLEXCAN
> 
> Can you move this to arch/powerpc/Kconfig & FSL_SOC instead.

I am not sure.  FSL_SOC seems to come with any of the freescale system
on a chip.  I would not be that worried, about the flexcan build as
I think that is sufficiently agostic where we will not see problems,
but now we could end up with build failures on any of the other configs
which select CAN_FLEXCAN.  I would normally want to do all those builds,
but there is no way I would know how to do that with my limited knowledge
of powerpc and freescale.

If you are comfortable with that, I will happily make the change.

Thanks,
Robin
