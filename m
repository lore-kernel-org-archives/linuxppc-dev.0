Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.citrix.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 322CFB7CF3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 22:11:14 +1100 (EST)
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
From: Ian Campbell <Ian.Campbell@citrix.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Mar 2010 11:00:32 +0000
Message-ID: <1268218832.11737.68575.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, "H.
	Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-03-10 at 10:55 +0000, ijc@hellion.org.uk wrote:
> 
> arch_init_chip_data cannot be moved into struct irq_chip at this time
> because irq_desc->chip is not known at the time the irq_desc is
> setup. For now rename arch_init_chip_data to arch_init_irq_desc (for
> PowerPC, the only other user, whose usage better matches the new name)
> and on x86 convert arch_init_chip_data to ioapic_init_chip_data and
> call this whenever the IO APIC code allocates a new IRQ.

One idea I had to improve this was to add a struct irq_chip * as a
parameter to irq_to_desc_alloc_node. The new parameter potentially could
be NULL for current behaviour. Does that sound like a reasonable
approach?

Ian.
