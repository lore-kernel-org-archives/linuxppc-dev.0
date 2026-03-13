Return-Path: <linuxppc-dev+bounces-18162-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A9F106FD97
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 07:27:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXGKg1G94z3cJk;
	Fri, 13 Mar 2026 18:27:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773386871;
	cv=none; b=Vo2qSrgMIUl/UgVKmXa73kaHBMKd4vD97dVklbuR5FyQWWGnU/oQ/REKJcH1P7CCY7vHKBAVoDUzxRbDiU/++b8gZaNG/ZCRmmeajuQk9BjzYqMlvwf4Qy6vuN0v/VfBUJDcBYf1MLGhBrdXPjy1b3aQX3/8k48WKE9HXA2yR7Igl6syARJp1fCen1W0XAq7gz90Kcob6Oit0a/t48UL8SOWtn11LMa69EqdRTavC/RmKkHjAPm3EcyVRGYHp8ZADhGVzhFmQIzALnvGmrEJxw2DVwJN3+lNwZfsBFyeRUgjENwjyJfyffPUZufK/+20/QtgjYp6/23QuX0Tby64UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773386871; c=relaxed/relaxed;
	bh=iAenRQtYFFXZgQjstRc4Jy6sCLPp0tS71T2Ij/xkLAI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c6fYaxk9fEduuMkbD19zP9wx7QzTabfoXSeoDIEebVNXhTDSRiBqYlY8CTL5PlfSU26MJ+k7iUp1TlUg0+KQFPhetzSe6/0M5Xkgx+KFOdnDnYVoVxnCn2l8ClHfZrOMYcwQ7pr11GYcZcvIfDHB5AxKS3QdsqtCBhnzKyJ7DaVMsTiTVIJI/n7HcYeMFA9nBf58K0ZnG/Cdx2TUHdxIoY7c1f7tlFesALgHM7OeVvJi7Z6SkCxyeWHhlmnA9ZdC2i9PekabnnqWkRsyeU1JnNaf8Ii/tCaPqwjOd4eHbQpfq8D84kiYMI8UVDjE7stHS4hwChTGTIPpvUodwHxyhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKEp4ZvE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKEp4ZvE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXGKd4DCxz3cGM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 18:27:49 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4Xw982581620;
	Fri, 13 Mar 2026 07:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iAenRQ
	tYFFXZgQjstRc4Jy6sCLPp0tS71T2Ij/xkLAI=; b=qKEp4ZvEBqxRVikttbrntF
	WWQ203Lua+crG05r6VAtBa0/bkbghmmMFp7CSi/eBIF8c/7Umd/HOwFvOAsO3Bwk
	aOBgWBWDw8W+mnEpWmbvnXwY/B07gZFUhhEy0+PmOo4+nhj+vNUP2Mww72hck3CU
	oIrRFe39/axbwiM28eqxsn3HpLE/8mBQrBshD4Tns0yNyBzWAojtrHyDUdOYkUj+
	NRjFuEzjs+AXjzld4+GB4tMgSyZ0r067coC5jcB34vhdrtLl2fEmeMG6fd/YxZKQ
	KospVEVdZE7lQq3MtjpUTVu5IsJIFKd+oBdxAUl4XWHZdZKnA66Bjj0g4dlyCX3A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94xn7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:23:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D4u7OK025674;
	Fri, 13 Mar 2026 07:23:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8dnmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:23:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D7Ncwu19268138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 07:23:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CABA158043;
	Fri, 13 Mar 2026 07:23:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 098B658053;
	Fri, 13 Mar 2026 07:23:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.43])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 07:23:34 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] powerpc/xive: fix kmemleak caused by incorrect chip_data
 lookup
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <878qbw5lfb.fsf@yellow.woof>
Date: Fri, 13 Mar 2026 12:53:22 +0530
Cc: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
        ritesh.list@gmail.com, gautam@linux.ibm.com, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3269117-075D-481E-AFD2-D4AE703C8EF2@linux.ibm.com>
