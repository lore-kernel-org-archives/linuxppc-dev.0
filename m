Return-Path: <annamaya@yahoo.com>
Received: from web53807.mail.yahoo.com (web53807.mail.yahoo.com
	[206.190.36.202]) by ozlabs.org (Postfix) with SMTP id 7DE2167A73
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jan 2005 08:20:10 +1100 (EST)
Message-ID: <20050121212003.72257.qmail@web53807.mail.yahoo.com>
Date: Fri, 21 Jan 2005 13:20:03 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: annamaya <annamaya@yahoo.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <20050121201632.69802.qmail@web53804.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: Kernel booting issues on a MPC8270 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am sorry but I dont believe the "mfpvr" instruction
has anything to do with it. I thought removing it was
getting rid of the problem but I was wrong. The board
still gets reset when the very first instruction is
executed. I am stumped.

--- annamaya <annamaya@yahoo.com> wrote:

> I debugged this problem a little more and realized
> that the reset was happenning right after the
> execution of the first kernel instruction at
> 0x0000000c. The instruction at this location was
> "mfpvr r28". I traced this back to a snippet of code
> that was dealing with pipeline depth issues on the
> MPC8260. Once I commented this code out, more
> instructions were issued but the reboot happens
> elsewhere. I am not able to pin-point the location
> of
> the debug since my BDI fails to catch the reset when
> it happens. Can someone point me to the cause of
> this
> situation? Thanks in advance.
> 
> --- annamaya <annamaya@yahoo.com> wrote:
> 
> > I am trying to boot a mvista Linux Kernel ver.
> > 2.4.20
> > on  a MPC8270 board. I am using the embed_config()
> > in
> > zImage to pass the board info since the bootloader
> > is
> > not ppcboot. After the message, "Now booting the
> > kernel", the board just reboots, as if someone
> > yanked
> > the reset line. I have BDI hooked up but it
> doesn't
> > seem to catch the reset point in the code. And I
> am
> > unable to trace this to anything in the code. Any
> > suggestions? Thanks in advance.
> > 
> > 
> > 		
> > __________________________________ 
> > Do you Yahoo!? 
> > Yahoo! Mail - now with 250MB free storage. Learn
> > more.
> > http://info.mail.yahoo.com/mail_250
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Read only the mail you want - Yahoo! Mail SpamGuard.
> 
> http://promotions.yahoo.com/new_mail 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
