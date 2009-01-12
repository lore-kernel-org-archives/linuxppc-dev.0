Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB191DE0F0
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 21:44:25 +1100 (EST)
Date: Mon, 12 Jan 2009 11:44:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090112104402.GD10405@elte.hu>
References: <20090112104837.69feedec.sfr@canb.auug.org.au>
	<1231719015.22571.4.camel@pasglop> <20090112090552.GD26750@elte.hu>
	<1231753791.8959.7.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231753791.8959.7.camel@localhost>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Michael Ellerman <michael@ellerman.id.au> wrote:

> On Mon, 2009-01-12 at 10:05 +0100, Ingo Molnar wrote:
> > * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > On Mon, 2009-01-12 at 10:48 +1100, Stephen Rothwell wrote:
> > > > Hi Linus,
> > > > 
> > > > Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> > > > 
> > > > arch/powerpc/platforms/pasemi/cpufreq.c: In function 'pas_cpufreq_cpu_init':
> > > > arch/powerpc/platforms/pasemi/cpufreq.c:216: error: incompatible types in assignment
> > > > arch/powerpc/platforms/powermac/cpufreq_64.c: In function 'g5_cpufreq_cpu_init':
> > > > arch/powerpc/platforms/powermac/cpufreq_64.c:365: error: incompatible types in assignment
> > > > arch/powerpc/platforms/cell/cbe_cpufreq.c: In function 'cbe_cpufreq_cpu_init':
> > > > arch/powerpc/platforms/cell/cbe_cpufreq.c:121: error: incompatible types in assignment
> > > > 
> > > > Caused by commit 835481d9bcd65720b473db6b38746a74a3964218 ("cpumask:
> > > > convert struct cpufreq_policy to cpumask_var_t") which missed updating
> > > > all the powerpc (at least) cpufreq drivers.
> > > 
> > > Yeah, it only updates x86 it seems ... 
> > 
> > Yeah - and that build bug was stupid too - when touching a generic file 
> > that is called include/linux/cpufreq.h and changing a key data field one 
> > should at minimum get the idea that it's generic for a reason and should 
> > start grepping the tree ...
> > 
> > It slipped through because it didnt get caught in build tests because 
> > cpufreq isnt enabled in the powerpc defconfig.
> 
> Which defconfig?
>
> powerpc(master) $ git grep CPU_FREQ=y arch/powerpc/configs/ppc64_defconfig
> arch/powerpc/configs/ppc64_defconfig:CONFIG_CPU_FREQ=y

ah, indeed - you are right.

	Ingo
