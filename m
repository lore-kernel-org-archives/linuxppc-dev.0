Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyDy92pXnzDrcK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 00:32:33 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id k15so3411480pgr.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 05:32:33 -0800 (PST)
Date: Thu, 14 Dec 2017 23:32:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powernv/kdump: Fix cases where the kdump kernel can
 get HMI's
Message-ID: <20171214233220.19f3b36d@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzkF0ntwaXs3STmCT0tNz-LZyyPnSMHh8rTG=oFQw7fL=w@mail.gmail.com>
References: <20171213080828.2800-1-bsingharora@gmail.com>
 <20171213080828.2800-2-bsingharora@gmail.com>
 <20171213205101.2cc0c830@roar.ozlabs.ibm.com>
 <20171214111213.07ba99a4@gmail.com>
 <20171214115137.5603f77d@roar.ozlabs.ibm.com>
 <CAKTCnzkF0ntwaXs3STmCT0tNz-LZyyPnSMHh8rTG=oFQw7fL=w@mail.gmail.com>
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

On Thu, 14 Dec 2017 23:16:26 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Thu, Dec 14, 2017 at 12:51 PM, Nicholas Piggin <npiggin@gmail.com> wrote:


> >> I can't call smp_send_nmi_ipi due to the nmi_ipi_busy_count and
> >> I'm worried about calling a stale nmi_ipi_function via the
> >> system_reset_exception path, if we are OK with it, I can revisit
> >> the code path  
> >
> > You shouldn't get a stale one, that would also be a bug -- we
> > have to cope with NMIs coming in at any time that are triggered
> > externally (not by smp_send_nmi_ipi), so if you see any bugs
> > there those need to be fixed separately.
> >  
> 
> Yes, I think it's a bug, nothing clears nmi_ipi_function (from what
> I can see), so when the next NMI comes in and goes into
> pnv_system_reset_exception
> it'll execute the stale handler.

The CPU won't be in the nmi_ipi_pending_mask though, so it shouldn't
get that far. You could add a bit of paranoia to clear the function
pointer I suppose, but AFAIKS it's not needed.

> I'll respin things based on the
> suggestion above
> and deal with any bugs as well.

Thanks,
Nick
