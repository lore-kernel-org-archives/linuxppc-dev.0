Return-Path: <linuxppc-dev+bounces-23299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E48CC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 11:14:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqy8F338dz2xKh;
	Wed, 01 Jul 2026 21:14:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782904461;
	cv=pass; b=KrMQiYPmwc33JjXbiSo7AI4fC327c0j615th7SGXxm6uGr0QPq1F9mI53IxNZ1PQQ8QE9Mv4gNe56yxiJSRUNuWLd8AxNn4l0Z68iUmsjF1+V3se2zxgkcjoglxCrDc5ouHIStuTBz5c0iOyHM6IJvNEkFp5V6iao6wQFcfveeWWdAaWoOTsfaJNt8rFVIGEnkVqlRAkT13AXi69u2vkCuMIWugVFFUMgik2jkGZEjKYC9aYggm0Nk8W3yZoTx+chGA4wJtmxk0AUtTfXQYdNF5/T02X4cfiQdGXiY5tWPJaqpU/JbacSEqio4+jqhLqmrJwDU6AhP0hR2YEofd8AQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782904461; c=relaxed/relaxed;
	bh=zBMNUj5ZFIK+a9WiuUdLciP3a+A3oBXyXdorGkk+ELI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QDjhBxso2bu9fBxF+EV44agfslaoDLGuXrf3pr6OrYvG6fCYPhyOBhLxaUaEVdDIijCyn2Ix62Ga01cmAsDR+QFiNQdGYr5+WaOD8Diw59PBIakXIV6T6xvDa7xSEu1FJrp6de5cnWreDXwCB4WLyiTT86V59rJJ4SFaEdg8kaFWg1HnWVp62uE+XGuOqM9yX1QMq4oHgUvrekGdj1EPazjy+ynAuLQmk5HMx9n21HV9h3d11MTbbb3Tp9EDIRycetUum3PIwXY9duu0yzqTPoYY+BFhi5Psz8nuEPi0b5Iaq2ADEynC0Wa9o2CCzKKgNJOiCh4rQQV/543P5aao5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LbFup+jw; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=JCQssids; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LbFup+jw;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=JCQssids;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqy892yMrz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 21:14:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1782904452; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KjF8H2a5/mMKTytyJ+Vbmt4ZHOqfHcaijVJIXLSXcYAgMVhEU35wmndEf+w09ZlHV2
    vr1e19t9n6xkv8sQ+Zo3v0C/zgoj+eg0BGcPih8eQbdT5Lhkd4J/lao2Pfams2xudBLY
    PC2HW46gFcxB5GBLQ1e5HOh468OQ8X0tj7KV0Afv4J6LpqHmNZ6LvbjjXf95WIGbM/PG
    E1ATSty/Dt1ZNog4HpBdGFSeSgeyinobwkVSSj+jTZQuz0mY6TMXG8PCEdN+bIInrXWo
    s0+pjMDjsabZ0j91To3GypHCAOzHMjcxbt57uBH9pR9iKxav1xvpr2uxUfURKjmLKhLz
    vNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782904452;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=zBMNUj5ZFIK+a9WiuUdLciP3a+A3oBXyXdorGkk+ELI=;
    b=sO1WK9n43O2NN9Y6isr0DgZPKKzJVJQmTnDFnsbGkc7IsMveTgtNCixap+Gx5/F8SR
    GHLItszIuJI4DmPAFTsMHJ2vT8eiBoCEyfI5m7RTU10PjQHSvNOm38pHEUggGYK9f2f7
    cwt2ApFS8BUhH7ScvKh9L+Ix94y5qRPGro//HTFIV7BmogNyR5gIyawjYXlbWAK0/TTH
    2B6EIelTje37BU4a1RtaHNZ4Nx6iSNU+1c1A6oaHxAL3yjLd9HdULRfMCh3LJg6Wuamp
    nlCQtDsKQOwwUYSjV7fEv2WscumZbQZvXf7RIAK7IGy5oeEiq5hkbpKYItha3Um2m4bc
    yhQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782904452;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=zBMNUj5ZFIK+a9WiuUdLciP3a+A3oBXyXdorGkk+ELI=;
    b=LbFup+jwQynVtUisDBxcdqGvxxp5YMVov0yPBKICGtzoZNoeDZvXv+TJnMgxrZqYCw
    ErdxKWfCo2r7wTAIk9tY222oKsTanQQyfJQjA/FEARt9F+pLwMaQCaR/y5wI/EuhMtv/
    gW6AMMERymwCAYyAWaFDkjhA9KJiIMi7u05Bl/Pj9+fkJy03bOhokIdDn/btyZxiMtUz
    kz3TwfA+S2n5C+2ekHuMP3VTXLJDPlyxJm7V4cYRNpRj1lmSTiXQIA6xFhEu34aVpf2O
    hAYH2XpVuf7rFuknTCe0RSf4j6xYfifxTpQkxHibpREiFXYgheGnMMsApfrOMoYVvMzc
    Oz7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782904452;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=zBMNUj5ZFIK+a9WiuUdLciP3a+A3oBXyXdorGkk+ELI=;
    b=JCQssidsfgcdqSzwSQws1Lx8T0oEQHsvFPZjKI7VnWuQvqDwLfcjKvjtp5eWekY2Rn
    uIexzKC19PiuSAucnPCA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5ixsy7AC37lg/RWRao1rCMUta1rqbB9oQIBJmk="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id e4c84d261BECQCG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 1 Jul 2026 13:14:12 +0200 (CEST)
