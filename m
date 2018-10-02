Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3623C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:07:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698F520666
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698F520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PkYd2sfgzF3HC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 02:07:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PkWD31xgzF37M
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 02:04:55 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 058C9AED5;
 Tue,  2 Oct 2018 16:04:51 +0000 (UTC)
Date: Tue, 2 Oct 2018 18:04:46 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
Message-ID: <20181002160446.GA18290@dhcp22.suse.cz>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
 <20181002145922.GZ18290@dhcp22.suse.cz>
 <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue 02-10-18 10:14:49, Michael Bringmann wrote:
> On 10/02/2018 09:59 AM, Michal Hocko wrote:
> > On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
> > [...]
> >> When the device-tree affinity attributes have changed for memory,
> >> the 'nid' affinity calculated points to a different node for the
> >> memory block than the one used to install it, previously on the
> >> source system.  The newly calculated 'nid' affinity may not yet
> >> be initialized on the target system.  The current memory tracking
> >> mechanisms do not record the node to which a memory block was
> >> associated when it was added.  Nathan is looking at adding this
> >> feature to the new implementation of LMBs, but it is not there
> >> yet, and won't be present in earlier kernels without backporting a
> >> significant number of changes.
> > 
> > Then the patch you have proposed here just papers over a real issue, no?
> > IIUC then you simply do not remove the memory if you lose the race.
> 
> The problem occurs when removing memory after an affinity change
> references a node that was previously unreferenced.  Other code
> in 'kernel/mm/memory_hotplug.c' deals with initializing an empty
> node when adding memory to a system.  The 'removing memory' case is
> specific to systems that perform LPM and allow device-tree changes.
> The powerpc kernel does not have the option of accepting some PRRN
> requests and accepting others.  It must perform them all.

I am sorry, but you are still too cryptic for me. Either there is a
correctness issue and the the patch doesn't really fix anything or the
final race doesn't make any difference and then the ppc code should be
explicit about that. Checking the node inside the hotplug core code just
looks as a wrong layer to mitigate an arch specific problem. I am not
saying the patch is a no-go but if anything we want a big fat comment
explaining how this is possible because right now it just points to an
incorrect API usage.

That being said, this sounds pretty much ppc specific problem and I
would _prefer_ it to be handled there (along with a big fat comment of
course).
-- 
Michal Hocko
SUSE Labs
