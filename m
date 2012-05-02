Return-Path: <hughd@google.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D056B6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 08:54:27 +1000 (EST)
Received: by vbip1 with SMTP id p1so143730vbi.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2012 15:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120502215406.GL2450@linux.vnet.ibm.com>
References: <alpine.LSU.2.00.1204301451270.2986@eggly.anvils>
 <1335832418.20866.95.camel@pasglop>
 <alpine.LSU.2.00.1204302142310.27208@eggly.anvils>
 <20120501142208.GA2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205011410360.28232@eggly.anvils>
 <20120501232516.GR2441@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1205021324430.24246@eggly.anvils>
 <1335993615.4088.1.camel@pasglop>
 <20120502215406.GL2450@linux.vnet.ibm.com>
Date: Wed, 2 May 2012 15:54:24 -0700
Message-ID: <CANsGZ6bw4JwMRgUriooDvFB=g-HkpyL8XJa9s47RPfOEPCMcpw@mail.gmail.com>
Subject: Re: linux-next ppc64: RCU mods cause __might_sleep BUGs
From: Hugh Dickins <hughd@google.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "Paul E. McKenney" <paul.mckenney@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2012 at 2:54 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Thu, May 03, 2012 at 07:20:15AM +1000, Benjamin Herrenschmidt wrote:
>> On Wed, 2012-05-02 at 13:25 -0700, Hugh Dickins wrote:
>> > Got it at last. =C2=A0Embarrassingly obvious. =C2=A0__rcu_read_lock() =
and
>> > __rcu_read_unlock() are not safe to be using __this_cpu operations,
>> > the cpu may change in between the rmw's read and write: they should
>> > be using this_cpu operations (or, I put preempt_disable/enable in the
>> > __rcu_read_unlock below). =C2=A0__this_cpus there work out fine on x86=
,
>> > which was given good instructions to use; but not so well on PowerPC.
>> >
>> > I've been running successfully for an hour now with the patch below;
>> > but I expect you'll want to consider the tradeoffs, and may choose a
>> > different solution.
>>
>> Didn't Linus recently rant about these __this_cpu vs this_cpu nonsense ?
>>
>> I thought that was going out..
>
> Linus did rant about __raw_get_cpu_var() because it cannot use the x86
> %fs segement overrides a bit more than a month ago. =C2=A0The __this_cpu
> stuff is useful if you have preemption disabled -- avoids the extra
> layer of preempt_disable().
>
> Or was this a different rant?

https://lkml.org/lkml/2011/11/29/321

I think it ended up with Christoph removing the more egregious
variants, but this_cpu_that and __this_cpu_the_other remaining.

Hugh
