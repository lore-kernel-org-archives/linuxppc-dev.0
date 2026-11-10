Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B3606BF1F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bNH7JWBj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP1YZ1szDz3dXT;
	Tue, 10 Nov 2026 20:28:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794302930;
	cv=none; b=TBNUGWrvK0QQDjpDDRWlA64CavRm84Ev9QNoESQyvBlfaiQftI2+1wSUD11GSf3hUONNGjsXFF+aUg+2c/qLSSX8FEtJRIHhUyz1VLOmn9fqB44B1A0NDhJGk0jd7/7/1H30HWcaCtQ1vVsduKc2q5TWykJBLq5Fvk3JwamePYSxJ0VMCQJo08hQgItVgdqXRP7EZP2eXJNgDrBxqnEConwr5kcBSHPw1/ZI6Mh3XyI6WB92nLuD4iVUirJymRHSco4gqFJETB1lJnxT2bGI5Wwr7hafcDne14L23d85aUbHyCtDGNn7OpEnGGQV7FMuJoqMXsdsIHfxjxcazXXucw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794302930; c=relaxed/relaxed;
	bh=m3p/DDXuAbdnnQuiur5i1eemlv0No7Pemm1h08DiR30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhvSe/BdEkuo58SwneNAejklpngOsBp7ftq8yIc23UacedTG4UYAlczaOJxbMI/PEblQYF9miNw9PBvd7aTSGsES3Ur/8ogMMC+5Kx4UCTZQtXiZmSCh0nA1e0fIylop1MbXoq73UZIfk4WA1Z6CgmB5NrMwsEtNBYuj7PsJnmPd+7wpCo+Psij8nvcyQ5+dgIPlEgirKB4XKt8aUP9enY3KNNNleytdROMjP3mvrnw+kCqB7I8vnq6ewgZ9Di5dNCUkfOnDIi8vUoRaYBIME62jHI2961NOPJwLIkHcFR6PO94YKSAu60AQAI4WE2c95BL1zpoodD49FCEggvaZRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bNH7JWBj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bNH7JWBj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP1YY2Zvgz3dXS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:28:49 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8EkeJ172632;
	Tue, 10 Nov 2026 09:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m3p/DD
	XuAbdnnQuiur5i1eemlv0No7Pemm1h08DiR30=; b=bNH7JWBjDpfrXCniM6jbZY
	urSiv2tl6E4orY10ZedBBa245qfEbepXIJw5iO4aqro/Jx7Ffw1QIT/K4/Fxhx/p
	orA/2S4pd7gOTEDa+qji5DwdtylgKBknQpwB33MxnvkCKMzUOZ7IdU2REBRHy/Pz
	/Pg/b6xulXyCfc9FiRMx2JDnRyP+wHxY+39jrCD6UoTZVJofGTSleEFy7zomJzLN
	oYWMV6HHCiWJAKZ98G4pXhqhVToZPOB0vGFrY1eKSahC672Wc5fjGfjhoD9hOKxd
	W0Um+aZftyR8ys6Z8KkcUfTivJCwpNtiss7iSdm1mCBc/FU3lb/gwDkAqn4ekujg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt46a4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:28:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7ntVX1406220;
	Tue, 10 Nov 2026 09:28:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak5yp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:28:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA9SZv242140142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 09:28:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4802004B;
	Tue, 10 Nov 2026 09:28:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858622004F;
	Tue, 10 Nov 2026 09:28:33 +0000 (GMT)
