Return-Path: <mark@klomp.org>
Received: from gnu.wildebeest.org (wildebeest.demon.nl [212.238.236.112])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpLYM2RLxzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 21:16:38 +1000 (AEST)
Message-ID: <1497525392.3755.307.camel@klomp.org>
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
From: Mark Wielaard <mark@klomp.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, acme@kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 15 Jun 2017 13:16:32 +0200
In-Reply-To: <3621613.kMnvz8Tm3d@milian-kdab2>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <1497354282.3755.201.camel@klomp.org> <59400ADD.4090709@linux.vnet.ibm.com>
 <3621613.kMnvz8Tm3d@milian-kdab2>
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

On Thu, 2017-06-15 at 10:46 +0200, Milian Wolff wrote:
> Just a quick question: Have you guys applied my recent patch:
>=20
> commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6
> Author: Milian Wolff <milian.wolff@kdab.com>
> Date:   Thu Jun 1 23:00:21 2017 +0200
>=20
>     perf report: Include partial stacks unwound with libdw
>    =20
>     So far the whole stack was thrown away when any error occurred before
>     the maximum stack depth was unwound. This is actually a very common
>     scenario though. The stacks that got unwound so far are still
>     interesting. This removes a large chunk of differences when comparing
>     perf script output for libunwind and libdw perf unwinding.
>=20
> If not, then this could explain the issue you are seeing.

Thanks! No, I didn't have that patch (*) yet. It makes a huge
difference. With that, Paolo's patch and the elfutils libdw powerpc64
fallback unwinder patch, it looks like I get user stack traces for
everything now on ppc64le.

Cheers,

Mark

(*) It just this one-liner, but what a difference that makes:

--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -224,7 +224,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg=
,
=20
        err =3D dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback=
, ui);
=20
-       if (err && !ui->max_stack)
+       if (err && ui->max_stack !=3D max_stack)
                err =3D 0;
=20
        /*
