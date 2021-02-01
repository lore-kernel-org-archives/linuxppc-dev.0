Return-Path: <SRS0=IXH7=HD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC0FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Feb 2021 13:19:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5178660C41
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Feb 2021 13:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5178660C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DTpSj5nwJzDrTH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Feb 2021 00:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mbenes@suse.cz;
 receiver=<UNKNOWN>)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DTpNx5GQ0zDrQV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 00:16:16 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5380CAE9A;
 Mon,  1 Feb 2021 13:16:13 +0000 (UTC)
Date: Mon, 1 Feb 2021 14:16:12 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 04/13] module: use RCU to synchronize find_module
In-Reply-To: <YBfvvdna9pSeu+1g@gunter>
Message-ID: <alpine.LSU.2.21.2102011415290.21637@pobox.suse.cz>
References: <20210128181421.2279-1-hch@lst.de>
 <20210128181421.2279-5-hch@lst.de>
 <alpine.LSU.2.21.2101291626080.22237@pobox.suse.cz> <YBfvvdna9pSeu+1g@gunter>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, linux-kbuild@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Masahiro Yamada <masahiroy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 live-patching@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Vetter <daniel@ffwll.ch>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Feb 2021, Jessica Yu wrote:

> +++ Miroslav Benes [29/01/21 16:29 +0100]:
> >On Thu, 28 Jan 2021, Christoph Hellwig wrote:
> >
> >> Allow for a RCU-sched critical section around find_module, following
> >> the lower level find_module_all helper, and switch the two callers
> >> outside of module.c to use such a RCU-sched critical section instead
> >> of module_mutex.
> >
> >That's a nice idea.
> >
> >> @@ -57,7 +58,7 @@ static void klp_find_object_module(struct klp_object
> >> *obj)
> >>   if (!klp_is_module(obj))
> >>    return;
> >>
> >> -	mutex_lock(&module_mutex);
> >> +	rcu_read_lock_sched();
> >>   /*
> >>    * We do not want to block removal of patched modules and therefore
> >>    * we do not take a reference here. The patches are removed by
> >> @@ -74,7 +75,7 @@ static void klp_find_object_module(struct klp_object
> >> *obj)
> >>   if (mod && mod->klp_alive)
> >
> >RCU always baffles me a bit, so I'll ask. Don't we need
> >rcu_dereference_sched() here? "mod" comes from a RCU-protected list, so I
> >wonder.
> 
> Same here :-) I had to double check the RCU documentation. For our
> modules list case I believe the rcu list API should take care of that
> for us. Worth noting is this snippet from Documentation/RCU/whatisRCU.txt:
> 
>    rcu_dereference() is typically used indirectly, via the _rcu
>    list-manipulation primitives, such as list_for_each_entry_rcu()

Ok, thanks to both for checking and explanation.

Ack to the patch then.

Miroslav
