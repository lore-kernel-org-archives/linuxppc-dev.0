Return-Path: <roland@redhat.com>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id DD62BDDE9A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 10:59:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: ptrace CHECK_FULL_REGS
In-Reply-To: Benjamin Herrenschmidt's message of  Tuesday,
	25 September 2007 10:33:26 +1000
	<1190680406.12382.9.camel@localhost.localdomain>
References: <20070924235052.5AFC24D04B7@magilla.localdomain>
	<1190680406.12382.9.camel@localhost.localdomain>
Message-Id: <20070925005945.02E924D04B7@magilla.localdomain>
Date: Mon, 24 Sep 2007 17:59:44 -0700 (PDT)
Cc: David Woodhouse <dwmw2@redhat.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yup, I think I ditched most of them.. for some reason I decided it
> couldn't happen, but maybe I'm wrong ?

Well, it's a BUG_ON.  It's supposed to be for something that "can't happen".
That's why it's a sanity check, not a wild assertion. ;-)

The 2/2 patch is an example of a bug that CHECK_FULL_REGS catches.
In the status quo, using PTRACE_PEEKUSR in a bug case crashes while using
PTRACE_GETREGS in the same place might get bogus data.  (In the actual bug
thus found, the data is not bogus and only the bit that FULL_REGS checks is.)


Thanks,
Roland
