Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C83241A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 19:38:01 +1100 (AEDT)
Date: Mon, 29 Feb 2016 19:37:56 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 7/7] KVM: PPC: Add support for multiple-TCE
 hcalls
Message-ID: <20160229083756.GB32418@fergus.ozlabs.ibm.com>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-8-git-send-email-aik@ozlabs.ru>
 <56C52EF8.4050409@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C52EF8.4050409@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2016 at 01:39:52PM +1100, Alexey Kardashevskiy wrote:
> 
> The latest powerkvm kernel passes @thp instead of NULL and check for it
> below in addition to (shift > PAGE_SHIFT), should it be fixed here as well?
> 
> Is that possible for __find_linux_pte_or_hugepte() return thp==true but
> shift<=PAGE_SHIT, assuming we call it on vcpu->arch.pgdir, not an ordinary
> task pgdir?

Looking at the code for __find_linux_pte_or_hugepte, if it returns
thp==true then it must return shift==PMD_SHIFT, which is 24 for
Book3S 64 with 64k pages.  With 4k pages, we don't get the option to
enable THP (on Book3S 64).

Other platforms might return other values, but they would always be
greater than PAGE_SHIFT.

Paul.
