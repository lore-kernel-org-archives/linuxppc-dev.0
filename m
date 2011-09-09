Return-Path: <olof@lixom.net>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 607B8B71AD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Sep 2011 04:43:42 +1000 (EST)
Received: by ywb3 with SMTP id 3so1861189ywb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Sep 2011 11:43:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110909173455.GH2435@linux.vnet.ibm.com>
References: <20110906180015.GA2560@linux.vnet.ibm.com>
	<1315332049-2604-48-git-send-email-paulmck@linux.vnet.ibm.com>
	<CAOesGMi--W6TCUMZzF07-Zep9Ta3tBJWZcG+5imEK_Hza0y9Jg@mail.gmail.com>
	<20110909173455.GH2435@linux.vnet.ibm.com>
Date: Fri, 9 Sep 2011 11:43:38 -0700
Message-ID: <CAOesGMj4WssrZQEWs09F45s16Bxv7F1q6Qv_4FZG3+rW2sddNg@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 48/55] powerpc: strengthen
	value-returning-atomics memory barriers
From: Olof Johansson <olof@lixom.net>
To: paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: mathieu.desnoyers@polymtl.ca, laijs@cn.fujitsu.com, eric.dumazet@gmail.com,
	patches@linaro.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	josh@joshtriplett.org, dhowells@redhat.com, darren@dvhart.com,
	niv@us.ibm.com, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	anton@samba.org, Valdis.Kletnieks@vt.edu, mingo@elte.hu,
	akpm@linux-foundation.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 9, 2011 at 10:34 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Fri, Sep 09, 2011 at 10:23:33AM -0700, Olof Johansson wrote:
>> [+linuxppc-dev]
>>
>> On Tue, Sep 6, 2011 at 11:00 AM, Paul E. McKenney
>> <paulmck@linux.vnet.ibm.com> wrote:
>> > The trailing isync/lwsync in PowerPC value-returning atomics needs
>> > to be a sync in order to provide the required ordering properties.
>> > The leading lwsync/eieio can remain, as the remainder of the required
>> > ordering guarantees are provided by the atomic instructions: Any
>> > reordering will cause the stwcx to fail, which will result in a retry.
>>
>> Admittedly, my powerpc barrier memory is starting to fade, but isn't
>> isync sufficient here? It will make sure all instructions before it
>> have retired, and will restart any speculative/issued instructions
>> beyond it.
>>
>> lwsync not being sufficient makes sense since a load can overtake it.
>
> As I understand it, although isync waits for the prior stwcx to execute,
> it does not guarantee that the corresponding store is visible to all
> processors before any following loads.

Ah yes, combined with brushing up on the semantics in
memory-barriers.txt, this sounds reasonable to me.

>> > diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/a=
sm/synch.h
>> > index d7cab44..4d97fbe 100644
>> > --- a/arch/powerpc/include/asm/synch.h
>> > +++ b/arch/powerpc/include/asm/synch.h
>> > @@ -37,11 +37,7 @@ static inline void isync(void)
>> > =A0#endif
>> >
>> > =A0#ifdef CONFIG_SMP
>> > -#define __PPC_ACQUIRE_BARRIER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0\
>> > - =A0 =A0 =A0 START_LWSYNC_SECTION(97); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
>> > - =A0 =A0 =A0 isync; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> > - =A0 =A0 =A0 MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
>> > -#define PPC_ACQUIRE_BARRIER =A0 =A0"\n" stringify_in_c(__PPC_ACQUIRE_=
BARRIER)
>> > +#define PPC_ACQUIRE_BARRIER =A0 =A0"\n" stringify_in_c(sync;)
>>
>> This can just be done as "\n\tsync\n" instead of the stringify stuff.
>
> That does sound a bit more straightforward, now that you mention it. =A0;=
-)

With that change, I'm:

Acked-by: Olof Johansson <olof@lixom.net>

But at least Ben or Anton should sign off on it too.


-Olof
