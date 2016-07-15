Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrD2q1Q9bzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 10:29:07 +1000 (AEST)
Date: Fri, 15 Jul 2016 10:28:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, <rt@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bharata B Rao
 <bharata@linux.vnet.ibm.com>, Christophe Jaillet
 <christophe.jaillet@wanadoo.fr>, Linus Torvalds
 <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [patch V2 30/67] powerpc/numa: Convert to hotplug state machine
Message-ID: <20160715102825.34d60395@kryten>
In-Reply-To: <9e878731c9b447ee5e8318237822c492@www.linutronix.de>
References: <20160713153219.128052238@linutronix.de>
 <20160713153335.369278769@linutronix.de>
 <20160715074257.7801cd00@kryten>
 <9e878731c9b447ee5e8318237822c492@www.linutronix.de>
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

Hi Anna-Maria,

> >> Install the callbacks via the state machine and let the core invoke
> >> the callbacks on the already online CPUs.  
> >
> > This is causing an oops on ppc64le QEMU, looks like a NULL
> > pointer:  
> 
> Did you tested it against tip WIP.hotplug?

I noticed tip started failing in my CI environment which tests on QEMU.
The failure bisected to commit 425209e0abaf2c6e3a90ce4fedb935c10652bf80

It reproduces running ppc64le QEMU on a x86-64 box. On Ubuntu:

sudo apt-get install qemu-system-ppc gcc-powerpc64le-linux-gnu

make ARCH=powerpc pseries_le_defconfig

make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- vmlinux -j4

qemu-system-ppc64 -nographic -vga none -kernel vmlinux 

Anton
