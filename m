Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05E4A1A012D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:29:00 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RESEND v6 1/2] arm64: dts: Add the arasan sdhci nodes in
 apm-storm.dtsi
Date: Tue, 12 May 2015 09:28:10 +0200
Message-ID: <5446694.nHWK6QO1on@wuerfel>
In-Reply-To: <CAOHikRAeOH5Pt4WZFk1C29dUytO7H0ox_dgq578oW19ue8Eb8Q@mail.gmail.com>
References: <1431333531-30491-1-git-send-email-stripathi@apm.com>
 <1431333531-30491-2-git-send-email-stripathi@apm.com>
 <CAOHikRAeOH5Pt4WZFk1C29dUytO7H0ox_dgq578oW19ue8Eb8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 Michal Simek <michal.simek@xilinx.com>, patches <patches@apm.com>,
 Don Dutile <ddutile@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 12 May 2015 11:03:46 Suman Tripathi wrote:
> > @@ -533,6 +567,15 @@
> >                         interrupts = <0x0 0x4f 0x4>;
> >                 };
> >
> > +               sdhci0: sdhci@1c000000 {
> > +                       compatible = "arasan,sdhci-4.9a";
> > +                       reg = <0x0 0x1c000000 0x0 0x100>;
> > +                       interrupts = <0x0 0x49 0x4>;
> > +                       dma-coherent;
> > +                       clock-names = "clk_xin", "clk_ahb";
> > +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> > +               };
> > +
> >                 phy1: phy@1f21a000 {
> >                         compatible = "apm,xgene-phy";
> >                         reg = <0x0 0x1f21a000 0x0 0x100>;
> > --
> > 1.8.2.1
> >
> 
> Can anyone from dt community review this patch ? I have changed the dts node
> names from sdhc to sdhci as per Arnd, Michael comments .

I was actually asking for it to be named 'mmc', not 'sdhci', because the
name is supposed to indicate the purpose of the device, not the
implementation. I realize that we are inconsistent here, just as with
'uart' vs 'serial', and that ePAPR does not define what to do.

We should probably add something to Documentation/devicetree/bindings/mmc/mmc.txt
about this topic and change all the dts files accordingly (unless there
is a risk for regressions). At the moment, the mmc.txt file also includes
an example with 'sdhci', not 'mmc'.

	Arnd
