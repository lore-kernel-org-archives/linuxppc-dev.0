Return-Path: <linuxppc-dev+bounces-24962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A0BC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 04:43:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h908r0m85z2xrL;
	Wed, 29 Jul 2026 14:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785300236;
	cv=none; b=WSFAJqEPSREene/AQdH3T9kAILDmJIln8pa40IqfAdFAZC66cpF59/wMqPDI7Ju+B7wa+nNtEeTTRR0HWjDiGd1javvf68LBY1bnB6/5HhaUCV3k/ESiIaS6fKM91mrnddHtFRPvSqBswsssguDKuusHUhay7R7xuqShLjSA7sbawzcrdgdsMA1GHMcpBpdjsG55b6aqfN4i+HSchvnJcJ1fbI/fp6/beCynYnWxS6jLR5/9pyrx4o6Ru+Gf0XykJYZ06tx9obEkJsMhzDiG2h4vOh09yTKm/AHjFdQ4le2k8VthFKXyI//cEeox3qW0hHJ56vaIF9G7da8u16eu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785300236; c=relaxed/relaxed;
	bh=15p+jqNFZAfw2yM3WowHRKQRDWWM94uommOxlAoD/EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jYkfke0PU5lrSl8mUgR+J/WdMegko8WIOU78enTdQGfkxQLVlDGRFiTpUOtJgKXycC4A1Jhs6Ed73qw2mm9VxPEQwlwB5EUFNoj6Yz7lhAKPgmLVWndrl7t/bgThDyQR/O/hOxlv6Eda311OtKqFWyavejqCKDX9n/WvgTpzVhR8xtcxqg/Vhg10SnrKkEcukrs7kIRQCMnwU5oiGwGuKencBg8iWx8ASg0+iIDm7r/JAGM9RowZ8uGI9MNTH/XFRRDNIYt2cWwXJhTTxmkTt2Eu3/LfMGJG3fFUjE0LeJS5FXnrmMotvz1cVWEV9rGVzqg8LZIODjTJheTMHUiQzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a2fTrKg3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a2fTrKg3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h908q2SkVz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:43:54 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T1HcLK2793523;
	Wed, 29 Jul 2026 04:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=15p+jq
	NFZAfw2yM3WowHRKQRDWWM94uommOxlAoD/EU=; b=a2fTrKg351Pqer7I+kH2IP
	rd0VwjuOznOYOwV7IHHMrmkpLTnhE49T+2wuc3j5MNM7az+5BsfbvrWH3IpWHH+d
	hplBRIZQ/B/+W/hW+i8QplZYuHtr1p9QmgmwMvHKvJNRCHsqJxuv9IzUZopncMRC
	71C+OgmFThGwDNEhVuk5o1/dHLVU4314fL6EJHAOXaRj7MXjX9KABt3dQqrhswtG
	8q3AXpHzmKTy8PA+YD2g/JHEGzSmbu6zp7VgtGnZStSgU+3iL9SeumPYbaJ9J84U
	/bGRBaEyAYfOxN0DRo2OLrrCOC/y4PYlJN6zFDwZ35pKdYoCriCb3jzE34YB+Ktw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7guk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 04:43:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T4fd90021055;
	Wed, 29 Jul 2026 04:43:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqdbj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 04:43:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T4hSbk28967622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 04:43:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8287A2004B;
	Wed, 29 Jul 2026 04:43:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC6120040;
	Wed, 29 Jul 2026 04:43:24 +0000 (GMT)
