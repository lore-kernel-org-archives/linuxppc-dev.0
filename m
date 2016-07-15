Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrR1K0YrxzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 18:43:33 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id q128so1326365wma.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 01:43:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 15 Jul 2016 10:43:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Anton Blanchard <anton@samba.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, rt@linutronix.de,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 30/67] powerpc/numa: Convert to hotplug state machine
Message-ID: <20160715084324.GB1056@gmail.com>
References: <20160713153219.128052238@linutronix.de>
 <20160713153335.369278769@linutronix.de>
 <20160715074257.7801cd00@kryten>
 <9e878731c9b447ee5e8318237822c492@www.linutronix.de>
 <20160715102825.34d60395@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715102825.34d60395@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> Hi Anna-Maria,
> 
> > >> Install the callbacks via the state machine and let the core invoke
> > >> the callbacks on the already online CPUs.  
> > >
> > > This is causing an oops on ppc64le QEMU, looks like a NULL
> > > pointer:  
> > 
> > Did you tested it against tip WIP.hotplug?
> 
> I noticed tip started failing in my CI environment which tests on QEMU.
> The failure bisected to commit 425209e0abaf2c6e3a90ce4fedb935c10652bf80

That's very useful, thanks Anton!

I have removed this commit from the series for the time being, refactored the 
followup commits (there was one trivial conflict). We can re-try this patch when a 
fix is found.

Thanks,

	Ingo
