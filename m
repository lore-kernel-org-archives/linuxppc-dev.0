Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D0EAA2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2013 21:59:44 +1100 (EST)
Date: Sat, 5 Jan 2013 10:36:27 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 1/2] cpuhotplug/nohz: Remove offline cpus from
 nohz-idle state
Message-ID: <20130105103627.GU2631@n2100.arm.linux.org.uk>
References: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, mhocko@suse.cz,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Mike Frysinger <vapier@gentoo.org>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 srivatsa.bhat@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2013 at 06:58:38PM -0800, Srivatsa Vaddagiri wrote:
> I also think that the
> wait_for_completion() based wait in ARM's __cpu_die() can be replaced with a
> busy-loop based one, as the wait there in general should be terminated within
> few cycles.

Why open-code this stuff when we have infrastructure already in the kernel
for waiting for stuff to happen?  I chose to use the standard infrastructure
because its better tested, and avoids having to think about whether we need
CPU barriers and such like to ensure that updates are seen in a timely
manner.

My stance on a lot of this idle/cpu dying code is that much of it can
probably be cleaned up and merged into a single common implementation -
in which case the use of standard infrastructure for things like waiting
for other CPUs do stuff is even more justified.
