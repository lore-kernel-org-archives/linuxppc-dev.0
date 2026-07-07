Return-Path: <linuxppc-dev+bounces-23670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6DCC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 04:34:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvT0L2JJnz2yfS;
	Tue, 07 Jul 2026 14:34:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.171 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783398882;
	cv=pass; b=FIcw4B9PVkQTzwAwFBTSGz19Pe2L5pUlFSAgmyE4F3IKsar4oLvU0Ko8lkfMosFe5vXmzxegiJMMMNeFzWoywcBe34iE8vdQBugnALNPldrIyGj4OacnmxfPIAnRPsqTn4PlfT2SSm8xql95wRVuYCHnY6PztgT9yD9dBhBj9l48xpiMLgxeJUQfRL6LC7O0oaCCfwmJTNvgzn+GRzDK3BcnXDn0+9vhrqaReeucwQtToLCxAD2uHTpIPEUAUsiyhNL3cOtv5xdu8sLTUsz0C7VzYlwZRAtj0p4gPCiZz5lUJquhZrW96SBQryHG88hlPKskkbfvOg16+LoynoOkcA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783398882; c=relaxed/relaxed;
	bh=u3IWUCGARqVOUe1k2VTrO7/4RsUY7qdLv+qZpKCsdHg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kpEHFeExO9XNhReNFgujanGAfqAVGu3s1JZsP997gthrItRZpTNvnv2yP/QBvA/Ei2jt8J3J/thRgYuZ5N34NHb8TykbcTdRQPWGE2smKjP/rVVlZA34TqOez2lOSut/FUb0ftAKBAsUtlp5ZrUkRqxWWtTTHA8Gprlpm8iv1sQkjNBETByhL0Njco/c9GrahxMBBl7H7HyJRAVmHlNWfM82MWvBx4kZ8adrNZ4aJ+MT2v7XnR+avlJ+Aks+NAQpzg07g0AGOEWKhmm8lOEat1b2o6TgudmgwNXHefj2LBBJ6PTsvNCMdP2U4Vma7u8b6K0Y28eP/UqoY/r94UY7Jg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jv8MHj9B; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Tdvac8RV; dkim-atps=neutral; spf=pass (client-ip=81.169.146.171; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jv8MHj9B;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Tdvac8RV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.171; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvT0D52LNz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 14:34:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1783398689; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=U/z5LVimjpzXqUecmx/o6VjOMJ0L+8XYEqKm7ouCNeJw7Ve3ykstCCT5qxzJm///hS
    OqgZpZ3k1rHvnfZPiwfPizGBR4fILBBKPXMFKhh8+bN1mpccj+2/CXfTOLP9ooWXW+PG
    Q8mcFRgC042NI48xtGrTB2lAjlGVDWs1hg86qYWsutUBs2fX1rTVKF/UXZf4put2iYcS
    NtiK+JGjK/P3odQ7tX/ZRAX5dIAhtO0ibhWH5jz80WS9jYAbtymsBi3Foe2Fx5Ko3rIS
    NH4MnIztcumVAdBG8JrrT7UzSlEekYQ7/kRGPCQMGL3H4y85EdTCdwfjMA39CbJWeg87
    8r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783398689;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=u3IWUCGARqVOUe1k2VTrO7/4RsUY7qdLv+qZpKCsdHg=;
    b=WJJUP7FRSAqynguTl/4w9UA+WZ4xVlgWfYqqFk1YAd3MBfznz6v0vHFRCt2XTVHsEt
    WZ16IpiB2TNfmGId0duAELdqHhI/ee9Wj4zwFJpdnDGXGIkWkTIpZpegabxxoXonGa5g
    nd+aglW1SIReBAQykIyjYTiSh+071KAyRSsYBkSOkv7FRbOhAT0MBtH2yGYT8GXZj9kt
    tE1cIVUitDu08QRY7cwlpsDeoUEcUHLNNkJso56BsbHNUlWk5OjXRjaUnC9dcVD5JtpD
    LmWod5ZQcOJGfGx4fFnf7AXKhnOuTu7IAl1OHawBINMYndq0/QGc6wFfbDJApwuxexJH
    jCrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783398689;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=u3IWUCGARqVOUe1k2VTrO7/4RsUY7qdLv+qZpKCsdHg=;
    b=jv8MHj9B3uc/RRu6y7lINHD5y3R87luWUtEMrQSKvnMhrw89RhHb/KQhAiE8QGzNU2
    DFdbCpGe0SMffZ4vvzP1O+BnjWixpReenQ8QKVnK40DWqj86011Eo+lOM1XZLMlK7eMU
    SH6hDCZNwr1ukh2e6QODWiqLsVYtkQswCfu8e9RmxnysSM9pRRuQxyE6erv64QrLVEVW
    +lBxXSm0VJjt4W7mEtaUoEXAgDSMMxb80sPFgFceKzHNYkbhrQsBt+6AuI7UmEKghtKx
    GrXtXy4w5Wz2THEGBw3YjKUT6HJEUziDHrqD64CMpDh3L7lhFX1gFMCjID8lzJzzSO+J
    TAUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783398689;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=u3IWUCGARqVOUe1k2VTrO7/4RsUY7qdLv+qZpKCsdHg=;
    b=Tdvac8RVHv1nVhSwLYVw3GrJsyj9Z/yiTh5+WcZ1FBmKO+vismc2mf6C18WBYV5L0/
    XgTRHdtpsPXsY1/2F5Cg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m7hrg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id e4c84d2674VSkjn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 06:31:28 +0200 (CEST)
Subject: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's
 pci.c than in pasemi's setup.c.
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Damien Stewart <hypexed@yahoo.com.au>,
 Darren Stevens <darren@stevens-zone.net>
References: <20260701105501.2093-1-chzigotzky@xenosoft.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <91cfa587-c555-45ad-2a34-83e5191ade7d@xenosoft.de>
Date: Tue, 7 Jul 2026 06:31:28 +0200
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
In-Reply-To: <20260701105501.2093-1-chzigotzky@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Any comments about this patch?

Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

-- Christian


On 01/07/26 12:54, Christian Zigotzky wrote:
 >  "pas_pci_init" was before "nemo_init_IRQ".
 >  Now "pas_pci_init" is after "nemo_init_IRQ" in the official kernel 
source
 >  code.
 >  I think "pas_pci_init" scans (discovers) the PCI(e) devices
 >  and after that, "nemo_init_IRQ" assigns interrupt numbers
 >  to these devices if required.
 >  It's not possible to assigns interrupt numbers to PCI(e) devices
 >  which have not been discovered yet.
 >
 > Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
 > ---
 >  arch/powerpc/platforms/pasemi/pci.c   | 7 +++++++
 >  arch/powerpc/platforms/pasemi/setup.c | 7 ++++---
 >  2 files changed, 11 insertions(+), 3 deletions(-)
 >
 > diff --git a/arch/powerpc/platforms/pasemi/pci.c 
b/arch/powerpc/platforms/pasemi/pci.c
 > index 2df955274652..7208c325bfc5 100644
 > --- a/arch/powerpc/platforms/pasemi/pci.c
 > +++ b/arch/powerpc/platforms/pasemi/pci.c
 > @@ -25,6 +25,8 @@
 >
 >  #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) 
| (off))
 >
 > +extern void nemo_init_IRQ(void);
 > +
 >  static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
 >  {
 >      /* Device 0 Function 0 is special: It's config space spans 
function 1 as
 > @@ -265,6 +267,11 @@ static int __init pas_add_bridge(struct 
device_node *dev)
 >       */
 >      isa_bridge_find_early(hose);
 >
 > +    /*
 > +     * ISA bridge is now active, add the i8259 cascade (if needed)
 > +     */
 > +    nemo_init_IRQ();
 > +
 >      return 0;
 >  }
 >
 > diff --git a/arch/powerpc/platforms/pasemi/setup.c 
b/arch/powerpc/platforms/pasemi/setup.c
 > index d03b41336901..eec74611be46 100644
 > --- a/arch/powerpc/platforms/pasemi/setup.c
 > +++ b/arch/powerpc/platforms/pasemi/setup.c
 > @@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc 
*desc)
 >      chip->irq_eoi(&desc->irq_data);
 >  }
 >
 > -static void __init nemo_init_IRQ(struct mpic *mpic)
 > +void nemo_init_IRQ(void)
 >  {
 >      struct device_node *np;
 >      int gpio_virq;
 > +    struct mpic *mpic;
 > +
 >      /* Connect the SB600's legacy i8259 controller */
 >      np = of_find_node_by_path("/pxp@0,e0000000");
 >      i8259_init(np, 0);
 > @@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 >      irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 >      mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 >
 > +    mpic = irq_get_chip_data(gpio_virq);
 >      irq_set_default_domain(mpic->irqhost);
 >  }
 >
 > @@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)
 >          mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 >      }
 >
 > -    nemo_init_IRQ(mpic);
 > -
 >      of_node_put(mpic_node);
 >      of_node_put(root);
 >  }


-- 
Sent with BrassMonkey 34.2.2 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.2.2)

