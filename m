Return-Path: <rmcguire@videopresence.com>
Received: from smtpout07-04.prod.mesa1.secureserver.net
	(smtpout07-01.prod.mesa1.secureserver.net [64.202.165.230])
	by ozlabs.org (Postfix) with SMTP id 63947DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 16:32:46 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
	<001101c746e3$5b8dab00$6405a8c0@absolut>
	<A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
Subject: RE: MPC8360 : PCI resource allocate error
Date: Fri, 2 Feb 2007 21:32:41 -0800
Message-ID: <000601c74754$b9a1eb90$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Comments in line:

> On Feb 2, 2007, at 10:01 AM, Russell McGuire wrote:
> 
> > Here is the current .dts mapping, though I am beginning to suspect the
> > hardware or a possible U-boot bug on this.
> >
> > U-boot can't see the PCI USB card in SLOT 3, but it can see the all
> > of the
> > other various PCI cards I have <ATI video card, sound card, ATA card,
> > network card>
> 
> Are any cards detected in SLOT 3 with u-boot?  If not, I'd think HW
> as well.

Yes, actually of the 6 cards I have, all are seen except the USB card. 
And the USB card is seen in all other slots. So it appears to be a SLOT
issue, but not a card issue.  Somehow this card is unique and uncovering an
error that I don't know about yet. Perhaps I have a single address line
sizzled or something. This is the same slot that has the IO resource
allocation problems; I don't think I need to debug that in Linux. 

OR.. 

Is there any PCI test code out there??? Maybe I should forego the drivers,
and figure out some kind of test. I made a blind assumption in U-boot that
if it worked to detect cards that everything was in order.

> 
> > All the cards that are seen by U-boot have the IO resource problem.
> > Only
> > when in Slot 3.
> >
> > I probably need to direct this at the U-boot crowd, but what about
> > these
> > defines in U-boot? Would they have any bearing? I forgot to publish
> > these
> > when I originally had asked the question bout PCI IO space, but
> > they are the
> > only ALL zero's in the mapping.
> 
> They shouldn't on just seeing the device.  Since PCI config cycles
> are used and U-boot will scan all busses you should at least see the
> device.
> 
> - k
