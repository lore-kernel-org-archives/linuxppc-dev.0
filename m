Return-Path: <paulus@ozlabs.org>
Date: Wed, 28 Jul 2010 09:41:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 04/11] powerpc: Simplify update_vsyscall
Message-ID: <20100727234152.GC14947@brick.ozlabs.ibm.com>
References: <1279068988-21864-1-git-send-email-johnstul@us.ibm.com>
	<1279068988-21864-2-git-send-email-johnstul@us.ibm.com>
	<1279068988-21864-3-git-send-email-johnstul@us.ibm.com>
	<1279068988-21864-4-git-send-email-johnstul@us.ibm.com>
	<1279068988-21864-5-git-send-email-johnstul@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279068988-21864-5-git-send-email-johnstul@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 13, 2010 at 05:56:21PM -0700, John Stultz wrote:

> Currently powerpc's update_vsyscall calls an inline update_gtod.
> However, both are straightforward, and there are no other users,
> so this patch merges update_gtod into update_vsyscall.
> 
> Compiles, but otherwise untested.

This and the following two patches will cause interesting conflicts
with two commits in Ben Herrenschmidt's powerpc.git next branch,
specifically 8fd63a9e ("powerpc: Rework VDSO gettimeofday to prevent
time going backwards") and c1aa687d ("powerpc: Clean up obsolete code
relating to decrementer and timebase") from me.  In fact the first of
those two commits includes changes equivalent to those in your 5/11
patch ("powerpc: Cleanup xtime usage"), as far as I can see.

BTW, BenH's tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

Paul.
