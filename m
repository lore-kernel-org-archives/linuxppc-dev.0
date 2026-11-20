Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E1606A33A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iram.es header.i=@iram.es header.a=rsa-sha256 header.s=dkim3 header.b=PBYzuzlL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW6tC5wyZz2xpt;
	Fri, 20 Nov 2026 18:49:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=143.55.146.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795160963;
	cv=none; b=L3EVLKxoeQPoO2+NECb8hAuLnngxCc7QHFuXDJP6BJ30N+IJ2ZM+jno46g9eDmXQjeAg4txvysGiCuu0fX2HMf8oqJwXrhiJuawBZPAf5nwflcgiLoclLMfloTOY70pXqYZZf80OBGb+O/WuV4920D/v+MQuOJXfyX11aPX0diNLDrKJSlwJ+vysjjJkwTSIpico0lWdDucu5HjV41sdWqjfMxk29Q+/HXn/01qFSh9SziGyWvpB1o5qe6YzX0bv7dkbykTMJFLoOFJxVqhmazO8tmq89WK/K6WsGEbcZZkTX8LCzIlFQLfm2LjkkS7hDZVveLUVQczIoRAjdrFt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795160963; c=relaxed/relaxed;
	bh=6FVvdOwqrNhc4WYxaL2P1olVozXOorss5OA68hPoxVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGKEqhaLDE58ZTUxsaY8hG1jcLCZF7va6OZu9pmaW0SMvdhY1pqImmE5xOjACvB73TtOdHkbPS6rl4SvuvC5QJpo2f9DROkncnbVzRlsaepp4tvOao7gOx7zKemnEq2q4Rttdgh5VmDwJ2tRdhX9SHDiOy74fApbMBYNz/UGdBbAl0GUVY+xNl57+qVoeNRGe6cdb2SKul7+OO0xUH4TQR8J2P2a1nClpO1O4AqEYrB7+xFSkr7b9yKn7PPw+6bZLr2/9rB4i0C0OP3/SQVuwqQAErwRamtYjWJrpbOLKhKcqKG8dOiIevd5YArjFe5zVBqBKBm2vq31Tw3Tkm8QKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=iram.es; dkim=pass (2048-bit key; unprotected) header.d=iram.es header.i=@iram.es header.a=rsa-sha256 header.s=dkim3 header.b=PBYzuzlL; dkim-atps=neutral; spf=pass (client-ip=143.55.146.78; helo=mx07-006a4e02.pphosted.com; envelope-from=paubert@iram.es; receiver=lists.ozlabs.org) smtp.mailfrom=iram.es
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=iram.es
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=iram.es header.i=@iram.es header.a=rsa-sha256 header.s=dkim3 header.b=PBYzuzlL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iram.es (client-ip=143.55.146.78; helo=mx07-006a4e02.pphosted.com; envelope-from=paubert@iram.es; receiver=lists.ozlabs.org)
X-Greylist: delayed 1328 seconds by postgrey-1.37 at boromir; Fri, 20 Nov 2026 18:49:21 AEDT
Received: from mx07-006a4e02.pphosted.com (mx07-006a4e02.pphosted.com [143.55.146.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW6t91DlTz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 18:49:19 +1100 (AEDT)
Received: from pps.filterd (m0316690.ppops.net [127.0.0.1])
	by mx07-006a4e02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7Qdeq3902747;
	Fri, 20 Nov 2026 08:26:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=dkim3; bh=6FVvdOwqrNhc4WYxaL2P1olVozXO
	orss5OA68hPoxVM=; b=PBYzuzlLgI5EvsCtmxj7lZlYN0ypimrNa7jevGPJfaIy
	ZZffrNzoc9n8sQo2QO/cruMbIj5LiYDJWl7w6ifKmg97RIzkHMGVwibX339+xXpt
	ym6CBHyETD+uis7aug+418oXHbXmKrbDetKQFN4fhRY9rLU1buVol5x5YxhOjV6g
	rwKRSyJ4q3b4csistOXW8bM3sT5Pq0bWBnIssG/hDAkdM/rwhQVjimFpKNbMApnr
	712aUGxj23FM7bXEZqWl30DjZG6nVL3vVRo+ZHUIdNUxEWDX1poNfUklGwSNKKi/
	948G8YBts8OVNnffucZEOQD8hsT5j2qcoU14SoO62Q==
Received: from mta-out01.sim.rediris.es (mta-out01.sim.rediris.es [130.206.24.43])
	by mx07-006a4e02.pphosted.com (PPS) with ESMTPS id 4j2htrr04t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:26:39 +0100 (CET)
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
	by mta-out01.sim.rediris.es (Postfix) with ESMTPS id D6BB61400DA;
	Fri, 20 Nov 2026 08:26:38 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mta-out01.sim.rediris.es (Postfix) with ESMTP id B598D1400DC;
	Fri, 20 Nov 2026 08:26:38 +0100 (CET)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out01.sim.rediris.es
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8T47SwKRLBOX; Fri, 20 Nov 2026 08:26:38 +0100 (CET)
Received: from front02.sim.rediris.es (front02.sim.rediris.es [130.206.24.72])
	by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 8397A1400DA;
	Fri, 20 Nov 2026 08:26:38 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by front02.sim.rediris.es (Postfix) with ESMTP id 741FE80076;
	Fri, 20 Nov 2026 08:26:38 +0100 (CET)
Received: from front02.sim.rediris.es ([127.0.0.1])
 by localhost (front02.sim.rediris.es [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5bd1ULypEOZn; Fri, 20 Nov 2026 08:26:38 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by front02.sim.rediris.es (Postfix) with ESMTP id 2E96380085;
	Fri, 20 Nov 2026 08:26:38 +0100 (CET)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 front02.sim.rediris.es
X-Virus-Scanned: amavis at sim.rediris.es
Received: from front02.sim.rediris.es ([127.0.0.1])
 by localhost (front02.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wKkOqcERDb6q; Fri, 20 Nov 2026 08:26:38 +0100 (CET)
Received: from lt-gp.iram.es (gra-fw.iram.es [150.214.244.1])
	by front02.sim.rediris.es (Postfix) with ESMTPA id 8417180076;
	Fri, 20 Nov 2026 08:26:37 +0100 (CET)
Date: Fri, 20 Nov 2026 08:26:36 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Matt Turner <mattst88@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powermac: Fix low_sleep_handler with
 STRICT_KERNEL_RWX
Message-ID: <av_2LFCIUP-xHvEb@lt-gp.iram.es>
References: <20261119-pmac-sleep-strict-rwx-v1-1-9068dc16d59e@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-pmac-sleep-strict-rwx-v1-1-9068dc16d59e@gmail.com>
X-Proofpoint-GUID: x1fj9GTbeW8XebDbVr8vycYEp9XFdaS5
X-Authority-Analysis: v=2.4 cv=ReEFmFtv c=1 sm=1 tr=0 ts=6afff62f cx=c_pps
 a=QKUl0uxKTaJPacWKUfn9WA==:117 a=QKUl0uxKTaJPacWKUfn9WA==:17
 a=b8+xJRgcbepLoiPQPEzLjyvsYN4=:19 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6eT1_X6YcEdk1gFvU5eV:22 a=ETolyViPtXBpHFtc-ESi:22
 a=pGLkceISAAAA:8 a=LN4aeqg-WjX7mWm0oF0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: x1fj9GTbeW8XebDbVr8vycYEp9XFdaS5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXyB9NDkRE0oHH
 uDsUkRQgwttDOY6GGtBEVc1j1tzFmChAo0ZezbIbxPN6RHCGLmRb4E5CqhfUmd9PXXqj5JvhlJo
 q1lK+tMgTUZQGbDg9w1w5ekPffSTaINA7MHpvl2HxH1mQVex6KVs84UWJSOGdMTEW3YfBI/wFsx
 OmJRj5g5NKWh8bDO7Gn8NSLak90RY/00MNYNDjpVAU8UwTarUtVjP99sSdXX1/COqLeq63LMOb/
 5wWGX7y+IDliW47Q778qzErA3q1A0EJGm0xEymbFvPnq9pELGppWu7IV18AUKusGS9VUp9K1Jpy
 pCM5H5zyLNzf58Cz89Yc6NTfzHkgj1gpasbSRlX78yyav0W29yAez7so/GfedgKfI7Tk0f+UA8v
 vAXIaEEnEZPYr2I2GvQ+zrRgAcjt40m0iGe6rlHGvtCb+nrDHph1wXdR1jXXGPhBo4MrKNicP2Q
 pyM+D9Is9k/0eXK4deQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXx/QdtulYbzIQ
 2YNOO9XaTD9Dh72SyZeL6Y2BU/NVlHUZN0smoNzwftsGFBq+7i75Cf02rrisjliSVwIqmd3oeSg
 M8w13dbgpSxn7tNUw4rY2eAGR1WpD+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 04:26:19PM -0500, Matt Turner wrote:
> Before sleeping, low_sleep_handler() stores the ROM wakeup vectors and
> the 'Lars' magic at physical addresses 0x0-0x84. It does so through the
> kernel linear mapping at KERNELBASE with data relocation on. With
> CONFIG_STRICT_KERNEL_RWX, that page is the start of kernel text and is
> mapped read-only, so the first store takes a DSI and PMU sleep oopses
> with interrupts disabled, leaving the machine hung:
> 
>   NIP [c0033018] low_sleep_handler+0x198/0x1b4
>   LR [c0032ff4] low_sleep_handler+0x174/0x1b4
>   DAR: c0000000 DSISR: 0a000000
>   [f2169d20] [c086df18] powerbook_sleep+0x86c/0xbe4 (unreliable)
>   [f2169db0] [c00b1178] suspend_devices_and_enter+0x680/0x700
>   [f2169e00] [c00b1428] pm_suspend+0x230/0x25c
>   [f2169e20] [c00af7dc] state_store+0x74/0xd0
> 
> Turn off MSR[DR] around the stores and write to physical address 0
> directly, as flush_disable_75x() and flush_disable_745x() already do
> for their cache flushes. The ROM reads these locations with the MMU
> off, so physical address 0 is where they belong anyway.
> 
> The stores stay ahead of the low_cpu_offline_self entry point, so the
> CPU hotplug path is unchanged. pmac32-cpufreq also calls
> low_sleep_handler() and gets the same fix.
> 
> The Linux PTE for page 0 has been read-only since STRICT_KERNEL_RWX was
> first enabled for PPC32, and the BATs since commit 63b2bc619565
> ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX").
> 
> Tested with suspend to RAM on an iMac G4 (PowerMac6,1, 7448). Not
> tested on Grackle machines or with pmac32-cpufreq.
> 
> Fixes: 95902e6c8864 ("powerpc/mm: Implement STRICT_KERNEL_RWX on PPC32")
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/powerpc/platforms/powermac/sleep.S | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
> index 822ed70cdcbf..750cb0160b4c 100644
> --- a/arch/powerpc/platforms/powermac/sleep.S
> +++ b/arch/powerpc/platforms/powermac/sleep.S
> @@ -184,19 +184,31 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
>  	addi	r5,r5,grackle_wake_up@l
>  	tophys(r5,r5)
>  	stw	r5,SL_PC(r11)
> -	lis	r4,KERNELBASE@h
>  	tophys(r5,r11)
>  	addi	r5,r5,SL_PC
>  	lis	r6,MAGIC@ha
>  	addi	r6,r6,MAGIC@l
> -	stw	r5,0(r4)
> -	stw	r6,4(r4)
> -	/* Setup stuffs at 0x80-0x84 for Core99 */
>  	lis	r3,core99_wake_up@ha
>  	addi	r3,r3,core99_wake_up@l
>  	tophys(r3,r3)
> +
> +	/* With STRICT_KERNEL_RWX, the kernel mapping of page 0 is
> +	 * read-only. Write the vectors with data relocation off.
> +	 */
> +	mfmsr	r7
> +	rlwinm	r8,r7,0,~MSR_DR
> +	sync
> +	mtmsr	r8
> +	isync
> +	li	r4,0

Actually this instruction is not needed, just s/r4/0/ where r4 is used
as a base address. (If you put r0 instead, the assembler may complain).

Not really critical, this is just my MOOD (Micro Optimization Of the Day).

Best regards,
Gabriel

> +	stw	r5,0(r4)
> +	stw	r6,4(r4)
> +	/* Setup stuffs at 0x80-0x84 for Core99 */
>  	stw	r3,0x80(r4)
>  	stw	r5,0x84(r4)
> +	sync
> +	mtmsr	r7
> +	isync
>  
>  	.globl	low_cpu_offline_self
>  low_cpu_offline_self:
> 
> ---
> base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
> change-id: 20261119-pmac-sleep-strict-rwx-57e5dcacee55
> 
> Best regards,
> --  
> Matt Turner <mattst88@gmail.com>
> 
> 
 

 


