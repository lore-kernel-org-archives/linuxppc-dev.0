Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 3562F2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jan 2005 07:54:56 +1100 (EST)
To: Joakim.Tjernlund@lumentis.se
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 02 Jan 2005 15:12:01 +0100."
	<BCEFJBPJCGFCNMMMIDBHOEPBCJAA.Joakim.Tjernlund@lumentis.se>
Date: Sun, 02 Jan 2005 21:54:24 +0100
Sender: wd@denx.de
Message-Id: <20050102205429.8F01DC14DD@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPU15 errata workaround for 8xx by WD 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Joakim,

in message <BCEFJBPJCGFCNMMMIDBHOEPBCJAA.Joakim.Tjernlund@lumentis.se> you wrote:
> 
> Had a look at your CPU15 errata workaround for 8xx and I have a comment
> or two:
> 
> 1) I think you should make the sysctl support a compile time option
>    as the overhead for sysctl support in the TLB handler is 6 instr. when
>    the fix itself is only 4 instr.

You are right. For a permanent patch that would be better  -  in  our
case  it  was important to be able to turn on and off this workaround
dynamically with exactly the same kernel binary. We  wanted  to  have
real  proof that the effects we saw were caused by CPU15 erratum, and
that the workaround fixes these problems.

> 2) You placed the workaround in the middle of the CPU6 workaround which will
>    disable the CPU6 workaround(I think). Move it before the #ifdef CONFIG_8xx_CPU6
>    and you should be fine.

I think you are right.

> 3) Your test program uses the dcbst and dcbi instr. and these are buggy as they do not
>    update the DAR register in the TLB exceptions. I guess you made sure that such errors
>    will not happen?

Ummm... I think so.

> 4) The CPU15 bug has been around for years I think, what made it show up now? New toolchains?

No, this is not a toolchain issue. It's a processor problem.

I have to admit that I didn't believe our customer when  he  reported
that  he has problems that were caused by the CPU15 bug - I never saw
this on any other 8xx processor before, and as you say  it  has  been
mentioned  in  all errata sheets I can remember. As far as I can tell
it is only the MPC870/885 duet family of processors where this  CPU15
bug actually hits. I have no idea why.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Brain: an apparatus with which we think we think.    - Ambrose Bierce
