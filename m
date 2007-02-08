Return-Path: <olecom@flower.upol.cz>
Received: from raven.upol.cz (raven.upol.cz [158.194.120.4])
	by ozlabs.org (Postfix) with ESMTP id 6837ADDE2E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 23:40:49 +1100 (EST)
Date: Thu, 8 Feb 2007 13:35:40 +0100
To: David Miller <davem@davemloft.net>
Subject: Re: Kbuild change breaks the ppc64 build
Message-ID: <20070208123540.GT22699@flower.upol.cz>
References: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
	<20070208.040003.112623191.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070208.040003.112623191.davem@davemloft.net>
From: Oleg Verych <olecom@flower.upol.cz>
Cc: torvalds@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 08, 2007 at 04:00:03AM -0800, David Miller wrote:
> From: Paul Mackerras <paulus@samba.org>
> Date: Thu, 8 Feb 2007 22:10:54 +1100
[]
> Linus and Oleg tried to fix it with various subsequent changes
> to scripts/Kbuild.include, but it's still broken.

And Roland McGrath, but it turned to be very bad.

Maybe you have older set of fixes. I have x86-64 and i386 built,
though with make 3.81(debian).

But it may be ppc specific, as

        CFLAGS += $(call cc-option,-mcpu=970)
	else
	CFLAGS += $(call cc-option,-mcpu=power4)

may be turned to be options without spaces (make V=1)!

> For some reason $(call ...) invocations add spaces.  I tried
> another test case:
> 
> define test
>  $(shell echo -n)
> endef
> 
> VAR:=$(call test)
> 
> all:
> 	@echo "\'$(VAR)\'"
> 
> And this always prints:
> 
> ' TEST'
> 
> even with GNU Make version 3.81
> 
> If I put a $(strip ...) around the define, the space is
> still there.  If I put the $(strip ...) around VAR's
> $(call), the space goes away.

____
