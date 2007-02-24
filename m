Return-Path: <bwarren@qstreams.com>
Received: from web308.biz.mail.mud.yahoo.com (web308.biz.mail.mud.yahoo.com
	[68.142.199.184]) by ozlabs.org (Postfix) with SMTP id 49F1ADDE10
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 14:20:25 +1100 (EST)
Date: Fri, 23 Feb 2007 19:13:43 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: MPC834x global timers question
To: Bruce_Leonard@selinc.com, linuxppc-embedded@ozlabs.org
In-Reply-To: <OF37CF163F.2ABC0002-ON8825728C.00068359-8825728C.00075898@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <725190.72914.qm@web308.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce,

--- Bruce_Leonard@selinc.com wrote:

> I know this isn't the right forum for this but I
> can't seem to find a 
> generic PPC mailing list.
> 
> I'm trying to get a global timer going on an
> MPC834x, and the way I learn 
> is to just play with HW, so I've got an Abatron
> BDI2K hooked up to my 
> processor so I can just manipulate registers without
> having to deal with 
> writing code.  However, I seem to be unable to
> modify certain registers in 
> the global timers with this set up and I don't
> understand why. 
> Specifically, if a register has a bit that's a '1'
> following a reset, I 
> can't change that bit to a '0'.  This is happening
> with the Global Timers 
> Reference Registers (GTRFR1 - 4) and the Global
> Timers Prescale Registers 
> (GTPSR1 - 4).  The reset state of the GTRFRs is
> 0xFFFF and I can't change 
> it to any other value.  The reset state of the
> GTPSRs is 0x3 and I can't 
> clear the 2 LSB.  I can change any other bits in the
> prescale registers, 
> but not the two which are a '1' at reset.

There's a sequence that needs to be followed.  You
need to enable the timer first, then set the mode,
then set the prescaler.  I've attached some expect
code for U-boot that generates a 1Hz output from timer
3 on an MCP8349.  It's not quite what you have, but
hopefully close enough for you to figure it out.  I
also have a simple char driver for Linux if you need
it later on.

COMMENT "Set SICLR so that GPIO1_8 becomes TOUT3"
send "mm.w e0000114\r"
expect $mmPrompt
send "8001\r"
expect $mmPrompt
send "q\r"
expect $mainPrompt

COMMENT "Enable timer 3"
send "mm.b e0000504\r"
expect $mmPrompt
send "01\r"
expect $mmPrompt
send "q\r"
expect $mainPrompt

COMMENT "Set mode register"
send "mm.w e0000520\r"
expect $mmPrompt
send "ff0c\r"
expect $mmPrompt
send "q\r"

COMMENT "Set frequency to 1Hz"
send "mm.w e0000524\r"
expect $mmPrompt
send "1f77\r"
expect $mmPrompt
send "q\r"
expect $mainPrompt

Hope this helps
regards,
Ben
