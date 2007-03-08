Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17903.33399.786962.498809@cargo.ozlabs.ibm.com>
Date: Thu, 8 Mar 2007 14:26:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Subject: Re: [patch 2/6 -rt] powerpc 2.6.20-rt8: to convert spinlocks to raw
	ones.
In-Reply-To: <20070308004344.GA23200@gnuppy.monkey.org>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi649d25qz.wl@toshiba.co.jp>
	<45EECE5C.6030100@ru.mvista.com>
	<17902.60669.945986.186995@cargo.ozlabs.ibm.com>
	<45EEF6A4.9090807@ru.mvista.com>
	<17903.4302.502364.126701@cargo.ozlabs.ibm.com>
	<45EF2CD8.3050804@ru.mvista.com>
	<17903.12035.781782.317694@cargo.ozlabs.ibm.com>
	<20070308004344.GA23200@gnuppy.monkey.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bill Huey (hui) writes:

> The places that need to be reverted to raw spinlocks are generally either
> acquired by function calls that allocate the spinlock at a terminal of the
> kernel's lock graph or isolated from other callers completely (parts of the
> timer for logic for instance). It's all about the collision of various lock
> (preemptive and non-preemptive) subtrees and how to avoid scheduling within
> atomic violations that lead to deadlocks. The -rt patch gets arbitrary
> preemption abilities by shrinking the non-preemptive sub-tree bit to the bare
> essentials of what will let a system to run yet still preserve all of
> the expected locking semantics of a critical section.

Thanks; that's an interesting explanation.

It misses the point of what I was saying to Sergei, though, which was
*not* "I don't understand your patch", it was "if this patch goes into
a git tree, someone coming along in 3 years time won't understand the
patch."  In other words I was ranting about the need for a decent
description to accompany the patch itself, so it would go into the
permanent record.

Regards,
Paul.
