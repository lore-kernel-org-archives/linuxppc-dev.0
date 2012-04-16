Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAF2FB7002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 09:24:12 +1000 (EST)
Received: by obbef5 with SMTP id ef5so8078776obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 16:24:10 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1334617382.25353.14.camel@pasglop>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
 <1334617382.25353.14.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 16 Apr 2012 17:23:50 -0600
Message-ID: <CACxGe6tgoSwKbioaTo7Ma8c4R-=0s_7dOjYRR8Gj-og5EVqMfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2012 at 5:03 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-04-16 at 14:13 -0600, Grant Likely wrote:
>> The mpc8xx driver uses a reference to NR_IRQS that is buggy. =A0It uses
>> NR_IRQs for the array size of the ppc_cached_irq_mask bitmap, but
>> NR_IRQs could be smaller than the number of hardware irqs that
>> ppc_cached_irq_mask tracks.
>>
>> Also, while fixing that problem, it became apparent that the interrupt
>> controller only supports 32 interrupt numbers, but it is written as if
>> it supports multiple register banks which is more complicated.
>>
>> This patch pulls out the buggy reference to NR_IRQs and fixes the size
>> of the ppc_cached_irq_mask to match the number of HW irqs. =A0It also
>> drops the now-unnecessary code since ppc_cached_irq_mask is no longer
>> an array.
>
> Can you rename ppc_cached_irq_mask while at it ? I think it was written
> that way because it was all copy/pasted from powermac/pic.c which -does-
> need it to be an array (and has the same bugs btw) :-)
>
> I wonder if we can get rid of the cached mask alltogether... I have the
> feeling that we could just rely on the irq_desc fields nowadays for
> that... this code is ancient.

The irq_desc fields aren't ideal because they are per-irq and would
need to be &'ed together for each mask/unmask/ack operation.  We could
store something in the irq_domain I suppose, but I'm not convinced it
is worth it for an interrupt controller that will only ever have one
instance in the system.  If I were to refactor any deeper than I have,
then I'm move this driver over to use irq_generic_chip instead.

g.
