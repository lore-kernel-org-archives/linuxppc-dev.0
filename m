Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FD89B7CCD
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 21:39:16 +1100 (EST)
In-Reply-To: <4B8E3582.8060003@denx.de>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
To: hs@denx.de
Message-ID: <OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 3 Mar 2010 11:38:55 +0100
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

Heiko Schocher <hs@denx.de> wrote on 2010/03/03 11:10:10:
>
> Hello Joakim,
>
> Joakim Tjernlund wrote:
> > Heiko Schocher <hs@denx.de> wrote on 2010/03/03 09:02:47:
> [...]
> >> Here the results:
> >> (The first 4 rows are the results for the kernel without your patches,
> >>  the next 4 rows are the results for the kernel with your patches)
> >>
> >> make[1]: Entering directory `/home/hs/lmbench-3.0-a9/results'
> >
> > I see both ups and downs in this test, don't quite understand why.
> > What is your config w.r.t SWAP, MODULES, CPU6 and CPU15?
>
> Sorry, forgot to say, where to find the sources. You can find them
> here:
>
> http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/tqm8xx

OK, so you got SWAP=no, MODULES=yes, CPU6=no, CPU15=no
PIN_TLB isn't listed in you def config so I assume
it is no?

MODULES=yes nullifies one optimization.

I don't understand the bad numbers for Prot Fault:
File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
tqm8xx    Linux 2.6.33- 5917.2 3968.3  31.2K 4329.0  4147.0  18.8    34.1 135.2
tqm8xx    Linux 2.6.33- 5714.3 3937.0  32.3K 6060.6  4210.0  14.2    34.5 131.4
tqm8xx    Linux 2.6.33- 5747.1 4000.0  31.2K 4329.0  4114.0 7.692    34.0 133.1
tqm8xx    Linux 2.6.33- 5747.1 4081.6  30.3K 4273.5  4100.0  18.2    34.2 135.0
tqm8xx    Linux 2.6.33- 5714.3 3952.6  31.2K 4273.5  4130.0  33.5    35.1 136.1
tqm8xx    Linux 2.6.33- 5714.3 3906.2  31.2K 6060.6  4105.0  25.7    35.5 135.9
tqm8xx    Linux 2.6.33- 5681.8 3921.6  32.3K 4255.3  4144.0  23.5    35.0 134.9
tqm8xx    Linux 2.6.33- 5649.7 3937.0  30.3K 4237.3  4116.0  21.6    35.3 135.3

Could you try reverting patch:
  8xx: Don't touch ACCESSED when no SWAP.
and see if that makes a difference?

Turning on pinned TLBs(you must turn on ADVANCED_OPTIONS first) could be an improvement,
regardless of my patches.

    Jocke
