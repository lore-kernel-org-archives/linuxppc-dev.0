Return-Path: <SRS0=clhE=XY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094CFC4360C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Sep 2019 23:21:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB3B20863
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Sep 2019 23:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YjWTNeT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB3B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46hM3P46k0zDqQK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 09:21:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.65; helo=hqemgate16.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="YjWTNeT0"; 
 dkim-atps=neutral
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46hM1l3rbszDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2019 09:19:39 +1000 (AEST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d913c0e0000>; Sun, 29 Sep 2019 16:19:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 29 Sep 2019 16:19:35 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 29 Sep 2019 16:19:35 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Sep
 2019 23:19:35 +0000
Received: from [10.2.173.141] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Sep
 2019 23:19:34 +0000
Subject: Re: [PATCH v4 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
From: John Hubbard <jhubbard@nvidia.com>
To: Leonardo Bras <leonardo@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-2-leonardo@linux.ibm.com>
 <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f8fca251-e31a-1d50-49e9-e69a893d9059@nvidia.com>
Date: Sun, 29 Sep 2019 16:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4ff1e8e8-929b-9cfc-9bf8-ee88e34de888@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1569799183; bh=cuUpAejunirY1oVB4xqJhAFbQh4uc7B1ykg3wBoKKZs=;
 h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=YjWTNeT0CKiy9o+jGIp6KtWT7AvUC9MjQefsgmJQTtk7jdKDbA6WjFQ9JoKMOVBVx
 6C7SwiTGmjYkn5+tZPcgR0XtRz7TfihkWkQORs+3CDC+f0s8P4fPbHRlQl7oe3HAZW
 nrxf5kbcgk+ker4DiB23UJ2izp3Os3fz8miMQxXdGrwPK8X5Lt+idjpD6foHYfWZVr
 w3ztaYXbj0fG9ryOzoGhDspATQNBZuyoeb3i/cvNce3LrgwKUfLxo5qJNZT3gtZsI4
 NOz4ZBOs6z/j4VuUFKxFcU1NF9kxF4C22OplZjoArvqsyPljPn2jofEe5dcLYmdJe5
 CuLqlhxPTaTCA==
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
Cc: Keith Busch <keith.busch@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 9/29/19 3:40 PM, John Hubbard wrote:
> On 9/27/19 4:39 PM, Leonardo Bras wrote:
...
> +config LOCKLESS_PAGE_TABLE_WALK_TRACKING
> +=C2=A0=C2=A0=C2=A0 bool "Tracking (and optimization) of lockless page ta=
ble walkers"
> +=C2=A0=C2=A0=C2=A0 default n
> +
> +=C2=A0=C2=A0=C2=A0 help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Maintain a reference count of active lock=
less page table
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 walkers. This adds 4 bytes to struct mm s=
ize, and two atomic
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 operations to calls such as get_user_page=
s_fast(). Some
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 architectures can optimize page table ope=
rations if this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is enabled.
> +
>  =C2=A0endmenu

Actually, the above should be an internal-only config option (PPC arch can
auto-select it), so just:

+config LOCKLESS_PAGE_TABLE_WALK_TRACKING
+	bool

...because it's entirely up to other code (as opposed to other people)
as to whether this should be selected.

I got carried away. :)

thanks,
--=20
John Hubbard
NVIDIA
