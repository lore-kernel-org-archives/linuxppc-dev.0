Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id F31D767A2F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 09:35:16 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so313033wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 14:35:14 -0800 (PST)
Message-ID: <528646bc05021714356238ff35@mail.gmail.com>
Date: Thu, 17 Feb 2005 15:35:14 -0700
From: Grant Likely <glikely@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <528646bc05021714135dcb1d01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <528646bc05021515486bd9f926@mail.gmail.com>
	<4213B111.4050905@246tNt.com>
	<528646bc05021714135dcb1d01@mail.gmail.com>
Subject: Re: Lite5200 full duplex support
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 17 Feb 2005 15:13:33 -0700, Grant Likely <glikely@gmail.com> wrote:
> On Wed, 16 Feb 2005 21:46:09 +0100, Sylvain Munaut <tnt@246tnt.com> wrote:
> > Grant Likely wrote:
> >
> > >BTW, here's what I changed:
> > >drivers/net/fec_mpc52xx/fec_phy.c line 294 (phy_info_lxt971)
> > >from:
> > >        { mk_mii_write(MII_REG_ANAR, 0x0A1), NULL }, /* 10/100, HD */
> > >to:
> > >        { mk_mii_write(MII_REG_ANAR, 0x1E1), NULL }, /* 10/100, HD */
> > >
> > >
> > >
> > I'm not sure actually. I also wondered and forgot to ask the author. I guess
> > I always tought there was a problem with it without checking.
> >
> I've played around with it a bit more and I have discovered one
> problem.  When in full duplex the carrier detect seems to bounce up
> and down for every frame received off the wire.  I've beaten the tar
> out of it with netperf and it doesn't seem to be causeing any
> instability (yet)...  Still investigating.
> 
Update: The error seems to be carrier sense loss during transmit.  The
FEC documentation states that carrier loss errors are counted, but the
frame is not retransmitted and no interrupt is generated.  The driver
copies the value directly out of the counter register when reporting
status.

I do not know yet if it affects received frames...

Cheers,
g.

> Cheers,
> g.
>
