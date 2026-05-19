Return-Path: <linuxppc-dev+bounces-21196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840ECCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 21:55:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKpPs5yPmz2xf8;
	Wed, 20 May 2026 07:55:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779226481;
	cv=none; b=KprjfmmyExB5kExxUJcpF0Tlt1LTcmde2bDtuMFnrH7iNeSDPQEmqOI/VYAtJ2XDIHj5sjNNYMlAamgb3SlkiHYXqnXX0gQvDIkWy9A8GNVQhufFOfzAQ5uxD3q25MDE5Ei+LjKVyeDGSrbps74QC+nasAvUxNjEMKwpbwDwjX/11kNxwmCZv6DDFBcd6v4Kn63o68fRy5uDWR3dQzr0vXRaZozKJt8v3WeahPiXryEQDhwTUy+YaU9COCaOm+9F7KFcGbb3q1zuloxeBFhhSIZmbIxALpfGbvphYNoWiwpjggJA8OmSwRnNiMeOoI3Gx3DaKevZVTlhqJ1bmugjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779226481; c=relaxed/relaxed;
	bh=VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYmFNvLpluC4Z7FX616DtePznRf8lK0Zn127PflAtA9ptIlLNZiQoTznVolKjN3R6GT8hOFI7ZKwKO8bCTdw3ZGTn7/qfzAi4xyzFRg3UsDxq4Y2TY+jwPldmLDbraMY0sDFzxDD7V6q6crDSnMt/6I83YCIOPwVVDXeeXMY2jW58yyf7zz4QMzB/XMUORKdFFzzPn98eXMBynuUyFqb37YAkZC2BWu5mrI6Q1NB1mRoof5QpE55MlXcQxR09VOzhW+c+bFjdUrDL6trUM2rUAVR/d5z+gPmu/Yx2OgIzUf2NU+Co2Yo8mb5hccdmbgSfD09inKjX/QCYN24tQ49vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FPDGbx0T; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OCxg+rf4; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=georgi.djakov@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FPDGbx0T;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OCxg+rf4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=georgi.djakov@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKnxr3BMMz2xWR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 07:34:38 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JExNwb1237989
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 21:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=; b=FPDGbx0TuXRy5ByC
	aCnLH69AqWtqKU0ZeYV2Mz1Ff+ymL1ypchmygcp/NXSBhhcbVOHDdrujTXkaTnQu
	QTG27uEWjq/j0GPled3OiBWUk3Mff18opD4MMsyt3p7wE4mdv/fEDGSjXYmMKM11
	KZKZVgGDN6N2+N5Qw0Rlv/RlU3YNXN2FAXZWC2CV6oAGgUM8jljG9qUM3QPouv+9
	a3OslV8v0u6xIs12ZxpO4AlGGc9iCySIeDXMLWU6N7h4R8Ja1E8+koWYHIwqqTH7
	7x9wOHwSA/VAxMC0UbejwlQ3wEeNs7v2Y7dEmIFzVEpzsPwr6woMSVr6k44gd3e/
	zHyBLg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sska2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 21:34:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2efc342ef15so5468363eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779226474; x=1779831274; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=;
        b=OCxg+rf4hmNPXkzmvhA7fvZ/bGGd/PM3x5XU9xpJ+VwPWZQ2GR7ajVHnl6nVjdiCUB
         y+zgzAHdk93sf0SmvI1ZXPX0xuuAfCa1o5sA3H1T6OF/jSYfgKMM8gVBbxlsy1ikI2h0
         IbJQxve+UGlVt7AmgGPUT1CNhIHF8XS1kN0DkAU8DXnkkdoxbmoyjp4x/r+KrLTqXUT0
         Ql4wriYlDjEz/ywt/VBjTwvYUi7QZ5cr5AQobFtHPD7QOVgG7QIWxAVq+mp6mlxPEx59
         uBmscAt5r0085gNMvqjVUywQ3kwDyR4BakO2xq+7IWmLqMhTUSqwlmurYNhQzr45XpBw
         75xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226474; x=1779831274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDn4qGggayMUbM2m3q+lfb9GiCRfeMM4D3/Bti+Y/68=;
        b=Ba1rxZp+JH3D7Yy7wJkZ5WO8WQg/+3TL8gNmb1RtT25NaQ62QqL3r628u2t0zYrhn4
         HZV3xs3k807WB4sD8O4CiYZ13NCsQargs/6kvCaq19KPGV+LgL59T+O/cg2Bpnw7h2sD
         jc0tf6xQo9TI6f59gqwtHRoQRwoiDDR0e4adcYxWBNFchDYALSCXyjcLqJVpsIXeAmmL
         2xl901n0+bVMujwKAvRrMJ2mOcOcXsFtiptpNSQ55+pCohq8ljM+2FTFK8bAQQeqjuwl
         FLV4w4MQhERAJAnsVGYMy3U085NhPg/Ht/5emtlvaivNE35DbMZNxAHjDxZC48Z9lXbE
         0M5A==
X-Forwarded-Encrypted: i=1; AFNElJ8MZkrONtZIii7NgjVE1GwIt+ceK2l3rTCpJECAIySSuzOBg8XBM1jM6Qo67pIpJkXqeR9ZVMMB9hj0m4o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKu4jsYy3JKW5tk96IiDn97K0MXii8h0WRO1kKVwKUAx4vvnN4
	M9QUuzWdY1qqVGon6jfZFwWN4Lx5RpHB0kUJ0842PsAIJ/ysV8BscwvZAg5wazt3lVs/Rx3SEfs
	W6auqbeBjTrWwYloN3ItB6rHFRjWqvcosR4ic057RCaACSY47Y93fGLCaRyywRTytTios
