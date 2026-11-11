Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA6606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LQz86sXB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPfQQ2HmFz2yPq;
	Wed, 11 Nov 2026 21:09:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794391790;
	cv=none; b=Tkups5WeIXcf5sCtJxkp0fYu/iwAkMaPbl/SMYX6PjCawiRAllaog/UG+1fahoK+D4t3NJCSI4tkrGvVDMhuAVcdf/at/ldo5687/O4Dzxvs0p2LxA6RGukWaq/kUMK/VE14/CRbsTOqmcZ2gp5njmrtkwGAvXWPttqDgbFQDeWoeWZTQhl2XODl6LUSSr/z3WVyzW67vLl4E7RYN1golPoSUYmu/qOByR9LG1dEwHPAPYaOsjmgzBg9YFxoTeIcjVKkhS2cTq8+32Qj71yu9y7LbUqOTT9suwIG+F7Egfzns6TIGClu8tMkaxxrfl8JLFxVCXkGX0ojV6P2h3da+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794391790; c=relaxed/relaxed;
	bh=jEhEi9CeTKpVUmtThXx0AkKDXprkxUCaOiZAqez0tQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqZalonhGCth/NXdaZKvpWd/kPSOHICefGOBeanQ/IAClU9Ho95IX9nZ+hlTwCsl1aTuFTCOHi/yDe+RUXpLJ7mkuWWNkFJjVWmQyCmdR1QA6UpJ4eEl3Ov6mgkAsNX04DCToryngt9IKF3vKZiShZR6riiEG97JaxXCWQZT81+oH5+ttcoQDe2Fl2WhIL+Vr5MnzD5Z2RjfS9Gm0839egFOJrEuHc0XWfoTD9jHrBLTptCZji2RF28qSksfKWANCMUbNhXxyjBnvFBFtP9WELAtVK3ZV4kKDTc/jHL1i7bUb6mVFNnRKLvqHoAJzNHY4w6xeeH7Ez2lIttTfUJX5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LQz86sXB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LQz86sXB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPfQP2FJDz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 21:09:48 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iOUu285435;
	Wed, 11 Nov 2026 10:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jEhEi9CeTKpVUmtThXx0AkKDXprkxU
	CaOiZAqez0tQw=; b=LQz86sXB3GnIarAyMjAb8YgUzSwGW0MZ1BrNpoNwec7PAD
	VxF7TR4hH4sC/9FYtwS4f4VwQRM3O4YOSf1EI5NVdPlDAZ6jU8eHXmex8VzaNaRg
	cJ/J+5wJdPRJqMsv0LU5TxQqx6Ks4E3dpPKnvGrqhtKmCr8Prcai908Y5OfPJEoo
	IzDIE7GXQNMAHE3QPcM6fQxTlkLRy94NQnshtfiKUsThfSyJvOMts0B0uzfM5rhT
	ZIFKJ6qKQuixvsUp8Dn6fgNK2F8HrLybHDhOGOJiurewfc9Ir5B4hYR8mf6aBtrG
	+oZ1ZIYEGtQwm7w9hh72dP3OwTEcMkbgpAXpe/jQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq71kg3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 10:09:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB77ocY3005842;
	Wed, 11 Nov 2026 10:09:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0rget-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 10:09:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABA9fNq47645102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 10:09:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F6220049;
	Wed, 11 Nov 2026 10:09:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9260420040;
	Wed, 11 Nov 2026 10:09:39 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Nov 2026 10:09:39 +0000 (GMT)
Date: Wed, 11 Nov 2026 15:48:07 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH] powerpc: Link with -z notext
Message-ID: <20261111145459.6b15a2c5-eb-amachhiw@linux.ibm.com>
Mail-Followup-To: Thomas Huth <thuth@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
 <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
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
In-Reply-To: <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXwaphTl4YCSnO
 lIVRmRYdxR+7sQ48iSfhNJQAaAseUqxKaByAP/rZd9G3svYhiCgTPpd8LK/ygLluhrSmXcFZImx
 UZklAN71fn3d60x7vP23XrfCsZxn5Xo=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af43eea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=GCA8b2iqAg_wZIL1NzYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1WC-CqiRryi4i_MNQ-p0ehpCRyHYwX-H
X-Proofpoint-GUID: 1WC-CqiRryi4i_MNQ-p0ehpCRyHYwX-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX6xvHSqKGOtB1
 XbQ2pYsu6kNxSYOCdI/lNGxonQHL0edTglBmnoFf7jO5JlKRXNrx1/q5VoJVKGJL3OOUhRD8ybv
 YrPMXG3DL4tSaruyvyhh52/oBr8qeJ9+hmt8QwYlNYg1aPxUASsTYF2B9tvT5NlzoQN4/HCwZLv
 NfLsDUoM1GtWUD4QCYLUnkmECJ5KEi7Q3n+WbDhRX9BdSVG/keD/3FyZI49ab5Wa1KYjnkFqKiI
 6aAqGvZrqpLocAoGDOd7IP6k3LZh8GAGTEIfyiRz7HmUuMQl/z6PRszqeY90avOL4sw+WVQd8iN
 r4dsgrjZHlXMxXnHns9srALbr0sN7PZIVO3f7mKmvFNEGY/llKP0vbFOLak7lFYsG+ezrAY7X/f
 eKJAT8Ba58rlW00PMARlW1HviCjW+ogU+1cS8Uzr3S/oq3Ua/AVW6YH8XLOF4q83igyZn5KPnC3
 bkDftLy55drzt3qyKsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110038
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

On 2026/11/11 08:54 AM, Thomas Huth wrote:
> Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
> > Building the powerpc tests with GNU ld 2.46.1 fails when linking the
> > test binaries:
> > 
> >    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
>  Hi!
> 
> This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora
> 44) ... which compiler and distro are you using?

Thanks for checking!

I'm also using the same GNU ld version on Fedora 44 PPC64LE host (more details
are below).  Are you cross compiling on an x86 host by any chance where you are
not seeing this problem?

Assuming that you are, the difference is due to the default linker configuration
between native and cross-compilation packages on Fedora:

On native Fedora 44 ppc64le:
----------------------------
  $ ld --help | grep -E '\-z (no)?text'
    -z text                     Treat DT_TEXTREL in output as error (default)
    -z notext                   Don't treat DT_TEXTREL in output as error
    -z textoff                  Don't treat DT_TEXTREL in output as error

On Fedora x86_64 cross-linker (powerpc64le-linux-gnu-ld):
---------------------------------------------------------
  $ powerpc64le-linux-gnu-ld --help | grep -E '\-z (no)?text'
    -z text                     Treat DT_TEXTREL in output as error
    -z notext                   Don't treat DT_TEXTREL in output as error (default)
    -z textoff                  Don't treat DT_TEXTREL in output as error (default)

Because the cross-linker defaults to `-z notext`, cross-compiling on x86_64
succeeds silently, whereas native builds fail:

  /usr/bin/ld.bfd: error: read-only segment has dynamic relocations

Toolchain & host details (ppc64le native):
------------------------------------------
$ uname -a
Linux fedora 7.3.3-200.fc44.ppc64le #1 SMP PREEMPT_DYNAMIC Fri Nov  6 20:22:11 UTC 2026 ppc64le GNU/Linux

$ ld --version
GNU ld version 2.46.1-1.fc44

Thanks,
Amit

