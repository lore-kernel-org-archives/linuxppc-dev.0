Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 042E42C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 13:22:14 +1100 (EST)
Message-ID: <1386123722.16703.129.camel@pasglop>
Subject: Re: Error in frreing hugepages with preemption enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Date: Wed, 04 Dec 2013 13:22:02 +1100
In-Reply-To: <20131203222121.GB18764@redhat.com>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D07238568@039-SN2MPN1-012.039d.mgd.msft.net>
 <EDB02D3B-6B03-4CCB-95C8-FDF2F2932E1D@suse.de>
 <20131203222121.GB18764@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-03 at 23:21 +0100, Andrea Arcangeli wrote:
> #ifdef CONFIG_PPC_FSL_BOOK3E
>         hugepd_free(tlb, hugepte);
         ^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the culprit

(Alex, you didn't specify this was embedded or did I miss it ?)

> #else
>         pgtable_free_tlb(tlb, hugepte, pdshift - shift);
> #endif
> }

That function does:

	batchp = &__get_cpu_var(hugepd_freelist_cur);

IE, it tries to use a per-CPU batch. Basically, it's duplicating the
logic in mm/memory.c for RCU freeing using a per-cpu freelist. I suppose
it assumes being called under something like the page table lock ?

This code also never "flushes" the batch, which is a concern...

Alex, this is Freescale stuff, can you followup with them ?

Cheers,
Ben.
