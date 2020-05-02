Return-Path: <SRS0=G0Pv=6Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1462C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 23:05:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FD22072E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 May 2020 23:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FD22072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49F4TM6NkjzDrHs
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 May 2020 09:05:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=linux.com (client-ip=3.19.106.255; helo=gentwo.org;
 envelope-from=cl@linux.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
X-Greylist: delayed 451 seconds by postgrey-1.36 at bilbo;
 Sun, 03 May 2020 09:02:51 AEST
Received: from gentwo.org (gentwo.org [3.19.106.255])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49F4Qg5b9FzDqfP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 May 2020 09:02:51 +1000 (AEST)
Received: by gentwo.org (Postfix, from userid 1002)
 id 28E4C3ED19; Sat,  2 May 2020 22:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by gentwo.org (Postfix) with ESMTP id 2680B3ED18;
 Sat,  2 May 2020 22:55:16 +0000 (UTC)
Date: Sat, 2 May 2020 22:55:16 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] powerpc/numa: Set numa_node for all possible cpus
In-Reply-To: <20200501031128.19584-2-srikar@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.2005022254170.28355@www.lameter.com>
References: <20200501031128.19584-1-srikar@linux.vnet.ibm.com>
 <20200501031128.19584-2-srikar@linux.vnet.ibm.com>
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
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michal Hocko <mhocko@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 1 May 2020, Srikar Dronamraju wrote:

> -	for_each_present_cpu(cpu)
> -		numa_setup_cpu(cpu);
> +	for_each_possible_cpu(cpu) {
> +		/*
> +		 * Powerpc with CONFIG_NUMA always used to have a node 0,
> +		 * even if it was memoryless or cpuless. For all cpus that
> +		 * are possible but not present, cpu_to_node() would point
> +		 * to node 0. To remove a cpuless, memoryless dummy node,
> +		 * powerpc need to make sure all possible but not present
> +		 * cpu_to_node are set to a proper node.
> +		 */
> +		if (cpu_present(cpu))
> +			numa_setup_cpu(cpu);
> +		else
> +			set_cpu_numa_node(cpu, first_online_node);
> +	}
>  }


Can this be folded into numa_setup_cpu?

This looks more like numa_setup_cpu needs to change?

