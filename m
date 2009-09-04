Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1233BB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Sep 2009 01:46:29 +1000 (EST)
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190]) by ozlabs.org (Postfix) with ESMTP id 70B03DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2009 01:46:27 +1000 (EST)
Received: by ywh28 with SMTP id 28so1457174ywh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Sep 2009 08:46:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AA1347A.5060702@linutronix.de>
References: <20090902110410.GC15401@www.tglx.de>
	<fa686aa40909030948h4acf6d3x1c318baa2fdefe1f@mail.gmail.com>
	<4AA1347A.5060702@linutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 4 Sep 2009 09:45:54 -0600
Message-ID: <fa686aa40909040845v7410446eqe16a537c398252b7@mail.gmail.com>
Subject: Re: [RFC] net/fs_enet: send a reset request to the PHY on init
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 4, 2009 at 9:38 AM, Sebastian Andrzej
Siewior<bigeasy@linutronix.de> wrote:
> Grant Likely wrote:
> =A0> What version of the kernel are you using? =A0The line numbers don't
>>
>> match up with kernel mainline, so I wonder if this is before or after
>> the OF MDIO rework changes.
>
> It is the kernel which was shipped in ads5121's bsp which is 2.6.24.

Okay, I can safely ignore this then.  Wolfgang may be interested
though.  He's been doing some work to get 5121 support mainlined.

> I have no network support in boot loader so I can't do it there. Doing it=
 at
> phy-probe time sounds reasonable.
> So all other boards are doing this kind of reset in u-boot?

In general I take the approach that as much as possible firmware
should have devices in a sane state before booting the kernel just to
avoid doing board specific fixup stuff in the kernel tree.  But this
isn't law, just more of a rule of thumb that I go by.  2nd resort is
to create a board specific platform code file and put it there
(arch/powerpc/platforms/*).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
