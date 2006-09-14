Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0852E67B76
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 09:36:22 +1000 (EST)
Date: Thu, 14 Sep 2006 16:36:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <17673.56806.552948.748504@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0609141633310.4388@g5.osdl.org>
References: <17671.64971.450232.870486@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609141208510.4388@g5.osdl.org>
	<17673.56806.552948.748504@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 15 Sep 2006, Paul Mackerras wrote:
> 
> Curious.  It doesn't look familiar.  I have had problems printing from
> my G5 in the past few weeks, but I attributed it to something being
> broken in debian unstable, and right now, running current git,
> printing is working again for me.

Ok, maybe the debian brokenness exists in FC5 too, and a "yum upgrade" 
broke it for me rather than any kernel work. I guess I'll just have to try 
different kernels and see if the kernel matters at all. The strace output 
just made me assume that maybe the kernel _does_ do something wrong.

> I just tried stracing the X server (I don't have a cupsd running) and
> the selects look reasonable, e.g.:
> 
> select(256, [1 3 4 5 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
> 26 27 28 29 30 32 33], NULL, NULL, {0, 484000}) = 1 (in [33], left {0,
> 460000}) <0.026111>
> 
> Is your cupsd a 32-bit or a 64-bit binary?

My cupsd is 32-bit (but so is my X server, so I'd assuge strace has the 
same breakage). Strace looks ok when I trace "firefox", though (which is 
using "poll()", not select). So..

		Linus
