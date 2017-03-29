Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtPZj0Z0YzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 21:46:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kirjanov@gmail.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: "linuxppc-dev\@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH] kvm: powerpc: book3s: Disable preemption while accessing
 paca xics_phys filed
In-Reply-To: <CAHj3AV=0dBL-2WfKcsVK57zYRWwnpz+w-89y8Tek5wGNVA-=qg@mail.gmail.com>
References: <1490603214-30116-1-git-send-email-kda@linux-powerpc.org>
 <87a884evrc.fsf@concordia.ellerman.id.au>
 <20170329093747.GC13844@fergus.ozlabs.ibm.com>
 <CAHj3AV=0dBL-2WfKcsVK57zYRWwnpz+w-89y8Tek5wGNVA-=qg@mail.gmail.com>
Date: Wed, 29 Mar 2017 21:46:34 +1100
Message-ID: <87d1d0jr79.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kirjanov@gmail.com> writes:

> On Wednesday, March 29, 2017, Paul Mackerras <paulus@ozlabs.org> wrote:
>
>> On Wed, Mar 29, 2017 at 12:07:03PM +1100, Michael Ellerman wrote:
>> > Denis Kirjanov <kda@linux-powerpc.org <javascript:;>> writes:
>> >
>> [...]
>> > > @@ -3930,7 +3934,11 @@ static int kvmppc_book3s_init_hv(void)
>> > >      * indirectly, via OPAL.
>> > >      */
>> > >  #ifdef CONFIG_SMP
>> > > -   if (!get_paca()->kvm_hstate.xics_phys) {
>> > > +   preempt_disable();
>> > > +   xics_phys = get_paca()->kvm_hstate.xics_phys;
>> > > +   preempt_enable();
>> > > +
>> > > +   if (!xics_phys) {
>> > >             struct device_node *np;
>> >
>> > Can you tell me what actual problem (other than the warning) this is
>> > fixing?
>>
>> If paca->kvm_hstate.xics_phys is non-zero on one cpu, it will be
>> non-zero on them all.  Therefore this is not fixing any actual
>> problem, just the warning.
>
> Then we can replace get_paca with local_paca to avoid the warning, right?

Yeah in this case I think that's fine. I dislike it somewhat because a
reader of that code now needs to know about what local_paca is but I
guess that's OK.

My point was that just sticking preempt_disable/enable() around every
get_paca() call is not the right way to deal with these warnings.

cheers
