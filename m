Return-Path: <linuxppc-dev+bounces-22202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DE7CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:19:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvLz0d2nz2yS0;
	Tue, 09 Jun 2026 00:19:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928394;
	cv=none; b=a1Wjk0WSeB0Wbz03jkaHJN+2AIvWYaKbr+/qyyuNZdqUARf/gMmFM/sEkBL5AKn7aE/JioA1FcyZHtYqdEQ363zrVXdTmzFfrZQZT+CRGEY7APbld4TKciP/EkBB8IaoZBTnixIQzDEHmEaW1l/TGtmExYU+NPqnNoNRgpx2lLDis4aby87nSnpUCQwnD3oweVbA1PAO3TpYs4cSa5XnVpI9c4NqNEldT7qreg6gWgyFfP8GhHyWwC3F7g4nnPlg593fnxvLBbiqTumiW4J6H2k9nzFPuOMCKr7t0bEGzLCe3DS10QGARkek2A+lofrhu4/y0YS666zH2KCEWBA8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928394; c=relaxed/relaxed;
	bh=pTnj5hc2AGLIaTtiaPIpTmrWWo1jdcJMYBjGgCDyyjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hRAQ8g8ieVD/2R4jffN09K2m8i2D79HlR+GQcQ+abrxcyxbNi62mmwr2tuOAJw3Bj8fab1TVENceF+BYSWU35EyetFMTBDpX9UPC2+gM+RSCc8hSeryeTVWpO1qTP5WFh9qR0mJDRHPbnMG+KL2kI5Uefex6LBsv8fTEYjfwvxTiPs1sWS4LNBOoxWtDHBZzl2jTeNlfnwIC0DKAdTujIF7DBxKaO3hPL82jGY2cVQDRCsQJ0MeCYZzIaoizQGXSQHpc3WjyHGlskrldjtlvfstMWv9U8Yzx6ZlbP+fIr/m2Sl83yE9j8jacn6HAxbwXdy2TzJS4UNVJr0Ph1rvqfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kv2q8G4S; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Kv2q8G4S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvLx5gTPz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:19:52 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588A7i91458768;
	Mon, 8 Jun 2026 14:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pTnj5hc2AGLIaTtiaPIpTmrWWo1jdc
	JMYBjGgCDyyjs=; b=Kv2q8G4SKMkysAkJbBslHkb5PPRE3mJDxWiQ3cLgS3TK3G
	CVxKz/xk7dwvU/sN5JEnyd+oX8gVFE422M9b9V1W7JOLoxcMu07mW5gSeWiWS5Te
	N7Ia1GITDv+Lck+8yu3SNXU7fZ4arSA989yvWA2TlvIPrn86j9EHo126o3aFSrUD
	+SRaUloFIfkjGc6eLFSeYb2dHbw24HVh8xovpQFm7lAKm32ZCGS7Dhy4ihBTriFG
	Q+1luifPjiY0gyH1dQ0YsJovPIkGs8XRCPFOBa+xtlbFsd89mL9rKdeE3FpXqXiI
	Z3op3V0W5+9uaP40C4KOqflfLYohTJxy9ImHwEOg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb957nvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:19:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658E4baE005680;
	Mon, 8 Jun 2026 14:19:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpwt7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:19:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658EJXOH25821920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 14:19:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 122C358056;
	Mon,  8 Jun 2026 14:19:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060B058052;
	Mon,  8 Jun 2026 14:19:27 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.27.161])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with SMTP;
	Mon,  8 Jun 2026 14:19:26 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Mon, 08 Jun 2026 19:49:25 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Harsh Prateek Bora
 <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree
 Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
In-Reply-To: <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
 <aiGJvUqgjUo6M5et@mac.bl1-in.ibm.com> <87ldctmosh.fsf@vajain21.in.ibm.com>
 <aiaAPQmWG7JXGoGn@Gautams-MacBook-Pro.local>
