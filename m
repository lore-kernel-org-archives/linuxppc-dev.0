Return-Path: <chuckmeade@mindspring.com>
Received: from txslsmtp2.vzwmail.net (unknown [66.174.85.156])
	by ozlabs.org (Postfix) with ESMTP id 2C08E67B3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 07:40:35 +1000 (EST)
From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 17:25:21 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGKEFDLDAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000f01c68f2a$68b83960$0e67a8c0@Jocke>
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

> > On Jun 13, 2006, at 11:48 AM, Alex Zeffertt wrote:
> > 
> > > Hi list,
> > >
> > > I'm trying to boot a linux-2.6.11 kernel on a MPC83xx based 
> > board.   
> > > Through
> > > some experimentation I have found I need 
> > "console=uart,io,0xfe004500"
> > > in the kernel command line in order to get any output over 
> > the serial 
> > > port.
> > >
> > > Half way through initialisation the kernel appears to swap from its 
> > > "early"
> > > 8250 serial driver to a "full" 8250 serial driver.  At this 
> > point it 
> > > prints "No ttyS device at I/O port 0xfe004500 for console" 
> > and there 
> > > is no further output.
> > >
> > > Does anyone have any idea what I may be doing wrong?
> > >
> > > BTW, here's the output that I do get.
> > 
> > Alex, where did you get this 2.6.11 kernel?  The public tree 
> > didn't have support for 83xx in 2.6.11.  I'd suggest looking 
> > at using something newer like 2.6.16 and see if you have the 
> > same issue.
> 
> I suspect he got from the same place I did, freescales LTIB dev. env.
> which has been patched to support 832x. I am having the same problem as he
> has, any info on what the problem might be would be great.
> 
> Also, if anyone has any info on when these patches will be sent upstream, I 
> sure would like to hear about it.
> 
>  Jocke

Hi Joakim,

Same here -- go into arch/ppc/platforms/83xx and edit file mpc83xx_sys.c.
If you are using the 8323e cpu, then you need to make sure that file has
code to support the 8323E.  Mine didn't, so I got no platform devices 
initialized (no serial port, no Eth devs).  I added a block of code to support
the 8323E (set mask to 0xffff0000 and "value" to 0x80620000, then the 
device list for the 8323E).  Use existing code there as a guide, it was not
difficult once I figured out that this was the problem.

If you are using a newer LTIB release than me, perhaps yours is fixed.
The one I have is from 3/15/06.

Anyway, this works fine for me and addresses the problem of the platform
devs not getting initialized.

Chuck
