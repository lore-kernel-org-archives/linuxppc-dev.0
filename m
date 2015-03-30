Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B89441A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 23:32:15 +1100 (AEDT)
In-Reply-To: <1427261761-22952-5-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 04/27] powerpc/fsl_pci: Don't change ppc_swiotlb_enable
 after swiotlb_subsys_init
Message-Id: <20150330123215.A276C14015A@ozlabs.org>
Date: Mon, 30 Mar 2015 23:32:15 +1100 (AEDT)
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-03 at 05:35:38 UTC, Daniel Axtens wrote:
> The only function that checks ppc_swiotlb_enable is swiotlb_subsys_init.

.. which is a subsys initcall.

> The code in fsl_pci.c is called well after that, so don't bother
> changing it.

Hmm, I think we got this wrong. I don't remember exactly but it was probably me
who told you it could be removed, but I probably hadn't had a coffee yet :}

I see setup_pci_atmu() called by fsl_pci_syscore_do_resume(), ie. at runtime ==
late. So ignore that.

But also fsl_add_bridge(), called from fsl_pci_probe(), which is a platform
driver, registered at arch initcall via fsl_pci_init().

arch initcall happens *before* subsys, so in that case this will be effective.

So I think we need to leave it alone.

cheers
