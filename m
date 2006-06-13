Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 0043467B3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 07:39:29 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Chuck Meade'" <chuckmeade@mindspring.com>,
	"'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 23:39:27 +0200
Message-ID: <001101c68f31$d89aa220$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <IIEEICKJLNEPBBDJICNGKEFDLDAA.chuckmeade@mindspring.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > 
> > I suspect he got from the same place I did, freescales LTIB 
> dev. env.
> > which has been patched to support 832x. I am having the 
> same problem 
> > as he has, any info on what the problem might be would be great.
> > 
> > Also, if anyone has any info on when these patches will be sent 
> > upstream, I sure would like to hear about it.
> > 
> >  Jocke
> 
> Hi Joakim,
> 
> Same here -- go into arch/ppc/platforms/83xx and edit file 
> mpc83xx_sys.c.
> If you are using the 8323e cpu, then you need to make sure

Yes, got one of those.
 
> that file has code to support the 8323E.  Mine didn't, so I 
> got no platform devices initialized (no serial port, no Eth 
> devs).  I added a block of code to support the 8323E (set 
> mask to 0xffff0000 and "value" to 0x80620000, then the device 
> list for the 8323E).  Use existing code there as a guide, it 
> was not difficult once I figured out that this was the problem.

hmm, you don't have a patch handy?

> 
> If you are using a newer LTIB release than me, perhaps yours is fixed.
> The one I have is from 3/15/06.

Me too, I have requested that freescale release a new LTIB with proper support,
but who knows when the will be.

> 
> Anyway, this works fine for me and addresses the problem of 
> the platform devs not getting initialized.
> 
> Chuck
> 
> 
> 
