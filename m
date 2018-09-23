Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JPDc46WgzF1p5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 09:48:48 +1000 (AEST)
Message-ID: <a06045cd5f4229113cb301668b2d993060a3ee73.camel@neuling.org>
Subject: Re: [PATCH v8 1/3] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
From: Michael Neuling <mikey@neuling.org>
To: ego@linux.vnet.ibm.com
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Murilo Opsfelder Araujo
 <muriloo@linux.ibm.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Sep 2018 09:48:47 +1000
In-Reply-To: <20180921171740.GA12919@in.ibm.com>
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <1537464159-25919-2-git-send-email-ego@linux.vnet.ibm.com>
 <d1cf1628ed2641140d3508d355cdc172d6b145e9.camel@neuling.org>
 <20180921171740.GA12919@in.ibm.com>
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

On Fri, 2018-09-21 at 22:47 +0530, Gautham R Shenoy wrote:
> Hello Michael,
>=20
> On Fri, Sep 21, 2018 at 01:02:45PM +1000, Michael Neuling wrote:
> > This doesn't compile for me with:
> >=20
> > arch/powerpc/kernel/smp.c: In function =E2=80=98smp_prepare_cpus=E2=80=
=99:
> > arch/powerpc/kernel/smp.c:812:23: error: =E2=80=98tg.threads_per_group=
=E2=80=99 may be used
> > uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >   struct thread_groups tg;
> >                        ^
> > arch/powerpc/kernel/smp.c:812:23: error: =E2=80=98tg.nr_groups=E2=80=99=
 may be used
> > uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> > cc1: all warnings being treated as errors
> > /home/mikey/src/linux-ozlabs/scripts/Makefile.build:305: recipe for tar=
get
> > 'arch/powerpc/kernel/smp.o' failed
> >=20
>=20
> I couldn't get this error with gcc 4.8.5 and 8.1.1 with
> pseries_defconfig and powernv_defconfig with CONFIG_PPC_WERROR=3Dy.

I'm using 5.4.0 which is in Ubuntu 16.04 (LTS).

> Does the following the following delta patch make it work?

Yep that fixes it, thanks.

Mikey
