Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBm6z6x0lzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 18:38:19 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id u144so1363169pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 00:38:18 -0700 (PDT)
Date: Wed, 11 Oct 2017 13:08:13 +0530
From: Santosh Sivaraj <santosh@fossix.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20171011073813.uzmxrhwxprs5awzj@santosiv.in.ibm.com>
References: <20171010093033.73x66lxl3xxi33qo@naverao1-tp.localdomain>
 <20171010231003.10325-1-santosh@fossix.org>
 <20171011070443.5lupjenfs4ycwd5q@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011070443.5lupjenfs4ycwd5q@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> wrote (on 2017-10-11 07:04:43 +0000):

> Hi Santosh,
> This seems to have gone from v4 to v6 -- did I miss v5?

Nope, this is indeed v5, a typo :-(
>
> On 2017/10/10 11:10PM, Santosh Sivaraj wrote:
> > Current vDSO64 implementation does not have support for coarse clocks
> > (CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls back
> > to system call, increasing the response time, vDSO implementation reduces
> > the cycle time. Below is a benchmark of the difference in execution times.
> > 
> > (Non-coarse clocks are also included just for completion)
> > 
> > clock-gettime-realtime: syscall: 172 nsec/call
> > clock-gettime-realtime:    libc: 28 nsec/call
> > clock-gettime-realtime:    vdso: 22 nsec/call
> > clock-gettime-monotonic: syscall: 171 nsec/call
> > clock-gettime-monotonic:    libc: 30 nsec/call
> > clock-gettime-monotonic:    vdso: 25 nsec/call
> > clock-gettime-realtime-coarse: syscall: 153 nsec/call
> > clock-gettime-realtime-coarse:    libc: 16 nsec/call
> > clock-gettime-realtime-coarse:    vdso: 10 nsec/call
> > clock-gettime-monotonic-coarse: syscall: 167 nsec/call
> > clock-gettime-monotonic-coarse:    libc: 17 nsec/call
> > clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
> > 
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> > ---
> >  arch/powerpc/kernel/asm-offsets.c         |  2 +
> >  arch/powerpc/kernel/vdso64/gettimeofday.S | 67 ++++++++++++++++++++++++++-----
> >  2 files changed, 58 insertions(+), 11 deletions(-)
> 
> ... and no changes since the last rev?

There is that one line change of label. But otherwise its the same.
> 
> It is better to post new versions in a separate thread and to include 
> the changelog for easier review.
>

Sure.

Thanks,
Santosh
> 
> - Naveen
> 

-- 
