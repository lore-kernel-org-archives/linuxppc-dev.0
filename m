Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B74A8B7CF1
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 21:42:28 +1100 (EST)
In-Reply-To: <4B94BE1F.8030203@denx.de>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de>
	<20100304121656.6758A28BBC@gemini.denx.de>
	<OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
	<4B8FE00F.4030405@denx.de>
	<OF342998FA.F0D2DAE1-ONC12576DD.003A3D7E-C12576DD.003AA365@transmode.se>
	<4B94AB55.3020308@denx.de>
	<OF7533FA9E.2786BF7B-ONC12576E0.002FB5D8-C12576E0.002FFEE9@transmode.se>
	<4B94BE1F.8030203@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
To: hs@denx.de
Message-ID: <OF1413A940.58E7B20E-ONC12576E0.003A9000-C12576E0.003ACFB7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 8 Mar 2010 11:42:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heiko Schocher <hs@denx.de> wrote on 2010/03/08 10:06:39:
>
> Hello Joakim,
>
> Joakim Tjernlund wrote:
> > Heiko Schocher <hs@denx.de> wrote on 2010/03/08 08:46:29:
> >> Hello Joakim,
> >>
> >> Joakim Tjernlund wrote:
> >> [...]
> >>> What would be interesting is to skip patch 3 and turn off
> >>> MODULES add PIN_TLB and compare that against your unpatched .33 but
> >>> with MODULES off and PIN_TLB on
> >> run     version
> >>
> >> 1-4   Linux2.6.33-rc without module support and PIN_TLB=on
> >> 5-8   Linux2.6.33-rc without module support and PIN_TLB=on + patches 1,2,4
> >>
> >>                  L M B E N C H  3 . 0   S U M M A R Y
> >>                  ------------------------------------
> >>        (Alpha software, do not distribute)
> >
> > hmm, these results varies a lot. The only stable result I can see is:
> >
> >> Memory latencies in nanoseconds - smaller is better
> >>     (WARNING - may not be correct, check graphs)
> >> ------------------------------------------------------------------------------
> >> Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
> >> --------- -------------   ---   ----   ----    --------    --------    -------
> >> tqm8xx    Linux 2.6.33-    66   31.7  183.2       184.0      1163.0    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.7  183.2       184.0      1164.8    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.7  183.2       184.0      1163.2    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.7  183.2       183.8      1163.7    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.8  172.4       173.2      1147.3    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.8  172.5       173.2      1148.3    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.8  172.5       173.1      1146.9    No L2 cache?
> >> tqm8xx    Linux 2.6.33-    66   31.8  172.5       173.2      1147.3    No L2 cache?
> >
> > I don't see why the other results vary so much. Are you using NFS or having
> much network
> > traffic?
>
> I use NFS.

Then I think it is possible NFS gets in the way for stable measurements. Anyone
have experience with running lmbench on NFS?

        Jocke
