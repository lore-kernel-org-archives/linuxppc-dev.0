Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4351B7C0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 02:24:22 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Date: Fri, 30 Oct 2009 16:24:01 +0100
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>
	<20091030150855.GA15046@mail.gnudd.com>
In-Reply-To: <20091030150855.GA15046@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200910301624.03989.mb@bu3sch.de>
Cc: scottwood@freescale.com, bgat@billgatliff.com,
	linuxppc-dev@lists.ozlabs.org, Jonathan.Haws@sdl.usu.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 30 October 2009 16:08:55 Alessandro Rubini wrote:
> > asm("eieio; sync");
> 
> Hmm...
> 	: : : "memory"
> 
> And, doesn't ";" start a comment in assembly? (no, not on powerpc it seems)

Yes, I think the barrier is wrong.
Please try with

#define mb()	__asm__ __volatile__("eieio\n sync\n" : : : "memory")

-- 
Greetings, Michael.
