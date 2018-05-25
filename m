Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sbFN5mgtzF1fW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 16:00:08 +1000 (AEST)
Message-ID: <ef3168d13a2fc04fd52cd3b77c66e8a6c6f953ac.camel@neuling.org>
Subject: Re: [PATCH 2/2] selftests/powerpc: Add perf breakpoint test
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 25 May 2018 16:00:08 +1000
In-Reply-To: <87tvqx4a7q.fsf@concordia.ellerman.id.au>
References: <20180522061428.5142-1-mikey@neuling.org>
 <20180522061428.5142-2-mikey@neuling.org>
 <87tvqx4a7q.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-05-24 at 20:30 +1000, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
>=20
> > This tests perf hardware breakpoints (ie PERF_TYPE_BREAKPOINT) on
> > powerpc.
>=20
> This doesn't work for me on a P8 guest:
>=20
>   test: perf-hwbreak
>   tags: git_version:bb5602e
>   !! killing perf-hwbreak
>   !! child died by signal 15
>   failure: perf-hwbreak
>=20
>=20
> That means the harness killed it after 2 minutes.
>=20
> Sometimes it gets further:
>=20
>   test: perf-hwbreak
>   tags: git_version:v4.17-rc3-109-gbb20240fb508
>   threads=3D16 loops=3D1048576 scalar test
>   !! killing perf-hwbreak
>   !! child died by signal 15
>   failure: perf-hwbreak
>=20
>=20
> Do we just need to bump the timeout up, or is something going wrong
> here?

Yeah, sorry my bad.  The test was trying to randomly test all the combinati=
ons.
=20
I've rewritten it now to explicitly test all the combinations. This gives i=
t a
more consistent runtime. I do randomly vary the loop count but this is only=
 a
small variation (~10%) to avoid using a count from a previous test.

Mikey
