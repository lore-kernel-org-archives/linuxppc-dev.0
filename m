Return-Path: <annamaya@yahoo.com>
Received: from web53808.mail.yahoo.com (web53808.mail.yahoo.com
	[206.190.36.203]) by ozlabs.org (Postfix) with SMTP id 8564E2BDA5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 02:01:17 +1000 (EST)
Message-ID: <20041014155325.57264.qmail@web53808.mail.yahoo.com>
Date: Thu, 14 Oct 2004 08:53:25 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <D0DCDC9C-1D69-11D9-88FA-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Song <samlinuxppc@yahoo.com.cn>, linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I cant believe I was stupid enough to beleive that the
user's manual of an eval board was giving me the
correct information. 

The problem turned out to be that the FCC controllers
were not assigned to the ports that the manual stated.
They were switched. I was configuring the wrong FCC
controllers. Doh!

By manually looking at the FCC registers during tftp
transfers from the bootloader, I was able to figure
out that the controller in use for the port was
different from the one that the manual was telling me.

I appreciate all the help that I got in solving my
weird problems. Special thanks to Dan. I think I am
almost done supporting the EP8280 in the Linux Kernel
from denx.

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Oct 13, 2004, at 5:23 PM, annamaya wrote:
> 
> > I verified that the TX and RX clock signals are
> > correct and the CMXFCR route register is
> programmed
> > correctly for FCC2. I still see TX timeout errors.
> I
> > am stumped. :-(
> 
> Do you have the FCC MAC set up properly for
> full or half duplex?  If you don't have MDIO
> working,
> you are going to have to force this to the proper
> setting for your switch.  I mentioned this in a
> previous message.
> 
> If that doesn't work, take a look at the CPM
> memory map and ensure the "special" FCC
> area is mapped properly.  I don't remember
> if the 8280 has the "big" CPM like the 8260,
> or the small one like the 8272.  There is
> a configuration option that moves this memory
> address for the FCC fifos and special buffers.
> 
> 
> 	-- Dan
> 
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
