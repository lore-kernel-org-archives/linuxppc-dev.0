Return-Path: <annamaya@yahoo.com>
Received: from web53806.mail.yahoo.com (web53806.mail.yahoo.com
	[206.190.36.201]) by ozlabs.org (Postfix) with SMTP id 6D5612BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 11:03:05 +1000 (EST)
Message-ID: <20041016010303.65546.qmail@web53806.mail.yahoo.com>
Date: Fri, 15 Oct 2004 18:03:03 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <1FB8DAAD-1EF0-11D9-BD1F-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Floating point error on a MPC8280 based board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the reply Dan. I see it clearly now. I
think I need to visit my optometrist again. The pc is
set to 0xff000104 but the flash is mapped at
0xfff00000 and the default vector is going to be
0xfff00100. I need to look at the reset code just as
you suggested. I was stumped by the "floating point"
error since that was not something I expected on a bad
instruction fetch.

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Oct 15, 2004, at 4:59 PM, annamaya wrote:
> 
> > When I try to reboot my system on a MPC8280 eval
> > board, I see the floating point error. Does anyone
> > know why is this happening?
> 
> It's trying to jump to a restart location in the
> boot rom.
> It fetches a bad instruction that attempts to
> execute
> as a floating point instruction.
> 
> > bash-2.05b# reboot -f
> > Restarting system
> > floating point used in kernel (task=cf458000,
> > pc=ff000104)
> 
> This program counter is a typical warm restart boot
> rom location.  Change the kernel reboot code to jump
> to the proper place in your boot rom or force a
> restart
> in some way.
> 
> 
> 	-- Dan
> 
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
