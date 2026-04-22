Return-Path: <linuxppc-dev+bounces-19927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F38F94CCE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 06:34:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0qFV3b11z2yZN;
	Wed, 22 Apr 2026 16:34:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776839662;
	cv=none; b=oeDJGBdQJuI070cVPIQ/yVeZBuwZePXRkh423fnggtPbrnCaI1NGSKa6muYP/fAPuib4eE913jJOwxwaYieuqp1ElIW4+q4sixJ6nndlyPFVqJIcvP5IqNN7mBxQ9dJX2oPsRPp6ns+1FtgvFxsn7qmW8FSw5Ny5Iy69NZffrOoKk2Uny9ihmZQJzDaANaxsXgcxOs5lllDy/9V0cCiftx7Q7XY/2ZARY2hvAXkj31sSmYOYdaVFPUJRXubYvbIAA7qNb950slRgz52Tw0lFiGagRTbOFExaugF6V/qU4uBZySA0rNebYPrWrzp79hiGG9YoZH5xQusViqQ22F7ZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776839662; c=relaxed/relaxed;
	bh=lv3/WBINCsdmPFzZQfz8PwjDQ4gZCVFc1WMMhCu0iso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXsT0/YLpsZqkd1uqdzGaCRv3owjsSiBJ5Ppxp2Q7MfvzLTKm3nHjpMcCBLExGz59AhRhJNmTxgBtSy+7hUbds1Us/ijDf0KFQ0Ap5lsH8VmoHsxv1Vj68VlBJTdhz9H127sq2wUk2sWavGeXdDIU8mwq7DGIgDspn8+AaIyqXJ59gxq8LZ2FwlexOd9f28xwwvpBgZ8McdS0z4mvYkJZwaNSJWspJDJvarZGyPhP7wNXJD3P8WAK6Et52hsP4cU3vmJzrakAs/bkqAZzz+nIJL77pb/wGaer3ht36jAL0Kr7ZMBmrqZaKlyP4v5ukQxKdVNzVvUx4rll5Kqq007Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o3+g7ic2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o3+g7ic2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0qFT36rFz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 16:34:20 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LImEb8679540;
	Wed, 22 Apr 2026 06:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lv3/WB
	INCsdmPFzZQfz8PwjDQ4gZCVFc1WMMhCu0iso=; b=o3+g7ic2JjjTwhjfYy0GuU
	L8A46XYlRpfu4uyGD54Sc8R+cEXnryWWm6JDjDiIeFgqDTxVi7kvnMUfjK1excpH
	aUHwpANa7C3YQygHyolguQajmPDHjBC803o6oYJg8ekmz3kZF9klumVTPKmc6djp
	5WftRRztZ/4LyK2+m1IWj41wPiVKTPd8uLrvoMBu8zS62yAtKt/HBo+GJtCDV5pU
	/AD0z7Dt+BosnmW8xl5DIq201/N5GXH+SFim2YqedwY2xulS+tOyxOZLSVv7phkL
	S//9fz7eb1rxiy4FkJSxk55GD9D1dwylSc3Yg8UOWwpa6Pe7OLlW2wF89OzJX/3w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7hv9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:33:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M6KLh8008798;
	Wed, 22 Apr 2026 06:33:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky13dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 06:33:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63M6Xhqb30147220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 06:33:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5822004E;
	Wed, 22 Apr 2026 06:33:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE5D020040;
	Wed, 22 Apr 2026 06:33:25 +0000 (GMT)
Received: from [9.39.30.99] (unknown [9.39.30.99])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 06:33:25 +0000 (GMT)
Message-ID: <c0bd0fd5-5c30-4d2c-bcf6-5dabe59fa5b8@linux.ibm.com>
Date: Wed, 22 Apr 2026 12:03:24 +0530
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
Subject: Re: [PATCH 1/2] powerpc: Add a typos.toml file
To: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu
 <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Geoff Levand <geoff@infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Anatolij Gustschin <agust@denx.de>,
        =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Thomas Huth <thuth@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Paul Moore
 <paul@paul-moore.com>, Nam Cao <namcao@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Kees Cook <kees@kernel.org>, Stephen Rothwell <sfr@cab.auug.org.au>,
        Xichao Zhao <zhao.xichao@vivo.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Guangshuo Li <lgs201920130244@gmail.com>,
        Li Chen
 <chenl311@chinatelecom.cn>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Feng Tang <feng.tang@linux.alibaba.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Aditya Gupta
 <adityag@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yeoreum Yun
 <yeoreum.yun@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Chen Ni <nichen@iscas.ac.cn>, Haren Myneni <haren@linux.ibm.com>,
        Jonathan Greental <yonatan02greental@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>,
        Gaurav Batra <gbatra@linux.ibm.com>,
        Nilay Shroff <nilay@linux.ibm.com>,
        Vivian Wang <wangruikang@iscas.ac.cn>,
        =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>, Yury Norov <ynorov@nvidia.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Ruben Wauters <rubenru09@aol.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
References: <20260421121420.26079-1-linkmauve@linkmauve.fr>
 <20260421121420.26079-2-linkmauve@linkmauve.fr>
 <215f12d6-62c1-4837-9f78-ef270684950c@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <215f12d6-62c1-4837-9f78-ef270684950c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4EaM1Y0bvhcFaO8pxVl2Od4VPvv4qd_j
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69e86bcd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=YFAi04RA3zjlIS0kzIUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wxrhwpGYQgEkSGVFqfHgj6jxXBwEWO3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NyBTYWx0ZWRfX5/ArlEsGNSKD
 /9hFZpzk/tBrQnVBDmXiF4w1FvzvkI5FYebPR4H6fK6rtGBtQvh5Tbt/QZr3WMDy+6R0noufnH6
 Ya+wACPpOZFQJ09FYoTudgl5+q/PV7gmmAV9NPezJXdrAxHur1mG8YzhTK9VRbWhJwkgxq3LsPk
 ffWHlNMh03TTaqUGZnsGBKN42ZF2SD0q0NadhTGxwm168iEa2MRPxSZawS2Aw9hlkqZ9FOIGnaq
 2kciRJS8MdAoGjE59gmcgOQT6j/TVxpPgu9Pntm8o89A6QtjwmLm6VUuk22OG3ajrGUfVzkChFa
 GbkQ1ofav43aIkl/ufNxjJLZ1so6fkhvQr7RvNXLZE2zakfeViXv1oyWiyhQxGizn9RldP9mbN5
 RrefFQMDKwAImETMEeDhBW8vQlxZ1arpQuX6h/yYSDlnxl3v9+qH0tOe3tdsjrKIxpFe05AjSLr
 Bwv3zJRpcTPd94rsX8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220057



On 4/21/26 5:56 PM, Krzysztof Kozlowski wrote:
> On 21/04/2026 14:14, Link Mauve wrote:
>> This file is used by the typos tool[1] to determine which words to fix,
>> which ones not to fix, and what the target word should be.
>>
>> [1] https://github.com/crate-ci/typos
>>
>> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> 
> This typos.toml file does not belong to the kernel, IMO, but that's up
> to PowerPC folks.
> 

Right, Also there is nothing specific to arch/powerpc here.

IMO, This file should be part of the tool's repo. Not part of 
arch/powerpc kernel tree.

