Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE47BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 12:22:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9CE6127C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 12:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9CE6127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP5Xx51z2z30F3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 22:22:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ksngFMTA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ksngFMTA; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FP5XS2H08z2xYl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 22:21:43 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4FP5XQ3k59z9vDx; Mon, 19 Apr 2021 22:21:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FP5XN6hwYz9vDV;
 Mon, 19 Apr 2021 22:21:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618834902;
 bh=ozMqPJ3D5LeS0fKqMMOHm/0k1FsuW3w/Tknt0WqvEtI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ksngFMTA/LRUOyHWyzFSOcAtgpiEUSkHXYThjpIMzPezZXvwgLZloLLO/3TB+ZJPH
 DXKOmx0hJVslwYwAnAed32T4N1Nbw0f2gbq5o449s6rDfDX8Qm3wT7Cb3X7mDuQ+0z
 4V8K4sfbnwMvvBCPaYkyX5os7S1pPJKLdtqU26C6rGOBHaZXJQBVsHgkmuYhTsVxMy
 PkGrAGDawlnZTGhzM6ly+tsnXrP95znyVsvdOEqq+w/v6BxgTvNZBGiSCsBq6rReX9
 OXJbmMAvn4G7lLw0WnZW8QJCQh+zx4JNKfnS/v3zoWX+rhu6NuGoSSVleXdUfjz5hF
 4u8mVPkDQaULA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v4] powerpc/kexec_file: use current CPU info while
 setting up FDT
In-Reply-To: <3c004e09-7db2-1bb8-352a-0695278eea93@linux.ibm.com>
References: <20210419083624.1124390-1-sourabhjain@linux.ibm.com>
 <3c004e09-7db2-1bb8-352a-0695278eea93@linux.ibm.com>
Date: Mon, 19 Apr 2021 22:21:39 +1000
Message-ID: <877dkyea7g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mahesh@linux.vnet.ibm.com, stable@vger.kernel.org, bauerman@linux.ibm.com,
 linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hari Bathini <hbathini@linux.ibm.com> writes:
