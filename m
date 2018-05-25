Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqQ59cjzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:38 +1000 (AEST)
In-Reply-To: <20180413184144.25183-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/sparse: fix plain integer as NULL pointer warning
Message-Id: <40skqQ1Nybz9s1w@ozlabs.org>
Date: Fri, 25 May 2018 21:41:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-13 at 18:41:43 UTC, Mathieu Malaterre wrote:
> Trivial fix to remove the following sparse warnings:
> 
>   arch/powerpc/kernel/module_32.c:112:74: warning: Using plain integer as NULL pointer
>   arch/powerpc/kernel/module_32.c:117:74: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:1155:28: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:1230:20: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:1385:36: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:1752:23: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:2084:19: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:2110:32: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:2167:19: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:2183:19: warning: Using plain integer as NULL pointer
>   drivers/macintosh/via-pmu.c:277:20: warning: Using plain integer as NULL pointer
>   arch/powerpc/platforms/powermac/setup.c:155:67: warning: Using plain integer as NULL pointer
>   arch/powerpc/platforms/powermac/setup.c:247:27: warning: Using plain integer as NULL pointer
>   arch/powerpc/platforms/powermac/setup.c:249:27: warning: Using plain integer as NULL pointer
>   arch/powerpc/platforms/powermac/setup.c:252:37: warning: Using plain integer as NULL pointer
>   arch/powerpc/mm/tlb_hash32.c:127:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/mm/tlb_hash32.c:148:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/mm/tlb_hash32.c:44:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/mm/tlb_hash32.c:57:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/mm/tlb_hash32.c:87:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/kernel/btext.c:160:31: warning: Using plain integer as NULL pointer
>   arch/powerpc/kernel/btext.c:167:22: warning: Using plain integer as NULL pointer
>   arch/powerpc/kernel/btext.c:274:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/kernel/btext.c:285:31: warning: Using plain integer as NULL pointer
>   arch/powerpc/include/asm/hugetlb.h:204:16: warning: Using plain integer as NULL pointer
>   arch/powerpc/mm/ppc_mmu_32.c:170:21: warning: Using plain integer as NULL pointer
>   arch/powerpc/platforms/powermac/pci.c:1227:23: warning: Using plain integer as NULL pointer
>   arch/powerpc/platforms/powermac/pci.c:65:24: warning: Using plain integer as NULL pointer
> 
> Also use `--fix` command line option from `script/checkpatch --strict` to
> remove the following:
> 
>   CHECK: Comparison to NULL could be written "!dispDeviceBase"
>   #72: FILE: arch/powerpc/kernel/btext.c:160:
>   +	if (dispDeviceBase == NULL)
> 
>   CHECK: Comparison to NULL could be written "!vbase"
>   #80: FILE: arch/powerpc/kernel/btext.c:167:
>   +	if (vbase == NULL)
> 
>   CHECK: Comparison to NULL could be written "!base"
>   #89: FILE: arch/powerpc/kernel/btext.c:274:
>   +	if (base == NULL)
> 
>   CHECK: Comparison to NULL could be written "!dispDeviceBase"
>   #98: FILE: arch/powerpc/kernel/btext.c:285:
>   +	if (dispDeviceBase == NULL)
> 
>   CHECK: Comparison to NULL could be written "strstr"
>   #117: FILE: arch/powerpc/kernel/module_32.c:117:
>   +		if (strstr(secstrings + sechdrs[i].sh_name, ".debug") != NULL)
> 
>   CHECK: Comparison to NULL could be written "!Hash"
>   #130: FILE: arch/powerpc/mm/ppc_mmu_32.c:170:
>   +	if (Hash == NULL)
> 
>   CHECK: Comparison to NULL could be written "Hash"
>   #143: FILE: arch/powerpc/mm/tlb_hash32.c:44:
>   +	if (Hash != NULL) {
> 
>   CHECK: Comparison to NULL could be written "!Hash"
>   #152: FILE: arch/powerpc/mm/tlb_hash32.c:57:
>   +	if (Hash == NULL) {
> 
>   CHECK: Comparison to NULL could be written "!Hash"
>   #161: FILE: arch/powerpc/mm/tlb_hash32.c:87:
>   +	if (Hash == NULL) {
> 
>   CHECK: Comparison to NULL could be written "!Hash"
>   #170: FILE: arch/powerpc/mm/tlb_hash32.c:127:
>   +	if (Hash == NULL) {
> 
>   CHECK: Comparison to NULL could be written "!Hash"
>   #179: FILE: arch/powerpc/mm/tlb_hash32.c:148:
>   +	if (Hash == NULL) {
> 
>   ERROR: space required after that ';' (ctx:VxV)
>   #192: FILE: arch/powerpc/platforms/powermac/pci.c:65:
>   +	for (; node != NULL;node = node->sibling) {
> 
>   CHECK: Comparison to NULL could be written "node"
>   #192: FILE: arch/powerpc/platforms/powermac/pci.c:65:
>   +	for (; node != NULL;node = node->sibling) {
> 
>   CHECK: Comparison to NULL could be written "!region"
>   #201: FILE: arch/powerpc/platforms/powermac/pci.c:1227:
>   +	if (region == NULL)
> 
>   CHECK: Comparison to NULL could be written "of_get_property"
>   #214: FILE: arch/powerpc/platforms/powermac/setup.c:155:
>   +		if (of_get_property(np, "cache-unified", NULL) != NULL && dc) {
> 
>   CHECK: Comparison to NULL could be written "!np"
>   #223: FILE: arch/powerpc/platforms/powermac/setup.c:247:
>   +		if (np == NULL)
> 
>   CHECK: Comparison to NULL could be written "np"
>   #226: FILE: arch/powerpc/platforms/powermac/setup.c:249:
>   +		if (np != NULL) {
> 
>   CHECK: Comparison to NULL could be written "l2cr"
>   #230: FILE: arch/powerpc/platforms/powermac/setup.c:252:
>   +			if (l2cr != NULL) {
> 
>   CHECK: Comparison to NULL could be written "via"
>   #243: FILE: drivers/macintosh/via-pmu.c:277:
>   +	if (via != NULL)
> 
>   CHECK: Comparison to NULL could be written "current_req"
>   #252: FILE: drivers/macintosh/via-pmu.c:1155:
>   +	if (current_req != NULL) {
> 
>   CHECK: Comparison to NULL could be written "!req"
>   #261: FILE: drivers/macintosh/via-pmu.c:1230:
>   +	if (req == NULL || pmu_state != idle
> 
>   CHECK: Comparison to NULL could be written "!req"
>   #270: FILE: drivers/macintosh/via-pmu.c:1385:
>   +			if (req == NULL) {
> 
>   CHECK: Comparison to NULL could be written "!pp"
>   #288: FILE: drivers/macintosh/via-pmu.c:2084:
>   +	if (pp == NULL)
> 
>   CHECK: Comparison to NULL could be written "!pp"
>   #297: FILE: drivers/macintosh/via-pmu.c:2110:
>   +	if (count < 1 || pp == NULL)
> 
>   CHECK: Comparison to NULL could be written "!pp"
>   #306: FILE: drivers/macintosh/via-pmu.c:2167:
>   +	if (pp == NULL)
> 
>   CHECK: Comparison to NULL could be written "pp"
>   #315: FILE: drivers/macintosh/via-pmu.c:2183:
>   +	if (pp != NULL) {
> 
> Link: https://github.com/linuxppc/linux/issues/37
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d8731527acee53b4d46d59ff0b5fc3

cheers
