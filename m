Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlf6mJ8zDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:22 +1100 (AEDT)
In-Reply-To: <1483475991-16999-1-git-send-email-arbab@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <apopple@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: fix memory hotplug BUG() on radix
Message-Id: <3v3Qlf5kWfz9tk6@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-03 at 20:39:51 UTC, Reza Arbab wrote:
> Memory hotplug is leading to hash page table calls, even on radix:
> 
> ...
> 	arch_add_memory
> 		create_section_mapping
> 			htab_bolt_mapping
> 				BUG_ON(!ppc_md.hpte_insert);
> 
> To fix, refactor {create,remove}_section_mapping() into hash__ and
> radix__ variants. Leave the radix versions stubbed for now.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/32b53c012e0bfe20b2745962a89db0

cheers
