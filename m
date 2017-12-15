Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yydGB1g3LzDrYp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 15:47:46 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id a90so5358240pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 20:47:45 -0800 (PST)
Date: Fri, 15 Dec 2017 14:47:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/3] powernv/kdump: Fix cases where the kdump kernel
 can get HMI's
Message-ID: <20171215144733.1ca08521@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzkn2_LUn=NLQS6-c4hHR4uXt=jX4q-eGO_9xZhjo0v26Q@mail.gmail.com>
References: <20171215012740.30291-1-bsingharora@gmail.com>
 <20171215012740.30291-3-bsingharora@gmail.com>
 <20171215131053.10948c93@roar.ozlabs.ibm.com>
 <CAKTCnzkn2_LUn=NLQS6-c4hHR4uXt=jX4q-eGO_9xZhjo0v26Q@mail.gmail.com>
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

On Fri, 15 Dec 2017 14:34:03 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Fri, Dec 15, 2017 at 2:10 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Fri, 15 Dec 2017 12:27:40 +1100
> > Balbir Singh <bsingharora@gmail.com> wrote:

> > But then you still need an explicit kdump check for non-sreset wakeups
> > because the platform may not implement sreset, or it may fall back to
> > normal IPI if the sreset scom fails. So you then still need your
> >
> > if (kdump) crash_ipi_callback  
> 
> Yep, its required for the the non NMI case.
> 
> 
> How does this look -- based on your comment
> 
> +               } else if ((srr1 & wmask) == SRR1_WAKESRESET) {
> +                       irq_set_pending_from_srr1(srr1);
> +                       /* Does not return */
>                 }
> +
>                 smp_mb();
> 
>                 /*
>                  * For kdump kernels, we process the ipi and jump to
> -                * handling the system reset exception.
> +                * crash_ipi_callback
>                  */
> -               if (kdump_in_progress())
> -                       irq_set_pending_from_srr1(srr1);
> +               if (kdump_in_progress()) {
> +                       /*
> +                        * If we got to this point, we've not used
> +                        * NMI's, otherwise we would have gone
> +                        * via the SRR1_WAKESRESET path. We are
> +                        * using regular IPI's for waking up offline
> +                        * threads.
> +                        */
> +                       struct pt_regs regs;
> +
> +                       ppc_save_regs(&regs);
> +                       crash_ipi_callback(regs);
> +                       /* Does not return */
> +               }

That looks like it should do the trick.

Thanks,
Nick
