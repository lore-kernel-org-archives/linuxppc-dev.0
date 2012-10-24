Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F24D62C0109
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2012 16:45:56 +1100 (EST)
Received: by mail-ee0-f42.google.com with SMTP id l10so30254eei.15
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2012 22:45:53 -0700 (PDT)
Message-ID: <50878089.6060301@gmail.com>
Date: Wed, 24 Oct 2012 08:45:45 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com>
 <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
 <50841653.4050301@reliableembeddedsystems.com>
 <1350849666.2476.138.camel__11705.9888471433$1350849778$gmane$org@pasglop>
In-Reply-To: <1350849666.2476.138.camel__11705.9888471433$1350849778$gmane$org@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, rsarmah@apm.com, mla@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,
>
> Remind me what is the symptom ? A specific device isn't working ? Or the
> whole kernel goes toast ?

The whole kernel goes toast! Just reboots without saying much before;)

> My feeling is that those patches make MSIs
> work (well that's what they are supposed to do) and for some reason that
> doesn't agree with whatever you have connected to the PCIe slot...

I have nothing connected to the PCIe slot. Just a standard kilauea eval
board with a defconfig and a 3.6 kernel, so if someone has a kilauea
board it should be very easy to reproduce.

Mai, Rupjyoti do you have a kilauea bard lying around to test?

Maybe it's the kilauea fdt?

If I hard code NR_MSI_IRQS (as it used to be) at least the kernel boots
and I can work with the board. (I don't think MSI interrupts work).

23c23
< #define DEBUG
---
>
47d46
< #define NR_MSI_IRQS	4
55c54
< 	int msi_virqs[NR_MSI_IRQS];
---
> 	int *msi_virqs;
67c66
< 	err = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
---
> 	err = msi_bitmap_alloc(&msi_data->bitmap, msi_irqs,
88a88,92
> 	msi_data->msi_virqs = kmalloc((msi_irqs) * sizeof(int),
> 					    GFP_KERNEL);
> 	if (!msi_data->msi_virqs)
> 		return -ENOMEM;
>
192a197,198
> 	dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
>
202c208
< 	for (i = 0; i < NR_MSI_IRQS; i++) {
---
> 	for (i = 0; i < msi_irqs; i++) {
223,224d228
< 	/*msi = &ppc4xx_msi;*//*keep the msi data for further use*/
<

Regards,

Robert

>
> Cheers,
> Ben.
>

...If it's there, and you can see it, it's real. - If it's not there,
and you can see it, it's virtual.- If it's there, and you can't see it,
it's transparent.- If it's not there, and you can't see it, you erased
it. (from some mailing list)

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
