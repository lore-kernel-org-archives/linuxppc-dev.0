Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 160B61A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 14:06:21 +1000 (EST)
Message-ID: <1403582770.4587.150.camel@pasglop>
Subject: Re: [PATCH] powerpc: module: fix TOC symbol CRC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Tue, 24 Jun 2014 14:06:10 +1000
In-Reply-To: <20140619094404.18e7047b@kryten>
References: <20140617155658.30560.578.stgit@nimbus>
 <20140619094404.18e7047b@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rusty@rustcorp.com.au, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-19 at 09:44 +1000, Anton Blanchard wrote:
> Hi Laurent,
> 
> > The commit 71ec7c55ed91 introduced the magic symbol ".TOC." for ELFv2
> > ABI. This symbol is built manually and has no CRC value computed. A
> > zero value is put in the CRC section to avoid modpost complaining
> > about a missing CRC. Unfortunately, this breaks the kernel module
> > loading when the kernel is relocated (kdump case for instance)
> > because of the relocation applied to the kcrctab values.
> > 
> > This patch compute a CRC value for the TOC symbol which will match
> > the one compute by the kernel when it is relocated - aka '0 -
> > relocate_start' done in maybe_relocated called by check_version
> > (module.c).
> 
> Adding Rusty since he maintains the module loader code.

This patch gives me:

arch/powerpc/kernel/module_64.c: In function 'dedotify_versions':
arch/powerpc/kernel/module_64.c:325:33: error: 'reloc_start' undeclared (first use in this function)
arch/powerpc/kernel/module_64.c:325:33: note: each undeclared identifier is reported only once for each function it appears in

Cheers,
Ben.
