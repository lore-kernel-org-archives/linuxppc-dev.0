Return-Path: <yhlu.kernel@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id AEA64DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 11:01:06 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1707626rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 08 Nov 2008 16:01:05 -0800 (PST)
Message-ID: <86802c440811081601w2be45e55hc400095137831b85@mail.gmail.com>
Date: Sat, 8 Nov 2008 16:01:05 -0800
From: "Yinghai Lu" <yinghai@kernel.org>
Sender: yhlu.kernel@gmail.com
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/1] irq: Maintain user set affinity
In-Reply-To: <1226182645.13603.90.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
	<86802c440811081412u6d54beaam143801ce83225f40@mail.gmail.com>
	<1226182645.13603.90.camel@pasglop>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 8, 2008 at 2:17 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2008-11-08 at 14:12 -0800, Yinghai Lu wrote:
>> On Tue, Nov 4, 2008 at 8:31 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>> > From 819ad3ed4660f4238e053728a8b5aa93d22b13d7 Mon Sep 17 00:00:00 2001
>> > From: Kumar Gala <galak@kernel.crashing.org>
>> > Date: Tue, 4 Nov 2008 10:13:53 -0600
>> > Subject: [PATCH 1/1] irq: Maintain user set affinity
>> >
>> > This addresses a regression in that if a user specified an affinity
>> > for an interrupt that affinity information would get reset between
>> > a request_irq(), free_irq() and request_irq() for the same irq.
>> >
>> > On example of this is bringing up an ethernet interface, taking
>> > it down and bringing it back up again.
>> >
>> > Instead of always using the irq_default_affinity we use the
>> > previous setting of the IRQs affinity with the assumption that
>> > at boot the IRQs affinity will be set to irq_default_affinity.
>>
>> why ?, the default_affinity is expected behavior...
>>
>> for example: when MSI is used, second driver could get same irq if
>> first driver is unloaded.
>
> The default affinity should be set when the irq is allocated / assigned
> to a device, not when it's requested.

ok, you are right.

for MSI, affinity is set two times.

also in dynamic_irq_init is setting with
#ifdef CONFIG_SMP
        cpus_setall(desc->affinity);
#endif

it seems should use irq_default_affinity instead of CPU_MASK_ALL directly there.

YH
