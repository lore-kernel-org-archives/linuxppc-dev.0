Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id CC813B70E9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 02:56:12 +1000 (EST)
Received: by fxm17 with SMTP id 17so4823397fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 09:56:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279811975.7232.8696.camel@petert>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279811975.7232.8696.camel@petert>
Date: Thu, 22 Jul 2010 20:56:10 +0400
Message-ID: <AANLkTikd3pyVa3=V0pqA5uOto+RYWY_0kF_SL0d0B=BD@mail.gmail.com>
Subject: Re: [PATCH 1/2] MPC85xx: add definitions for PCI error detection soc
	part
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Dave Jiang <djiang@mvista.com>,
	bluesmoke-devel@lists.sourceforge.net,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Jul 22, 2010 at 7:19 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> Hi Dmitry,
>
> On Thu, 2010-07-22 at 04:03 +0400, Dmitry Eremin-Solenikov wrote:
>> Add definitions for PCI error detection device to be handled by (already
>> existing) mpc85xx_edac.c driver.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>> =A0arch/powerpc/boot/dts/mpc8536ds.dts =A0 =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/mpc8536ds_36b.dts =A0 =A0| =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/mpc8540ads.dts =A0 =A0 =A0 | =A0 =A08 ++++++++
>> =A0arch/powerpc/boot/dts/mpc8541cds.dts =A0 =A0 =A0 | =A0 14 +++++++++++=
+++
>> =A0arch/powerpc/boot/dts/mpc8544ds.dts =A0 =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/mpc8548cds.dts =A0 =A0 =A0 | =A0 14 +++++++++++=
+++
>> =A0arch/powerpc/boot/dts/mpc8555cds.dts =A0 =A0 =A0 | =A0 14 +++++++++++=
+++
>> =A0arch/powerpc/boot/dts/mpc8560ads.dts =A0 =A0 =A0 | =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/mpc8568mds.dts =A0 =A0 =A0 | =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/sbc8548.dts =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++=
++
>> =A0arch/powerpc/boot/dts/sbc8560.dts =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++=
++
>> =A0arch/powerpc/boot/dts/socrates.dts =A0 =A0 =A0 =A0 | =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/stx_gp3_8560.dts =A0 =A0 | =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/tqm8540.dts =A0 =A0 =A0 =A0 =A0| =A0 10 +++++++=
+++
>> =A0arch/powerpc/boot/dts/tqm8541.dts =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++=
++
>> =A0arch/powerpc/boot/dts/tqm8548-bigflash.dts | =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/tqm8548.dts =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++=
++
>> =A0arch/powerpc/boot/dts/tqm8555.dts =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++=
++
>> =A0arch/powerpc/boot/dts/tqm8560.dts =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++=
++
>> =A0arch/powerpc/boot/dts/xpedite5200.dts =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/powerpc/boot/dts/xpedite5200_xmon.dts | =A0 =A07 +++++++
>> =A021 files changed, 172 insertions(+), 0 deletions(-)
>
> It looks like the dts files for the MPC8572-based boards weren't
> included in this change despite patch 2/2 adding support for them. =A0I'd
> guess some other Freescale CPUs (eg P1020, P2020, etc) could be
> supported by the same driver if you are inclined to add them to this
> patch series.

I just did a quick search for all dts including mpc8540-pci node and added
respective mpc85xx-pci-error node. Current MPC85xx EDAC driver doesn't
support error handling on PCI-E busses (which MPC8572 and other CPUs
you mentioned have). I'll maybe look into PCI-E EDAC later. Also I don't ha=
ve
access to P10xx/P20xx manuals, so support for them may require some
more time.

--=20
With best wishes
Dmitry
