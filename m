Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdzcv6PjXzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 16:35:27 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g2so1153054pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 21:35:27 -0800 (PST)
Date: Thu, 9 Mar 2017 15:35:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/64s: POWER9 machine check handler
Message-ID: <20170309153515.07f3b255@roar.ozlabs.ibm.com>
In-Reply-To: <b9166ee8-faa3-41be-78ec-4968e0ee18b4@linux.vnet.ibm.com>
References: <20170228020048.8862-1-npiggin@gmail.com>
 <20170228020048.8862-4-npiggin@gmail.com>
 <b9166ee8-faa3-41be-78ec-4968e0ee18b4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Feb 2017 12:37:23 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 02/28/2017 07:30 AM, Nicholas Piggin wrote:

> > +long __machine_check_early_realmode_p9(struct pt_regs *regs)
> > +{
> > +	uint64_t nip, addr;
> > +	long handled;
> > +	struct mce_error_info mce_error_info = { 0 };
> > +
> > +	nip = regs->nip;
> > +
> > +	if (P9_SRR1_MC_LOADSTORE(regs->msr)) {  
> 
> Asynch store errors are reported in the srr1 with codes srr1 42=1, 36=1,
> 43=1 and 44:45 = 01 or 10. Since srr1 42=1, you may end up in
> mce_handle_derror_p9() for asynch errors and look for error bits in
> DSISR instead in SRR1. We will miss detecting asynch errors completely.

After clarification from hardware, Asynch MCEs are reported with
SRR1 bit 42 = 0, so I think this is okay.

Thanks,
Nick
