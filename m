Return-Path: <linuxppc-dev+bounces-29574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3355BCCA463
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 00:03:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5QCB1SHRz2xyk;
	Fri, 16 Oct 2026 11:03:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792109030;
	cv=none; b=TNVob87BRG9g4Vhh+P9ufovSECToL18agM9v9Ch9BznRAhkXhihmvncq4+aYWt2ZDn/iJptc9zaPl1oYKPd4COOl1lhDuz+9dTAt1VpLvBmc5XIUUtOxODo9caDK18+r3hHlTnrnvQQ9gHaQ70nP3qaKUHcA0GW2NbBreJkuMCkZCMPPTHRk5ZkOgKuyK2Sl81+SbBVRVaJ7NvhIn3F8okKe5e/xDw5iuD0fXVQ6KkuQ3HLJ4Cg3euqr361zWkbj/T9QsYwOqKW+ir+lu7WU8kJmGexSSsZlZ6KV2PMaq3qWPyst7bSfb49bx6hAxdkB2pHfZ0c2pJx9sPffglrKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792109030; c=relaxed/relaxed;
	bh=/J9vkQnHyxosFoJr9W9QBtjq0YYxgnpGBT61RpVtPOM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=JS5MajcR+Yqd4dbOSCVqwu11fUx9U8vogi6/eE8v2tIXUP+W3lP+wVN5Osl5Z8a8ukWEd97Fak3aIu7a2nEFHSwlhMLjQaoBYXqlhkF8uUaryj2RId5Wh+evTAa7b7rQLVi1arjluNnN8vG111Ww3lf/u3EvdeoPAAwaoov6d1WCyvO7Jj61mLzb73K01vzFSv3N8hppIg11dQWgFDU/cDMvWV5qHpTlOFBEwVQzajSc/wWdpwJegzz/JIOaYtmHp+KZL6Nv+y5K7iORaxz7waU8HAMBCMm/gkKeCJO0LZsOVu8cjRNSyrtHMTQ/qAW5o2kFwookGpgGZcY/LdVZLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T8JmhcId; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T8JmhcId;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5QC85XRZz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 11:03:47 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FJSN6v437488;
	Fri, 16 Oct 2026 00:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/J9vkQ
	nHyxosFoJr9W9QBtjq0YYxgnpGBT61RpVtPOM=; b=T8JmhcIdM+IZlDu1hLe31J
	m6mbjwcWL7wzOhkhG48GMAQlsaYPR+qFspy9MtxmiqJAc7tEhHppbNKH9Ly6ZtZV
	VqxL0sG8s2UwXNLFqIJ/BYZUI5pdL3Q7nroUwRsfUZ8NnojGqzqlf4TRT4AYhP4L
	6FIDNuGbJCz0GmEFk/Hg39Qj1dTW+wDF8Je9F6lhuDnTz0Ez1O9eo34NkYGd3QWl
	cZT5GXWip3BeiaEHOopn1erdpxY1LeO4vtBHH3q98w6K3sLk76T90ISRopD52k3Y
	zDVC5jr2MvAZIMwg+xjEXbsZPTVrL2CYSC8Mm8BnPyO6Np9NnZwnVMHA81Yvggnw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwjc4bu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 00:02:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN3x9q1927457;
	Fri, 16 Oct 2026 00:02:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq94xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 00:02:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69G02sUl44827056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 00:02:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18558580DF;
	Fri, 16 Oct 2026 00:02:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36309580E3;
	Fri, 16 Oct 2026 00:02:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.159.15])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Oct 2026 00:02:51 +0000 (GMT)
Message-ID: <2dd935d171066eb4f1c251184eee871ad91f46b4.camel@linux.ibm.com>
Subject: Re: [PATCH] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
        kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, noodles@fb.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu
 <roberto.sassu@huawei.com>
