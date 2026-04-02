Return-Path: <linuxppc-dev+bounces-19185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D8CC6B00
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 05:42:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmW2l4qJ2z2ySk;
	Thu, 02 Apr 2026 16:42:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775108543;
	cv=none; b=NwW464ZRlwpaRDfqXt6PNoY0khnk7224FnMUqgdJlb4sd2iQI6HMSk0TlFHd4I9phCYzaXhkAE6BIZkOvd3jJRnl2kc/2PNsj6Ik3SgkRQc8+IHNTD1mRTSPowdKxiSiqpG94UI/n1X3Vlnr+C9axxkDfqkGTut7Za5HrBnjTNmMFA3b+Rrj34WzzrRagzIxNYFeAvmnz9kV+mbi4Ns/TevdRuAYhyIuSuyWA8HWo+BFBOXYc7dCHXsbKFIwP5+9T7RJl3Fvs6NzbuLjX4pjPcOqmNu1XGlz9YnRvmnR6oJkyO3h3NPgn3XBrAu0XK8/1/wI6dm7gS+1WnFQMFMDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775108543; c=relaxed/relaxed;
	bh=EORk0tEdXeQE35AkewLeDAgsE7AO1utGOHCLHva2lH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYctdKadFFZY9z3s9u5XUwf/WYLt14dZtA5rahwriViXYEkd6dO3mhauLjNHwh8lz5jkLs32mQ5HQxi/F160lahAxTzKo95SwUQHz0exk/7XMmDlopT0BBUgkSWXtanl645W4++zTvUYvdhaArpBRMjtvR0lwWzK1w348eMUzOAjXwSV8YP4E3GmXreQ7s30Y40223zwP4O7w5LElvUBwwLe7goV1uGRimD6mEsY/DEeByRZ6o+C4uVMoukasN/qPyea8BF5jXueTwWp4L8+CZXNz2YVziuO4ZYkrsgvGk8OTFJZMim+fVwfbtPkcr5yw/oAiRnW85ju5B/QlTrLNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tDr7Ge/g; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tDr7Ge/g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmW2k1fm9z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 16:42:21 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631NtEA1188586;
	Thu, 2 Apr 2026 05:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EORk0t
	EdXeQE35AkewLeDAgsE7AO1utGOHCLHva2lH8=; b=tDr7Ge/gXxAE2pYlssE3hx
	xH8sieMGB924wlnaaxRNLSsYbfYJdKicH0VuY/zWYjwBNhmH/6dpSl9LkuCtICoQ
	yLZbBnqxAtGFP94073E7647+Txp0LvQDjUSUuV0G4T68Kw6KyH8zXkQykiOqw4v9
	cAFjAWJzZlHI/j+O975ZQonjQiO6SA29bBX6EC/iYmYtQvWpfeWgdfgXmT9Dl+Jr
	cjJ98avooB95Bx+MFAofgaNGBh2+BAxHjdvFms4ZYbw/aWHaPHDbH9K8TpvUTt1/
	4FBh8jJiS2H5qzNzTWdBKsiwjhcRyXsbg3O4myJriQz7G9kt5loP9+mJZ8KmdubA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnue2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 05:41:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321P5uL008732;
	Thu, 2 Apr 2026 05:41:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11rkk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 05:41:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6325fkaB31588960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 05:41:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4085758055;
	Thu,  2 Apr 2026 05:41:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F5D58043;
	Thu,  2 Apr 2026 05:41:34 +0000 (GMT)
