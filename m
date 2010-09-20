Return-Path: <tmarri@apm.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	by ozlabs.org (Postfix) with SMTP id 44098B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 04:00:11 +1000 (EST)
Received: by qwf7 with SMTP id 7so3738356qwf.28
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Sep 2010 11:00:08 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1284774145-14543-1-git-send-email-tmarri@apm.com>
	<20100918210920.E05AE157D71@gemini.denx.de>
In-Reply-To: <20100918210920.E05AE157D71@gemini.denx.de>
MIME-Version: 1.0
Date: Mon, 20 Sep 2010 11:00:03 -0700
Message-ID: <7707889dee57e97ad50b4ce5c7697466@mail.gmail.com>
Subject: RE: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: neilb@suse.de, yur@emcraft.com, linux-raid@vger.kernel.org,
	herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
	dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mr. Wolfgang
>
> Will this driver ever include any 40x processors? If not, you probably
> should use "44x" instead (here and everywhere in the rest of the
> code).
[Marri] Yes there is 40x based DMA engine we planned to include in the
future.

> > +/* Pointer to DMA0, DMA1 CP/CS FIFO */
> > +static void *ppc440spe_dma_fifo_buf;
>
> Seems this should go into "ppc440spe-dma.h"?
>
>
> > +/* This array is used in data-check operations for storing a pattern
> */
> > +static char ppc440spe_qword[16];
> > +
> > +static atomic_t ppc4xx_adma_err_irq_ref;
> > +static dcr_host_t ppc440spe_mq_dcr_host;
> > +static unsigned int ppc440spe_mq_dcr_len;
>
> Ditto?
>
> > +static unsigned long ppc440spe_rxor_state;
> > +
> > +static struct page *ppc440spe_rxor_srcs[32];
>
> And here again - please check globally!
>
>
> > +/**
> > + * ppc440spe_can_rxor - check if the operands may be processed with
> RXOR
> > + */
> > +static int ppc440spe_can_rxor(struct page **srcs, int src_cnt,
> size_t len)
>
> Again, should this then not be in ppc440spe specific files?
>
>
> It seems the split / generalization is highly incomplete yet.

[Marri] Some of the stuff can go into ppc440spe-dma.h. This is just
Beginning to add more new DMA engines support. I expect more changes to
come in.

Regards,
Marri