Date: Mon, 08 Jun 2026 19:49:25 +0530
Message-ID: <877bo9m7wy.fsf@vajain21.in.ibm.com>
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26cf78 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FEvzW7QgZIPG8QhEdCYA:9
X-Proofpoint-ORIG-GUID: IAcZRhrd19hqH9tIBTGj-YEn3gPFGtPn
X-Proofpoint-GUID: 334FODx7fJ4QzIEJE24es4nh5iroqIfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNCBTYWx0ZWRfXylAXCFV89dhV
 h3DNgITWM2xtuWmkgirPy1GBkIstat3tS0bbwOP6pFg0W7epEjmPogLG+49+SVmgT5o8R2kaKA8
 BcnYW5fRkD1YcRbac6Fkget9AhawkCvWLuia7SF2XcEYkaohaiMjdFgaKO81cTrPv82Ec0lPTEP
 YdNKRzsL65uq4+nOJSYSCAMcO6KXVozVhw8WK/6vIhoDNlW1n+wvWCyrWBlZh9DgipxZ6i9/x7s
 WCVxXDeuKYbzYgAZcjnHeP3v283XEWZ/h43rBO3I8fK5XQ6m3Ocu1RGBTwH4IqOx4wFxcGPcoUe
 VTO4J3b7jFYrK1ompMK2bobCbqF48BHCsCpS9LJDkLjtIOQTcQP4F6pdLHzVrMAPMuHwIgA7+dS
 UBwKhdV4pWGY3McmyGpPcGmh5h5523bNRHcYNp92at38+nJbBuLRqrl30eP8lhSK7KTJebDta8x
 Rem2ZlEwDleecsuhwzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080134

Gautam Menghani <gautam@linux.ibm.com> writes:

> On Fri, Jun 05, 2026 at 12:55:50PM +0530, Vaibhav Jain wrote:
>> Hi Gautam,
>> 
>> Thanks for testing this patch. Few questions:
>> Gautam Menghani <gautam@linux.ibm.com> writes:
>> 
>> > On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
>> >> On IBM POWER systems, newer processor generations can operate in
>> >> compatibility modes corresponding to earlier generations. This becomes
>> >> relevant for nested virtualization, where nested KVM guests may need to
>> >> run with a specific processor compatibility level.
>> >> 
>> <snip>
>> >
>> > I booted a KVM guest on LPAR with this patch in the following scenarios:
>> <snip>
>> 
>> > 3. P11 guest on P11 host booted in P10 compat mode: No error observed
>> This should have resulted in an error since booting a P11 guest on P10
>> compat mode host is not allowed with/without this patch. Can you please
>> check your test env and share the boot results.
>
> - lscpu output (host P11 LPAR booted in p10 compat mode)
> # lscpu                                                                                                                                                   03:35:13 [3/3]
> Architecture:                ppc64le
>   Byte Order:                Little Endian
> CPU(s):                      960
>   On-line CPU(s) list:       0-959
> Model name:                  POWER10 (architected), altivec supported
>   Model:                     2.0 (pvr 0082 0200)
>   Thread(s) per core:        8
>   Core(s) per socket:        15
>   Socket(s):                 8
>   Physical sockets:          4
>   Physical chips:            2
>   Physical cores/chip:       16
>
>
> - lscpu output from guest
> # lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   4
>   On-line CPU(s) list:    0-3
> Model name:               Power11 (raw), altivec supported
>   Model:                  2.0 (pvr 0082 0200)
>   Thread(s) per core:     1
>   Core(s) per socket:     4
>   Socket(s):              1
>
Argh, this doesnt look right. The kernel patch should have prevented the
P11 compat guest boot on P10 compat host. Looks like you havent used the
corrosponding Qemu patch [1] that could have prevented this from
happening.

Had a off mailing list discussion with Amit on how to address this issue
and he will be sending a new version of the patch to address this issue.


[1] https://lore.kernel.org/all/20260502140021.69712-2-amachhiw@linux.ibm.com/

>
>
> - QEMU command line
> /usr/bin/qemu-system-ppc64 -device virtio-blk-pci,drive=drive0,id=virtblk0 \
>     -drive file=/home/gautam/images/fc41.qcow2,format=qcow2,if=none,id=drive0 \
>     -m 100G -smp 4 -cpu host -nographic -machine pseries,ic-mode=xics -accel kvm
>
>
> Thanks,
> Gautam
>

-- 
Cheers
~ Vaibhav

