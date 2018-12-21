Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9099C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:21:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6036A21903
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COdD2YH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6036A21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ldmv1g3tzDqY6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:21:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="COdD2YH8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="COdD2YH8"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LdjG1q6BzDrBp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 17:18:09 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id y20so3726328edw.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 22:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z2FHmaBlflrf9QUQop5IgR5jIVNSrnKow3guJqFNBp8=;
 b=COdD2YH8/h3nimEm7utrbsKg4Ml7JYcY9DfP8E4scwbaGpuJsKCz3axXxnQG7d69l1
 iL3X8SQvyHRMbjCOZCMIocN9XR15PQllEuE4eo8XEU65Zx9bLCMJKjzSxLewFESRJFx4
 T77p1L0xMiGDxr4ZnpW7k7s0TP2FX5yXCwa0jiz5n5LHM5gJQkz1NqibcdKz0oqX8YwO
 ofRZu1KW+GwS7VkjKjsFHKByVkwclMRes1Q9IlluMx95VQuNcR0LkO9Qd7RYZ2Wt4yiZ
 B1gso9GMg0VbAatszoGRHbQz6WeXiLzFYztoLdNARRl8GpqZTbNeUeH7brzySblK7yna
 50nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z2FHmaBlflrf9QUQop5IgR5jIVNSrnKow3guJqFNBp8=;
 b=hBa5uUwZhLKODO05dfXe9BY+5OJH5tCJsMDcu5rckvw2YXdFdCkE+DH22mfbn+0xMJ
 MR7JC2ovg7Nc/EzF9C6XCSFxogPJ0tBABRELNhT4cgTFP/RD49oLmHIvZ3/cQeY+fWpp
 MNoRy8G+G9NZnpjJWWTrF8rcsw161KVYyvf10rPm4XBtR4Wv7AR54XiokMZmZ1pd77LQ
 MY40iTGkcBCRkBVDKMUy1yPkkd2uL0tngWtoarUKGGQz0J78Rk6kLms96DQrLMSXU7Ig
 GKYOzniiymJzc8GsYkWe8ieWBeUYlhzYqKIq4SHqd9+QRl05Imz4oBRrGiFNeS/egrj7
 d2sA==
X-Gm-Message-State: AA+aEWb1zbtAn0ToOAFDh7cniW48wYrPLCN0Zq3BgdDIqokBskfiYYn+
 ihXehABvPBwC4AZaMpike7+5hfVmAbAE4n12uw==
X-Google-Smtp-Source: AFSGD/W295SA9uQLpCCc6OGp9eUjomqYd0htfZ7bydooizYHZi08nl66rQowi+RjD57V5T1tJ+ZpnXngOinhdNwztpM=
X-Received: by 2002:a50:9feb:: with SMTP id c98mr1312405edf.253.1545373086325; 
 Thu, 20 Dec 2018 22:18:06 -0800 (PST)
MIME-Version: 1.0
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
 <20181220113547.GC9104@dhcp22.suse.cz>
 <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
 <20181220124419.GD9104@dhcp22.suse.cz>
In-Reply-To: <20181220124419.GD9104@dhcp22.suse.cz>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 21 Dec 2018 14:17:54 +0800
Message-ID: <CAFgQCTsTTQLyEr6NG4QvpYuuovathge6t+1ej_1edkGCai-jXw@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
To: Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Dec 20, 2018 at 8:44 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 20-12-18 20:26:28, Pingfan Liu wrote:
> > On Thu, Dec 20, 2018 at 7:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
> > > [...]
> > > > @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
> > > >   */
> > > >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> > > >  {
> > > > -     return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > > > +     if (unlikely(!possible_zonelists[nid])) {
> > > > +             WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> > > > +             if (unlikely(build_fallback_zonelists(nid)))
> > > > +                     nid = first_online_node;
> > > > +     }
> > > > +     return possible_zonelists[nid] + gfp_zonelist(flags);
> > > >  }
> > >
> > > No, please don't do this. We do not want to make things work magically
> >
> > For magically, if you mean directly replies on zonelist instead of on
> > pgdat struct, then it is easy to change
>
> No, I mean that we _know_ which nodes are possible. Platform is supposed
> to tell us. We should just do the intialization properly. What we do now
> instead is a pile of hacks that fit magically together. And that should
> be changed.
>
Not agree. Here is the typical lazy to do, and at this point there is
also possible node info for us to check and build pgdat instance.

> > > and we definitely do not want to put something like that into the hot
> >
> > But  the cose of "unlikely" can be ignored, why can it not be placed
> > in the path?
>
> unlikely will simply put the code outside of the hot path. The condition
> is still there. There are people desperately fighting to get every
> single cycle out of the page allocator. Now you want them to pay a
> branch which is relevant only for few obscure HW setups.
>
Data is more convincing.
I test with the following program  built with -O2 on x86. No
observable performance difference between adding an extra unlikely
condition. And it is apparent that the frequency of checking on
unlikely is much higher than my patch.
#include <stdio.h>
#define unlikely_notrace(x)     __builtin_expect(!!(x), 0)
#define unlikely(x) unlikely_notrace(x)
#define TEST_UNLIKELY 1
int main(int argc, char *argv[])
{
        unsigned long i,j;
        unsigned long end = (unsigned long)1 << 36;
        unsigned long x = 9;
        for (i = 1; i < end; i++) {
#ifdef TEST_UNLIKELY
                if (unlikely(i == end - 1))
                        x *= 8;
#endif
                x *= i;
                x = x%100000 + 1;
        }
        return 0;
}

> > > path. We definitely need zonelists to be build transparently for all
> > > possible nodes during the init time.
> >
> > That is the point, whether the all nodes should be instanced at boot
> > time, or not be instanced until there is requirement.
>
> And that should be done at init time. We have all the information
> necessary at that time.
> --

Will see other guys' comment.

Thanks and regards,
Pingfan
