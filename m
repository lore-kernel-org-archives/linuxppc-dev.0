Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 93F8F2BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 08:34:55 +1000 (EST)
Date: Thu, 7 Oct 2004 18:27:51 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0410071817420.8278@dell.enoriver.com>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
	<0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 7 Oct 2004, Dan Malek wrote:

>
> On Oct 7, 2004, at 2:48 PM, Tom Rini wrote:
>
>>>   CONFIG_8xx_UART
>>>   CONFIG_SMC2_UART
>>>   CONFIG_ALTSMC2
>>>   CONFIG_CONS_SMC2
>>>   CONFIG_USE_SCC_IO
>> 
>> Not all of these options exist in linux-2.6.
>
> Why not?  They must or some equivalent to get these features. I 
> dislike this 2.6 "forward progress" that continually removes 
> features we have deemed necessary in previous kernel versions.

   actually, i was going to mention this very point earlier, but i got 
the impression that others were already all over this issue so i left 
it alone.

   in the current Kconfig file, you have the option of selecting which 
of SMC1 or SMC2 you want to be the console.  fair enough, and a useful 
feature to be sure.

   but if the UART-related stuff is removed from arch/ppc/8xx_io, then 
i'm assuming you'll do that configuration under the menu

   Device Drivers -->
     Character devices -->
       Serial drivers
         CPM SCC/SMC serial port support

at least, that's what it looks like.  but there's no equivalent 
selection to pick *exactly* where you want your console in that 
submenu.  i wasn't suggesting that all the above *features* had to be 
expunged -- just that those specific variables were related to the old 
UART way of doing things and had to be dealt with, one way or the 
other.

   obviously, new variables should be added to the new config part of 
the menu to add that functionality back in (the same names could, of 
course, be re-used).  as it stands, from what i can see by looking 
through the directory drivers/serial/cpm_uart, there is currently no 
way to select your console (among other things).

   before messing with any more code, i think someone has to sit down 
and just design the Kconfig menus that will represent all the features 
you want, with menus, submenus, variables, dependencies and so on.

   thoughts?

rday








>
>> I think this had been discussed before, but perhaps not.  What should
>> happen at some point is something more like "Do you hae SMC1 ? What is
>> it? Do you have SMC2 ? What is it? Do youhave SCC1? What is it?" and so
>> on.  For now, I wouldn't worry about it.
>
> I don't understand the "what is it?" part of these questions.  As I
> have continually pointed out over the years, we don't have "SMC" or
> "SCC" drivers.  We have UART drivers that use SMCs or SCC, Ethernet
> drivers that use SCCs or FECs, audio drivers that use SMCs or SCCs,
> and so on.  It's a subtle but important configuration selection.  You
> select the feature you want (uart, Ethernet, audio, ATM, etc.), then
> you can be further prompted for peripheral routing information if necessary.
> We have discussed this at length in the past.
>
> Thanks.
>
>
> 	-- Dan
>
