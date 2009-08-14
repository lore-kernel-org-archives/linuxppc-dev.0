Return-Path: <gknispel@proformatique.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EBBFBB7BA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 08:45:45 +1000 (EST)
Received: from mx1.corp.proformatique.com (gon.proformatique.com
	[91.194.178.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.corp.proformatique.com",
	Issuer "Proformatique CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 88650DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 08:45:45 +1000 (EST)
Date: Sat, 15 Aug 2009 00:39:04 +0200
From: Guillaume Knispel <gknispel@proformatique.com>
To: Baojun Wang <wangbj.ml@gmail.com>
Subject: Re: Configure CPM2 PORTC pin (PC9) for external interrupt?
Message-ID: <20090815003904.5378cb35@xilun.lan.proformatique.com>
In-Reply-To: <17dc9c530908140727l6423bebawaed8808f195d4d20@mail.gmail.com>
References: <17dc9c530908140727l6423bebawaed8808f195d4d20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Aug 2009 22:27:39 +0800
Baojun Wang <wangbj.ml@gmail.com> wrote:

>   I need to configure CPM2 PORTC pin (PC9) for external interrupt, when I
> read the MPC8555ERM.pdf and cpm2-pic.c, I find that PC9 interrupt number is
> 56, and I request the IRQ in this way:
> 
>   hw_irq = 56;
>   virq = irq_create_mapping(cpm2_host, hw_irq);
> 
>   reqeust_irq(virq, ...);
> 
>   I can request the irq successfully, but the interrupt is never generated
> (ISR is not called) to the PC9 pins, even though the hardware said an
> interrupt was raised. (the hardware have a register with a special bit)
> 
>   Should I configure the cpm2 io port first to allow PORTC interrupt? I have
> read the cpm2 io port documentation, and I initialize the PC9 as:
> 
>   PPARC[pc9_bit] = 0;    /* for general purpose IO, not dedicated */
>   PSORC[pc9_bit] = 0;    /* no special option */
>   PDIRC[pc9_bit] = 0;     /* for both input/output */
> 
>   Am I missing some thing? Any suggestion will be greatly appreciated.

Hi,

Have a look on commit 7f3ea17f316577e31db868f720ac575c74d20163, which
fixes a linux bug about Port C interrupts

Also note that the 8555 have the same issue that the 8272 about
PC2 / PC3 missing which shifts other vectors, but I don't know if 56
for PC9 take that into account.

PS: in the future make sure to include your Linux version number, so we
know if an issue apply or not.

-- 
Guillaume KNISPEL
