Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C10EC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:45:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A4320882
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 23:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A4320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ym6z32vszDqQZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:45:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=stgolabs.net
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dave@stgolabs.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=stgolabs.net
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ym5B427WzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 10:44:12 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1ED2DAC8D;
 Tue,  2 Apr 2019 23:44:08 +0000 (UTC)
Date: Tue, 2 Apr 2019 16:43:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190402234357.tn3tik4r7k6nbrau@linux-r8p5>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Lameter <cl@linux.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
User-Agent: NeoMutt/20180323
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
Cc: kvm@vger.kernel.org, Alan Tull <atull@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 02 Apr 2019, Andrew Morton wrote:

>Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
>thinking that the benefit of removing a few mmap_sem-takings from a few
>obscure drivers (sorry ;)) is pretty small.

afaik porting the remaining incorrect users of locked_vm to pinned_vm was
the next step before this one, which made converting locked_vm to atomic
hardly worth it. Daniel?

Thanks,
Davidlohr
