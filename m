Return-Path: <linuxppc-dev+bounces-24122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5B0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 16:21:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzSP268tbz2xJT;
	Tue, 14 Jul 2026 02:21:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.83 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783959686;
	cv=pass; b=fmX75B3n6dR60+w6qinrIaDk90iz1YoWCPx5tLDwsuzD5fzNNxUktQPTpKwR4BzVWSmdPG2MAGFt5ZoNB+1Y+KJ8KdfN6LIFFK5n9+PcQNiU55P5Q2fG7y56s3qQh95BVz+07SKclzrUm4cqWuewPpJnZ9wzQRhTVegTPUQZwhToQ2BLjPCL+JyXUd+VfnA0mW/p3140MDH5uZ5gKG8V2G1l8MreUs0xxrZHx1M1rCDA1XZPdie7tJJDY822wUPRPTcWqrWBnQt6APzQbDGCZRvxue31zkOH3e4dxR1QzysFLh1JIM4Z/Dp5fpTN24yMMQnMMdGleoeUp3Nqjeaxaw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783959686; c=relaxed/relaxed;
	bh=2+pL6giVJaq6Auts7NJhD55gTdLOvJPAtilgd0ruH84=;
	h=Subject:From:To:References:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RSY5t7Yu9eC2AQmv7SjPuKOAflRYuZ9kMSL3XOtRBZisCxYgXMsGU1aJsyzDpk9jjVgD+CQglazoWneTwEOGksnGqDXEAfppf4UEE+jIPFivbcUfe9R3AQiWH0AHMke/BdzcrJGlsvYL8JccLcPWl6jDZT0fCTI1gGT0PZ0dCBLGavGo6AZYbYij3+WQR12s/IQjs/i1cu60RG4aqu4WO7gJHWZUK8E1BdSzm7KG8FQYCAM1jqGrkx67Ktb5BPExCWUEFs+g4tEku/AP3X7qn1+iWow/KBZG9MCoQJjGSR71Lcs51n3iQiu7sxQhLDIixCU9GA0YygVH8seAFKER9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a6MYExWD; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bXIqpEI0; dkim-atps=neutral; spf=pass (client-ip=85.215.255.83; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a6MYExWD;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bXIqpEI0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=85.215.255.83; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 150 seconds by postgrey-1.37 at boromir; Tue, 14 Jul 2026 02:21:20 AEST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzSNw6Ndhz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 02:21:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1783959492; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CtMlpUhBYzo+EpETjWxkw5OvR4SvX5v+NAOEFlobsv8Y9QWK6RkmwsxOpmMmX7ZmDk
    uWAL7KsoGVTkCf4ooEBmeH2D3TvNX9vX1d+ZmLTVdEbzf0evTM7FFg7LL/p9RAhiA0Xd
    uWr9ZXgAcqu/9rCF+msiViDiO0LKtnM3Im72cI6Slf10gTJByrfzw0/U3AZC4rB0a4Z2
    mU1TDN52AIR+BHeRt+WPHYcPjes55ji+OUZIYkt+EvB4NtRqycKAbwOUF0p1pW3Q7KvT
    amVfF0M5k9JEOaCTs2WcV43n/hyw/mFjUxiI2SAMXF56v9fagBoHrC3Mw7dwpzYFM4TD
    Mvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783959492;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:Cc:References:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2+pL6giVJaq6Auts7NJhD55gTdLOvJPAtilgd0ruH84=;
    b=deCfU058LPoC30jBU4OQwTF1aFmtHh8FctRz7FKmC3b8ZdqwBvpZ0jcOlKjb8Rp3Nh
    Jx+mDR8Jqi6y65vPkFOnE7JMB2XMkHnBvlXODedcGhO8lbUUb8icEk/yOY5xCXMzGpTU
    JMTDOQng5zpzbVJvG1DiEXJfSzV3IL2FqV3OI1UQyhePoIgt/hNZ0ZrShvt0duaLgFos
    lkHbcbuJ5o4CZ4W0xtOwY4oPSF5hQUhfWD0j7ZBFDwOtej9NU9RlrmjB/aCYHKJK7I2U
    S4xCK6s1jOWLvDyv9ftfxThwiMB8rcYoKT3KKz7p3XUSI6a7uAuXqGRZESuCKzNRFgR4
    kgNQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783959492;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:Cc:References:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2+pL6giVJaq6Auts7NJhD55gTdLOvJPAtilgd0ruH84=;
    b=a6MYExWDpHUI48W/IzNKz6Ld0i8PoIBDF1oisX31HUW2Pn8npbjk0phuQ/8hJxq0k/
    XsWTtIDLg80YpCK+eqH/JqfPjfiOf+QFYHQSX7MTDsAtT2DBBSCkMAcQF8SqYcIjYegY
    lysQ+NlGuF7UwTQczDDipjuVJDkGGW5AyBYTaock/6M4lAFX9xhdB4QScF8PSngVxqpi
    iqjai2iOEByDTjPE6eXr+qDZGy8SduIDNNUkX8/aK+5cOAIfwPAznmqEnBARjFmw0LCc
    gOg002cvGZ7TK+vKX9A4wmexw2BWNRdnTcJVYSiT52kqy5MkAMHNL02C3gy+eDXTQoE9
    KCcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783959492;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:Cc:References:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2+pL6giVJaq6Auts7NJhD55gTdLOvJPAtilgd0ruH84=;
    b=bXIqpEI0ttjMyymrh75tCAfe9GHx+ENMRtSFKZxRG8+DHTf1Qr35jshkOy9DE4ZFxK
    iLAo18ashYAcK9mtbgBg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+s7Xc="
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id e4c84d26DGIB6Ti
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Jul 2026 18:18:11 +0200 (CEST)
Subject: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's
 pci.c than in pasemi's setup.c.
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
References: <20260701105501.2093-1-chzigotzky@xenosoft.de>
 <91cfa587-c555-45ad-2a34-83e5191ade7d@xenosoft.de>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, Damien Stewart <hypexed@yahoo.com.au>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <e8ae26f2-568a-0848-a8bf-774bcdffc9cc@xenosoft.de>
Date: Mon, 13 Jul 2026 18:18:10 +0200
X-Mailer: BrassMonkey/34.2.2
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <91cfa587-c555-45ad-2a34-83e5191ade7d@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Is this patch OK? My P.A. Semi Nemo board boots with the patched kernel.

-- Christian

On 07/07/26 06:31, Christian Zigotzky wrote:
 > Any comments about this patch?
 >
 > Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
 >
 > -- Christian
 >
 >
 > On 01/07/26 12:54, Christian Zigotzky wrote:
 > >  "pas_pci_init" was before "nemo_init_IRQ".
 > >  Now "pas_pci_init" is after "nemo_init_IRQ" in the official kernel 
source
 > >  code.
 > >  I think "pas_pci_init" scans (discovers) the PCI(e) devices
 > >  and after that, "nemo_init_IRQ" assigns interrupt numbers
 > >  to these devices if required.
 > >  It's not possible to assigns interrupt numbers to PCI(e) devices
 > >  which have not been discovered yet.
 > >
 > > Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
 > > ---
 > >  arch/powerpc/platforms/pasemi/pci.c   | 7 +++++++
 > >  arch/powerpc/platforms/pasemi/setup.c | 7 ++++---
 > >  2 files changed, 11 insertions(+), 3 deletions(-)
 > >
 > > diff --git a/arch/powerpc/platforms/pasemi/pci.c 
b/arch/powerpc/platforms/pasemi/pci.c
 > > index 2df955274652..7208c325bfc5 100644
 > > --- a/arch/powerpc/platforms/pasemi/pci.c
 > > +++ b/arch/powerpc/platforms/pasemi/pci.c
 > > @@ -25,6 +25,8 @@
 > >
 > >  #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 
12) | (off))
 > >
 > > +extern void nemo_init_IRQ(void);
 > > +
 > >  static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
 > >  {
 > >      /* Device 0 Function 0 is special: It's config space spans 
function 1 as
 > > @@ -265,6 +267,11 @@ static int __init pas_add_bridge(struct 
device_node *dev)
 > >       */
 > >      isa_bridge_find_early(hose);
 > >
 > > +    /*
 > > +     * ISA bridge is now active, add the i8259 cascade (if needed)
 > > +     */
 > > +    nemo_init_IRQ();
 > > +
 > >      return 0;
 > >  }
 > >
 > > diff --git a/arch/powerpc/platforms/pasemi/setup.c 
