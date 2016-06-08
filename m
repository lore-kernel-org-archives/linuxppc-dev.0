Return-Path: <d6malek@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQ3nq3fgjzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 09:01:03 +1000 (AEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [RFC] Implementing HUGEPAGE on MPC 8xx
From: Dan Malek <d6malek@digitaldans.com>
In-Reply-To: <b2980a9d-4795-ae1b-16dd-ba244d559a31@c-s.fr>
Date: Wed, 8 Jun 2016 15:46:15 -0700
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Becky Bruce <beckyb@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <oss@buserror.net>
Message-Id: <9ED9D9D9-67F5-4598-94F7-D0E0A6FF5EA7@digitaldans.com>
References: <b2980a9d-4795-ae1b-16dd-ba244d559a31@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello Christophe.

I=E2=80=99m surprised there is still any interest in this processor =
family :)

On Jun 8, 2016, at 12:03 AM, Christophe Leroy <christophe.leroy@c-s.fr> =
wrote:

> MPC 8xx has several page sizes: 4k, 16k, 512k and 8M.
> Today, 4k and 16k sizes are implemented as normal page sizes and 8M is =
used for mapping linear memory space in kernel.
>=20
> I'd like to implement HUGE PAGE to reduce TLB misses from user apps.

My original plan was to implement the TLB miss handler in three lines of =
code.  I haven=E2=80=99t investigated recently, but I know the amount of =
code has grown substantially :)

> In 4k mode, PAGE offset is 12 bits, PTE offset is 10 bits and PGD =
offset is 10 bits
> In 16k mode, PAGE offset is 14 bits, PTE offset is 12 bits and PGD =
offset is 6 bits

Since the 8xx systems typically have rather small real memory, I was =
considering a combination of 4k and 512k pages as an attempt to maximize =
real memory utilization.  The 4k pages in the PTE tables as today, and =
the 512k flagged in the PGD and just loaded from there.  I don=E2=80=99t =
know if 16k is a big enough win (unless it=E2=80=99s the =E2=80=9Cstandard=
=E2=80=9D page size to keep TLBmiss as simple as possible), or if 8M is =
terribly useful from user space.

> =46rom your point of view, what would be the best approach to extend =
support of HUGE PAGES to PPC_8xx ?
> Would the good starting point be to implement a hugepagetlb-8xx.c from =
hugepagetlb-book3e.c ?

I guess that is the place to start.  When I first thought about this =
many years ago, I was hoping to map shared libraries and properly =
behaving programs.  The mechanism I considered to do this was either =
inspection of the section headers, using some section flags, or maybe =
Aux Vector  to set up mmap() to hugetlb at run-time.

Good Luck.

	=E2=80=94 Dan
