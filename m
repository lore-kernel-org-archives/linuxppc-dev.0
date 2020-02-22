Return-Path: <SRS0=nFyT=4K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83FC35669
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 03:48:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9EE214D8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 03:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9EE214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PZ6f0DgczDqpy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 14:48:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=linux.com (client-ip=3.19.106.255; helo=gentwo.org;
 envelope-from=cl@linux.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
X-Greylist: delayed 514 seconds by postgrey-1.36 at bilbo;
 Sat, 22 Feb 2020 14:46:51 AEDT
Received: from gentwo.org (gentwo.org [3.19.106.255])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PZ571FHYzDqpy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2020 14:46:50 +1100 (AEDT)
Received: by gentwo.org (Postfix, from userid 1002)
 id 6BF443F625; Sat, 22 Feb 2020 03:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by gentwo.org (Postfix) with ESMTP id 696023F624;
 Sat, 22 Feb 2020 03:38:11 +0000 (UTC)
Date: Sat, 22 Feb 2020 03:38:11 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To: Michal Hocko <mhocko@kernel.org>
Subject: Re: [5.6.0-rc2-next-20200218/powerpc] Boot failure on POWER9
In-Reply-To: <20200218152441.GH4151@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2002220337030.2000@www.lameter.com>
References: <3381CD91-AB3D-4773-BA04-E7A072A63968@linux.vnet.ibm.com>
 <cf6be5f5-4bbc-0d34-fb64-33fd37bc48d9@virtuozzo.com>
 <0ba2a3c6-6593-2cee-1cef-983cd75f920f@virtuozzo.com>
 <F5A68B0C-AFDE-4C45-B0F3-12A5154204E6@linux.vnet.ibm.com>
 <20200218115525.GD4151@dhcp22.suse.cz>
 <D6F45EDD-9F2E-4593-B630-55E5BD7DE915@linux.vnet.ibm.com>
 <20200218142620.GF4151@dhcp22.suse.cz>
 <35EE65CF-40E3-4870-AEBC-D326977176DA@linux.vnet.ibm.com>
 <20200218152441.GH4151@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, Pekka Enberg <penberg@kernel.org>,
 Kirill Tkhai <ktkhai@virtuozzo.com>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 18 Feb 2020, Michal Hocko wrote:

> Anyway, I do not think it is expected that kmalloc_node just blows up
> on those nodes. The page allocator simply falls back to the closest
> node. Something for kmalloc maintainers I believe.

That is the case for an unconstrained allocation. kmalloc_node means that
you want memory from that node. And If there is no such node then it is an
error.

> A short summary. kmalloc_node blows up when trying to allocate from a
> memory less node.

Use kmalloc instead? And set a memory allocation policy?

