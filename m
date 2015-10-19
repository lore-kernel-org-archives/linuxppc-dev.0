Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FF0D1A0B26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 20:41:54 +1100 (AEDT)
Message-ID: <1445247713.30407.6.camel@ellerman.id.au>
Subject: Re: [PATCH] rtas: Validate rtas entry before calling enter_rtas
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Mon, 19 Oct 2015 20:41:53 +1100
In-Reply-To: <5621CFB8.2050306@linux.vnet.ibm.com>
References: <20151016102327.6010.50184.stgit@hegdevasant.in.ibm.com>
 <CAOJe8K03v_0MULL_pxX=CgSaFTTDmS8aJe1j+aFO9HHxhZ7d4Q@mail.gmail.com>
 <56211459.1060006@linux.vnet.ibm.com>
 <CAOJe8K0Mva7+12k1eJjineUTfaPQiyae9HEnxRG+=2FkyrnmVA@mail.gmail.com>
 <5621CFB8.2050306@linux.vnet.ibm.com>
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

On Sat, 2015-10-17 at 10:04 +0530, Vasant Hegde wrote:
> On 10/16/2015 11:49 PM, Denis Kirjanov wrote:
> > On 10/16/15, Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> > > On 10/16/2015 04:02 PM, Denis Kirjanov wrote:
> > > > On 10/16/15, Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:
> > > > > Currently we do not validate rtas entry before calling enter_rtas().
> > > > 
> > > > have you figured out why we have null entry?

> > > Yes... On PowerNV platform we don't have RTAS.. Hence it's not initialized.

> > But why do we have CONFIG_PPC_RTAS on OPAL machines then?
 
> Today we use single config to build kernel for both PowerNV and PAPR guest. So
> that same ISO can be used in different environment (PAPR LPAR, PowerNV host,
> guest). I believe most distro also following this method. Hence we need this
> validation.

Yes that's right.

Many of our platforms can coexist. So for example you can build a 64-bit big
endian kernel with support for G5, pSeries, Powernv, PS3, IBM Cell Blades,
Pasemi, & Maple (Bimini).

That means code that is #ifdef'ed to depend on one of those platforms, may end
up running on another platform. So we usually also need a runtime check to make
sure code doesn't run in the wrong places.

You'll see a lot of initcalls are machine_xxx_initcalls(), which means they
only run if the correct platform was detected. There's also
firmware_has_feature() checks, and then also device tree based detection.

This one seems to have slipped through the cracks because the tools that call
sys_rtas() are not used on powernv machines, so no one has though to call that
syscall. And on pseries machines rtas is always present, though obviously the
code should have still checked rtas.entry to be safe.

cheers
