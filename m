Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334EC43612
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 12:46:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58452176F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 12:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58452176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LBNB54vVzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 23:46:50 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LBKQ4nMwzDqx5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 23:44:26 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5CCC7AE41;
 Thu, 20 Dec 2018 12:44:22 +0000 (UTC)
Date: Thu, 20 Dec 2018 13:44:19 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
Message-ID: <20181220124419.GD9104@dhcp22.suse.cz>
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
 <20181220113547.GC9104@dhcp22.suse.cz>
 <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
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
Cc: "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 20-12-18 20:26:28, Pingfan Liu wrote:
> On Thu, Dec 20, 2018 at 7:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
> > [...]
> > > @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
> > >   */
> > >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> > >  {
> > > -     return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > > +     if (unlikely(!possible_zonelists[nid])) {
> > > +             WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> > > +             if (unlikely(build_fallback_zonelists(nid)))
> > > +                     nid = first_online_node;
> > > +     }
> > > +     return possible_zonelists[nid] + gfp_zonelist(flags);
> > >  }
> >
> > No, please don't do this. We do not want to make things work magically
> 
> For magically, if you mean directly replies on zonelist instead of on
> pgdat struct, then it is easy to change

No, I mean that we _know_ which nodes are possible. Platform is supposed
to tell us. We should just do the intialization properly. What we do now
instead is a pile of hacks that fit magically together. And that should
be changed.

> > and we definitely do not want to put something like that into the hot
> 
> But  the cose of "unlikely" can be ignored, why can it not be placed
> in the path?

unlikely will simply put the code outside of the hot path. The condition
is still there. There are people desperately fighting to get every
single cycle out of the page allocator. Now you want them to pay a
branch which is relevant only for few obscure HW setups.

> > path. We definitely need zonelists to be build transparently for all
> > possible nodes during the init time.
> 
> That is the point, whether the all nodes should be instanced at boot
> time, or not be instanced until there is requirement.

And that should be done at init time. We have all the information
necessary at that time.
-- 
Michal Hocko
SUSE Labs
