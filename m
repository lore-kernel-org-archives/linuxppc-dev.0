Return-Path: <linuxppc-dev+bounces-21499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B885CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 06:44:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPjsj40LWz2y8t;
	Tue, 26 May 2026 16:44:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779777881;
	cv=none; b=VGko+ME52fkHZ5LXlxRgyoUqxfWrSJcHQVLDZ9NOGiyy3Rj1op4Z374K8KH++7/lBqZiId+/w/+Zbn+69HF7HeBzTtV1YlrnyHxq2NbEbnV/CsrX1LNMmiTVrXbMdnpdAuN6hA4DL/XyZ4Xa5aak6ciu8X7i5DtQ+EFmGi2g7dfdM9NxGAlXh8LtgRYS8+RbJt1hlqz+9ELCjd3ZGIwJCZOCKtWfCoJ/nCpYpy1UOYsWeEZmnbnYxLBTeAQnbamz47E1MaebiWqTqlwGnZawlQG2uFvmr6NBlLqhAyjlegQvjBdjoOiljsOahcyQm4/M6M2BeT/onoPitEOlpkZWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779777881; c=relaxed/relaxed;
	bh=v5FJK0wqruJnUH5eIQsQ7m4GlyVZrGtClvNqWq98Bqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwJqSfRKk9lj6plxxymNvtXHI8XfJmh3qFJwcmAQGdY1soORwt3xA0WfBV/AlNbVNPnbbZImiC3ljcTYDw5sn0PS6JlWhPSFj/5aImwF5x4jpVHZho6Fz5edm3Wembfc3W/gUDs81CMjJfvOPlDCxSncrj4XmfcjTpqT9aBMW96KnelwBePaKjVWpbDNCROhtFD27JHJGfyvAQIXGQnosDWHHeWz3wl66JERt8NnuIMqb/IK+v/bG0q0yv45bURreOVbLl2xLxZ6vvxDjcl8lPd7KYA9jiQleWz96Pd3VfGk8QjfUWuYS6fSSArLFyhtKr8auy3JAIY1RIqyPfbmow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ILqdq50l; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ILqdq50l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPjsh5l6Wz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 16:44:40 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PErwir2243358;
	Tue, 26 May 2026 06:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v5FJK0
	wqruJnUH5eIQsQ7m4GlyVZrGtClvNqWq98Bqg=; b=ILqdq50lKowXd1nJdKdxB/
	kQvLOjfo04/VkmSp/KAUEBnGgJZgGzGBfljXW47/Rg6aPHdjcYJ+4CFaOHL5nDp9
	3LmIJ4fLxgV0qUvlBk1dg99W8m4F5AyE8xirxFaJFgc236RK7/jf0F88vtxDvcjy
	LfJqy7iehzVEzdqpHZoMPNbSD/etpQoZ/pnvlbvJEP05TGy6pPo83fdH0i/4VIsh
	YlyLNQTdkfbEhfejhDXQ6yGkP4uLqaBRkZk0bV8tDq2+pDLE3CkMzPfIIfxfjJuZ
	VFCDjDp5vAdH4Q+f4vmm+tBjt6FNFiO1tjLqydkA/St0oWErG47ZCOGU8EM2L4PA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nujshx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 06:44:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q6d4Fb030319;
	Tue, 26 May 2026 06:44:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebs8y7v9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 06:44:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q6iSwt4653824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 06:44:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7C558050;
	Tue, 26 May 2026 06:44:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA85E58045;
	Tue, 26 May 2026 06:44:24 +0000 (GMT)
