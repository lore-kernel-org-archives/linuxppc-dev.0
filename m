Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B242DB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 22:54:02 +1100 (EST)
Date: Mon, 17 Jan 2011 11:26:37 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
Message-ID: <20110117112637.GA18599@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295262433.30950.53.camel@laptop>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>,
	sparclinux@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
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
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 17, 2011 at 12:07:13PM +0100, Peter Zijlstra wrote:
> diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
> index 42aa078..c4a570b 100644
> --- a/arch/alpha/kernel/smp.c
> +++ b/arch/alpha/kernel/smp.c
> @@ -587,6 +587,7 @@ handle_ipi(struct pt_regs *regs)
>  		case IPI_RESCHEDULE:
>  			/* Reschedule callback.  Everything to be done
>  			   is done by the interrupt return path.  */
> +			scheduler_ipi();
>  			break;
>  
>  		case IPI_CALL_FUNC:
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 9066473..ffde790 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -579,6 +579,7 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
>  				 * nothing more to do - eveything is
>  				 * done on the interrupt return path
>  				 */
> +				scheduler_ipi();

Maybe remove the comment "everything is done on the interrupt return path"
as with this function call, that is no longer the case.

Looks like the same is true for Alpha as well?
