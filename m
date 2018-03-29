Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BpH05pdvzF0W1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 02:15:55 +1100 (AEDT)
Received: by mail-pg0-x22e.google.com with SMTP id g8so3253358pgv.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 08:15:55 -0700 (PDT)
Date: Fri, 30 Mar 2018 01:15:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/14] powerpc: pass node id into create_section_mapping
Message-ID: <20180330011539.730a0ac1@roar.ozlabs.ibm.com>
In-Reply-To: <87o9j71lbf.fsf@concordia.ellerman.id.au>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-13-npiggin@gmail.com>
 <87o9j71lbf.fsf@concordia.ellerman.id.au>
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

On Thu, 29 Mar 2018 16:51:16 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index 328ff9abc333..435b19e74508 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -862,9 +862,9 @@ static void remove_pagetable(unsigned long start, unsigned long end)
> >  	radix__flush_tlb_kernel_range(start, end);
> >  }
> >  
> > -int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
> > +int __ref radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
> >  {
> > -	return create_physical_mapping(start, end);
> > +	return create_physical_mapping(start, end, nid);
> >  }  
> 
> This got a little muddled. We add the nid argument here, but
> create_physical_mapping() doesn't take it until patch 14.
> 
> I managed to fix it by rearranging the last three patches and fiddling
> things a bit. If you can check the result once I push that would be good.

I think it looks okay how you've got it.

Thanks,
Nick
