Return-Path: <annamaya@yahoo.com>
Received: from web53808.mail.yahoo.com (web53808.mail.yahoo.com
	[206.190.36.203]) by ozlabs.org (Postfix) with SMTP id 63B282BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 00:49:13 +1000 (EST)
Message-ID: <20041013144909.388.qmail@web53808.mail.yahoo.com>
Date: Wed, 13 Oct 2004 07:49:09 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <61D85700-1C95-11D9-91B5-003065F9B7DC@embeddededge.com>
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

Thanks for the reply Dan. Just before I got your mail,
I was going through the fcc ethernet driver from
mvista and I noticed the BCSR hack code to make the
PHY work on an EP8260. I went back to the manual for
the EP8280 and realized that they did something
similar on this board, just as you guessed. I will add
code to manage the PHY using these bits later.

Meanwhile, this board also has BCSR bits to control
enabling and powering on the PHY. I was able to add a
bit of code to  my ethernet driver and I can now see
the blinking lights on the ethernet port, similar to
the ones I see during tftp transfers from the boot
monitors. Interestingly, the boot monitor turns off
all the PHYs while the ethernet port is not being
access from the boot monitor. I fail to understand the
reasoning.

Anyways, I am able to enable and power the PHY device
and it looks like the port is seeing ethernet
activity. But my driver doesn't work and complains
about a TX timeout. I am sure I am missing something.
Can you suggest something that I could try?

Thank you.
--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Oct 12, 2004, at 5:02 PM, annamaya wrote:
> 
> > I am now trying to do an NFS mount of the root
> file
> > system. Looks like the EP8280 uses LXT971A PHY
> device.
> 
> I have one of their first 8260 boards that I used to
> do
> the initial Linux port long ago.  At that time, they
> had
> some weird CPLD implementation of MDIO that I could
> never get to work properly.  Not a bad idea, just
> didn't
> seem to be implemented properly.  I know they have
> done a second revision of this board, and I suspect
> the 8280 is just a glue into the same location
> design.
> 
> With that board you should have received sufficient
> information to determine what to do, although they
> have always been quite secretive about releasing
> enough information to successfully write software.
> 
> In the interim, just compile the driver without any
> MDIO control, hack the call to fcc_restart() at the
> end of init_fcc_startup() to just force half or full
> duplex (0 or 1) based upon the switch you are using.
> 
> 
> Good Luck.
> 
> 
> 	-- Dan
> 
> 



		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com