Received: from [9.39.31.79] (unknown [9.39.31.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 09:28:33 +0000 (GMT)
Message-ID: <9da4b3b5-cc9d-4a55-9aba-b491f9b222e5@linux.ibm.com>
Date: Tue, 10 Nov 2026 14:58:32 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/smp: Handle of_property_count_u32_elems() error
 in parse_thread_groups()
To: Nathan Chancellor <nathan@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX5WX+RPQynwG3
 5JfEkkjN3w1cHQWMBKfFpcnBzPn1tTr5MKrxHNfcNe6S+QdbL7ZIZuLJWRS421ha7tRmuYgWIMH
 cV8nhZOxY0zqcoobfa1AWp/696CSUWFifnvmpyUA3xFjnudlMO+6buUvWmAj+N146kzeY1fa4Cf
 hpX2hBKdqIuISg9Dabxa0v5hNpJFRq1HgIGG3S745lB0yZwP9HcoTE1jayf5QnK48Y/TzZF9hhK
 ndTbiIvDKoo2pHGWpcLZX+VtBbmmcGqRrBEBghASRHF9uOJgo6JbN3t+TQIWWXyjC5SGE/N5VUH
 j7ZMtBkRpu691+TNdwlDEdZjnSC0FSRv+607UUjhcKGWOseO3J9SotD1KS3NRuzqaQB+5DAyghs
 mlhy94sFUZCwkz2JdIfoGIpmySdOLDbRpE2Zga8/zmu5WKFpxU3LKFBLadsQiyNIsOC5DzJ7QRj
 VD1KxB6gnxxVldkltzw==
X-Proofpoint-ORIG-GUID: Vga60G3pp7sW2rY-UTzxIv8sw2-2Td04
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX5i0Nsm4mcGSp
 KcR58Y/mAj5iy4nUvD2VMeP6bffa9wunKHfQnS4dAZ6an1z/T442qDrqRRF9WlfRW+ORPvTat22
 n5iLnCwicwuXoPCaRK5aFkvSnkPUIUE=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af2e3c7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vYq-qXZFh7psd1dCY8cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YTGGr8qHyJr6rGJQsWXMyujRdtHwZC5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100036
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nathan. Thanks for the fix.

On 11/9/26 11:30 PM, Nathan Chancellor wrote:
> After commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
> conversions"), there is a warning on boot for several PowerPC
> configurations in QEMU:
> 
>    WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1b0, CPU#0: swapper/0/1
>    Modules linked in:
>    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc1-00262-g0af298e62e5c #1 PREEMPT(lazy)
>    NIP [c0000000006074e4] ___kmalloc_large_node+0x174/0x1b0
>    LR [c00000000060782c] __kmalloc_large_node_noprof+0x3c/0x150
>    Call Trace:
>    ...
>    [c00000000369fb60] [c000000000614ff0] __kmalloc_noprof+0x490/0x690
>    [c00000000369fbe0] [c000000000051308] _kzalloc_noprof.constprop.0+0x1c/0x74
>    [c00000000369fc00] [c00000000200b450] init_thread_group_cache_map+0xc0/0x2c4
>    ...
> 
> In this case, of_property_count_u32_elems() returns -EINVAL because
> there is no "ibm,thread-groups" property. When kcalloc() was used to
> allocate thread_group_array, the multiplication overflow check in
> _kmalloc_array_noprof() caught that a really large allocation was
> requested (as -EINVAL was converted to size_t) and returned NULL.
> kzalloc_objs() has no such check, so the large allocation check in
> __kmalloc_large_noprof() triggers the visible warning above.
> 
> Check if of_property_count_u32_elems() has returned an error and bail
> out if so, clearing up the warning.
> 
> Fixes: 790a1662d3a2 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks fine to me.
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> ---
>   arch/powerpc/kernel/smp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 7a25eaa59e62..58824f5f4c80 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -824,6 +824,8 @@ static int parse_thread_groups(struct device_node *dn,
>   	int i = 0;
>   
>   	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
> +	if (count < 0)
> +		return count;
>   	thread_group_array = kzalloc_objs(u32, count);
>   	if (!thread_group_array)
>   		return -ENOMEM;
> 
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> change-id: 20261109-powerpc-smp-handle-count-err-b48b9ffd6e90
> 
> Best regards,
> --
> Cheers,
> Nathan
> 

Should the similar fix is needed here as well?

arch/powerpc/platforms/powernv/idle.c:
         nr_idle_states = of_property_count_u32_elems(np,
                                                 "ibm,cpu-idle-state-flags");

         pnv_idle_states = kzalloc_objs(*pnv_idle_states, nr_idle_states);
         temp_u32 = kzalloc_objs(u32, nr_idle_states);
         temp_u64 = kzalloc_objs(u64, nr_idle_states);
         temp_string = kcalloc(nr_idle_states, sizeof(char *),  GFP_KERNEL);

