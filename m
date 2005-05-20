Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 3B44C679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 09:51:23 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1061443wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 16:51:22 -0700 (PDT)
Message-ID: <c3d0340b0505201651163b35cb@mail.gmail.com>
Date: Fri, 20 May 2005 16:51:22 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050520131620.B881@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b050518175411c484e3@mail.gmail.com>
	<20050519012404.GA11587@gate.ebshome.net>
	<c3d0340b05051818524c647e61@mail.gmail.com>
	<20050519020953.GB11587@gate.ebshome.net>
	<c3d0340b050520111228a6f4cd@mail.gmail.com>
	<20050520131620.B881@cox.net>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: DMA consistent allocation is limited to 2MB on 2.6.11 for
	ppc440?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

First of all thanks for your attention. :)

> Why are you using consistent memory for your DMA buffers?

Both CPU and IO controller (e.g. FC controller) have to be aware of
changes the other party makes on the data buffer. Some architectures
guarantee this coherence through bus snooping, which ppc440 is
unfortunately lack of. The simplest solution is to use consistent
memory.. On 2.4.x to some extent we don't need worry about how much
consistent memory is available. So the developers used consistent
mappings a lot instead of streaming DMA mappings. We would have been
more conservative to use consistent mappings had we known the
limitation earlier.

> The difference with this implementation is that it doesn't allow for
> arbitrarily huge consistent allocations by default.  However, I carefully
> placed a comment at the top to point people to the advanced setup
> menu where they can tune the consistent pool to be larger than the
> 2MB default.  You simply have to understand the memory map of your

I noticed your comment about the advanced settings:
CONFIG_CONSISTENT_SIZE and _START. However simply increasing the value
of CONSISTENT_SIZE won't get rid of the limiation. Right? The root
cause is in consistent_pte, which is only one page. It may be good to
have consistent_pte have more than one pages according to the
CONSISTENT_SIZE. Is it a useful fix?

> board port when setting this option.  You can break things as with
> other advanced setup menu options.

OK. Have to be very careful here.

Best regards,
-Shawn.
