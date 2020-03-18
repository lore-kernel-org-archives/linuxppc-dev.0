Return-Path: <SRS0=Ik3v=5D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8DC5ACD6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 14:54:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB4820752
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZ+M9CWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB4820752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jCkK1RQMzDqjM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 01:54:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.74;
 helo=us-smtp-delivery-74.mimecast.com; envelope-from=bhe@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=DZ+M9CWu; 
 dkim-atps=neutral
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jCRg006qzDqw2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 01:42:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584542523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7kBegBwWcEdb3wj4I7SyRaROqMrOxZ30lybsvlhbDs=;
 b=DZ+M9CWuWDdve6V03XCtVpHaqqZvv7a9xyQVPG2AXv31w+d5IvgdDsfrHWsKV2hOd0PEq3
 Tw6hLpXgOe/jkuQwOQrUwj+gDt3LAhvSOx9Kv0JQD4/To+XbqrV5k/lL/misNgqdPL9Dj5
 I+bnwExhPtyo4A6ZxPNYzf+nBmXfUNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-pO2FWBMJMNunXEjOqVSYpA-1; Wed, 18 Mar 2020 10:42:00 -0400
X-MC-Unique: pO2FWBMJMNunXEjOqVSYpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D2BA1361;
 Wed, 18 Mar 2020 14:41:57 +0000 (UTC)
Received: from localhost (ovpn-12-66.pek2.redhat.com [10.72.12.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBE160BFB;
 Wed, 18 Mar 2020 14:41:48 +0000 (UTC)
Date: Wed, 18 Mar 2020 22:41:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: allow to specify a default
 online_type
Message-ID: <20200318144146.GE30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com>
 <20200318130517.GC30899@MiWiFi-R3L-srv>
 <20200318135408.GP21362@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318135408.GP21362@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Yumei Huang <yuhuang@redhat.com>, linux-hyperv@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
 Milan Zamazal <mzamazal@redhat.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/18/20 at 02:54pm, Michal Hocko wrote:
> On Wed 18-03-20 21:05:17, Baoquan He wrote:
> > On 03/17/20 at 11:49am, David Hildenbrand wrote:
> > > Distributions nowadays use udev rules ([1] [2]) to specify if and
> > > how to online hotplugged memory. The rules seem to get more complex with
> > > many special cases. Due to the various special cases,
> > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE cannot be used. All memory hotplug
> > > is handled via udev rules.
> > > 
> > > Everytime we hotplug memory, the udev rule will come to the same
> > > conclusion. Especially Hyper-V (but also soon virtio-mem) add a lot of
> > > memory in separate memory blocks and wait for memory to get onlined by user
> > > space before continuing to add more memory blocks (to not add memory faster
> > > than it is getting onlined). This of course slows down the whole memory
> > > hotplug process.
> > > 
> > > To make the job of distributions easier and to avoid udev rules that get
> > > more and more complicated, let's extend the mechanism provided by
> > > - /sys/devices/system/memory/auto_online_blocks
> > > - "memhp_default_state=" on the kernel cmdline
> > > to be able to specify also "online_movable" as well as "online_kernel"
> > 
> > This patch series looks good, thanks. Since Andrew has merged it to -mm again,
> > I won't add my Reviewed-by to bother. 
> 
> JFYI, Andrew usually adds R-b or A-b tags as they are posted.

Got it, thanks for telling.

