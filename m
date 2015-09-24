Return-Path: <mjw@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAEEB1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:59:29 +1000 (AEST)
Message-ID: <1443088766.3102.19.camel@bordewijk.wildebeest.org>
Subject: Re: [PATCH] perf/probe: Search both .eh_frame and .debug_frame
 sections for probe location
From: Mark Wielaard <mjw@redhat.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org,
 masami.hiramatsu.pt@hitachi.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, srikar@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
Date: Thu, 24 Sep 2015 11:59:26 +0200
In-Reply-To: <1443060990-10313-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1443060990-10313-1-git-send-email-hemant@linux.vnet.ibm.com>
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

Hi Hemant,

On Thu, 2015-09-24 at 07:46 +0530, Hemant Kumar wrote:
> perf probe through debuginfo__find_probes() in util/probe-finder.c
> checks for the functions' frame descriptions in either .eh_frame section
> of an ELF or the .debug_frame. The check is based on whether either one
> of these sections is present. But sometimes, it may happen that,
> .eh_frame, even if present, may not be complete and may miss some
> descriptions.

Right. Depending on distro, toolchain defaults, arch, build flags, etc.
CFI might be found in either .eh_frame and/or .debug_frame. To be sure
you find the CFI covering an address you will always have to investigate
both if available.

I am not too familiar with the code so there might be a reason for
setting and reusing the pf->cfi to do the search twice. But might it not
be more clear to just store both pf->cfi_eh and pf->cfi_debug and then
check both in call_probe_finder () with the dwarf_cfi_addrframe () call?
Which is the only place I see actually using the cfi.

BTW. Not really related to this patch since the following was already in
the code, and is most likely always correct anyway:

> +	if (elf_section_by_name(elf, &ehdr, &shdr, ".eh_frame", NULL) &&
> +	    shdr.sh_type =3D=3D SHT_PROGBITS) {
> +		pf->cfi =3D dwarf_getcfi_elf(elf);

But that SHT_PROGBITS check is only necessary because of a bug in
elfutils < 0.156. For 0.156+ dwarf_getcfi_elf () will properly return
NULL in case you happen to be looking at a separate debug file that
has .eh_frame as NOBITS. In theory this prevents getting the CFI if the
file has stripped away the shdrs. Which is reasonable, there are
probably also other things that rely on the shdrs. But dwarf_getcfi_elf
is able to also get you the CFI with just the phdrs.

Cheers,

Mark