References: <20260311134336.326996-1-nilay@linux.ibm.com>
 <878qbw5lfb.fsf@yellow.woof>
To: Nam Cao <namcao@linutronix.de>, Nilay Shroff <nilay@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b3bb7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=f1nbpkWOvNJN98Hr3BgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NSBTYWx0ZWRfX0c3fQme1dENq
 YrcBizyhRLpCW5TXMdEUMGtZCAd9tj8u3CjW/vv3XNMk2GVeRKHtghkuIrkPC+f96aOZuAh6wCR
 icjsi8tZxP7ukmc41XkSvTh6XFTDAC7KKrFu25zAPV/fyBA6gsm0VKVBGf/18PlyAgQXTtFg09G
 wIxHEB28IsFfkks5xSgRiW4tKANX4e4CP7eRPbJwCRU/pg99fU21rNkl76VfUviZXB8DowGAxNz
 QdMsL/NuvDZVF7Aw2qQKSrUyyK5r+C6AGLCv1t4b+b84crTyItAs+SIB05vgORtCICvdz40r0wd
 SEJdhTR4LelqdVGNV0Kzqe16hy02Moavo2G7e0A2Ku1nOdfnAG1t5w1mK1uSixqMmwIkn+5L7do
 UWKBfTcw9KnEji5dAb/Bcxu5BWT2W1c7gLj3dzg/tFgFDs1o6csR3OTgexE1P+pRBcpKr+FYvqw
 Qdf00CbosAV6Lwf8avA==
X-Proofpoint-ORIG-GUID: VcDjfrF1Vbhv5Eu-Xo1_Va33LsTkOq-G
X-Proofpoint-GUID: 7GB6S0IcmAyA1Q_LC7OwYbR91m6gc0ab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130055



> On 13 Mar 2026, at 11:18=E2=80=AFAM, Nam Cao <namcao@linutronix.de> =
wrote:
>=20
> Nilay Shroff <nilay@linux.ibm.com> writes:
>> The kmemleak reports the following memory leak:
> ...
>> Fix this by retrieving the irq_data from the correct domain using
>> irq_domain_get_irq_data() and then accessing the chip_data via
>> irq_data_get_irq_chip_data().
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child =
interrupt controller drivers")
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Hi,


I have tested this patch, and it fixes the reported kmemleak issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Below is the kmemleak output without this patch applied:

cat /sys/kernel/debug/kmemleak
unreferenced object 0xc00000000606fc80 (size 64):
  comm "kworker/0:1", pid 11, jiffies 4294937450
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 ab 0d 00 04 00 00  ................
    00 00 a1 80 00 00 0a c0 00 00 aa 0d 00 04 00 00  ................
  backtrace (crc 642b8a1d):
    __kmalloc_cache_noprof+0x350/0x7a4
    xive_irq_alloc_data.constprop.0+0x40/0xe0
    xive_irq_domain_alloc+0xd4/0x1ac
    irq_domain_alloc_irqs_parent+0x44/0x6c
    pseries_irq_domain_alloc+0x1c4/0x34c
    irq_domain_alloc_irqs_parent+0x44/0x6c
    msi_domain_alloc+0xb0/0x214
    irq_domain_alloc_irqs_locked+0x138/0x4d0
    __irq_domain_alloc_irqs+0x8c/0xfc
    __msi_domain_alloc_irqs+0x214/0x4c8
    msi_domain_alloc_irqs_all_locked+0x70/0xf8
    pci_msi_setup_msi_irqs+0x60/0x78
    msix_setup_interrupts+0x17c/0x318
    __pci_enable_msix_range+0x41c/0x770
    pci_alloc_irq_vectors_affinity+0x170/0x1d8
    nvme_pci_enable+0xa0/0x3b0 [nvme]

unreferenced object 0xc00000000606f900 (size 64):
  comm "kworker/0:1", pid 11, jiffies 4294937451

With the patch applied, no kmemleak reports are observed after repeated =
MSI=E2=80=91X enable/disable cycles on the NVMe controller.

Regards,
Venkat
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20


