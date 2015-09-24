Return-Path: <mjw@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADB621A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 21:23:16 +1000 (AEST)
Message-ID: <1443093792.3102.42.camel@bordewijk.wildebeest.org>
Subject: Re: [PATCH] perf/probe: Search both .eh_frame and .debug_frame
 sections for probe location
From: Mark Wielaard <mjw@redhat.com>
To: =?UTF-8?Q?=E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3?= /
 =?UTF-8?Q?HIRAMATU=EF=BC=8CMASAMI?= <masami.hiramatsu.pt@hitachi.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "acme@kernel.org" <acme@kernel.org>,
 "sukadev@linux.vnet.ibm.com" <sukadev@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 24 Sep 2015 13:23:12 +0200
In-Reply-To: <50399556C9727B4D88A595C8584AAB37525585E9@GSjpTKYDCembx32.service.hitachi.net>
References: <1443060990-10313-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1443088766.3102.19.camel@bordewijk.wildebeest.org>
 <50399556C9727B4D88A595C8584AAB37525585E9@GSjpTKYDCembx32.service.hitachi.net>
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

On Thu, 2015-09-24 at 10:56 +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / H=
IRAMATU=EF=BC=8CMASAMI wrote:
> >I am not too familiar with the code so there might be a reason for
> >setting and reusing the pf->cfi to do the search twice. But might it not
> >be more clear to just store both pf->cfi_eh and pf->cfi_debug and then
> >check both in call_probe_finder () with the dwarf_cfi_addrframe () call?
> >Which is the only place I see actually using the cfi.
>=20
> Right, but since call_probe_finder can be called repeatedly on same binar=
y,
> we should keep pf->cfi for caching CFI too.

Yes. I was suggesting to rename pf->cfi to pf->cfi_eh and add
pf->cfi_debug, to make clear why there are two.

> >BTW. Not really related to this patch since the following was already in
> >the code, and is most likely always correct anyway:
> >
> >> +	if (elf_section_by_name(elf, &ehdr, &shdr, ".eh_frame", NULL) &&
> >> +	    shdr.sh_type =3D=3D SHT_PROGBITS) {
> >> +		pf->cfi =3D dwarf_getcfi_elf(elf);
> >
> >But that SHT_PROGBITS check is only necessary because of a bug in
> >elfutils < 0.156. For 0.156+ dwarf_getcfi_elf () will properly return
> >NULL in case you happen to be looking at a separate debug file that
> >has .eh_frame as NOBITS. In theory this prevents getting the CFI if the
> >file has stripped away the shdrs. Which is reasonable, there are
> >probably also other things that rely on the shdrs.
>=20
> Ah, I had just wanted to avoid introducing new ifdefs.

Yes, understandable. It is a weird corner case anyway.

> > But dwarf_getcfi_elf
> >is able to also get you the CFI with just the phdrs.
>=20
> Hmm, how can I make such binary? I can fix it, but we need a
> testcase for that.

eu-strip --strip-sections can create such binaries. But honestly I
wouldn't bother. They are basically useless and nobody (should) do that.
The only reason you might want to support them is for getting a
backtrace anyway through the CFI. But you won't be able to get any other
symbol or debug information from them.

I only really mentioned it because I am embarrassed about the bug in
elfutils. Just glad that it got fixed and the workaround isn't necessary
anymore. But it probably is not worth it now to try to remove the
workaround. There is no real benefit in this case.

Cheers,

Mark
