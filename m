Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1A4C5DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 05:41:12 +1100 (EST)
Date: Tue, 21 Oct 2008 22:41:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/83xx: add DS1339 RTC support for
	MPC8349E-mITX boards
Message-ID: <20081021184109.GA25590@oksana.dev.rtsoft.ru>
References: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
	<20081021182344.GA22232@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081021182344.GA22232@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2008 at 01:23:44PM -0500, Scott Wood wrote:
> On Fri, Oct 17, 2008 at 10:56:59PM +0400, Anton Vorontsov wrote:
> > diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> > index 5cedf37..7fc5414 100644
> > --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> > +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> > @@ -83,6 +83,14 @@
> >  			interrupts = <15 0x8>;
> >  			interrupt-parent = <&ipic>;
> >  			dfsrr;
> > +
> > +			rtc@68 {
> > +				device_type = "rtc";
> > +				compatible = "dallas,ds1339";
> > +				reg = <0x68>;
> > +				interrupts = <18 0x8>;
> > +				interrupt-parent = <&ipic>;
> > +			};
> 
> Why are we adding more device_types?

It seems that CHRP is using the device_type for rtc devices, which
means that real OF also provide it. But I guess we don't need it,
right? Then we should cleanup all the boards.
