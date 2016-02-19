Return-Path: <dave.hansen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 9CD551A0627
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 12:28:29 +1100 (AEDT)
Subject: Re: [PATCH V3 01/30] mm: Make vm_get_page_prot arch specific.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1455814254-10226-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <56C66FBB.7000808@intel.com>
Date: Thu, 18 Feb 2016 17:28:27 -0800
MIME-Version: 1.0
In-Reply-To: <1455814254-10226-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2016 08:50 AM, Aneesh Kumar K.V wrote:
> With next generation power processor, we are having a new mmu model
> [1] that require us to maintain a different linux page table format.
> 
> Inorder to support both current and future ppc64 systems with a single
> kernel we need to make sure kernel can select between different page
> table format at runtime. With the new MMU (radix MMU) added, we will
> have to dynamically switch between different protection map. Hence
> override vm_get_page_prot instead of using arch_vm_get_page_prot. We
> also drop arch_vm_get_page_prot since only powerpc used it.

Hi Aneesh,

I've got some patches I'm hoping to get in to 4.6 that start using
arch_vm_get_page_prot() on x86:

> http://git.kernel.org/cgit/linux/kernel/git/daveh/x86-pkeys.git/commit/?h=pkeys-v024&id=aa1e61398fb598869981cfe48275cff832945669

So I'd prefer that it stay in place. :)
