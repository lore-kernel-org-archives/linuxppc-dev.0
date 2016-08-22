Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHmPq1CbWzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 18:07:11 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so5890209pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 01:07:11 -0700 (PDT)
Date: Mon, 22 Aug 2016 18:07:00 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Enable storage keys for radix - user mode execution
Message-ID: <20160822080700.GB24002@350D>
Reply-To: bsingharora@gmail.com
References: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
 <87y43pibnf.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y43pibnf.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2016 at 11:32:44AM +0530, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > ISA 3 defines new encoded access authority that allows instruction
> > access prevention in privileged mode and allows normal access
> > to problem state. This patch just enables IAMR (Instruction Authority
> > Mask Register), enabling AMR would require more work.
> >
> 
> Don't we need to do them in hypervisor mode. Ie, the hypervisor setup
> things such that guest privileged mode cannot execute guest userspace.

Yes, true!

> 
> > I've tested this with a buggy driver and a simple payload. The payload
> > is specific to the build I've tested.
> >
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >  arch/powerpc/mm/pgtable-radix.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index af897d9..9e25663 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -294,6 +294,27 @@ found:
> >  	return;
> >  }
> >
> > +/*
> > + * For radix page tables we setup, the IAMR values as follows
> > + * IMAR = 0100...00 (key 0 is set to 1)
> > + * AMOR = 1100....00 (Mask for key 0 is 11)
> > + * AMR, UAMR, UAMOR are not affected
> > + */
> > +static void __init radix_init_iamr(void)
> > +{
> > +	unsigned long iamr_mask = 0x4000000000000000;
> > +	unsigned long iamr = mfspr(SPRN_IAMR);
> > +
> > +	unsigned long amor_mask = 0xc000000000000000;
> > +	unsigned long amor = mfspr(SPRN_AMOR);
> 
> Isn't AMOR hypervisor privileged ?.
>

You are right, I should split the AMOR initialization
to be HV only. IAMR is saved/restored during guest exit/entry.

So, the AMOR initialization needs to move.

I'll post a v2

Balbir Singh.
