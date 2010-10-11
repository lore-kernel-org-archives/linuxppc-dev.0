Return-Path: <lnxninja@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73BC5B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 08:11:49 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9BKpHSQ028558
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 16:51:17 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9BLBjaD098964
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 17:11:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9BLBiFm010743
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 18:11:45 -0300
From: "Tim Pepper" <lnxninja@linux.vnet.ibm.com>
Date: Mon, 11 Oct 2010 14:11:40 -0700
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH] allow low HZ values?
Message-ID: <20101011211140.GC953@tpepper-t61p.dolavim.us>
References: <20101011201121.GA953@tpepper-t61p.dolavim.us>
	<alpine.LFD.2.00.1010112227190.2909@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.00.1010112227190.2909@localhost6.localdomain6>
Cc: Marcio Saito <marcio@cyclades.com>, John Stultz <johnstul@us.ibm.com>,
	Jiri Slaby <jirislaby@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Tim Pepper <lnxninja@linux.vnet.ibm.com>,
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

On Mon 11 Oct at 22:32:06 +0200 tglx@linutronix.de said:
> On Mon, 11 Oct 2010, Tim Pepper wrote:
> 
> > I'm not necessarily wanting to open up the age old question of "what is
> > a good HZ", but we were doing some testing on timer tick overheads for
> > HPC applications and this came up...
> 
> Yeah. This comes always up when the timer tick overhead on HPC is
> tested. And this patch is again the fundamentally wrong answer.

Yep.  Long term no hz is definitely the goal.  I'm not sufficiently
connected to the -rt space I guess to have followed that there's somebody
again looking in that direction.  The rfc patch was mostly just a minimal
is there anything simple we can do in the meantime exercise.

> We have told HPC folks for years that we need a kind of "NOHZ" mode
> for HPC where we can transparently switch off the tick when only one
> user space bound thread is active and switch back to normal once this
> thing terminates or goes into the kernel via a syscall.

I'd not heard of this in between NOHZ-y idea...sounds promising.
We'd talked about different non-idle no hz approaches in the past year
or so, some of which were on the veeery complicated side of the spectrum.

> Sigh, nothing
> happened ever except for repeating the same crap patches over and
> over.

I'll check out what Frederic is doing.  Thanks for the pointer and
apologies for the noise.

-- 
Tim Pepper  <lnxninja@linux.vnet.ibm.com>
IBM Linux Technology Center
