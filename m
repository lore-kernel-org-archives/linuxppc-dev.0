Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3td4sr4pPmzDvk4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 14:28:16 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3td4sr0yKQz9t2p
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2016 14:28:16 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id x23so2975167pgx.3
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2016 19:28:16 -0800 (PST)
Message-ID: <1481599689.8786.2.camel@gmail.com>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
From: Balbir Singh <bsingharora@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>
Date: Tue, 13 Dec 2016 14:28:09 +1100
In-Reply-To: <1481556264.17253.57.camel@kernel.crashing.org>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
 <1481556264.17253.57.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-12 at 09:24 -0600, Benjamin Herrenschmidt wrote:
> On Mon, 2016-12-12 at 23:31 +1000, Nicholas Piggin wrote:
> > Otherwise, this looks nice if it does the right thing with the
> > interrupt
> > controller. It hasn't taken a lot of lines to implement which is
> > very
> > cool.
> 
> We might want to be a bit careful. It will work with XICS fine, but
> it
> might be trickier with a controller that needs explicit masking
> of the just received interrupts like some of the old mac ones. Or
> MPIC
> that you haven't modified to flatten the priorities etc....
> 
> Also lazy masking is ppc64 only but irc.c and time.c are shared.
> 
> I think we need to make this an "opt-in" based on some bit set by the
> platform or the PIC, possibly in ppc_md.
> 

Even though I'm using ppc_md.get_irq() the routine is called
only from exception64s.S, I can make the code conditional on
PPC_XICS. When we exploit the xive bits, we can add support for
that as well.

> Also note that there's already a PACA field to "recover" an interrupt
> snatched by KVM, though it's XICS specific, while your approach is
> more
> generic, you may want to merge the two. Talk to Paulus.
>

That is specific to KVM for kvm_interrupt_hv and kvm has a referecne to
the xics as well and within it, saved_xirr is tracked

Thanks for the reviews,
Balbir 