Received: from [9.39.23.157] (unknown [9.39.23.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 04:43:24 +0000 (GMT)
Message-ID: <12df5a43-792a-45a9-9524-fa974cc1ce62@linux.ibm.com>
Date: Wed, 29 Jul 2026 10:13:22 +0530
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] powerpc/kexec_file: Prevent kexec range truncation
To: Jinjie Ruan <ruanjinjie@huawei.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        rppt@kernel.org, baoquan.he@linux.dev, hbathini@linux.ibm.com,
        adityag@linux.ibm.com, ritesh.list@gmail.com, bauerman@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
 <20260729012948.2797865-4-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260729012948.2797865-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4SbrctvHR9Kpda8LgqON4PBXOXXDJ6SK
X-Proofpoint-ORIG-GUID: LKpFql9pH5eLX3NjuqZKl2G-L89jEJtV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAzMiBTYWx0ZWRfXw9eRDzOXc4ck
 1r+szb/COfk5cB/0JSaDLua/3J6Nwkg4pn9hHrKVEQjzkWx65uXColPRobe5osIgZE09kKzBg5s
 uCHvYQhtxHLPzYF1ruNEXGAGB5HEydCtRxDwkPOiun6Cc1o8YNe364l11nEYTdvdoNuasbW/6wn
 ao+6rSIe70O6ixwlsVH6KdGLa2ziB4c7DOFVuPnl3WAoQIce75GLRJKc8jzkPhxqImaKbwQyDCu
 DMn9SpW6vgHTIjC+QdZrPEN2ni2fik/g3AYWuBE8vI3K2K5mAkh/uNFtXyNUDo+KglblaBXYQ4I
 aWiIzlInSqIQ42eFslM9yjxTEFqreo99QA213BdOg0BL2GmFZMjFKwl98aBxQ49r5Z+m+qmI6xB
 kGE9liSWaAturCIKxrHLfJjMeJ12quvMWblmh2D1RwmyE6XJmEqC7h0otgajfYx0nWCCd73PaY5
 TrqOKUzeQLqBCYH6xMg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6984f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=7_du0d56ACxb2uu9obEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAzMiBTYWx0ZWRfX6I4kOY6J0cee
 PTCt/U/UN6jmkGWROxeA85Ta4ckZJpp9mLjy+a46GSjYMOik6yYQnj2aNtJzKj94zKYBBdPt/n4
 0NEK5USvfrdrKDHREMX9poycOS50VhA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290032



On 29/07/26 06:59, Jinjie Ruan wrote:
> Sashiko AI review pointed out the following issue.
>
> The __merge_memory_ranges() function incorrectly handles overlapping
> memory ranges when merging them. Although sort_memory_ranges() sorts all
> ranges by their start address in ascending order beforehand, the merge
> logic remains defective in two ways:
>
> 1. It compares the current range's start against the previous element (i-1)
>     instead of the running target index (idx)
>
> 2. It unconditionally overwrites 'ranges[idx].end' with 'ranges[i].end'.
>
> This logic flaw leads to critical memory truncation when a larger memory
> range completely subsumes subsequent smaller ranges.
>
> For example, consider a sorted input array with three ranges:
>    Range A (idx=0): [0x1000 - 0x9000]
>    Range B (i=1):   [0x2000 - 0x5000] (completely inside Range A)
>    Range C (i=2):   [0x6000 - 0x8000] (completely inside Range A)
>
> 1. When i=1 (Range B):
>     ranges[1].start (0x2000) <= ranges[0].end + 1 (0x9001) is TRUE.
>     The code executes: ranges[0].end = ranges[1].end, which erroneously
>     shrinks Range A's end from 0x9000 down to 0x5000.
>
> 2. When i=2 (Range C):
>     ranges[2].start (0x6000) <= ranges[1].end + 1 (0x5001) is FALSE.
>     The code falls into the else block, creating a broken new range.
>
> As a result, valid memory fragments [0x5001 - 0x5fff] and [0x8001 - 0x9000]
> are completely lost from the kexec exclude lists, potentially allowing
> the crash kernel to overwrite active memory, causing data corruption
> or crashes.
>
> Fix this by ensuring the start of the current range is compared against the
> end of the active merged range (idx), and use max() to safely prevent the
> outer boundary from being truncated.
>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: stable@vger.kernel.org
> Fixes: 180adfc532a8 ("powerpc/kexec_file: Add helper functions for getting memory ranges")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   arch/powerpc/kexec/ranges.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
> index e5fea23b191b..539061d14a77 100644
> --- a/arch/powerpc/kexec/ranges.c
> +++ b/arch/powerpc/kexec/ranges.c
> @@ -21,6 +21,7 @@
>   #include <linux/of.h>
>   #include <linux/slab.h>
>   #include <linux/memblock.h>
> +#include <linux/minmax.h>
>   #include <linux/crash_core.h>
>   #include <asm/sections.h>
>   #include <asm/kexec_ranges.h>
> @@ -105,19 +106,16 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
>   	struct range *ranges;
>   	int i, idx;
>   
> -	if (!mem_rngs)
> +	if (!mem_rngs || mem_rngs->nr_ranges <= 1)
>   		return;

Although the below loop handles this but it is good to return early when 
there is
only range.

>   
>   	idx = 0;
> -	ranges = &(mem_rngs->ranges[0]);
> +	ranges = mem_rngs->ranges;
>   	for (i = 1; i < mem_rngs->nr_ranges; i++) {
> -		if (ranges[i].start <= (ranges[i-1].end + 1))
> -			ranges[idx].end = ranges[i].end;
> +		if (ranges[i].start <= (ranges[idx].end + 1))
> +			ranges[idx].end = max(ranges[idx].end, ranges[i].end);

Yeah this changes is needed.

>   		else {
>   			idx++;
> -			if (i == idx)
> -				continue;

Do we really need to remove the above condition?

Isn't this condition is helpful till we find an overlap?

- Sourabh Jain

> -
>   			ranges[idx] = ranges[i];
>   		}
>   	}


