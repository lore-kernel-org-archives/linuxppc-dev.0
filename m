Return-Path: <kda@linux-powerpc.org>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com
 [IPv6:2607:f8b0:400d:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64ADC1A0F00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 18:33:01 +1100 (AEDT)
Received: by qkdp187 with SMTP id p187so17586777qkd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Dec 2015 23:32:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <566593B8.3070904@xenosoft.de>
References: <565AF986.9060106@xenosoft.de>
 <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
 <565C1B55.4020207@xenosoft.de> <565C8287.7090209@xenosoft.de>
 <20151130181217.GA15921@visitor2.iram.es>
 <565DB2FE.1010706@xenosoft.de> <565E7A9E.4000909@xenosoft.de>
 <1449044072.24750.3.camel@ellerman.id.au>
 <565F5E7C.9040207@xenosoft.de> <56603787.3000802@xenosoft.de>
 <566576E8.2060300@xenosoft.de> <566593B8.3070904@xenosoft.de>
Date: Tue, 8 Dec 2015 10:32:57 +0300
Message-ID: <CAOJe8K0FQOM=ea3qa=g4eOVbhCpyi5OQRWF8Mh1NZ8-mpUWJjw@mail.gmail.com>
Subject: Re: [P.A. Semi] Does the ethernet interface work on your Electra,
 Chitra, Nemo, and Athena board?
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Gabriel Paubert <paubert@iram.es>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/7/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> Hi all,
>
> I have some good news for you. I was able to fix the issue with the P.A.
> Semi Ethernet. It was a problem with the new DMA handling. The patch '
> [RFC/PATCH,v2] powerpc/iommu: Support "hybrid" iommu/direct DMA ops for
> coherent_mask < dma_mask (https://patchwork.ozlabs.org/patch/472535/)'
> is the problem.
>
> I had patched the following files before I compiled a kernel.
>
> arch/powerpc/Kconfig
> arch/powerpc/include/asm/device.h
> arch/powerpc/include/asm/dma-mapping.h
> arch/powerpc/include/asm/iommu.h
> arch/powerpc/kernel/dma-iommu.c
> arch/powerpc/kernel/dma-swiotlb.c
> arch/powerpc/kernel/dma.c
> arch/powerpc/platforms/powernv/pci-ioda.c
> arch/powerpc/platforms/pseries/iommu.c
> arch/powerpc/sysdev/dart_iommu.c
> include/asm-generic/dma-mapping-common.h
>
> The P.A. Semi Ethernet works again with the patched kernel.

Hi Ben,

Could you please take a look..

Thanks!

>
> I am happy. :-)
>
> Please fix the issue in the kernel source code.
>
> Thanks in advance,
>
> Christian
>
>
>
