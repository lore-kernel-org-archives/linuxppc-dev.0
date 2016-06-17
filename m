Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWZ8p6Tr5zDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 08:06:34 +1000 (AEST)
Received: from smtprelay.hostedemail.com (smtprelay0145.hostedemail.com
 [216.40.44.145])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rWZ8p2M84z9t0F
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Jun 2016 08:06:33 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id E3F8D28ED20
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 21:59:11 +0000 (UTC)
Date: Fri, 17 Jun 2016 17:59:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, karol herbst <karolherbst@gmail.com>,
 linux-kernel@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Yinghai Lu
 <yinghai@kernel.org>, koriakin@0x04.net, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] tracing: Expose CPU physical addresses (resource
 values) for PCI devices
Message-ID: <20160617175901.7bd90d14@gandalf.local.home>
In-Reply-To: <20160511190657.5898.4248.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160511190657.5898.4248.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Sorry for the late reply, this patch got pushed down in my INBOX.

Could I get someone from PPC to review this patch, just to be safe?

Thanks!

-- Steve



On Wed, 11 May 2016 14:06:57 -0500
Bjorn Helgaas <bhelgaas@google.com> wrote:

> Previously, mmio_print_pcidev() put "user" addresses in the trace buffer.
> On most architectures, these are the same as CPU physical addresses, but on
> microblaze, mips, powerpc, and sparc, they may be something else, typically
> a raw BAR value (a bus address as opposed to a CPU address).
> 
> Always expose the CPU physical address to avoid this arch-dependent
> behavior.
> 
> This change should have no user-visible effect because this file currently
> depends on CONFIG_HAVE_MMIOTRACE_SUPPORT, which is only defined for x86,
> and pci_resource_to_user() is a no-op on x86.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  kernel/trace/trace_mmiotrace.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> index 68f376c..cd7480d 100644
> --- a/kernel/trace/trace_mmiotrace.c
> +++ b/kernel/trace/trace_mmiotrace.c
> @@ -68,19 +68,15 @@ static void mmio_print_pcidev(struct trace_seq *s, const struct pci_dev *dev)
>  	trace_seq_printf(s, "PCIDEV %02x%02x %04x%04x %x",
>  			 dev->bus->number, dev->devfn,
>  			 dev->vendor, dev->device, dev->irq);
> -	/*
> -	 * XXX: is pci_resource_to_user() appropriate, since we are
> -	 * supposed to interpret the __ioremap() phys_addr argument based on
> -	 * these printed values?
> -	 */
>  	for (i = 0; i < 7; i++) {
> -		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
> +		start = dev->resource[i].start;
>  		trace_seq_printf(s, " %llx",
>  			(unsigned long long)(start |
>  			(dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
>  	}
>  	for (i = 0; i < 7; i++) {
> -		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
> +		start = dev->resource[i].start;
> +		end = dev->resource[i].end;
>  		trace_seq_printf(s, " %llx",
>  			dev->resource[i].start < dev->resource[i].end ?
>  			(unsigned long long)(end - start) + 1 : 0);
