Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9SlN5VZMzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 16:01:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Binderman <dcb314@hotmail.com>,
 "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus\@samba.org" <paulus@samba.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 anju@linux.vnet.ibm.com
Subject: Re: linux-4.14-rc3/arch/powerpc/perf/imc-pmu.c:599: pointless test ?
In-Reply-To: <HE1PR0802MB23316FCA14FD1F8E51FCAB059C710@HE1PR0802MB2331.eurprd08.prod.outlook.com>
References: <HE1PR0802MB23316FCA14FD1F8E51FCAB059C710@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Date: Mon, 09 Oct 2017 16:01:48 +1100
Message-ID: <87fuasewxv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Binderman <dcb314@hotmail.com> writes:
> Hello there,
>
> linux-4.14-rc3/arch/powerpc/perf/imc-pmu.c:599]: (style) Unsigned variable 'ncpu' can't be negative so it is unnecessary to test it.
>
> Source code is
>
>     if (ncpu >= 0 && ncpu < nr_cpu_ids) {
>
> but
>
>     unsigned int ncpu, core_id;
>
> Suggest remove test.

Thanks.

Notifying the author would be more helpful:

$ git blame -L 599,599 arch/powerpc/perf/imc-pmu.c
39a846db1d574 (Anju T Sudhakar 2017-07-19 03:06:35 +0530 599)   if (ncpu >= 0 && ncpu < nr_cpu_ids) {
$ git log -1 --format=%ae 39a846db1d574
anju@linux.vnet.ibm.com

cheers
