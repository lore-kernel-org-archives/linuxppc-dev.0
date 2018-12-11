Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF567C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 03:44:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A8B2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 03:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A8B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DQmr3qH6zDqyv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:44:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=bhe@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DQkH46tbzDqwF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 14:42:26 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FF323082193;
 Tue, 11 Dec 2018 03:42:24 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E707219C7F;
 Tue, 11 Dec 2018 03:42:21 +0000 (UTC)
Date: Tue, 11 Dec 2018 11:42:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: Is it worth to fix the crashkernel reserved memory blocks the
 hotplug issue?
Message-ID: <20181211034218.GN17340@MiWiFi-R3L-srv>
References: <CAFgQCTsn-v_OKWi72Fa1z0+8hOrSQr1UtoDGm2Ngrj_1GbscHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTsn-v_OKWi72Fa1z0+8hOrSQr1UtoDGm2Ngrj_1GbscHA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 11 Dec 2018 03:42:24 +0000 (UTC)
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
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/10/18 at 12:08pm, Pingfan Liu wrote:
> Hi,
> I found in powerpc code, it is doable to reserve memory region in
> movable zone, such as crashkernel does. But in x86 code, it checks the
> hotpluggable attribute of memory, hence if manually specifying a
> region in hotpluggable region, it will fail.

Yes, it is a problem. In x86, for crashkernel=xx@yy case to specify base
address of crashkernel reservation, it will find the region firstly, if
found region's base is not equal to specified base 'yy', means that
region has been occupied. The reservation will fail. And memblock
finding will only iterate unhotpluggable area, this will avoid reserving
crashkernel memory on hotpluggable region. 

In my opinion, it's worth fixing.

Thanks
Baoquan


> The x86 code:
> /* 0 means: find the address automatically */
> if (crash_base <= 0) {
> /*
> * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> * as old kexec-tools loads bzImage below that, unless
> * "crashkernel=size[KMG],high" is specified.
> */
> crash_base = memblock_find_in_range(CRASH_ALIGN,
>    high ? CRASH_ADDR_HIGH_MAX
> : CRASH_ADDR_LOW_MAX,
>    crash_size, CRASH_ALIGN);
> if (!crash_base) {
> pr_info("crashkernel reservation failed - No suitable area found.\n");
> return;
> }
> 
> } else {
> unsigned long long start;
> 
> start = memblock_find_in_range(crash_base,  --> this func will check
> the hotpluggable attribute of memory and return failure if the
> specifying region intersects with it.
>       crash_base + crash_size,
>       crash_size, 1 << 20);
> if (start != crash_base) {
> pr_info("crashkernel reservation failed - memory is in use.\n");
> return;
> }
> }
> 
> Thanks,
> Pingfan