In-Reply-To: <20261014150005.138309-1-roberto.sassu@huaweicloud.com>
References: <20261014150005.138309-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 20:04:39 -0400
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
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA5NCBTYWx0ZWRfX2HSmi+79F5sk
 F6cJ7NPejHB+7WHifxwy2jTNeN+1trz8LY4O/c9Nrxfke0WNdl7j1Q+67s4DKMWPR6esIHz8ktI
 K0tq6WDkqAuHdd5alAeGCbELszv+Iy4JZ0+fqSO/L13P8KVSgc+hLSs0BUMcp1abGeEddTWuQ0x
 DgckQmdPn28cVLNyaRpJNpQgHrkPzvNhtB4BrwiL11DqWhTQ4iKZBnJ6O6YMYp3wIbPkHlbPNTu
 yuFjLtwZNiUnx0o6/TBRUj7JJDZnA2Psv+zNVmANtyZBcqWuyk14cfQgW2Kd9p6jpMvxEPS0i4P
 9izNnrleHEY+3qJ5vxEC5owm2SmqeBCu4OE58PHvT8msLi1bqUTwEmcDI3uhC1lcyvBSJ8AI2/Z
 P4yU5XoeV0+kwIer2DSUzTnv5W4e9/IuU49Yz1D77lWvgRbiAXpcAuzu2CM8QtMFWDh3J7Pn/95
 F6Hddu++a3Zm8l5+F0g==
X-Proofpoint-GUID: NTtm2mgFbtZvv4BT6wKycrFWT1K8ZNoK
X-Proofpoint-ORIG-GUID: tiREeBn2CptRBXexEe4TPGoQAtBFlstP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA5NCBTYWx0ZWRfX/DAorNGlPVs4
 yv5/RElxR2BVrhNGnK8pZHiy6neDZgmPdHp2jFgKzGeIaabQ9Lw8/ORsLJZrcqeRQhQk4Obp43l
 W/UyHe4tHhV1wBc+cnuG7GIYhmkZQRE=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ad169af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=i0EeH86SAAAA:8
 a=oj6d6ukrGZa-rDQ9-ikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150094

Hi Roberto,

On Wed, 2026-10-14 at 17:00 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

The first paragraph should explain the problem from a high level: the user-
visible impact and cause. For example, something like:

=E2=80=9COn x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the devi=
ce tree
implementation of ima_get/free_kexec_buffer(). However, x86 doesn=E2=80=99t=
 pass the IMA
buffer through the device tree, so the buffer is never found and the IMA
measurement log is not carried over across kexec.=E2=80=9D

Then continue with the fix: defining CONFIG_HAVE_IMA_KEXEC_OF and selecting=
 it
only on the architectures that use the device tree implementation.

thanks,

Mimi

>=20
> The ima_get/free_kexec_buffer() device tree implementation relies on the
> arch code calling of_kexec_alloc_and_setup_fdt() to pass the information
> about where the IMA kexec buffer is located. Only the arm64, powerpc and
> riscv architectures support that. LoongArch implicitly assumes that the
> device tree implementation is used, but it does not call that function.

>=20
> The ima_get/free_kexec_buffer() x86 implementation instead still relies o=
n
> the setup data to pass the kexec buffer information, and is built only if
> CONFIG_OF_FLATTREE is not defined.
>=20
> However, if CONFIG_OF_FLATTREE is selected in x86, x86 attempts to use th=
e
> device tree implementations of ima_get/free_kexec_buffer(), which are nev=
er
> going to succeed because of_kexec_alloc_and_setup_fdt() is not called for
> that architecture.
>=20
> Instead, define CONFIG_HAVE_IMA_KEXEC_OF (automatically selects
> HAVE_IMA_KEXEC), select it for the architectures that should use the
> ima_get/free_kexec_buffer() device tree implementation, and enable these
> functions if the new config option is enabled. Set it also on LoongArch, =
to
> preserve the current behavior and avoid a link failure. LoongArch does no=
t
> pass the buffer location to the next kernel yet; this will be addressed
> separately.
>=20
> Finally, don't select it for x86, and use x86's own setup_data-based
> implementation regardless of CONFIG_OF_FLATTREE.
>=20
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kex=
ec")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

