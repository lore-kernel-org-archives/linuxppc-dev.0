Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E767C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 12:30:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D36021852
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 12:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmS8HOvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D36021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LB1M4pD3zDqsW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 23:30:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pmS8HOvQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pmS8HOvQ"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L9wz5NJ6zDql8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 23:26:43 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id h15so1583408edb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R4a5LGFdoY5XJf8K5/zF3Zn4wAJbZoJB4Ksv/i71lR8=;
 b=pmS8HOvQ99RyxXZv8Um0Dln2oVyXCzZzos0yDFrUuaAEJ2kXKJ9Ku3kIjGPqHo/LGU
 WetslvwId951YXveHiOIV8YVVN8BjF16781aCM21Rgk3wUUeoWCBmn1YRcKzu1HtJZ9l
 FLLO5mTeSJIYTv0kX2eLSof4sVTNItnoYfrXh69fl4sBmfudIjd9WV1XNpdt139rEmG7
 Lme39o7J6AXWplKSKr3tVL3CJbn6iDeBImXQ3iIMWXlMoWq0ZVNqA2tGxSpdtGqjxRdo
 na9s9cMzoexp0OzMB2JSHdI7ImTrf/0hfwJ/d9X57QL88JqDQcg3N3byEC/+6N+spZXr
 QMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R4a5LGFdoY5XJf8K5/zF3Zn4wAJbZoJB4Ksv/i71lR8=;
 b=Sab0HbQ5SNAjh2Co+ErrOjYKLCpLrh0lqJLU4Kdi7el05HQMRJr4LNcd5VQWKi0IKp
 wGWDPkEAHPzRtsXtwn9tpaqULn9QvceQ4XeczPvoVDfyRdmsa5VfsDbxBafIgOkEll5S
 w827VShCfvwixc6mxBIF8FwN9RWl+dvfYWknRmvwiBsVSDV1DhEgHss/d1mIj6Xli1pn
 rZsyIdpENAASvx5X7Zk4zRaOO/gA4Eyf3Bqrw7I6UKDJdaay3LXtv8uw3aqvpOgjkNHF
 q/vxIknxbjeMzgpjVH9Dbv2o0vonnYzpowh4bWYQdFhhJidMe5LqnCtbJHkT4iX/ZO/A
 u7eQ==
X-Gm-Message-State: AA+aEWZhYJVXGiZJmIXh/Clk+DHJax4XVHmcswWE7Hp3he50XJlgRrmr
 cYR8GL4wnlzK7qKPBp7CPQLdzsDXX+izsLjnKw==
X-Google-Smtp-Source: AFSGD/X0JdX1/FF5gw5aLqyJFharMVqH+3EGA/ie8E9ECtLlDqLGbrNPaoLf329YHkSosXaygBslGmRlZbcf556COmE=
X-Received: by 2002:a17:906:3488:: with SMTP id
 g8-v6mr19486881ejb.11.1545308800200; 
 Thu, 20 Dec 2018 04:26:40 -0800 (PST)
MIME-Version: 1.0
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
 <20181220113547.GC9104@dhcp22.suse.cz>
In-Reply-To: <20181220113547.GC9104@dhcp22.suse.cz>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Thu, 20 Dec 2018 20:26:28 +0800
Message-ID: <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
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

On Thu, Dec 20, 2018 at 7:35 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
> [...]
> > @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
> >   */
> >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> >  {
> > -     return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > +     if (unlikely(!possible_zonelists[nid])) {
> > +             WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> > +             if (unlikely(build_fallback_zonelists(nid)))
> > +                     nid = first_online_node;
> > +     }
> > +     return possible_zonelists[nid] + gfp_zonelist(flags);
> >  }
>
> No, please don't do this. We do not want to make things work magically

For magically, if you mean directly replies on zonelist instead of on
pgdat struct, then it is easy to change
> and we definitely do not want to put something like that into the hot

But  the cose of "unlikely" can be ignored, why can it not be placed
in the path?
> path. We definitely need zonelists to be build transparently for all
> possible nodes during the init time.

That is the point, whether the all nodes should be instanced at boot
time, or not be instanced until there is requirement.

To replace the possible_zonelists, I bring out the following draft
(locking issue is not considered)
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0705164..24e8ae6 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -453,6 +453,11 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
+       if (unlikely(!node_data[nid])) {
+               WARN_ONCE(1, "alloc from offline node: %d\n", nid);
+               if (unlikely(build_offline_node(nid)))
+                       nid = first_online_node;
+       }
        return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ec9cc4..4ef15fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5261,6 +5261,21 @@ static void build_zonelists(pg_data_t *pgdat)
        build_thisnode_zonelists(pgdat);
 }

+int build_offline_node(int nid)
+{
+       unsigned long zones_size[MAX_NR_ZONES] = {0};
+       unsigned long zholes_size[MAX_NR_ZONES] = {0};
+       pg_data_t *pgdat;
+
+       pgdat = kzalloc(sizeof(pg_data_t), GFP_ATOMIC);
+       if (!pgdat)
+               return -ENOMEM
+       node_data[nid] = pgdat;
+       free_area_init_node(nid, zones_size, 0, zholes_size);
+       build_zonelists(pgdat);
+       return 0;
+}
+

Thanks and regards,
Pingfan
