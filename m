Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A619F1A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 19:32:04 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 18:32:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 754883578058
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 19:32:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u118VrMe27525358
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 19:32:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u118VRYw019064
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 19:31:27 +1100
Message-ID: <56AF17CD.3080300@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 14:01:09 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 7/9] pseries: Add support for hash table resizing
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-8-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-8-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:54 AM, David Gibson wrote:

> +
> +static int pseries_lpar_resize_hpt_commit(void *data)
> +{
> +	struct hpt_resize_state *state = data;
> +
> +	state->commit_rc = plpar_resize_hpt_commit(0, state->shift);
> +	if (state->commit_rc != H_SUCCESS)
> +		return -EIO;
> +
> +	/* Hypervisor has transitioned the HTAB, update our globals */
> +	ppc64_pft_size = state->shift;
> +	htab_size_bytes = 1UL << ppc64_pft_size;
> +	htab_hash_mask = (htab_size_bytes >> 7) - 1;
> +
> +	return 0;
> +}
> +

snip

> +/* Must be called in user context */
> +static int pseries_lpar_resize_hpt(unsigned long shift)
> +{
> +	struct hpt_resize_state state = {
> +		.shift = shift,
> +		.commit_rc = H_FUNCTION,

> +
> +	rc = stop_machine(pseries_lpar_resize_hpt_commit, &state, NULL);

With my limited knowledge of stop_machine, wondering if the current
or any future version of 'pseries_lpar_resize_hpt_commit' function
can cause HPT change (page fault path) while stop is executing it.
