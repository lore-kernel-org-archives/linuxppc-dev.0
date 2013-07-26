Return-Path: <anton@scarybugs.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42F2E2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 05:10:42 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so2368842pbb.22
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 12:10:40 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Fri, 26 Jul 2013 12:06:08 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
Message-ID: <20130726190608.GA14216@lizard>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
 <1374514847.15592.7@snotra>
 <99E897753B6F7048BD8CCDB4661D02E13E49EC@039-SN2MPN1-022.039d.mgd.msft.net>
 <1374547294.15592.22@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1374547294.15592.22@snotra>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Zhang Haijun-B42677 <B42677@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 09:41:34PM -0500, Scott Wood wrote:
[...]
> >> > +static void esdhc_get_voltage(struct sdhci_host *host,
> >> > +			struct platform_device *pdev)
> >> > +{
....
> >> > +}
> >>
> >> Don't duplicate this code.  Move it somewhere common and share it.
> >[Haijun Wrote:] So, move it drivers/mmc/host/sdhci-pltfm.c and
> >share it as
> >Sdhc_get_voltage()....?
> 
> I'll let the MMC maintainer say what the appropriate place would
> be...  Don't capitalize the function name, though. :-)

Somewhere in drivers/mmc/core/core.c, near mmc_vddrange_to_ocrmask() would
be most appropriate, IMO. #ifdef CONFIG_OF would be needed, though.

Thanks,

Anton
