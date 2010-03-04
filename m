Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F407CB7CED
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 00:10:26 +1100 (EST)
In-Reply-To: <20100304121656.6758A28BBC@gemini.denx.de>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de>
	<20100304121656.6758A28BBC@gemini.denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 4 Mar 2010 14:06:48 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk <wd@denx.de> wrote on 2010/03/04 13:16:56:

> From: Wolfgang Denk <wd@denx.de>
> To: hs@denx.de
> Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>, Klaus-J=FCrgen
> <heydeck@kieback-peter.de>, linuxppc-dev@ozlabs.org, Scott Wood
> <scottwood@freescale.com>
> Date: 2010/03/04 13:17
> Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
>
> Dear Heiko,
>
> thanks for running the tests.
>
> In message <4B8F8BB4.6070201@denx.de> you wrote:
> >
> > here the results:
> >
> > run   version
> >
> > 1-4   2.6.33-rc6 without your patches
> > 5-8   2.6.33-rc6 with all your patches
> > 9-12   2.6.33-rc6 with patches 1,2 and 4 (without 8xx: Don't touch =
ACCESSED
> when no SWAP)
> > 13-16   2.6.33-rc6 with all your patches and CONFIG_PIN_TLB=3Dy
>
> So CONFIG_PIN_TLB imroves the performance as expected, while the othe=
r
> patches don;t show any measurable improvememt - or am I reading the
> results incorrectly?

Close but not quite. What stands out most is:

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
-----------------------------------------------------------------------=
-------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    =
Guesses
--------- -------------   ---   ----   ----    --------    --------    =
-------
tqm8xx    Linux 2.6.33-    66   31.8  141.0       184.0      1165.7
tqm8xx    Linux 2.6.33-    66   31.8  141.2       184.2      1165.3
tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.3      1165.6
tqm8xx    Linux 2.6.33-    66   31.8  141.3       184.2      1166.2

tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1100.5    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1102.5    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.7    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.0       171.8      1101.6    =
No L2 cache?

tqm8xx    Linux 2.6.33-    66   31.8  141.1       173.4      1149.1    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  141.1       173.4      1149.0    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  141.1       173.4      1148.7    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  141.1       173.4      1148.2    =
No L2 cache?

tqm8xx    Linux 2.6.33-    66   31.8  171.1       171.7      1099.8    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  171.1       171.6      1100.5    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.7  171.0       171.7      1101.0    =
No L2 cache?
tqm8xx    Linux 2.6.33-    66   31.8  171.0       171.6      1101.3    =
No L2 cache?


Besides the numbers, note how the first group doesn't have a Guesses en=
try.
Is there something odd with the results for the first group?

Also, since you are using MODULES, patch 2 is nullified.
Patch 1 is very minor and should not show I think.
This leaves patches 3 & 4.
There appears to be something funny with patch 3,Don't touch ACCESSED w=
hen no SWAP, as
it yields bad numbers for Prot Fault so perhaps I am missing something =
that needs ACCESSED
even if NO_SWAP. Perhaps a someone that knows MM in Linux knows?
Is there any messages in the kernel log(dmesg)?

 Jocke=
