Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth11.prod.mesa1.secureserver.net
	(smtpauth11.prod.mesa1.secureserver.net [64.202.165.33])
	by ozlabs.org (Postfix) with SMTP id 23BD8DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Aug 2008 07:56:00 +1000 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'bhanu jampala'" <adams.ppc@gmail.com>
References: <4a21eaea0808291353p29992a2che64854f93829d706@mail.gmail.com>
Subject: RE: How many super channels per TDM on MCC
Date: Fri, 29 Aug 2008 14:55:58 -0700
Message-ID: <A73DC0A13D5D4EA5B6648ED5498498CB@absolutdaddy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4a21eaea0808291353p29992a2che64854f93829d706@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Jampala,

I think the bit part you are missing is the SI and TSA assignment in the
82xx family manual.

This is how the associations are created; we should really step away from
the TDM and Super channel relationship as it is just a catch all for a port
that is interfaced with the SI TSA. You need to focus on how you are
breaking down your TDM stream with the SI TSA interface.

Your question should be:
How are super channels and the SIxRAM entries related?
How big should I make my timeslots? 8 bits? 4 bits? 1 bit?


Assuming basic ideas:
* Your TDM is running at 2Mhz for E1 rates.
* You have a line protocol with a sync pulse every SFrame or ESFrame.
* Divided your SIxRAM into 32 entries to parse your TDM.
* 8 bit time slots works for channelized and clear channel.
* One SI entry per time slot
* 4 time slots routed to each super channel

This would indicate that you can only get 4 super channels per TDM @ 2Mhz
and ESF. As your TDM doesn't carry any more data, assuming you running a
single E1 into a TDM interface.

Now if you have scaled up your clock rate, from E1 rates to say 8Mhz. Then
this all changes. 

IF
* Your TDM is running 8 Mhz <4 E1s combined into a single TDM>
* You can still sync on your ESF Frames.

* You Will need to figure out some way to sync you individual ESF frames
within your 8Mhz stream. Not sure on your HW, is it one sync pulse for every
ESF? Or one sync pulse for every four muxed ESFs?

* Your SixRAM entry might still have the same entries, but just be repeated
4x faster, good luck figuring out which time slot 1 is from which original
E1 Phy.

OR

* You might have to create 128 SI entries to handle all the time slots. In
this case you might have to consider using shadow entries and loops with the
SI. Assuming only one sync pulse for all ESFs grouped together.  IN this
case you could get 4 time slots per super channel and have 24 super channels
running on a single TDM.

As a side note there is a WhitePaper from Freescale that talks about a
similar scenario on the 8360E. You might check that out, i.e. hooking 16
T1/E1's into a system through a TDM backplane. In their case they only route
2 E1's per TDM though. Same rules would apply.





> -----Original Message-----
> From: bhanu jampala [mailto:adams.ppc@gmail.com]
> Sent: Friday, August 29, 2008 1:53 PM
> To: linuxppc-embedded@ozlabs.org
> Cc: rmcguire@videopresence.com; Robert Staven; Scott Wood
> Subject: How many super channels per TDM on MCC
> 
> Hi Guys,
> 
> This is regarding MCC controller on MPC8260.
> I am having problems figuring out how super channels fit into a TDM.
> 
> A superchannel is the combination of multiple MCC TX channels' FIFOs and
> one
> set of an MCC channel's parameters and buffer descriptors.
> 
> If I want to support 24 super channels with 4 timeslots each.
> Can I use a single TDM (i.e. from A,B ,C, D) to accomplish this task.
> (each TDM has 32 timeslots).
> 
> - Mukund Jampala