> On 19/04/21 2:06 pm, Sourabh Jain wrote:
>> kexec_file_load uses initial_boot_params in setting up the device-tree
>> for the kernel to be loaded. Though initial_boot_params holds info
>> about CPUs at the time of boot, it doesn't account for hot added CPUs.
>> 
>> So, kexec'ing with kexec_file_load syscall would leave the kexec'ed
>> kernel with inaccurate CPU info. Also, if kdump kernel is loaded with
>> kexec_file_load syscall and the system crashes on a hot added CPU,
>> capture kernel hangs failing to identify the boot CPU.
>> 
>>   Kernel panic - not syncing: sysrq triggered crash
>>   CPU: 24 PID: 6065 Comm: echo Kdump: loaded Not tainted 5.12.0-rc5upstream #54
>>   Call Trace:
>>   [c0000000e590fac0] [c0000000007b2400] dump_stack+0xc4/0x114 (unreliable)
>>   [c0000000e590fb00] [c000000000145290] panic+0x16c/0x41c
>>   [c0000000e590fba0] [c0000000008892e0] sysrq_handle_crash+0x30/0x40
>>   [c0000000e590fc00] [c000000000889cdc] __handle_sysrq+0xcc/0x1f0
>>   [c0000000e590fca0] [c00000000088a538] write_sysrq_trigger+0xd8/0x178
>>   [c0000000e590fce0] [c0000000005e9b7c] proc_reg_write+0x10c/0x1b0
>>   [c0000000e590fd10] [c0000000004f26d0] vfs_write+0xf0/0x330
>>   [c0000000e590fd60] [c0000000004f2aec] ksys_write+0x7c/0x140
>>   [c0000000e590fdb0] [c000000000031ee0] system_call_exception+0x150/0x290
>>   [c0000000e590fe10] [c00000000000ca5c] system_call_common+0xec/0x278
>>   --- interrupt: c00 at 0x7fff905b9664
>>   NIP:  00007fff905b9664 LR: 00007fff905320c4 CTR: 0000000000000000
>>   REGS: c0000000e590fe80 TRAP: 0c00   Not tainted  (5.12.0-rc5upstream)
>>   MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000242
>>         XER: 00000000
>>   IRQMASK: 0
>>   GPR00: 0000000000000004 00007ffff5fedf30 00007fff906a7300 0000000000000001
>>   GPR04: 000001002a7355b0 0000000000000002 0000000000000001 00007ffff5fef616
>>   GPR08: 0000000000000001 0000000000000000 0000000000000000 0000000000000000
>>   GPR12: 0000000000000000 00007fff9073a160 0000000000000000 0000000000000000
>>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>   GPR20: 0000000000000000 00007fff906a4ee0 0000000000000002 0000000000000001
>>   GPR24: 00007fff906a0898 0000000000000000 0000000000000002 000001002a7355b0
>>   GPR28: 0000000000000002 00007fff906a1790 000001002a7355b0 0000000000000002
>>   NIP [00007fff905b9664] 0x7fff905b9664
>>   LR [00007fff905320c4] 0x7fff905320c4
>>   --- interrupt: c00
>> 
>> To avoid this from happening, extract current CPU info from of_root
>> device node and use it for setting up the fdt in kexec_file_load case.
>> 
>> Fixes: 6ecd0163d360 ("powerpc/kexec_file: Add appropriate regions for memory reserve map")
>> 
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   arch/powerpc/kexec/file_load_64.c | 98 +++++++++++++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>> 
>>   ---
>> Changelog:
>> 
>> v1 -> v3
>>    - https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-April/227756.html
>> 
>> v3 -> v4
>>    - Rearranged if-else statement in update_cpus_node function to avoid
>>      redundant checks for positive cpus_offset.
>>   ---
>> 
>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>> index 02b9e4d0dc40..195ef303d530 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -960,6 +960,99 @@ unsigned int kexec_fdt_totalsize_ppc64(struct kimage *image)
>>   	return fdt_size;
>>   }
>>   
>> +/**
>> + * add_node_prop - Read property from device node structure and add
>> + *			them to fdt.
>> + * @fdt:		Flattened device tree of the kernel
>> + * @node_offset:	offset of the node to add a property at
>> + * np:			device node pointer
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +static int add_node_prop(void *fdt, int node_offset, const struct device_node *np)
>> +{
>> +	int ret = 0;
>> +	struct property *pp;
>> +	unsigned long flags;
>> +
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	raw_spin_lock_irqsave(&devtree_lock, flags);
>> +	for (pp = np->properties; pp; pp = pp->next) {
>> +		ret = fdt_setprop(fdt, node_offset, pp->name,
>> +				  pp->value, pp->length);
>> +		if (ret < 0) {
>> +			pr_err("Unable to add %s property: %s\n",
>> +			       pp->name, fdt_strerror(ret));
>> +			goto out;
>> +		}
>> +	}
>> +out:
>> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * update_cpus_node - Update cpus node of flattened device-tree using of_root
>> + *			device node.
>> + * @fdt:		Flattened device tree of the kernel.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +static int update_cpus_node(void *fdt)
>> +{
>> +	struct device_node *cpus_node, *dn;
>> +	int cpus_offset, cpus_subnode_off, ret = 0;
>> +
>> +	cpus_offset = fdt_path_offset(fdt, "/cpus");
>> +	if (cpus_offset < 0 && cpus_offset != -FDT_ERR_NOTFOUND) {
>> +		pr_err("Malformed device tree: error reading /cpus node: %s\n",
>> +		       fdt_strerror(cpus_offset));
>> +		return cpus_offset;
>> +	} else {
>
>
>> +		if (cpus_offset > 0) {
>> +			ret = fdt_del_node(fdt, cpus_offset);
>> +			if (ret < 0) {
>> +				pr_err("Error deleting /cpus node: %s\n",
>> +				       fdt_strerror(ret));
>> +				return -EINVAL;
>> +			}
>> +		}
>> +
>> +		/* Add cpus node to fdt */
>> +		cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
>> +					      "cpus");
>> +		if (cpus_offset < 0) {
>> +			pr_err("Error creating /cpus node: %s\n",
>> +			       fdt_strerror(cpus_offset));
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* Add cpus node properties */
>> +		cpus_node = of_find_node_by_path("/cpus");
>> +		ret = add_node_prop(fdt, cpus_offset, cpus_node);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* Loop through all subnodes of cpus and add them to fdt */
>> +		for_each_node_by_type(dn, "cpu") {
>> +			cpus_subnode_off = fdt_add_subnode(fdt,
>> +							   cpus_offset,
>> +							   dn->full_name);
>> +			if (cpus_subnode_off < 0) {
>> +				pr_err("Unable to add %s subnode: %s\n",
>> +				       dn->full_name, fdt_strerror(cpus_subnode_off));
>> +				return cpus_subnode_off;
>> +			}
>> +			ret = add_node_prop(fdt, cpus_subnode_off, dn);
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>
> The above code block doesn't really need an explicit else condition..

Yeah, use the early return to avoid having to indent all the rest of
that logic.

Please send a v5.

cheers
