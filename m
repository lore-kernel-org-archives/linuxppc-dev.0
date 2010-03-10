Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id A8D20B6EFF
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 23:06:16 +1100 (EST)
Received: by pvg11 with SMTP id 11so332681pvg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 04:06:15 -0800 (PST)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
Date: Wed, 10 Mar 2010 04:06:14 -0800
Message-ID: <86802c441003100406t70dd854fx491f0ee9a6fce62b@mail.gmail.com>
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
From: Yinghai Lu <yinghai@kernel.org>
To: ijc@hellion.org.uk
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Ian Campbell <ian.campbell@citrix.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
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

On Wed, Mar 10, 2010 at 2:55 AM,  <ijc@hellion.org.uk> wrote:
> From: Ian Campbell <ian.campbell@citrix.com>
>
> Move arch_init_copy_chip_data and arch_free_chip_data into function
> pointers in struct irq_chip since they operate on irq_desc->chip_data.
>
> arch_init_chip_data cannot be moved into struct irq_chip at this time
> because irq_desc->chip is not known at the time the irq_desc is
> setup. For now rename arch_init_chip_data to arch_init_irq_desc (for
> PowerPC, the only other user, whose usage better matches the new name)
> and on x86 convert arch_init_chip_data to ioapic_init_chip_data and
> call this whenever the IO APIC code allocates a new IRQ.
>
> I've retained the chip_data behaviour for uv_irq although it isn't
> clear to me if these interrupt types support migration or how closely
> related to the APIC modes they really are. If it weren't for this the
> ioapic_{init,copy,free}_chip_data functions could be static to
> io_apic.c.
>
> I've tested by booting on a 64 bit system, but it's not clear to me
> what actions I need to take to actually exercise some of these code
> paths.
>

can you just add another pointer field in irq_desc?

some kind of *irq_info etc.

YH