b/arch/powerpc/platforms/pasemi/setup.c
 > > index d03b41336901..eec74611be46 100644
 > > --- a/arch/powerpc/platforms/pasemi/setup.c
 > > +++ b/arch/powerpc/platforms/pasemi/setup.c
 > > @@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct 
irq_desc *desc)
 > >      chip->irq_eoi(&desc->irq_data);
 > >  }
 > >
 > > -static void __init nemo_init_IRQ(struct mpic *mpic)
 > > +void nemo_init_IRQ(void)
 > >  {
 > >      struct device_node *np;
 > >      int gpio_virq;
 > > +    struct mpic *mpic;
 > > +
 > >      /* Connect the SB600's legacy i8259 controller */
 > >      np = of_find_node_by_path("/pxp@0,e0000000");
 > >      i8259_init(np, 0);
 > > @@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 > >      irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 > >      mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 > >
 > > +    mpic = irq_get_chip_data(gpio_virq);
 > >      irq_set_default_domain(mpic->irqhost);
 > >  }
 > >
 > > @@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)
 > >          mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 > >      }
 > >
 > > -    nemo_init_IRQ(mpic);
 > > -
 > >      of_node_put(mpic_node);
 > >      of_node_put(root);
 > >  }
 >
 >


-- 
Sent with BrassMonkey 34.2.2 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.2.2)

