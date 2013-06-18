Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 212D22C0E2E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:55:22 +1000 (EST)
Received: by mail-ie0-f169.google.com with SMTP id 10so9567653ied.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 01:55:19 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <51BFCF53.9050302@linux.vnet.ibm.com>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
 <1370825362-11145-9-git-send-email-grant.likely@linaro.org>
 <51BFCF53.9050302@linux.vnet.ibm.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 18 Jun 2013 09:54:58 +0100
Message-ID: <CACxGe6uTCL7jK4FDNfY0UdpiAQaXMJ8uwO=cWYE6iwQz94=4Ww@mail.gmail.com>
Subject: Re: [RFC 08/10] irqdomain: Refactor irq_domain_associate_many()
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 18, 2013 at 4:09 AM, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrot=
e:
> =E4=BA=8E 2013/6/10 8:49, Grant Likely =E5=86=99=E9=81=93:
>
>> Originally, irq_domain_associate_many() was designed to unwind the
>> mapped irqs on a failure of any individual association. However, that
>> proved to be a problem with certain IRQ controllers. Some of them only
>> support a subset of irqs, and will fail when attempting to map a
>> reserved IRQ. In those cases we want to map as many IRQs as possible, so
>> instead it is better for irq_domain_associate_many() to make a
>> best-effort attempt to map irqs, but not fail if any or all of them
>> don't succeed. If a caller really cares about how many irqs got
>> associated, then it should instead go back and check that all of the
>> irqs is cares about were mapped.
>>
>> The original design open-coded the individual association code into the
>> body of irq_domain_associate_many(), but with no longer needing to
>> unwind associations, the code becomes simpler to split out
>> irq_domain_associate() to contain the bulk of the logic, and
>> irq_domain_associate_many() to be a simple loop wrapper.
>>
>> This patch also adds a new error check to the associate path to make
>> sure it isn't called for an irq larger than the controller can handle,
>> and adds locking so that the irq_domain_mutex is held while setting up a
>> new association.
>>
>> Signed-off-by: Grant Likely <grant.likely@linaro.org>
[...]
>> -int irq_domain_associate_many(struct irq_domain *domain, unsigned int
>> irq_base,
>> -                             irq_hw_number_t hwirq_base, int count)
>> +int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
>> +                        irq_hw_number_t hwirq)
>>   {
>> -       unsigned int virq =3D irq_base;
>> -       irq_hw_number_t hwirq =3D hwirq_base;
>> -       int i, ret;>> +       struct irq_data *irq_data =3D irq_get_irq_=
data(virq);
>> +       int ret;
>>
>> -       pr_debug("%s(%s, irqbase=3D%i, hwbase=3D%i, count=3D%i)\n", __fu=
nc__,
>> -               of_node_full_name(domain->of_node), irq_base,
>> (int)hwirq_base, count);
>> +       if (WARN(hwirq >=3D domain->hwirq_max,
>> +                "error: hwirq 0x%x is too large for %s\n", (int)hwirq,
>> domain->name))
>> +               return -EINVAL;
>> +       if (WARN(!irq_data, "error: virq%i is not allocated", virq))
>> +               return -EINVAL;
>> +       if (WARN(irq_data->domain, "error: virq%i is already associated"=
,
>> virq))
>> +               return -EINVAL;
>
>
> Hi Grant,
>
> I have a qestion here, assume that we have three hwirqs and alloc three
> virqs, for first irq, it check irq_data
> and irq_data->domain pass, but the second is failed, then this code do
> nothing with failed( in
>
> irq_domain_associate_many()) and continue to associated the third one.
>
>
> This should be very dangours, even though I have no idea of when this cou=
ld
> happen.

Define what you mean by "dangerous". You are correct that it is a bad
situation, and the kernel will complain very loudly if it happens.
However, the users of irq_domain_associate_many() are usually irq
controllers using a legacy domain that needs to be set up during early
boot. If the IRQ controller setup fails and gets unwound, then it is
very likely that there will be no output at all from the kernel. This
has actually been a problem on a number of platforms and it is a big
part of why this irqdomain refactoring series wasn't merged 6 months
ago.

I think it is better to relax the behaviour of
irq_domain_associate_many() so that if something fails, then at least
it can limp along and try to get at least some of the irqs associated.
That way we can find and fix problematic platforms rather than failing
silently.

Also, I don't see anything particularly dangerous about this behaviour
other than having some of the hwirqs not being associated with a virq.
The code protects against this path and if an irq controller receives
an IRQ on a unassociated hwirq, then the kernel will also log that as
an error.

g.