Received: from [9.43.16.154] (unknown [9.43.16.154])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 05:41:34 +0000 (GMT)
Message-ID: <67ba2bd7-9d77-484a-be7c-c49245594e45@linux.ibm.com>
Date: Thu, 2 Apr 2026 11:11:32 +0530
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
Subject: Re: [PATCH RESEND 0/5] bitmap: cleanup bitmaps printing
To: Yury Norov <ynorov@nvidia.com>, linux-kernel@vger.kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>,
        Kees Cook <kees@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Russ Weight <russ.weight@linux.dev>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Jakub Kicinski <kuba@kernel.org>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <abxaIMi55N4X9JWz@yury> <ac2_EzO-uCaLqTlg@yury>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <ac2_EzO-uCaLqTlg@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: q-gRfypHVWLTKOzqQbUHo8Z3Z9Q05fie
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ce019c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=BVaCEM1crgw_HuzovtUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NCBTYWx0ZWRfX+LzEahelN8CB
 K5xjq6K7tuNN9Z6LEY869JOJ/BWdUA5T3hrx2CGUq/W0LFizueDwnkFK3UutliY2VjJ4y4b/y/e
 RjtACzrvnuqGgRk4MwIj7lTNCnrnuw4rWYDTelhhcWP8OwbtFkhO+aWFmTqllHJVuqq1uT3+/PX
 ASCCJDGX/fkvHFBpn4+AyhbZwkmZerCH8ed4JukJfZ8NdT73Its1nC6ZujMBj5sAFfq6Ol+OhvA
 fgQXNCxJnGBHocBh3T29naC3PSRc9/9oSM0hrxM4VvqL8AfhQjAhOgwIZCQkkrVthoA4FWyPizI
 kN18xwZ5O+bRVP6CYLM46EOWNRg/JCtNMsYaXe2QuY2oPWlVivtcapr1059JPvtVj1Mwn9WyGE6
 90MaE8mPWrjOl/4d7jpNemMa1Tl0e9gwy+0NjF752w0EB4kZU36ltbej1CJReXa/0YLyn0gf8lA
 M4igH8/Rl81iS18thOw==
X-Proofpoint-ORIG-GUID: rmybyCQ6Fqx2OWdLNeg6foaJ2qq3aIwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020044


On 4/2/26 6:27 AM, Yury Norov wrote:
> On Thu, Mar 19, 2026 at 04:18:40PM -0400, Yury Norov wrote:
>> Ping?
> OK, taking 1-4 in bitmap-for-next.

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com> for powerpc patch


>
> Thanks,
> Yury
>   
>> On Tue, Mar 03, 2026 at 03:08:36PM -0500, Yury Norov wrote:
>>> Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
>>> print bitmap into a human readable format, making sure that the output
>>> string will not get big enough to cross the current page limit.
>>>
>>> Some drivers use this function immediately before passing the result to
>>> scnprintf() with no modification. This is useless because scnprintf(),
>>> and helpers based on it like seq_pritf() and sysfs_emit(), take care of
>>> not overflowing the buffer by itself, and perfectly print bitmaps with
>>> "%*pb[l]".
>>>
>>> This is a resend of non-networking part of [1]. Patches #3,5 switch from
>>> plain scnprintf() to sysfs_emit(), as pointed out by Thomas Weißschuh.
>>>
>>> [1] https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
>>>
>>> The networking part, for reference:
>>>
>>> https://lore.kernel.org/all/20260303185507.111841-1-ynorov@nvidia.com/
>>>
>>> Each patch can be applied individually per corresponding subsystem.
>>>
>>> Yury Norov (5):
>>>    powerpc/xive: simplify xive_spapr_debug_show()
>>>    thermal: intel: switch cpumask_get() to using
>>>      cpumask_print_to_pagebuf()
>>>    coresight: don't use bitmap_print_to_pagebuf()
>>>    lib/prime_numbers: drop temporary buffer in dump_primes()
>>>    fpga: m10bmc-sec: switch show_canceled_csk() to using sysfs_emit()
>>>
>>>   arch/powerpc/sysdev/xive/spapr.c              | 12 ++-----
>>>   drivers/fpga/intel-m10-bmc-sec-update.c       |  3 +-
>>>   .../hwtracing/coresight/coresight-cti-sysfs.c | 32 ++++++++-----------
>>>   drivers/thermal/intel/intel_powerclamp.c      |  3 +-
>>>   lib/math/tests/prime_numbers_kunit.c          |  6 ++--
>>>   5 files changed, 21 insertions(+), 35 deletions(-)
>>>
>>> -- 
>>> 2.43.0