Received: from [9.123.1.210] (unknown [9.123.1.210])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 06:44:24 +0000 (GMT)
Message-ID: <6169bbc4-1829-4b9e-bb2c-a508a001e1b6@linux.ibm.com>
Date: Tue, 26 May 2026 12:14:23 +0530
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
Subject: Re: [PATCH] powerpc/boot: Allow text relocations for pseries wrapper
 with binutils 2.46+
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Antonio Alvarez Feijoo <antonio.feijoo@suse.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20260525161601.32097-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260525161601.32097-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA1NiBTYWx0ZWRfX9rcihx8bupIy
 cD4Pnf5cHwVzutHqB7GS4GfAIM3hzo+5kSJ4w4e/lukmso5fnMapmDkxWKiTEbPVHhKu/a8nOrW
 jLadidncXpxeOAB25kT9zRSkJOdjqM6j6A1CLctWTczKOKHbqCXitfDSc0GCUwPfGEkMEsNCkZI
 9I9+5YQf97Mex6QFENzr3uIqBbdRlvCvmPo7ij5utyWgq9ZXXxH4+rZFjk056EruuGBWC5yCBaL
 HugWJVyQzGLX9A093IvwxGk+hJvdAbg0r9pl7IHrPnCmGKGkGXbHVlz0jWKGu93HCMkYFxmj4v5
 rcEXTGDhG1DoDBv72Bmbs7sR+CKGk85OrrvFpbanGtAeneZ0IxxK3yUYfryiiwycBHdxHALHj4r
 mUJkaSsYyN2xZ9BqiKMNkz8sj//ZV9gIBTU3cTxgLHS1A8LRh807tcwYdW3BYqMVjD9pMnXY0Sm
 EeGF1HjWAROPJP3V+6w==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a15414f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=eDpnT0D1nqHXEcdKhn8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KuCf5coYXHOawg-mupjfTKcEJF7OBe-d
X-Proofpoint-GUID: xo53U0jTN0NPChcC6iS9OJlH4QYQNnnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260056



On 25/05/26 9:46 PM, Amit Machhiwal wrote:
> Binutils 2.46 changed the default linker behavior from '-z notext' to
> '-z text', which treats dynamic relocations in read-only segments as
> errors rather than warnings. This causes the pseries boot wrapper build
> to fail with:
>
>    /usr/bin/ld.bfd: arch/powerpc/boot/wrapper.a(crt0.o): warning:
>      relocation against `_platform_stack_top' in read-only section `.text'
>    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>
> The pseries wrapper uses '-pie' to create position-independent code.
> However, crt0.S contains a pointer to '_platform_stack_top' in the .text
> section, which requires a dynamic relocation at runtime. This creates
> DT_TEXTREL (text relocations), which were allowed by default in binutils
> 2.45 and earlier (via implicit '-z notext') but are now rejected by
> binutils 2.46+.
>
> Add '-z notext' linker flag to explicitly allow text relocations for
> the pseries platform, similar to what is already done for the epapr
> platform. This restores the previous behavior and allows the boot
> wrapper to build successfully with binutils 2.46+.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/boot/wrapper | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 1efd1206fcab..25321ce262e8 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -262,6 +262,7 @@ pseries)
>       if [ "$format" != "elf32ppc" ]; then
>   	link_address=
>   	pie=-pie
> +	notext='-z notext'
>       fi
>       make_space=n
>       ;;
>
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
Hi Amit,
I have tested this patch and it has fixed the kernel build issue. Here 
is my analysis:

i) Without applying the patch:

Kernel build failed with below error -

   CC [M]  drivers/net/usb/r8152.mod.o
   CC [M]  drivers/net/usb/hso.mod.o
   CC [M]  drivers/net/usb/lan78xx.mod.o
   CC [M]  drivers/net/usb/asix.mod.o
   CC [M]  drivers/net/usb/ax88179_178a.mod.o
/usr/bin/ld.bfd: arch/powerpc/boot/wrapper.a(crt0.o): warning: 
relocation against `_platform_stack_top' in read-only section `.text'
/usr/bin/ld.bfd: error: read-only segment has dynamic relocations
make[2]: *** [arch/powerpc/boot/Makefile:386: 
arch/powerpc/boot/zImage.pseries] Error 1
   CC [M]  drivers/net/usb/cdc_ether.mod.o
make[1]: *** [arch/powerpc/Makefile:236: zImage] Error 2
make[1]: *** Waiting for unfinished jobs....

ii) After applying the patch :

Kernel build got successful.

Please feel free to add:

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you!
Anushree Mathur