Content-Type: multipart/alternative; boundary=Apple-Mail-A9834DA5-6F3E-44C3-B813-B52DCA8C1CC2
Content-Transfer-Encoding: 7bit
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's pci.c than in pasemi's setup.c.
Date: Wed, 1 Jul 2026 13:14:02 +0200
Message-Id: <179DBFE9-ACE5-4842-AF33-ACCA2B0D8C6D@xenosoft.de>
References: <20260701105501.2093-1-chzigotzky@xenosoft.de>
Cc: Darren Stevens <darren@stevens-zone.net>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au
In-Reply-To: <20260701105501.2093-1-chzigotzky@xenosoft.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <chleroy@kernel.org>
X-Mailer: iPhone Mail (23F84)


--Apple-Mail-A9834DA5-6F3E-44C3-B813-B52DCA8C1CC2
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable


The Nemo board [1] doesn=E2=80=99t boot without this patch. Darren explained=
 it really well:

Originally we initialised the PCI-e ports in setup arch, this is quite early=
, and it seems uses some kernel functions that were not recommended (They ch=
anged a whole lot of different platforms at the same time for the same reaso=
n)

After this we added the ISA bridge, then the kernel would init the IRQ conto=
llers.

The patch that broke booting on the X1000 moved the pas_pci_init to a node i=
n the machine description, where it called later in the boot sequence. Unfor=
tunately this is after we've tried to add the i8259 contoller from the pas_i=
nit_IRQ. Since our ISA bridge can't be found until we've connected the PCI-e=
 ports the system tries to write to registers that aren't yet mapped - resul=
t a kernel panic, but before console I/O has been initialised so it appears t=
o be a hang. We had a similar problem when they were introducing Radix suppo=
rt.

My patch changes our code so that it works with the new kernel code in place=
. Basically I moved the code that adds the i8259 cascade to after we've scan=
ned for the ISA bridge where I know it will work.

Hopefully this makes sense, shout out if it doesn't

Regards
Darren

[1] https://en.wikipedia.org/wiki/AmigaOne_X1000

