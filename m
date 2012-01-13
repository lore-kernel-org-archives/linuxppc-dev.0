Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B96BB6FCC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2012 11:48:01 +1100 (EST)
Received: by pbbb7 with SMTP id b7so719371pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 16:47:59 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F0F7B60.5040701@gmail.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Jan 2012 17:47:38 -0700
Message-ID: <CACxGe6vER6hTr0ez9_=bTL+F1n3DZHCa9Yc9fVGQ36i=X62sVQ@mail.gmail.com>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of the
 ppc one
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2012 at 5:31 PM, Rob Herring <robherring2@gmail.com> wrote:
> Adding lakml...
>
> On 01/11/2012 03:27 PM, Grant Likely wrote:
>> On Wed, Jan 11, 2012 at 2:15 PM, Rob Herring <robherring2@gmail.com> wro=
te:
>>> Grant,
>>>
>>> On 01/11/2012 02:22 PM, Grant Likely wrote:
>>>> This patch removes the simplistic implementation of irq_domains and en=
ables
>>>> the powerpc infrastructure for all irq_domain users. =A0The powerpc
>>>> infrastructure includes support for complex mappings between Linux and
>>>> hardware irq numbers, and can manage allocation of irq_descs.
>>>>
>>>> This patch also converts the few users of irq_domain_add()/irq_domain_=
del()
>>>> to call irq_domain_add_legacy() instead.
>>>
>>> So what is the non-legacy way? Legacy implies we don't want to do it
>>> that way. I guess until we remove all non-DT platforms with GIC we are
>>> stuck with legacy. That seems like it could be a ways out until we get
>>> there.
>>
>> Non-legacy is letting the irq_domain manage the irq_desc allocations.
>> Some of the controllers will be easy to convert, some will be more
>> difficult. =A0The primary thing that really blocks getting away from the
>> legacy method is anything that expects hardcoded #defined irq numbers.
>> =A0The goal is to convert all users over to the linear revmap method.
>>
>
> So I gave this a spin on highbank. I ran into a couple problems.
>
> I had to revert "irqdesc: Consolidate irq reservation logic" which is in
> your branch, but not this series. irq_alloc_desc_from was returning -EEXI=
ST.

Hmmm... I thought I sorted that out.  Thanks for letting me know.

>
> The GIC code did not work which I think is specific to using gic_of_init
> which makes irq_start =3D -1. With that it still doesn't work. It dies in
> gic_set_type... I've found one problem which I'll reply inline to, but I
> think this is a dead end path anyway.

Haha, I'm not surprised.  That last patch was only compile tested on
platforms using the gic.  I'm not surprised that I flubbed it.

> You have removed the irq_alloc_descs call from the GIC which is a step
> backwards. Several of the ARM DT enabled platforms are at the point they
> can fully support dynamic virq base for each irqchip. I changed the
> domain from legacy to linear and got things working.
> The issue with

I hadn't actually intended to remove the irq_alloc_descs in this
patch.  That was a leftover hunk from when I was playing with going
straight to irq_domain_add_linear().  For this specific patch, I'll
put the alloc back in and test it that way.  A follow-on patch can do
a proper conversion to the linear revmap.

> linear is for SPARSE_IRQ. The default behavior on ARM for SPARSE_IRQ is
> all nr_irqs are allocated at boot time before any controller is
> initialized. The only platform with a GIC and requiring SPARSE_IRQ is
> shmobile, but it is also the only one that calls irq_alloc_desc
> functions for it's interrupts. So I think we are okay there. The problem
> occurs when enabling SPARSE_IRQ for a non-DT platform with a GIC and
> with irqchips that don't call irq_alloc_desc for their irqs. IMHO, this
> should be an okay trade-off. There's no advantage to enabling SPARSE_IRQ
> on ARM for platforms that don't require it. All the platforms with a GIC
> have active work to convert to DT (except shmobile which I think is
> okay), so it's a temporary issue.

Actually, I believe Thomas' long term goal is to always enable
SPARSE_IRQ and remove the option entirely, so it should still be
properly resolved. I'll take a look next week if I don't get to it
tomorrow.  I need to resurrect my vexpress qemu test environment so I
can test the permutations.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
