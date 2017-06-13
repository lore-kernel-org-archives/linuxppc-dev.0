Return-Path: <mark@klomp.org>
Received: from gnu.wildebeest.org (wildebeest.demon.nl [212.238.236.112])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn7Rp4HsyzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 21:52:38 +1000 (AEST)
Message-ID: <1497354282.3755.201.camel@klomp.org>
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
From: Mark Wielaard <mark@klomp.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 acme@kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 13 Jun 2017 13:44:42 +0200
In-Reply-To: <593E81ED.8060606@linux.vnet.ibm.com>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <a44cf3bd-e868-a8d5-4518-2bea76be7f8f@redhat.com>
 <593E81ED.8060606@linux.vnet.ibm.com>
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

Hi Ravi,

On Mon, 2017-06-12 at 17:28 +0530, Ravi Bangoria wrote:
> So, I tested this patch along with Mark's patch[1] on elfutils an looks
> like it's not working. Steps on what I did:
>=20
> After applying Mark's patch on upstream elfutils:
>=20
>   $ aclocal
>   $ autoheader
>   $ autoconf
>   $ automake --add-missing
>   $ ./configure
>   $ make
>   $ make install DESTDIR=3D/home/ravi/elfutils-git
>=20
> After applying your patch on upstream perf:
>=20
>   $ make
>   $ ./perf record --call-graph=3Ddwarf ls
>   $ LD_LIBRARY_PATH=3D/home/ravi/elfutils-git/usr/local/lib:\
>     /home/ravi/elfutils-git/usr/local/lib/elfutils/:$LD_LIBRARY_PATH \
>     ./perf script
>=20
>     ls 44159  1800.878468:     191408 cycles:u:
>=20
>     ls 44159  1800.878673:     419356 cycles:u:
>                        8a97c hpte_need_flush (/usr/lib/debug/lib/modules/=
4.11.0-3.el7.ppc64le/vmlinux)
>                        835f4 flush_hash_page (/usr/lib/debug/lib/modules/=
4.11.0-3.el7.ppc64le/vmlinux)
>                        8acec hpte_need_flush (/usr/lib/debug/lib/modules/=
4.11.0-3.el7.ppc64le/vmlinux)
>                       3468f4 ptep_clear_flush (/usr/lib/debug/lib/modules=
/4.11.0-3.el7.ppc64le/vmlinux)
>                       328b10 wp_page_copy (/usr/lib/debug/lib/modules/4.1=
1.0-3.el7.ppc64le/vmlinux)
>                       32ebe4 do_wp_page (/usr/lib/debug/lib/modules/4.11.=
0-3.el7.ppc64le/vmlinux)
>                       33434c __handle_mm_fault (/usr/lib/debug/lib/module=
s/4.11.0-3.el7.ppc64le/vmlinux)
>                       335040 handle_mm_fault (/usr/lib/debug/lib/modules/=
4.11.0-3.el7.ppc64le/vmlinux)
>                        7bf94 do_page_fault (/usr/lib/debug/lib/modules/4.=
11.0-3.el7.ppc64le/vmlinux)
>                        1a4f8 handle_page_fault (/usr/lib/debug/lib/module=
s/4.11.0-3.el7.ppc64le/vmlinux)
>=20
>     ls 44159  1800.878961:     430876 cycles:u:
>=20
>     ls 44159  1800.879195:     423785 cycles:u:
>=20
>     ls 44159  1800.879360:     427359 cycles:u:
>=20
> Here I don't see userspace callchain getting unwound. Please let me know
> if I'm doing anything wrong.

I see the same on very short runs. But when doing a slightly longer run,
even just using ls -lahR, which does some more work, then I do see user
backtraces. They are still missing for some of the early samples though.
It is as if there is a stack/memory address mismatch when the probe is
"too early" in ld.so.

Could you do a test run on some program that does some more work to see
if you never get any user stack traces, or if you only not get them for
some specific probes?

Thanks,

Mark
