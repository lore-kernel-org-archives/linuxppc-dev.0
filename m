Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDD0C2C020F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 07:52:50 +1100 (EST)
Date: Thu, 6 Feb 2014 21:52:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/3] tick/cpuidle: Initialize hrtimer mode of broadcast
In-Reply-To: <52F3C9BE.4050203@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1402062151140.21991@ionos.tec.linutronix.de>
References: <20140206054158.4595.17827.stgit@preeti>
 <20140206055012.4595.55692.stgit@preeti>
 <alpine.DEB.2.02.1402061655560.21991@ionos.tec.linutronix.de>
 <52F3C9BE.4050203@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2009438275-1391719956=:21991"
Cc: deepthi@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 linux-pm@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2009438275-1391719956=:21991
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Thu, 6 Feb 2014, Preeti U Murthy wrote:
> On 02/06/2014 09:33 PM, Thomas Gleixner wrote:
> > On Thu, 6 Feb 2014, Preeti U Murthy wrote:
> > 
> > Compiler warnings are not so important, right?
> > 
> > kernel/time/tick-broadcast.c: In function ‘tick_broadcast_oneshot_control’:
> > kernel/time/tick-broadcast.c:700:3: warning: ‘return’ with no value, in function returning non-void [-Wreturn-type]
> > kernel/time/tick-broadcast.c:711:3: warning: ‘return’ with no value, in function returning non-void [-Wreturn-type]
> 
> My apologies for this, will make sure this will not repeat. On compilation I
> did not receive any warnings with the additional compile time flags too.I
> compiled it on powerpc. Let me look into why the warnings did not show up.
> Nevertheless I should have taken care of this even by simply looking at the
> code.

Huch, PPC seems to have an extra stupid version of gcc :)
 
> The cpuidle patch then is below. The trace_cpu_idle_rcuidle() functions have
> been moved around so that the broadcast CPU does not trace any idle event
> and that the symmetry between the trace functions and the call to the
> broadcast framework is  maintained. Wow, it does become very simple :)

Indeed :)

Care to resend the whole lot with all fixes applied and perhaps
compile tested on x86 :)
 
Thanks,

	tglx
--8323329-2009438275-1391719956=:21991--
