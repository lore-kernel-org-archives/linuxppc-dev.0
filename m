Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43550B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2012 16:53:26 +1000 (EST)
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
Date: Sat, 26 May 2012 00:53:20 -0600
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 (Li Yang-R's message of "Mon, 21 May 2012 06:31:48 +0000")
Message-ID: <g7gvzbfhb.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 ashish kalra <ashish.kalra@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Yang-R58472 <r58472@freescale.com> writes:

> Thanks for bringing [CONFIG_MPC8315_DS] up again.  Looks like we do
> have a problem here.

My impression is that the simplest fix is Adrian's patch, which simply
keys off CONFIG_MPC831x_RDB.  It's not very satisfying, but I'll take
"working" vs. "rare lockups at boot".

If there is some other defining characteristic of boards that require
this patch, then a simple KConfig snippit with a description would be
even better.  Without any KConfig support for this variable, I lost it
even after using an oldconfig from my vendor.

(Or, if it was preserved, I might have removed it when trying to
optimize the kernel for support for our hardware, and I had no way of
knowing that the MPC8315_DS had any impact on my system at all...)

If it's actually a CPU/SOC-level problem, then an ideal situation
would conditionalize the fix by examining CPU version or stepping.
That would allow us to get rid of the config variable entirely.

> Btw, did it help with your problem by enabling it?

Possibly.  :)

I only saw the problem (failure to SATA handshake at 3Gbps?) very
rarely, maybe one in 100 warm boot cycles.

I've added the patch to my current project, and have not seen the
problem since then, but until I'm problem free for another few weeks,
I can't sign off on it.

It certainly does look like a reasonable band-aid fix.  In our case,
we don't need anywhere near the higher bandwidth, so it's acceptable
from that point of view.

A clear statement or reference to a CPU / SOC errata would be
preferred, though.  It's a 4-year-old design, so even a brown paper
bag bug isn't all that embarrassing anymore.  :)

Thanks,
Tony

p.s. This board also seems to suffer from occasionaly USB lockups on
     boot; if you end up digging through errata on 8315-based boards,
     please keep an eye out for that as well.  Thanks!  Link:

        http://patchwork.ozlabs.org/patch/152755/

     I'm currently using that patch as well as a 10ms delay to try to
     avoid the hang.  Successfully, so far, but a "blessed" solution
     from FSL would be awesome.
