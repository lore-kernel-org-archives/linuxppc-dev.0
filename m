Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id D0449B7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 06:19:17 +1100 (EST)
Message-ID: <4D349621.1040603@caviumnetworks.com>
Date: Mon, 17 Jan 2011 11:18:57 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
References: <1295262433.30950.53.camel@laptop>
In-Reply-To: <1295262433.30950.53.camel@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Russell King <linux@arm.linux.org.uk>,
	Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>,
	Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Mike Frysinger <vapier@gentoo.org>,
	user-mode-linux-devel@lists.sourceforge.net,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>,
	xen-devel@lists.xensource.com, Mikael Starvik <starvik@axis.com>,
	linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	user-mode-linux-user@lists.sourceforge.net,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-am33-list@redhat.com,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	"David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2011 03:07 AM, Peter Zijlstra wrote:
> For future rework of try_to_wake_up() we'd like to push part of that
> onto the CPU the task is actually going to run on, in order to do so we
> need a generic callback from the existing scheduler IPI.
>
> This patch introduces such a generic callback: scheduler_ipi() and
> implements it as a NOP.
>
> I visited existing smp_send_reschedule() implementations and tried to
> add a call to scheduler_ipi() in their handler part, but esp. for MIPS
> I'm not quite sure I actually got all of them.
>
> Also, while reading through all this, I noticed the blackfin SMP code
> looks to be broken, it simply discards any IPI when low on memory.
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>
> ---
>   arch/alpha/kernel/smp.c         |    1 +
>   arch/arm/kernel/smp.c           |    1 +
>   arch/blackfin/mach-common/smp.c |    3 ++-
>   arch/cris/arch-v32/kernel/smp.c |   13 ++++++++-----
>   arch/ia64/kernel/irq_ia64.c     |    2 ++
>   arch/ia64/xen/irq_xen.c         |   10 +++++++++-
>   arch/m32r/kernel/smp.c          |    2 +-
>   arch/mips/kernel/smtc.c         |    1 +
>   arch/mips/sibyte/bcm1480/smp.c  |    7 +++----
>   arch/mips/sibyte/sb1250/smp.c   |    7 +++----
[...]

Peter,

You will also have to patch the mailbox_interrupt() function in 
arch/mips/cavium-octeon/smp.c

David Daney.
