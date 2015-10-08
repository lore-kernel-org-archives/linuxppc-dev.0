Return-Path: <jwboyer@gmail.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1D321A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 11:15:47 +1100 (AEDT)
Received: by iow1 with SMTP id 1so41136974iow.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2015 17:15:45 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1444263036.31685.2.camel@ellerman.id.au>
References: <560EA623.1040300@redhat.com>
 <1444102518.16909.3.camel@ellerman.id.au>
 <56141237.2040403@redhat.com>
 <1444197649.6794.7.camel@ellerman.id.au>
 <20151007071911.GA31002@gate.crashing.org>
 <1444209210.19375.1.camel@ellerman.id.au>
 <CA+5PVA7rpTbbVRJ_ze8Fndk+uxb2c=uqjkJRk+E9_aymu2fUew@mail.gmail.com>
 <1444263036.31685.2.camel@ellerman.id.au>
Date: Wed, 7 Oct 2015 20:15:45 -0400
Message-ID: <CA+5PVA4XggCNPo3eA0fTzsfe7rHEKqoZQwF3Rbj79wjZJFyAMg@mail.gmail.com>
Subject: Re: Missing operand for tlbie instruction on Power7
From: Josh Boyer <jwboyer@fedoraproject.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 Laura Abbott <labbott@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 7, 2015 at 8:10 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-10-07 at 10:31 -0400, Josh Boyer wrote:
>> On Wed, Oct 7, 2015 at 5:13 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > On Wed, 2015-10-07 at 02:19 -0500, Segher Boessenkool wrote:
>> >> On Wed, Oct 07, 2015 at 05:00:49PM +1100, Michael Ellerman wrote:
>> >> > > It's also worth noting that the __flush_power7 uses tlbiel instead of tlbie.
>> >> >
>> >> > Yeah that's a good point. It's not clear if the swsusp code wants to a local or
>> >> > a global invalidate.
>> >>
>> >> If I read the code right, this is called on the boot CPU when all the
>> >> non-boot CPUs are still (potentially) down, so if you would do a global
>> >> invalidate the non-boot CPUs might not even notice, so those need to do
>> >> a (local) invalidate after being brought up anyway?  Or they probably
>> >> need it before being brought down at all?  You figure it out, it makes
>> >> my brain hurt :-)
>> >
>> > A good rule would be that every cpu does a local invalidate before turning on
>> > the MMU. That would work for this case and also for kexec, kdump, junk left by
>> > firmare etc. But I don't think we do that consistently in a way that works for
>> > this code at the moment.
>> >
>> >> > As an alternative, can you try adding a .machine push / .machine "power4" /
>> >> > .machine pop, around the tlbie. That should tell the assembler to drop back to
>> >> > power4 mode for that instruction, which should then do the right thing. There
>> >> > are some examples in that file.
>> >>
>> >> That will get the assembler to not complain, but it will assemble the wrong
>> >> instruction: the power7 instruction has the same opcode (but different
>> >> semantics).  So if you assemble a "tlbie r4" in power4 mode, a newer CPU
>> >> will see it as a "tlbie r4,r0" and do the wrong thing.
>> >
>> > Yeah, it would basically maintain the existing behaviour which is wrong but a
>> > known quantity. I suspect no one has ever run this on Power7 or in fact
>> > anything other than G5 or Book3E.
>>
>> Likely not, but leaving it broken just because it is known behavior
>> seems pretty weird to me.
>
> In a universe where I have infinite time to fix random things we would
> obviously do a proper fix :)
>
>> I think Fedora will look at simply disabling hibernation on ppc64 so the file
>> isn't built at all.  Seems to be a safer option.
>
> It's safer for sure. Though you might have some G5 users who are using it and
> notice it being disabled.

The 5 of them will notice it being disabled and then they'll realize
they either get a working kernel minus hibernation, or they get no
kernel at all because it doesn't compile.

josh
