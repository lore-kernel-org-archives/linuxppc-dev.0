Return-Path: <yinghai@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D1BDB7CF4
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 06:00:31 +1100 (EST)
Message-ID: <4B97EC00.6030300@kernel.org>
Date: Wed, 10 Mar 2010 10:59:12 -0800
From: Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>	
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>	
	<86802c441003100406t70dd854fx491f0ee9a6fce62b@mail.gmail.com>
	<1268225473.11737.69196.camel@zakaz.uk.xensource.com>
In-Reply-To: <1268225473.11737.69196.camel@zakaz.uk.xensource.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2010 04:51 AM, Ian Campbell wrote:
> On Wed, 2010-03-10 at 12:06 +0000, Yinghai Lu wrote:
>> On Wed, Mar 10, 2010 at 2:55 AM,  <ijc@hellion.org.uk> wrote:
>>> From: Ian Campbell <ian.campbell@citrix.com>
>>>
>>> Move arch_init_copy_chip_data and arch_free_chip_data into function
>>> pointers in struct irq_chip since they operate on irq_desc->chip_data.
>>>
>>> arch_init_chip_data cannot be moved into struct irq_chip at this time
>>> because irq_desc->chip is not known at the time the irq_desc is
>>> setup. For now rename arch_init_chip_data to arch_init_irq_desc (for
>>> PowerPC, the only other user, whose usage better matches the new name)
>>> and on x86 convert arch_init_chip_data to ioapic_init_chip_data and
>>> call this whenever the IO APIC code allocates a new IRQ.
>>>
>>> I've retained the chip_data behaviour for uv_irq although it isn't
>>> clear to me if these interrupt types support migration or how closely
>>> related to the APIC modes they really are. If it weren't for this the
>>> ioapic_{init,copy,free}_chip_data functions could be static to
>>> io_apic.c.
>>>
>>> I've tested by booting on a 64 bit system, but it's not clear to me
>>> what actions I need to take to actually exercise some of these code
>>> paths.
>>>
>>
>> can you just add another pointer field in irq_desc?
>>
>> some kind of *irq_info etc.
> 
> I think I don't understand what you are suggesting.
> 
> There is already a pointer for irq_chip specific use i.e.
> irq_desc->chip_data. This patchset is just about ensuring that the field
> really is available to any chip implementation rather than just assuming
> it is always used for the acpi chip types (on x86 at least).
> 
> Does adding a second pointer with the same (intended?) semantics as the
> existing one buy us anything?


#ifdef CONFIG_INTR_REMAP
        struct irq_2_iommu      *irq_2_iommu;
#endif
        struct irq_chip         *chip;
        struct msi_desc         *msi_desc;

we already have that for irq_2_iommu and msi_desc

YH
