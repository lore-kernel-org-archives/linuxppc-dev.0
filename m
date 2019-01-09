Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E5EC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 13:46:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB704206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 13:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB704206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bluematt.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZVm30vqSzDqb0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 00:46:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bluematt.me
 (client-ip=192.241.179.72; helo=mail.bluematt.me;
 envelope-from=kernel@bluematt.me; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bluematt.me
Received: from mail.bluematt.me (mail.bluematt.me [192.241.179.72])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZVZh1zCyzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 00:38:33 +1100 (AEDT)
Received: from [192.168.0.100] (unknown [69.202.205.58])
 by mail.bluematt.me (Postfix) with ESMTPSA id 62B701201A8;
 Wed,  9 Jan 2019 13:38:29 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug 202149] New: NULL Pointer Dereference in __split_huge_pmd on
 PPC64LE
From: Matt Corallo <kernel@bluematt.me>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <8736q2jbhr.fsf@linux.ibm.com>
Date: Wed, 9 Jan 2019 08:38:28 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <A61367CF-277E-4E74-8A9D-C94C5E53817B@bluematt.me>
References: <bug-202149-27@https.bugzilla.kernel.org/>
 <20190104170459.c8c7fa57ba9bc8a69dee5666@linux-foundation.org>
 <87ef9nk4cj.fsf@linux.ibm.com>
 <ed4bea40-cf9e-89a1-f99a-3dbd6249847f@bluematt.me>
 <8736q2jbhr.fsf@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's normal daily usage on a workstation (TALOS 2). I've seen it at least tw=
ice, both times in rustc, though I've run rustc more times than I can count.=
 Note that the program that triggered it was running in lxc and it only happ=
ened after upgrading to 4.19.

> On Jan 9, 2019, at 06:50, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wr=
ote:
>=20
> Matt Corallo <kernel@bluematt.me> writes:
>=20
>> .config follows. I have not tested with 64K pages as, sadly, I have a=20
>> large BTRFS volume that was formatted on x86, and am thus stuck with 4K=20=

>> pages. Note that this is roughly the Debian kernel, so it has whatever=20=

>> patches Debian defaults to applying, a list of which follows.
>>=20
>=20
> What is the test you are running? I tried a 4K page size config on P9. I
> am running ltp test suite there. Also tried few thp memremap tests.
> Nothing hit that.
>=20
> root@:~/tests/ltp/testcases/kernel/mem/thp# getconf  PAGESIZE
> 4096
> root@ltc-boston123:~/tests/ltp/testcases/kernel/mem/thp# grep thp /proc/vm=
stat=20
> thp_fault_alloc 641141
> thp_fault_fallback 0
> thp_collapse_alloc 90
> thp_collapse_alloc_failed 0
> thp_file_alloc 0
> thp_file_mapped 0
> thp_split_page 1
> thp_split_page_failed 0
> thp_deferred_split_page 641150
> thp_split_pmd 24
> thp_zero_page_alloc 1
> thp_zero_page_alloc_failed 0
> thp_swpout 0
> thp_swpout_fallback 0
> root@:~/tests/ltp/testcases/kernel/mem/thp#=20
>=20
> -aneesh
>=20

