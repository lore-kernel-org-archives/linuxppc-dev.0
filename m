Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F881B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 07:32:41 +1100 (EST)
Date: Mon, 11 Oct 2010 22:32:06 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tim Pepper <lnxninja@linux.vnet.ibm.com>
Subject: Re: [RFC] [PATCH] allow low HZ values?
In-Reply-To: <20101011201121.GA953@tpepper-t61p.dolavim.us>
Message-ID: <alpine.LFD.2.00.1010112227190.2909@localhost6.localdomain6>
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcio Saito <marcio@cyclades.com>, John Stultz <johnstul@us.ibm.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Oct 2010, Tim Pepper wrote:

> I'm not necessarily wanting to open up the age old question of "what is
> a good HZ", but we were doing some testing on timer tick overheads for
> HPC applications and this came up...

Yeah. This comes always up when the timer tick overhead on HPC is
tested. And this patch is again the fundamentally wrong answer.

We have told HPC folks for years that we need a kind of "NOHZ" mode
for HPC where we can transparently switch off the tick when only one
user space bound thread is active and switch back to normal once this
thing terminates or goes into the kernel via a syscall. Sigh, nothing
happened ever except for repeating the same crap patches over and
over.

FYI, Frederic is working on that right now. He will talk about it at
the plumbers RT microconf, so you might catch him there.

Thanks,

	tglx
