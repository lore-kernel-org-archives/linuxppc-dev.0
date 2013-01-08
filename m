Return-Path: <vatsa@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine01.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C34DD2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2013 15:27:54 +1100 (EST)
Date: Mon, 7 Jan 2013 20:27:50 -0800
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] cpuhotplug/nohz: Remove offline cpus from
 nohz-idle state
Message-ID: <20130108042750.GA18214@quicinc.com>
References: <1357268318-7993-1-git-send-email-vatsa@codeaurora.org>
 <20130105103627.GU2631@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130105103627.GU2631@n2100.arm.linux.org.uk>
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
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [2013-01-05 10:36:27]:

> On Thu, Jan 03, 2013 at 06:58:38PM -0800, Srivatsa Vaddagiri wrote:
> > I also think that the
> > wait_for_completion() based wait in ARM's __cpu_die() can be replaced with a
> > busy-loop based one, as the wait there in general should be terminated within
> > few cycles.
> 
> Why open-code this stuff when we have infrastructure already in the kernel
> for waiting for stuff to happen?  I chose to use the standard infrastructure
> because its better tested, and avoids having to think about whether we need
> CPU barriers and such like to ensure that updates are seen in a timely
> manner.

I was primarily thinking of calling as few generic functions as possible on
a dead cpu. I recall several "am I running on a dead cpu?" checks
(cpu_is_offline(this_cpu) that were put in generic routines during early
versions of cpu hotplug [1] to educate code running on dead cpu, the need for
which went away though with introduction of atomic/stop-machine variant. The
need to add a RCU_NONIDLE() wrapper around ARM's cpu_die() [2] is perhaps a more
recent example of educating code running on dead cpu. As quickly we die as
possible after idle thread of dying cpu gains control, the better!

1. http://lwn.net/Articles/69040/
2. http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/107971.html

- vatsa
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
