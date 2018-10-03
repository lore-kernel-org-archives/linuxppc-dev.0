Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E9FC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 07:25:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C572089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 07:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C572089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q6xl6BB6zF0QC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 17:25:47 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q6vM3Q1kzF3C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 17:23:42 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6735FAFF6;
 Wed,  3 Oct 2018 07:03:23 +0000 (UTC)
Date: Wed, 3 Oct 2018 09:03:20 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
Message-ID: <20181003070320.GE18290@dhcp22.suse.cz>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
 <20181002145922.GZ18290@dhcp22.suse.cz>
 <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
 <20181002160446.GA18290@dhcp22.suse.cz>
 <e7dd66c1-d196-3a14-0115-acdaf538ebfd@linux.vnet.ibm.com>
 <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
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
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue 02-10-18 12:45:50, Tyrel Datwyler wrote:
> On 10/02/2018 11:13 AM, Michael Bringmann wrote:
> > 
> > 
> > On 10/02/2018 11:04 AM, Michal Hocko wrote:
> >> On Tue 02-10-18 10:14:49, Michael Bringmann wrote:
> >>> On 10/02/2018 09:59 AM, Michal Hocko wrote:
> >>>> On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
> >>>> [...]
> >>>>> When the device-tree affinity attributes have changed for memory,
> >>>>> the 'nid' affinity calculated points to a different node for the
> >>>>> memory block than the one used to install it, previously on the
> >>>>> source system.  The newly calculated 'nid' affinity may not yet
> >>>>> be initialized on the target system.  The current memory tracking
> >>>>> mechanisms do not record the node to which a memory block was
> >>>>> associated when it was added.  Nathan is looking at adding this
> >>>>> feature to the new implementation of LMBs, but it is not there
> >>>>> yet, and won't be present in earlier kernels without backporting a
> >>>>> significant number of changes.
> >>>>
> >>>> Then the patch you have proposed here just papers over a real issue, no?
> >>>> IIUC then you simply do not remove the memory if you lose the race.
> >>>
> >>> The problem occurs when removing memory after an affinity change
> >>> references a node that was previously unreferenced.  Other code
> >>> in 'kernel/mm/memory_hotplug.c' deals with initializing an empty
> >>> node when adding memory to a system.  The 'removing memory' case is
> >>> specific to systems that perform LPM and allow device-tree changes.
> >>> The powerpc kernel does not have the option of accepting some PRRN
> >>> requests and accepting others.  It must perform them all.
> >>
> >> I am sorry, but you are still too cryptic for me. Either there is a
> >> correctness issue and the the patch doesn't really fix anything or the
> >> final race doesn't make any difference and then the ppc code should be
> >> explicit about that. Checking the node inside the hotplug core code just
> >> looks as a wrong layer to mitigate an arch specific problem. I am not
> >> saying the patch is a no-go but if anything we want a big fat comment
> >> explaining how this is possible because right now it just points to an
> >> incorrect API usage.
> >>
> >> That being said, this sounds pretty much ppc specific problem and I
> >> would _prefer_ it to be handled there (along with a big fat comment of
> >> course).
> > 
> > Let me try again.  Regardless of the path to which we get to this condition,
> > we currently crash the kernel.  This patch changes that to a WARN_ON notice
> > and continues executing the kernel without shutting down the system.  I saw
> > the problem during powerpc testing, because that is the focus of my work.
> > There are other paths to this function besides powerpc.  I feel that the
> > kernel should keep running instead of halting.
> 
> This is still basically a hack to get around a known race. In itself
> this patch is still worth while in that we shouldn't crash the kernel
> on a null pointer dereference. However, I think the actual problem
> still needs to be addressed. We shouldn't run any PRRN events for the
> source system on the target after a migration. The device tree update
> should have taken care of telling us about new affinities and what
> not. Can we just throw out any queued PRRN events when we wake up on
> the target?

And until a proper fix is developed can we have NODE_DATA test in the
affected code rather than pollute the generic code with something that
is essentially a wrong usage of the API? With a big fat warning
explaining what is going on here?
-- 
Michal Hocko
SUSE Labs
