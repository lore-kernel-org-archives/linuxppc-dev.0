Return-Path: <pat@computer-refuge.org>
Received: from mailhub247.itcs.purdue.edu (mailhub247.itcs.purdue.edu
	[128.210.5.247])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.purdue.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFCD8B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  3 Nov 2010 14:15:34 +1100 (EST)
From: Patrick Finnegan <pat@computer-refuge.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with Infiniband adapter on IBM p550
Date: Tue, 2 Nov 2010 23:15:04 -0400
References: <201010072324.33062.pat@computer-refuge.org>
	<1286516470.2463.403.camel@pasglop>
	<1286516749.2463.408.camel@pasglop>
In-Reply-To: <1286516749.2463.408.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201011022315.04291.pat@computer-refuge.org>
Cc: paulus@samba.org,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, October 08, 2010, Benjamin Herrenschmidt wrote:
> > Ok, so from what I can tell, the driver is unhappy because either
> > BAR 0 hasn't been assigned a memory resource or the size doesn't
> > match what the driver expects.
> 
> Ooops, accidentally sent too quickly...
> 
> >From your OF log I see:
> reg                     00c10000 00000000 00000000  00000000 00000000
>                         03c10010 00000000 00000000  00000000 00100000
>                         43c10018 00000000 00000000  00000000 00800000
>                         43c10020 00000000 00000000  00000000 08000000
> assigned-addresses      83c10020 00000000 e8000000  00000000 08000000
> 
> Now, I think this is the problem.
> 
> The "assigned-addresses" property seems to indicate that the firmware
> only assigned BAR 4 and didn't assign anything to the other ones.
> 
> I don't know why, but it definitely looks like a firmware bug to me.
> On those machines, PCI resource assignment is under hypervisor
> control and so Linux cannot re-assign missing resources itself.
> 
> I'll see if I can find a FW person to shed some light on this.
> 
> Can you provide me (privately maybe) with the FW version on the
> machine ?

Ben,

Have you found out anything more on this (firmware) bug?

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
