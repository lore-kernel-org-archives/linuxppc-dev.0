Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szLtc2fxczDsyx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 17:02:00 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id s8so1479043pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 23:02:00 -0700 (PDT)
Date: Wed, 19 Oct 2016 17:01:46 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/7] powerpc/64s: tool to flag direct branches from
 unrelocated interrupt vectors
Message-ID: <20161019170146.75d936bc@roar.ozlabs.ibm.com>
In-Reply-To: <408e4f35-17a6-8738-c711-8bfb39928628@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-4-npiggin@gmail.com>
 <408e4f35-17a6-8738-c711-8bfb39928628@gmail.com>
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

On Wed, 19 Oct 2016 15:28:40 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On 19/10/16 14:15, Nicholas Piggin wrote:
> > Direct banches from code below __end_interrupts to code above
> > __end_interrupts when built with CONFIG_RELOCATABLE are disallowed
> > because they will break when the kernel is not located at 0.
> > 
> > Sample output:
> > 
> >     WARNING: Unrelocated relative branches
> >     c000000000000118 bl-> 0xc000000000038fb8 <pnv_restore_hyp_resource>
> >     c00000000000013c b-> 0xc0000000001068a4 <kvm_start_guest>
> >     c000000000000148 b-> 0xc00000000003919c <pnv_wakeup_loss>
> >     c00000000000014c b-> 0xc00000000003923c <pnv_wakeup_noloss>
> >     c0000000000005a4 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
> >     c000000000001af0 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
> >     c000000000001b24 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
> >     c000000000001b58 b-> 0xc000000000106ffc <kvmppc_interrupt_hv>
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---  
> 
> If this is the same script I gave you, you can add my SOB line as well

I can't remember now, but I know you had something... I'm usually careful
to get attributions right. I'll add your SOB.
