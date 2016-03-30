Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZxJN0XP2zDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 05:39:31 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 15:39:27 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 98F34352005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 14:39:10 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2UHdQNq9503038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 14:39:26 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2UIdKCH029486
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 15:39:20 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Date: Wed, 30 Mar 2016 15:38:07 -0300
Message-ID: <1703586.buApXYfjM8@hactar>
In-Reply-To: <1459328976.23987.4.camel@ellerman.id.au>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <20160330080459.GB21299@naverao1-tp.in.ibm.com>
 <1459328976.23987.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 30 M=E4rz 2016, 20:09:36 schrieb Michael Ellerman:
> On Wed, 2016-03-30 at 13:34 +0530, Naveen N. Rao wrote:
> > On 2016/03/29 08:35PM, Thiago Jung Bauermann wrote:
> > > Am Dienstag, 29 M=E4rz 2016, 14:31:34 schrieb Michael Ellerman:
> > > > On Mon, 2016-03-28 at 17:06 -0300, Thiago Jung Bauermann wrote:=

> > > > > With this patch, all vmlinux symbols match /proc/kallsyms and=
 the
> > > > > testcase passes.
> > > >=20
> > > > Have you tested this on an LE system?
> > >=20
> > > No, I was focusing on ppc64 BE.
> >=20
> > Which kernel did you use? I don't see this with the latest 4.6.0-rc=
1.
>=20
> Yeah I can't reproduce the perf test failure either.

I can still reproduce on 4.6.0-rc1.

> Not sure what's going on?

Try disabling CONFIG_FUNCTION_TRACER. The test failure happens when .kr=
etprobe_trampoline_holder and
kretprobe_trampoline have the same address. If that option is enabled, =
the symbols have different addresses:

$ eu-readelf -s /boot/vmlinux-4.6.0-rc1-dirty | grep kretprobe_tramp   =
                                                =20
 2479: c000000000ef1d68     24 NOTYPE  LOCAL  DEFAULT       37 kretprob=
e_trampoline_holder
 2480: c000000000043ab0     40 FUNC    LOCAL  DEFAULT        1 .kretpro=
be_trampoline_holder
86903: c000000000043ac4      0 NOTYPE  GLOBAL DEFAULT        1 kretprob=
e_trampoline
$ grep kretprobe_tramp /proc/kallsyms
c000000000043ab0 t .kretprobe_trampoline_holder
c000000000043ac4 T kretprobe_trampoline
c000000000ef1d68 d kretprobe_trampoline_holder

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