> On 01 July 2026 at 12:55 pm, Christian Zigotzky <chzigotzky@xenosoft.de> w=
rote :
>=20
> =EF=BB=BF "pas_pci_init" was before "nemo_init_IRQ".
> Now "pas_pci_init" is after "nemo_init_IRQ" in the official kernel source
> code.
> I think "pas_pci_init" scans (discovers) the PCI(e) devices
> and after that, "nemo_init_IRQ" assigns interrupt numbers
> to these devices if required.
> It's not possible to assigns interrupt numbers to PCI(e) devices
> which have not been discovered yet.
>=20
> Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> ---
> arch/powerpc/platforms/pasemi/pci.c   | 7 +++++++
> arch/powerpc/platforms/pasemi/setup.c | 7 ++++---
> 2 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/=
pasemi/pci.c
> index 2df955274652..7208c325bfc5 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -25,6 +25,8 @@
>=20
> #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (of=
f))
>=20
> +extern void nemo_init_IRQ(void);
> +
> static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
> {
>    /* Device 0 Function 0 is special: It's config space spans function 1 a=
s
> @@ -265,6 +267,11 @@ static int __init pas_add_bridge(struct device_node *=
dev)
>     */
>    isa_bridge_find_early(hose);
>=20
> +    /*
> +     * ISA bridge is now active, add the i8259 cascade (if needed)
> +     */
> +    nemo_init_IRQ();
> +
>    return 0;
> }
>=20
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platform=
s/pasemi/setup.c
> index d03b41336901..eec74611be46 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc=
)
>    chip->irq_eoi(&desc->irq_data);
> }
>=20
> -static void __init nemo_init_IRQ(struct mpic *mpic)
> +void nemo_init_IRQ(void)
> {
>    struct device_node *np;
>    int gpio_virq;
> +    struct mpic *mpic;
> +
>    /* Connect the SB600's legacy i8259 controller */
>    np =3D of_find_node_by_path("/pxp@0,e0000000");
>    i8259_init(np, 0);
> @@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
>    irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>    mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>=20
> +    mpic =3D irq_get_chip_data(gpio_virq);
>    irq_set_default_domain(mpic->irqhost);
> }
>=20
> @@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)
>        mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>    }
>=20
> -    nemo_init_IRQ(mpic);
> -
>    of_node_put(mpic_node);
>    of_node_put(root);
> }
> --
> 2.55.0.windows.1
>=20

--Apple-Mail-A9834DA5-6F3E-44C3-B813-B52DCA8C1CC2
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html class=3D"apple-mail-supports-explicit-dark-mode"><head><meta http-equi=
v=3D"content-type" content=3D"text/html; charset=3Dutf-8"></head><body dir=3D=
"auto"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div>The Nemo board [1] d=
oesn=E2=80=99t boot without this patch. Darren explained it really well:</di=
v><div><br></div><div>Originally we initialised the PCI-e ports in setup arc=
h, this is quite early, and it seems uses some kernel functions that were no=
t recommended (They changed a whole lot of different platforms at the same t=
ime for the same reason)</div><div><br></div><div>After this we added the IS=
A bridge, then the kernel would init the IRQ contollers.</div><div><br></div=
><div>The patch that broke booting on the X1000 moved the pas_pci_init to a n=
ode in the machine description, where it called later in the boot sequence. U=
nfortunately this is after we've tried to add the i8259 contoller from the p=
as_init_IRQ. Since our ISA bridge can't be found until we've connected the P=
CI-e ports the system tries to write to registers that aren't yet mapped - r=
esult a kernel panic, but before console I/O has been initialised so it appe=
ars to be a hang. We had a similar problem when they were introducing Radix s=
upport.</div><div><br></div><div>My patch changes our code so that it works w=
ith the new kernel code in place. Basically I moved the code that adds the i=
8259 cascade to after we've scanned for the ISA bridge where I know it will w=
ork.</div><div><br></div><div>Hopefully this makes sense, shout out if it do=
esn't</div><div><br></div><div>Regards</div><div>Darren</div><div><br></div>=
<div>[1]&nbsp;<a href=3D"https://en.wikipedia.org/wiki/AmigaOne_X1000">https=
://en.wikipedia.org/wiki/AmigaOne_X1000</a></div></div><div dir=3D"ltr"><br>=
<blockquote type=3D"cite">On 01 July 2026 at 12:55 pm, Christian Zigotzky &l=
t;chzigotzky@xenosoft.de&gt; wrote :<br><br></blockquote></div><blockquote t=
ype=3D"cite"><div dir=3D"ltr">=EF=BB=BF<span> "pas_pci_init" was before "nem=
o_init_IRQ".</span><br><span> Now "pas_pci_init" is after "nemo_init_IRQ" in=
 the official kernel source</span><br><span> code.</span><br><span> I think "=
