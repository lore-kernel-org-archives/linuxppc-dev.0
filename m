Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B78A2C01EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 12:07:03 +1000 (EST)
Message-ID: <518078C0.7070805@scrye.com>
Date: Tue, 30 Apr 2013 20:06:56 -0600
From: Anthony Foiani <tkil@scrye.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <1367368958.24133.21@snotra>
In-Reply-To: <1367368958.24133.21@snotra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott --

On 04/30/2013 06:42 PM, Scott Wood wrote:
> I just meant that, for whatever boards you would have put this in the 
> device tree, put it in platform code instead (if the platform file 
> supports more than one board type, then check the compatible at the 
> top of the device tree). 

I think I understand what you're suggesting.

Instead of a new property name, I would instead check for my specific 
board type (let's call it a foo-8315) in the top-level compatible list?  
So I'd change my devtree to have this top-level compatible:

/ {
     compatible = "example,foo-8315", "fsl,mpc8315erdb";

If I saw that, I would then twiddle the bits as needed?

MIght work, although having it in the sata block of the device tree has 
the advantage of providing me exactly the OF node that I need (in 
ofdev->dev.of_node).  I'd have to figure out how to traverse to the dev 
tree root and then back down one to the root compat entry.  Probably not 
impossible, but I was aiming for a fairly minimal patch.

It would also be nice if we could unravel exactly why that 
CONFIG_8315_DS ever showed up in the first place.  (The other "minimal" 
aspect of my patch was to try to make changes only around that one area, 
so that others could see that it was a simple change.)

> Or do you mean that you would not set this on any board's device tree 
> by default, and instead have users set it if they encounter problems? 

No, I would expect to set it on all the boards, so using the 
compatibility hack above would work.

> Is this a custom board you're seeing it on?

Not ours, but our vendor isn't very active on upstreaming things. (And 
yes, had I know that 5 years ago, I could possibly have changed vendors, 
or made upstreaming a part of the contract.  But at this point, we're 
stuck with this vendor, and they're not going to fix it; so I'm trying 
to fix it, and I'm trying to do the best job of upstreaming those fixes 
that I can.)

> git send-email can connect directly to an SMTP server.

Ok, I'll play around with that.

Thanks again,
Anthony
