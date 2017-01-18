Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v38BZ56rzzDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 12:14:14 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id f144so17249151pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:14:14 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 18 Jan 2017 06:44:05 +0530
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/mm: refactor radix physical page mapping
Message-ID: <20170118011405.GA10798@localhost.localdomain>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
 <20170117064635.GB8963@dhcp-9-109-223-248.in.ibm.com>
 <20170117183456.4wzelaejta6w6f5m@arbab-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170117183456.4wzelaejta6w6f5m@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 17, 2017 at 12:34:56PM -0600, Reza Arbab wrote:
> Thanks for your review!
> 
> On Tue, Jan 17, 2017 at 12:16:35PM +0530, Balbir Singh wrote:
> > On Mon, Jan 16, 2017 at 01:07:43PM -0600, Reza Arbab wrote:
> > > --- a/arch/powerpc/mm/pgtable-radix.c
> > > +++ b/arch/powerpc/mm/pgtable-radix.c
> > > @@ -107,54 +107,66 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
> > >  	return 0;
> > >  }
> > > 
> > > +static inline void __meminit print_mapping(unsigned long start,
> > > +					   unsigned long end,
> > > +					   unsigned long size)
> > > +{
> > > +	if (end <= start)
> > > +		return;
> > 
> > Should we pr_err for start > end?
> 
> I think that would be overkill. The way this little inline is called, start
> > end is not possible. The real point is not to print anything if start ==
> end. Using <= just seemed better in context.
>

Agreed

<snip>
 
> > 
> > Should we try a lower page size if map_kernel_page fails for this mapping_size?
> 
> The only way map_kernel_page can fail is -ENOMEM. If that's the case,
> there's no way we're going to be able to map this range at all. Better to
> fail fast here, I would think.
>

I think I am OK with this implementation for now. 

Balbir Singh. 