X-Gm-Gg: Acq92OHuNlB0ZaEWW9+tk5h514pBtstws2gckybxVkYrDMlwMi3tq6B5pyfjHy4DJ6v
	O/TRmSfltclXbpCO1bY9PSMPvDEer8D2J5dkcXp9EtaN0FK1OAtXtl+qupgnHpTGh2ZjEtkFF2g
	bT40XIxH6T7+w3nEbwPxAlknGO4kRvFx/bVQbM8verM+GQyv35KwHJQ4V2h9mbJFgDWrSUUKAIH
	I2T+XcWnLmvYXc/6JmLKo7xz63lN9Fqm7kJtcrcB+potKYWHWOPkobntPTouidsjRJumEXUsQCO
	4amuEDCPTlU8zWQREOJZ8Aaw3LeiQ4ij4fyPdf3SqCYhtz8RZo4fRGs3UGe9I2w//MWb8oU1Yit
	z8DGu+QQ3lnOailPDFqjW0xBaZmf6XBbONVzH4rVwtZ1C1i+ibW6c
X-Received: by 2002:a05:7301:19ae:b0:304:13f3:e461 with SMTP id 5a478bee46e88-30413f4159bmr584083eec.3.1779226474512;
        Tue, 19 May 2026 14:34:34 -0700 (PDT)
X-Received: by 2002:a05:7301:19ae:b0:304:13f3:e461 with SMTP id 5a478bee46e88-30413f4159bmr584047eec.3.1779226473901;
        Tue, 19 May 2026 14:34:33 -0700 (PDT)
Received: from [192.168.0.31] ([212.5.153.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm16873423eec.23.2026.05.19.14.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 14:34:33 -0700 (PDT)
Message-ID: <35028dcc-3bb1-4e76-b471-183f319a7f46@oss.qualcomm.com>
Date: Wed, 20 May 2026 00:34:25 +0300
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
Subject: Re: [PATCH v8 2/6] mm/memory_hotplug: Fix incorrect altmap passing in
 error path
To: Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
        joao.m.martins@oracle.com, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
 <20260428081855.1249045-3-songmuchun@bytedance.com>
Content-Language: en-US
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
In-Reply-To: <20260428081855.1249045-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Pe64EVg--Nz_FQKoWIQT5wTLpEcowCvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIxNCBTYWx0ZWRfXy0hXRgPjg0AX
 1pwkc2t7xxTyfocLWMF2UEkyimhcLWM+DfkSVpoj62+eiz+qACpszfMRs2oEeIJAfV3lbAmGUcY
 X4mIptrcBHNttblPEIrVcXI7SHqKOyrdyg3yQdMyyyHjJnlIwdNruXTCtNo1zxiymVWnXSLgMm1
 4e3vb4YGU/c8DbzF5khLEHHBjSQvp5jmj38mEWnGSmYpsBvdl0XJNxhBAt+Ly+kF6fOfP1eLCI8
 2uKaBRFcC4llTkaf6NZQizjx2nKo5rQOfApM1+MslLCnKMDrss64yH1LdcQAzWxEmwZ7wyYHt+d
 MjldkljdaIH3d/Le1L/GJLkp79sgbNU6sko6gaJKdkssFW9UylGxXald4ibUCON76GApkKbAkvU
 si8A+9apq+eegBYzQGqNvpzvzgvjKayFgRCJVLo1/1inzhKiKBmqCO2JQCEmeAGxuLophTETR1Y
 O3m9zq8gGBAXHaZB0YA==
X-Proofpoint-ORIG-GUID: Pe64EVg--Nz_FQKoWIQT5wTLpEcowCvQ
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0cd76b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=douLNevBrtimd63D7eljNA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8 a=cJIYO2twRcDUUobFbVwA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190214

On 4/28/2026 11:18 AM, Muchun Song wrote:
> In create_altmaps_and_memory_blocks(), when arch_add_memory() succeeds
> with memmap_on_memory enabled, the vmemmap pages are allocated from
> params.altmap. If create_memory_block_devices() subsequently fails, the
> error path calls arch_remove_memory() with a NULL altmap instead of
> params.altmap.
> 
> This is a bug that could lead to memory corruption. Since altmap is
> NULL, vmemmap_free() falls back to freeing the vmemmap pages into the
> system buddy allocator via free_pages() instead of the altmap.
> arch_remove_memory() then immediately destroys the physical linear
> mapping for this memory. This injects unowned pages into the buddy
> allocator, causing machine checks or memory corruption if the system
> later attempts to allocate and use those freed pages.
> 
> Fix this by passing params.altmap to arch_remove_memory() in the error
> path.
> 
> Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4426abb05655..e3352284f635 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1469,7 +1469,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>  		ret = create_memory_block_devices(cur_start, memblock_size, nid,
>  						  params.altmap, group);
>  		if (ret) {
> -			arch_remove_memory(cur_start, memblock_size, NULL);
> +			arch_remove_memory(cur_start, memblock_size, params.altmap);
>  			kfree(params.altmap);
>  			goto out;
>  		}


