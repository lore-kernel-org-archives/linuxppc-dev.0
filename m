Return-Path: <bigeasy@linutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94847B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Sep 2009 01:38:49 +1000 (EST)
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1CAADDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2009 01:38:47 +1000 (EST)
Message-ID: <4AA1347A.5060702@linutronix.de>
Date: Fri, 04 Sep 2009 17:38:34 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] net/fs_enet: send a reset request to the PHY on init
References: <20090902110410.GC15401@www.tglx.de>
	<fa686aa40909030948h4acf6d3x1c318baa2fdefe1f@mail.gmail.com>
In-Reply-To: <fa686aa40909030948h4acf6d3x1c318baa2fdefe1f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
  > What version of the kernel are you using?  The line numbers don't
> match up with kernel mainline, so I wonder if this is before or after
> the OF MDIO rework changes.
It is the kernel which was shipped in ads5121's bsp which is 2.6.24.

> Regardless, this doesn't look right.  It certainly isn't right for the
> driver to do an unconditional PHY reset when it doesn't actually know
> what phy is attached.  For most boards I'm sure this is not desirable
> because it will cause a delay while the PHY auto negotiates.
> Depending on when the first network traffic begins, can cause several
> seconds of boot delay.
> 
> Best would be to do this in U-Boot.  Otherwise, I think I would rather
> see it at phy_device probe time.  At least then it would be on a
> per-phy basis, or could be controlled by a property in the device tree
> so that all boards don't get the same impact.
I have no network support in boot loader so I can't do it there. Doing it 
at phy-probe time sounds reasonable.
So all other boards are doing this kind of reset in u-boot?

> g.
> 


Sebastian
