Return-Path: <bhelgaas@google.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 636B91A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 04:35:32 +1000 (AEST)
Received: by wgkl9 with SMTP id l9so32807127wgk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 11:35:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150713032303.D49801402B1@ozlabs.org>
References: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150713032303.D49801402B1@ozlabs.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Jul 2015 13:35:09 -0500
Message-ID: <CAErSpo52Kk0c=1UHQzxntJc3ph_CX8vcY+QdULBKv-HGUHBK9Q@mail.gmail.com>
Subject: Re: [3/3] IRQ: Print "unexpected IRQ" messages consistently across
 architectures
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 linux-am33-list@redhat.com,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 12, 2015 at 10:23 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sun, 2015-12-07 at 22:02:11 UTC, Bjorn Helgaas wrote:
>> Many architectures use a variant of "unexpected IRQ trap at vector %x" to
>> log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
>> number, but "vector" more often refers to a CPU vector number, and (b) it
>> prints the IRQ number in hex with no base indication, while Linux IRQ
>> numbers are usually printed in decimal.
>>
>> Print the same text ("unexpected IRQ %d") across all architectures.
>>
>> No functional change other than the output text.
>
> There's already a fallback version in asm-generic, so shouldn't you instead
> just delete all the versions that are identical to that?
>
> eg. on powerpc we have:
>
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -     printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +     printk(KERN_CRIT "unexpected IRQ %d\n", irq);
>>  }
>
> And the generic version is:
>
>>  #ifndef ack_bad_irq
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -     printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +     printk(KERN_CRIT "unexpected IRQ %d\n", irq);
>>  }
>>  #endif
>
> So we can just delete the powerpc version?

Wow, I really didn't do my homework here.  Not only is there a generic
version already, but there's also print_irq_desc(), which prints way
more information than any of the ack_bad_irq() implementations.

I'll try again :)

Bjorn
