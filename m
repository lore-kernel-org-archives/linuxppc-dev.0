Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 004872BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jan 2005 08:58:27 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <wd@denx.de>
Date: Sun, 2 Jan 2005 22:58:15 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHCEPECJAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20050102205429.8F01DC14DD@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: CPU15 errata workaround for 8xx by WD 
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Dear Joakim,
> 
> in message <BCEFJBPJCGFCNMMMIDBHOEPBCJAA.Joakim.Tjernlund@lumentis.se> you wrote:
> > 
> > Had a look at your CPU15 errata workaround for 8xx and I have a comment
> > or two:
> > 
> > 1) I think you should make the sysctl support a compile time option
> >    as the overhead for sysctl support in the TLB handler is 6 instr. when
> >    the fix itself is only 4 instr.
> 
> You are right. For a permanent patch that would be better  -  in  our
> case  it  was important to be able to turn on and off this workaround
> dynamically with exactly the same kernel binary. We  wanted  to  have
> real  proof that the effects we saw were caused by CPU15 erratum, and
> that the workaround fixes these problems.

Have you done any performance measurements with with/without the CPU15
patch? To always invalidate the previous and the next TLB(plus the extra code in the
TLB handler) seems expensive.

> 
> > 2) You placed the workaround in the middle of the CPU6 workaround which will
> >    disable the CPU6 workaround(I think). Move it before the #ifdef CONFIG_8xx_CPU6
> >    and you should be fine.
> 
> I think you are right.
> 
> > 3) Your test program uses the dcbst and dcbi instr. and these are buggy as they do not
> >    update the DAR register in the TLB exceptions. I guess you made sure that such errors
> >    will not happen?
> 
> Ummm... I think so.

Me too, but I only had a quick look.

> 
> > 4) The CPU15 bug has been around for years I think, what made it show up now? New toolchains?
> 
> No, this is not a toolchain issue. It's a processor problem.
> 
> I have to admit that I didn't believe our customer when  he  reported
> that  he has problems that were caused by the CPU15 bug - I never saw
> this on any other 8xx processor before, and as you say  it  has  been
> mentioned  in  all errata sheets I can remember. As far as I can tell
> it is only the MPC870/885 duet family of processors where this  CPU15
> bug actually hits. I have no idea why.

That explains why I never seen this before, thanks.

A better fix would be to make the toolchain insert an extra NOP if
the last instr. in a page is a branch, but that will take some time.
Any GCC people on this list?

    Regards
            Joakim
> 
> Best regards,
> 
> Wolfgang Denk
