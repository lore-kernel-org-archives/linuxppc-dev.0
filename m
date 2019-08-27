Return-Path: <SRS0=ZD8a=WX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C3C3A5A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 07:20:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BDC206BF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 07:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BDC206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HgJH1vQYzDqT1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 17:20:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HgFt0xCbzDqtn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 17:18:25 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C36DBAF37;
 Tue, 27 Aug 2019 07:18:22 +0000 (UTC)
Date: Tue, 27 Aug 2019 09:18:21 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Perform a bounds check in arch_add_memory
Message-ID: <20190827071821.GS7538@dhcp22.suse.cz>
References: <20190827052047.31547-1-alastair@au1.ibm.com>
 <20190827062844.GQ7538@dhcp22.suse.cz>
 <ea9e43fff6b6531af0620f9df62e015af66d4535.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9e43fff6b6531af0620f9df62e015af66d4535.camel@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue 27-08-19 16:39:56, Alastair D'Silva wrote:
> On Tue, 2019-08-27 at 08:28 +0200, Michal Hocko wrote:
> > On Tue 27-08-19 15:20:46, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > It is possible for firmware to allocate memory ranges outside
> > > the range of physical memory that we support (MAX_PHYSMEM_BITS).
> > 
> > Doesn't that count as a FW bug? Do you have any evidence of that in
> > the
> > field? Just wondering...
> > 
> 
> Not outside our lab, but OpenCAPI attached LPC memory is assigned
> addresses based on the slot/NPU it is connected to. These addresses
> prior to:
> 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to 2PB")
> were inaccessible and resulted in bogus sections - see our discussion
> on 'mm: Trigger bug on if a section is not found in __section_nr'.

Please document this in the changelog

-- 
Michal Hocko
SUSE Labs
