Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 308322BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 05:26:41 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Wrobel Heinz-r39252" <Heinz.Wrobel@freescale.com>,
	"'Wolfgang Denk'" <wd@denx.de>
Date: Tue, 4 Jan 2005 19:26:22 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEOEMBCPAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <DF02D66C37C26B4C8018BF84F0E37FEC3AB842@zwg18exm01.ea.freescale.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: CPU15 errata workaround for 8xx by WD 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Heinz 

> Wolfgang, Joakim,
>  
> > I have to admit that I didn't believe our customer when  he  
> > reported that  he has problems that were caused by the CPU15 
> > bug - I never saw this on any other 8xx processor before, and 
> > as you say  it  has  been mentioned  in  all errata sheets I 
> > can remember. As far as I can tell it is only the MPC870/885 
> > duet family of processors where this  CPU15 bug actually 
> > hits. I have no idea why.
> 
> CPU15 is highly timing dependent. Even a single clock difference in the bus interface can make it (dis)appear.
> It can happen on Duet's as on any other 8xx ... or not.

Ahh, better not change any timing then on our boards :)
I have been running the cpu15 program from Wolfgang for 2 days now and no problem so far.

> 
> The simple workaround of invalidating the prev/next page is exactly that. Simple. It works, but for code with page 
> locality it can hurt performance because you would get excessive reloads. A smarter workaround affecting only pages that 
> need the workaround is preferrable, if it fits into the MMU table framework.

Are it there any know timing patterns that won't show this bug?

> 
> Heinz

Since you work at Freescale and appear to know 8xx I want to ask this:

Are there any plans on documenting/fixing the buggy cache insns. such dcbz, icbi etc. that
don't update the DAR register when causing a TLB Miss/Error?

I got this report from Motorola in May 2003:

We have generated the case of dcbx instruction and tlb miss
in verilog. We see that the DAR is not updated and the root couse is a
follows:

The load store treats dcbx instructions as a mtspr so it gets the tlb miss
error but does not update the DAR.

DAR is updated by two kind of errors
1) During the address phase.
2) During the data phase.


When there is a load store instruction the tlb miss error comes together
with the address phase. On dcbx instructions it comes one clock after the
address phase. So the DAR update mechanism does not update the DAR.


 Jocke
