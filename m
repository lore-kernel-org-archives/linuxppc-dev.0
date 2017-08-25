Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xfCqG0RM0zDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Aug 2017 06:45:45 +1000 (AEST)
Date: Fri, 25 Aug 2017 22:43:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Will Deacon <will.deacon@arm.com>
cc: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com, dvhart@infradead.org,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/1] futex: remove duplicated code and fix UB
In-Reply-To: <20170824094756.GA6346@arm.com>
Message-ID: <alpine.DEB.2.20.1708252243020.2124@nanos>
References: <20170824073105.3901-1-jslaby@suse.cz>
 <20170824094756.GA6346@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 Aug 2017, Will Deacon wrote:
> On Thu, Aug 24, 2017 at 09:31:05AM +0200, Jiri Slaby wrote:
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> > +{
> > +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);
> > +	int oldval, ret;
> > +
> > +	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
> > +		if (oparg < 0 || oparg > 31)
> > +			return -EINVAL;
> > +		oparg = 1 << oparg;
> > +	}
> > +
> > +	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> > +		return -EFAULT;
> > +
> > +	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
> > +	if (ret)
> > +		return ret;
> 
> We could move the pagefault_{disable,enable} calls here, and then remove
> them from the futex_atomic_op_inuser callsites elsewhere in futex.c

Correct, but we can do that after getting this in.

Thanks,

	tglx
