Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB1931A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 18:40:30 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 06 May 2015 10:40:03 +0200
Message-ID: <2568634.iEosTvMJpM@wuerfel>
In-Reply-To: <5549C68B.9090602@xilinx.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <4635229.bceBxngCoe@wuerfel> <5549C68B.9090602@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>,
 "jcm@redhat.com" <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "chris@printf.net" <chris@printf.net>, "patches@apm.com" <patches@apm.com>,
 Rob Herring <robherring2@gmail.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 06 May 2015 09:45:15 Michal Simek wrote:
> On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
> > On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
> >>>> @@ -533,6 +567,16 @@
> >>>>                         interrupts = <0x0 0x4f 0x4>;
> >>>>                 };
> >>>>
> >>>> +               sdhc0: sdhc@1c000000 {
> >>>> +                       device_type = "sdhc";
> >>>
> >>> device_type generally should not be used (there are a few exceptions).
> >>
> >> Okay !!
> >>
> > 
> > While we're at it, please change sdhc@1c000000 to mmc@1c000000.
> > Even though Linux does not care, we try to use the standard device
> > names for consistency.
> 
> Do we have a list of these names somewhere?
> Normally I do use ePARP - generic names recommendation but mmc or sdhci
> are not listed there.
> Both combination mmc@ or sdhci@ are used in the kernel.
> 
> On zynq and zynqmp we do use shdci@.
> 

Ah, I thought ePAPR listed mmc already. Using "sdhci" is a little too
specific here, since a lot of mmc hosts are not sdhci compliant, and
"sdhc" is completely wrong, because that identifies a specific card
type, but a host that supports SDHC cards will generally also work
with SD (less than 4GB) or SDXC (more than 48GB) cards.

	Arnd
