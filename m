Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MLwQ4yVYzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 23:14:25 +1000 (AEST)
Date: Thu, 12 Apr 2018 14:14:04 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: "Dmitry V. Levin" <ldv@altlinux.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180412131404.GE16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412124928.GA29458@altlinux.org>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2018 at 03:49:28PM +0300, Dmitry V. Levin wrote:
> The "KERNEL BUG" diagnostics I was talking about was added to strace yesterday
> as a part of workaround commit, see
> https://github.com/strace/strace/commit/34c7794cc16e2511eda7b1d5767c655a83b17309
> Before that change the test just failed.

Ah, seeing the test case really helps to see exactly what and why it's
broken.  Yes, Eric's commit was definitely wrong and needs to be
reverted, because it incorrectly changes what happens when kill(1) is
used to deliver a SIGFPE signal to a process.

Eric, please sort this out - you have a much better handle on whether
there are any dependencies here that would need to be resolved from
a simple revert of the offending commits, but that revert must happen
because you've caused a user visible regression.

The original code _was_ safe even if it wasn't correct to the specs,
as we'd end up copying the si_addr field (as the si_pid copy) and a
zeroed field as the si_uid copy.  It was just that si_code was
technically wrong, and that's something that would be even more
dangerous to change now.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
