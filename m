Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id F244567A86
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jan 2005 04:48:53 +1100 (EST)
Message-ID: <003501c50498$fb92f720$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Stuart Adams" <sja@brightstareng.com>,
	<linuxppc-embedded@ozlabs.org>
References: <41F916ED.1070705@brightstareng.com>
Date: Thu, 27 Jan 2005 12:52:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: MPC5200 bogomips
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


----- Original Message ----- 
From: "Stuart Adams" <sja@brightstareng.com>
To: <linuxppc-embedded@ozlabs.org>
Sent: Thursday, January 27, 2005 11:29 AM
Subject: MPC5200 bogomips


> 
>   We are only seeing 263.78 bogomips on a MPC5200 running
>   at 396 MHz.
> 
>   Doesn't this seem way to low ?? With a 603e core I'd expect
>   1 bogomip per MHz or better.
> 
>   The exact same kernel source running on an 8xx PPC gets about
>   1 bogomip per MHZ and my 745 CPU board does 2 bogomips
>   per MHz ... the bogomip calibration code is the same for all
>   PPC architectures so it seem like it should be an apples-to-apples
>   comparison.
> 
> -- Stuart
> 

Ha! You almost sound like you are quoting me from when I first
looked at bogomips on the 5200.  Here's the story:  If you drill
down to where bogomips are calculated you will see that it is
measuring the speed of a dbnz instruction.  The calculation assumes
2 clocks per dbnz.  So the 8xx comes out at 1 BogoMIP/MHz.  The
5200 takes 3 clocks/dbnz in this loop, so you get .67 BogoMIP/MHz.  
Not to worry, it's only one specific scenario.  Overall I've found the 
5200 to be about 1.5 MIPS/MHz compared to 8xx 1 MIPS/MHz.

Mark Chambers
