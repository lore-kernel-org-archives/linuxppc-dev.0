Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyZrh5GPpzDrV0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 13:59:00 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id e3so5135168pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 18:59:00 -0800 (PST)
Date: Fri, 15 Dec 2017 12:58:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/3] powerpc/powernv: Identify scom driven system reset
Message-ID: <20171215125848.71da3d0e@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzm+Ha2SLqp1q4W0i82TFP3wjZzPjLsyP2qdCAZf34o9CA@mail.gmail.com>
References: <20171215012740.30291-1-bsingharora@gmail.com>
 <20171215012740.30291-2-bsingharora@gmail.com>
 <20171215124457.69841739@roar.ozlabs.ibm.com>
 <CAKTCnzm+Ha2SLqp1q4W0i82TFP3wjZzPjLsyP2qdCAZf34o9CA@mail.gmail.com>
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

On Fri, 15 Dec 2017 13:54:18 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Fri, Dec 15, 2017 at 1:44 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Fri, 15 Dec 2017 12:27:39 +1100
> > Balbir Singh <bsingharora@gmail.com> wrote:
> >  
> >> In irq_set_pending_from_srr1() we were missing 0x2 as system
> >> reset identified from SRR1 caused by back to back system
> >> resets or when interrupts are caused by SCOM when the thread
> >> is not in power saving mode.
> >>
> >> This helps us get to NMI handling in both the case where NMI
> >> is caused when in power-saving and not in power-saving mode.
> >> The actual exploitation is expected when we are doing a kdump
> >> and an offline CPU might not be in power-saving mode due to
> >> an already spurious IPI or any other reason.
> >>
> >> Signed-off-by: Balbir Singh <bsingharora@gmail.com>  
> >
> > When not in power saving mode, we don't look at SRR1 at all, so
> > we don't need this. You should never be getting it returned as the
> > result of your idle instruction (except on DD1 which has a bug,
> > but firmware doesn't implement the NMI IPI).
> >  
> 
> I added this for the next patch. We call irq_set_pending_from_srr1
> while coming out of CPU idle, but if for any reason the IPI was spurious
> and then we see an NMI during kdump, I did want to detect that
> and callback into the NMI handler.

You'll never see it. The SRR1 value you get is the idle wakeup code.
So any scom-when-not-idle bit should never be set.

Thanks,
Nick
