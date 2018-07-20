Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Ww0L0WW7zDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 12:32:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, ego@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
In-Reply-To: <1205bfc10c62986b4345fa258cf37e820c08226b.camel@neuling.org>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
 <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
 <20180718081249.GA17700@in.ibm.com>
 <1205bfc10c62986b4345fa258cf37e820c08226b.camel@neuling.org>
Date: Fri, 20 Jul 2018 12:32:43 +1000
Message-ID: <87tvoubpro.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:
> On Wed, 2018-07-18 at 13:42 +0530, Gautham R Shenoy wrote:
>> On Wed, Jul 18, 2018 at 09:24:19AM +1000, Michael Neuling wrote:
>> > 
>> > >  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
>> > > diff --git a/arch/powerpc/kernel/idle_book3s.S
>> > > b/arch/powerpc/kernel/idle_book3s.S
>> > > index d85d551..5069d42 100644
>> > > --- a/arch/powerpc/kernel/idle_book3s.S
>> > > +++ b/arch/powerpc/kernel/idle_book3s.S
>> > > @@ -120,6 +120,9 @@ power9_save_additional_sprs:
>> > >  	mfspr	r4, SPRN_MMCR2
>> > >  	std	r3, STOP_MMCR1(r13)
>> > >  	std	r4, STOP_MMCR2(r13)
>> > > +
>> > > +	mfspr	r3, SPRN_SPRG3
>> > > +	std	r3, STOP_SPRG3(r13)
>> > 
>> > We don't need to save it.  Just restore it from paca->sprg_vdso which should
>> > never change.
>> 
>> Ok. I will respin a patch to restore SPRG3 from paca->sprg_vdso.
>> 
>> > 
>> > How can we do better at catching these missing SPRGs?
>> 
>> We can go through the list of SPRs from the POWER9 User Manual and
>> document explicitly why we don't have to save/restore certain SPRs
>> during the execution of the stop instruction. Does this sound ok ?
>> 
>> (Ref: Table 4-8, Section 4.7.3.4 from the POWER9 User Manual
>> accessible from
>> https://openpowerfoundation.org/?resource_lib=power9-processor-users-manual)
>
> I was thinking of a boot time test case built into linux. linux has some boot
> time test cases which you can enable via CONFIG options.
>
> Firstly you could see if an SPR exists using the same trick xmon does in
> dump_one_spr(). Then once you have a list of usable SPRs, you could write all
> the known ones (I assume you'd have to leave out some, like the PSSCR), then set

Write what value?

Ideally you want to write a random bit pattern to reduce the chance
that only some bits are being restored.

But you can't do that because writing a value to an SPRs has an effect.

Some of them might even need to be zero, in which case you can't really
distinguish that from a non-restored zero.

> the appropriate stop level, make sure you got into that stop level, and then see
> if that register was changed. Then you'd have an automated list of registers you
> need to make sure you save/restore at each stop level.
>
> Could something like that work?

Maybe.

Ignoring the problem of whether you can write a meaningful value to some
of the SPRs, I'm not entirely convinced it's going to work. But maybe
I'm wrong.

But there's a much simpler solution, we should 1) have a selftest for
getcpu() and 2) we should be running the glibc (I think?) test suite
that found this in the first place. It's frankly embarrassing that we
didn't find this.

cheers