pas_pci_init" scans (discovers) the PCI(e) devices</span><br><span> and afte=
r that, "nemo_init_IRQ" assigns interrupt numbers</span><br><span> to these d=
evices if required.</span><br><span> It's not possible to assigns interrupt n=
umbers to PCI(e) devices</span><br><span> which have not been discovered yet=
.</span><br><span></span><br><span>Signed-off-by: Christian Zigotzky &lt;chz=
igotzky@xenosoft.de&gt;</span><br><span>---</span><br><span> arch/powerpc/pl=
atforms/pasemi/pci.c &nbsp;&nbsp;| 7 +++++++</span><br><span> arch/powerpc/p=
latforms/pasemi/setup.c | 7 ++++---</span><br><span> 2 files changed, 11 ins=
ertions(+), 3 deletions(-)</span><br><span></span><br><span>diff --git a/arc=
h/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c</span=
><br><span>index 2df955274652..7208c325bfc5 100644</span><br><span>--- a/arc=
h/powerpc/platforms/pasemi/pci.c</span><br><span>+++ b/arch/powerpc/platform=
s/pasemi/pci.c</span><br><span>@@ -25,6 +25,8 @@</span><br><span></span><br>=
<span> #define PA_PXP_CFA(bus, devfn, off) (((bus) &lt;&lt; 20) | ((devfn) &=
lt;&lt; 12) | (off))</span><br><span></span><br><span>+extern void nemo_init=
_IRQ(void);</span><br><span>+</span><br><span> static inline int pa_pxp_offs=
et_valid(u8 bus, u8 devfn, int offset)</span><br><span> {</span><br><span>  &=
nbsp; &nbsp;/* Device 0 Function 0 is special: It's config space spans funct=
ion 1 as</span><br><span>@@ -265,6 +267,11 @@ static int __init pas_add_brid=
ge(struct device_node *dev)</span><br><span>  &nbsp; &nbsp; */</span><br><sp=
an>  &nbsp; &nbsp;isa_bridge_find_early(hose);</span><br><span></span><br><s=
pan>+ &nbsp; &nbsp;/*</span><br><span>+ &nbsp; &nbsp; * ISA bridge is now ac=
tive, add the i8259 cascade (if needed)</span><br><span>+ &nbsp; &nbsp; */</=
span><br><span>+ &nbsp; &nbsp;nemo_init_IRQ();</span><br><span>+</span><br><=
span>  &nbsp; &nbsp;return 0;</span><br><span> }</span><br><span></span><br>=
<span>diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/plat=
forms/pasemi/setup.c</span><br><span>index d03b41336901..eec74611be46 100644=
</span><br><span>--- a/arch/powerpc/platforms/pasemi/setup.c</span><br><span=
>+++ b/arch/powerpc/platforms/pasemi/setup.c</span><br><span>@@ -214,10 +214=
,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)</span><br><span=
>  &nbsp; &nbsp;chip-&gt;irq_eoi(&amp;desc-&gt;irq_data);</span><br><span> }=
</span><br><span></span><br><span>-static void __init nemo_init_IRQ(struct m=
pic *mpic)</span><br><span>+void nemo_init_IRQ(void)</span><br><span> {</spa=
n><br><span>  &nbsp; &nbsp;struct device_node *np;</span><br><span>  &nbsp; &=
nbsp;int gpio_virq;</span><br><span>+ &nbsp; &nbsp;struct mpic *mpic;</span>=
<br><span>+</span><br><span>  &nbsp; &nbsp;/* Connect the SB600's legacy i82=
59 controller */</span><br><span>  &nbsp; &nbsp;np =3D of_find_node_by_path(=
"/pxp@0,e0000000");</span><br><span>  &nbsp; &nbsp;i8259_init(np, 0);</span>=
<br><span>@@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *=
mpic)</span><br><span>  &nbsp; &nbsp;irq_set_chained_handler(gpio_virq, sb60=
0_8259_cascade);</span><br><span>  &nbsp; &nbsp;mpic_unmask_irq(irq_get_irq_=
data(gpio_virq));</span><br><span></span><br><span>+ &nbsp; &nbsp;mpic =3D i=
rq_get_chip_data(gpio_virq);</span><br><span>  &nbsp; &nbsp;irq_set_default_=
domain(mpic-&gt;irqhost);</span><br><span> }</span><br><span></span><br><spa=
n>@@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)</span><br><span>=
  &nbsp; &nbsp; &nbsp; &nbsp;mpic_unmask_irq(irq_get_irq_data(nmi_virq));</s=
pan><br><span>  &nbsp; &nbsp;}</span><br><span></span><br><span>- &nbsp; &nb=
sp;nemo_init_IRQ(mpic);</span><br><span>-</span><br><span>  &nbsp; &nbsp;of_=
node_put(mpic_node);</span><br><span>  &nbsp; &nbsp;of_node_put(root);</span=
><br><span> }</span><br><span>-- </span><br><span>2.55.0.windows.1</span><br=
><span></span><br></div></blockquote></body></html>=

--Apple-Mail-A9834DA5-6F3E-44C3-B813-B52DCA8C1CC2--

