Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04B581A0947
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 12:30:43 +1100 (AEDT)
Message-ID: <1456014735.3136.26.camel@kernel.crashing.org>
Subject: Re: [PATCH V3 01/30] mm: Make vm_get_page_prot arch specific.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@ozlabs.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Date: Sun, 21 Feb 2016 11:32:15 +1100
In-Reply-To: <87egc9e83j.fsf@linux.vnet.ibm.com>
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160218231546.GC2765@fergus.ozlabs.ibm.com>
 <87egc9e83j.fsf@linux.vnet.ibm.com>
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

On Fri, 2016-02-19 at 08:10 +0530, Aneesh Kumar K.V wrote:
> 
> I was hoping to do that after this series. Something similar to
> 
> https://github.com/kvaneesh/linux/commit/0c2ac1328b678a6e187d1f2644a007204c59a047
> 
> "
> powerpc/mm: Add helper for page flag access in ioremap_at
> 
> Instead of using variables we use static inline which get patched during
> boot to either hash or radix version.
> "
> 
> That gives us a base to revert patches if we find issues with hash and
> still have a working radix base. So idea is to introduce radix with minimal
> changes to hash and then consolidate hash and radix as much as we can by
> updating hash linux format.

It's too much churn. In the end, that adds more risk than it removes and
makes it harder to follow what's going on.

I'd say first change hash to use the radix PTE format, then add radix.

Maybe just wait for Paulus patches ?

Cheers,
Ben.
