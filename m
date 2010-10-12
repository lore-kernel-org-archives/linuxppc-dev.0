Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4885CB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 02:03:38 +1100 (EST)
From: Andi Kleen <andi@firstfloor.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH] allow low HZ values?
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
	<alpine.LFD.2.00.1010112227190.2909@localhost6.localdomain6>
Date: Tue, 12 Oct 2010 16:31:20 +0200
In-Reply-To: <alpine.LFD.2.00.1010112227190.2909@localhost6.localdomain6>
	(Thomas Gleixner's message of "Mon, 11 Oct 2010 22:32:06 +0200
	(CEST)")
Message-ID: <871v7v32kn.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcio Saito <marcio@cyclades.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Jiri Slaby <jirislaby@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <johnstul@us.ibm.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Tim Pepper <lnxninja@linux.vnet.ibm.com>, jblunck@infradead.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, 11 Oct 2010, Tim Pepper wrote:
>
>> I'm not necessarily wanting to open up the age old question of "what is
>> a good HZ", but we were doing some testing on timer tick overheads for
>> HPC applications and this came up...
>
> Yeah. This comes always up when the timer tick overhead on HPC is
> tested. And this patch is again the fundamentally wrong answer.

That's a unfair description of the proposal.

> We have told HPC folks for years that we need a kind of "NOHZ" mode
> for HPC where we can transparently switch off the tick when only one
> user space bound thread is active and switch back to normal once this
> thing terminates or goes into the kernel via a syscall. Sigh, nothing
> happened ever except for repeating the same crap patches over and
> over.

Jan Blunck posted a patch for this exactly few months ago.
Unfortunately it didn't get the accounting right, but other than
that it seemed like a reasonable starting point.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
