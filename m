Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id DB9A6B7C59
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 03:30:14 +1100 (EST)
Received: from mailgw1.invitel.net (mailgw1.invitel.net [91.82.208.34])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	B416311A697
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 17:30:10 +0100 (CET)
Date: Thu, 04 Mar 2010 17:30:07 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
In-reply-to: <OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-id: <4B8FE00F.4030405@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de> <20100304121656.6758A28BBC@gemini.denx.de>
	<OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Joakim,

Joakim Tjernlund wrote:
> Wolfgang Denk <wd@denx.de> wrote on 2010/03/04 13:16:56:
>> From: Wolfgang Denk <wd@denx.de>
>> To: hs@denx.de
>> Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>, Klaus-Jürgen
>> <heydeck@kieback-peter.de>, linuxppc-dev@ozlabs.org, Scott Wood
>> <scottwood@freescale.com>
>> Date: 2010/03/04 13:17
>> Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
>>
>> Dear Heiko,
>>
>> thanks for running the tests.
>>
>> In message <4B8F8BB4.6070201@denx.de> you wrote:
>>> here the results:
>>>
>>> run   version
>>>
>>> 1-4   2.6.33-rc6 without your patches
>>> 5-8   2.6.33-rc6 with all your patches
>>> 9-12   2.6.33-rc6 with patches 1,2 and 4 (without 8xx: Don't touch ACCESSED
>> when no SWAP)
>>> 13-16   2.6.33-rc6 with all your patches and CONFIG_PIN_TLB=y
>> So CONFIG_PIN_TLB imroves the performance as expected, while the other
>> patches don;t show any measurable improvememt - or am I reading the
>> results incorrectly?
> 
> Close but not quite. What stands out most is:
> 
> Memory latencies in nanoseconds - smaller is better
>     (WARNING - may not be correct, check graphs)
> ------------------------------------------------------------------------------
> Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
> --------- -------------   ---   ----   ----    --------    --------    -------
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       184.0      1165.7
> tqm8xx    Linux 2.6.33-    66   31.8  141.2       184.2      1165.3
> tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.3      1165.6
> tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.2      1166.2
> 
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1100.5    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1102.5    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.7    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.6    No L2 cache?
> 
> tqm8xx    Linux 2.6.33-    66   31.8  141.1       173.4      1149.1    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  141.1       173.4      1149.0    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.7  141.1       173.4      1148.7    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.7  141.1       173.4      1148.2    No L2 cache?
> 
> tqm8xx    Linux 2.6.33-    66   31.8  171.1       171.7      1099.8    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  171.1       171.6      1100.5    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.7  171.0       171.7      1101.0    No L2 cache?
> tqm8xx    Linux 2.6.33-    66   31.8  171.0       171.6      1101.3    No L2 cache?
> 
> 
> Besides the numbers, note how the first group doesn't have a Guesses entry.
> Is there something odd with the results for the first group?

Hmm.. just to be safe, I made this test again, but it shows also no entry in
"Guesses" ... Hardware, Linux Source, rootFS, lmbench sources, all the
same ...

> Also, since you are using MODULES, patch 2 is nullified.
> Patch 1 is very minor and should not show I think.
> This leaves patches 3 & 4.
> There appears to be something funny with patch 3,Don't touch ACCESSED when no SWAP, as
> it yields bad numbers for Prot Fault so perhaps I am missing something that needs ACCESSED
> even if NO_SWAP. Perhaps a someone that knows MM in Linux knows?
> Is there any messages in the kernel log(dmesg)?

I couldn;t find something in the output with dmesg ... but if you
want this output, I can send it to you.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
