Return-Path: <linuxppc-dev+bounces-26958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48354C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg52963hJz2yvK;
	Thu, 10 Sep 2026 01:53:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969217;
	cv=none; b=SAfqYyPKuiHgrphWqmtsePcXTdAg/pHu5TLZs+Y4Ez+Zp1+/ZyQ4BK2eRTiD+F67RpD0/I7b00kk+oyMexn1DD+QrZeyDDeSSHtFTw99QXvbZGYnLOcu7WhfzvL3g+1QFnXNP6e3NfX0kdfqAQ6vGHpKRt9KuRW6y0uut5yhPFTTlv1kOZCbHkYih/TsLEKiHaEM+SGGL94JG/Ke8fGvQhWpl9F+dWBnjHQYgKsfpEMrGpssrne2/D6J+D8Ba2mBoH7QBReJdFFbQ42+ikdIW1a4HrLbFdk59OdVaUY9veTwxLAKjEssQAg0GcTO/WG4CN7l4ap4mIE28WGm+mJZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969217; c=relaxed/relaxed;
	bh=9fEv8CVQ+LcrjyrEyKWNY8tE1ZC5nOC4fuPxuTwwtWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8LpK/ZdY+hrthwzRvEBwY+VpUG/FlO+/PmrjP+SbK7jm6mY0zHuIjdbYv1Vemo10i4rzYPzyzSHeCl1/iKzhcEbmG3gZ9YnWA0oDPQd6CRgbsV1QEB03PH8dZlqPGb8mJikI/OA255NdG6dGZyxiVMw7VB00ZT3eTpC1gP+2jY4ieGWIF+UnlGxn+NUrpmLCBQKxtMQts43qjiCaJv/8ylpFpC+1CBXVrXD0nrJ7XhEH7USyajy+0/O72iv7yQ81XbBphUNsGOmAFr14gjABvghubqAfMKaO8dvmMBpmEeiFz94dbvAV6rp7YPTLTM+L79jb6mtdHE2SMfh5Uh/TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FkZShthZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FkZShthZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5285xRWz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 01:53:36 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1hXA1930950;
	Wed, 9 Sep 2026 15:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9fEv8C
	VQ+LcrjyrEyKWNY8tE1ZC5nOC4fuPxuTwwtWQ=; b=FkZShthZPf6z6Inxuhf+uF
	iNXUzguRjPZq6PaXhqShCZ3McDp20T3UU5KU3cjMrWdZqtNCUuSuqfdkm8GvIvLF
	dd72+XGKDtIjz69shK+IZlKQChWqyKHmF6exXT0UkgZBSqDxfU9Ur7ERBXMUX80P
	s0bhDfhWZtFY8AxXcf0pCGiGI5KikMBri/OGHlqKcjofQOFEa0vOHAVhylAiOQpt
	uCOLt6833VHDacYxqLq1mLTEtUp5aex8n856rgslbajZo+ccvWXcR2TgU4TdVmIw
	4EHKN7jBzQE3ENXFaCKAqQK2azDDhu9EJCVqra+ip00luEloiWqmnR79lR7H0gcw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk6vp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:53:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FfE6N015367;
	Wed, 9 Sep 2026 15:53:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswb807-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:53:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689FrJXq50987368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:53:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F5A2004B;
	Wed,  9 Sep 2026 15:53:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CF0E20043;
	Wed,  9 Sep 2026 15:53:10 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:53:09 +0000 (GMT)
Message-ID: <30360c50-0238-40e8-b598-bdfda1141cc8@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:23:06 +0530
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
Subject: Re: [PATCH v2 02/22] coredump: refuse negative skips
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
 <20260820-work-coredump-sparse-v2-2-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-2-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pYL1X5j4L64D3lhY8GC7_PxezJajFPeA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfXyZQ2yeCYTZ8Y
 0zY5ztZt9jhIlCwPuIHMWYJZeFMN1RfSvZmQxlYKHYhZCliMI/1/l/3Wg0EpWXDDd6lWozX46Rp
 BOsUhsvxP3K7Gf6k9YxbUWZBPcLY48o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX5MyolTbYyMTx
 81rdDfK4pUyI4nx4v6Y9Tq/r/gVfH0lueULm43ZNa2On7UJUzNwVwdVblnzuc6TdwypX9OVkabd
 mY7Y+a3Um2ewoWxHnuzkeZMU9B9ZEx8zXreAkdyeB0s9N4qbY4sE3Mi+N9nw47/d2BRpkyMNGvD
 3NamjGc8COyszi5eNpC2WHmCm6ZnIaCNR9nVGU8PKzrDMBSZz7UZmsQZ2GC97VMvBlLdIC1rSRX
 cnRoYJFT+Rf7HW7PJ/28KPLDCHwRT7HIo66pa7r9Oacak+UAvogwSvhdsx8cRtWmtDzjGv5q3Tx
 MRgAeULZKoh4YyzTCo7msiB5MQSn0j7ly8YqteQYeKytKoC6USiarP/25m9uwlz0MZyki4TDtFE
 9HQGoeP/j1znxi3DPlsn/xA5Dz4ToJDJEyWtDxCPse+ktxUKAo6Dlm+UeqHdrTyl+tA5+qewgyB
 79OOPB5Pjo8vswDjYfA==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa180f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0fa85O3lyfMzuANSHggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x7FvKhawyt97Kk1EQB6_XHSAe9xWv9Jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> The dump_skip_to() helper calculates a relative skip based on the
> absolute positon of the coredump:
>
> 	cprm->to_skip = pos - cprm->pos;
>
> That's easy to mess up for callers and one already did. This risk
> endless zero PAGE_SIZE loops or overwriting already written coredump
> data thereby corrupting the dump.
>
> I don't think skipping backwards has any meaning. So warn and refuse.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   fs/coredump.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e68a76ff92a3..ac4e922c9cb9 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1261,6 +1261,8 @@ EXPORT_SYMBOL(dump_emit);
>   
>   void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
>   {
> +	if (WARN_ON_ONCE(pos < cprm->pos))
> +		return;
>   	cprm->to_skip = pos - cprm->pos;
>   }
>   EXPORT_SYMBOL(dump_skip_to);
>
-- 
Thanks and Regards
R.Nageswara Sastry


