Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqqdP5pZLzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 14:10:49 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id k134so7242734pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Dec 2017 19:10:49 -0800 (PST)
Date: Mon, 4 Dec 2017 13:10:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [rfc] powernv/kdump: Fix cases where the kdump kernel can get
 HMI's
Message-ID: <20171204131033.2df6ea84@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnz=w5KEECS2RwWjrfDVgMVZWYJqQb4C8EOUbfZh2Bb=z4A@mail.gmail.com>
References: <20171202134808.27480-1-bsingharora@gmail.com>
 <20171203123658.056226c1@roar.ozlabs.ibm.com>
 <CAKTCnz=w5KEECS2RwWjrfDVgMVZWYJqQb4C8EOUbfZh2Bb=z4A@mail.gmail.com>
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

On Mon, 4 Dec 2017 11:37:01 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On Sun, Dec 3, 2017 at 1:36 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > Seems like a reasonable approach. Why do we only do this for
> > powernv? It seems like a good idea in general to pull all
> > offlined CPUs out and into the same state for all platforms
> > and for all shutdown/restart/crash paths.
> >  
> 
> The reason is largely wake-up related, do we expect offline CPUs to wake
> up in the kdump kernel. Largely the infrastructure allows us to selectively
> decide what platforms need this support. I did not want to break the world
> by enabling it across platforms (pseries for example) without good reason.

What happens if a pseries offlined CPU gets an exception for some reason
though? It seems like it would return into pseries_mach_cpu_die of the
old kernel which will go wrong.

Maybe the platform has stronger guarantees that it won't wake up there,
like requiring a specific hcall or something?

I was just thinking trying to move all platforms in general to the same
scheme would be preferable, unless there is a good reason not to. Just
for sharing code and behaviour.

> 
> > Also I wonder if there is anything we should do on the other
> > side of the equation for the kdump kernel to pull CPUs into a
> > known state rather than rely on the crash kernel to do it for
> > us. We might have a better ability to do that with system
> > reset IPIs now.
> >  
> 
> Yes, but do we need to do that or quickly dump the vmcore to a file
> and exit?

Well if the previous kernel did not shut them down properly, we need
to do that. Don't we? My point is the previous kernel crashed somehow,
we should be trying to fix everything up rather than hoping it crashed
"nicely" for us.

Yes we shouldn't disturb things as much as possible, but we've booted
an entire new kernel in its own reserved memory, so I'm not sure if
it's such a concern to try fixing up wayward CPUs.

Thanks,
Nick
