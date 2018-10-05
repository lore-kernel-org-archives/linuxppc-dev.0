Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDD5C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:14:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853F42084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853F42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RYG059PyzF3ZD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 01:14:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RY9Z0YXyzF3TV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 01:10:57 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w95F5Ku0133595
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Oct 2018 11:10:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mx91gd8ju-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 11:10:55 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Fri, 5 Oct 2018 16:05:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 5 Oct 2018 16:05:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w95F5h3u63897732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Oct 2018 15:05:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D453AE045;
 Fri,  5 Oct 2018 18:04:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C216EAE051;
 Fri,  5 Oct 2018 18:04:32 +0100 (BST)
Received: from [9.148.204.169] (unknown [9.148.204.169])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  5 Oct 2018 18:04:32 +0100 (BST)
Date: Fri, 05 Oct 2018 18:05:01 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
 <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100515-0020-0000-0000-000002D00A38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100515-0021-0000-0000-0000211E6102
Message-Id: <59C9470E-F718-4A11-BC65-FD68901723AC@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-05_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=701 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050153
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>,
 linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On October 5, 2018 6:25:38 AM GMT+03:00, Benjamin Herrenschmidt <benh@kern=
el=2Ecrashing=2Eorg> wrote:
>On Fri, 2018-10-05 at 00:07 +0300, Mike Rapoport wrote:
>> When a memblock allocation APIs are called with align =3D 0, the
>alignment is
>> implicitly set to SMP_CACHE_BYTES=2E
>>=20
>> Replace all such uses of memblock APIs with the 'align' parameter
>explicitly
>> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
>> memblock internal allocation functions=2E
>>=20
>> For the case when memblock APIs are used via helper functions, e=2Eg=2E
>like
>> iommu_arena_new_node() in Alpha, the helper functions were detected
>with
>> Coccinelle's help and then manually examined and updated where
>appropriate=2E
>>=20
>> The direct memblock APIs users were updated using the semantic patch
>below:
>
>What is the purpose of this ? It sounds rather counter-intuitive=2E=2E=2E

Why?
I think it actually more intuitive to explicitly set alignment to SMP_CACH=
E_BYTES rather than use align =3D 0 because deeply inside allocator it will=
 be implicitly reset to SMP_CACHE_BYTES=2E=2E=2E

>Ben=2E

--=20
Sincerely yours,
Mike=2E

