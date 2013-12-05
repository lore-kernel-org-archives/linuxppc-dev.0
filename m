Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF69B2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 16:20:40 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 5 Dec 2013 15:20:39 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B1BD93578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 16:20:36 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB552VcD46137584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 16:02:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB55KZFl011197
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 16:20:36 +1100
Message-ID: <1386220835.21910.21.camel@pasglop>
Subject: Re: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 05 Dec 2013 16:20:35 +1100
In-Reply-To: <87a9gfri3u.fsf@linux.vnet.ibm.com>
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1386126782.16703.137.camel@pasglop> <87a9gfri3u.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org, Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-05 at 10:48 +0530, Aneesh Kumar K.V wrote:
> 
> Ok, I can move the changes below #ifdef CONFIG_NUMA_BALANCING ? We call
> change_prot_numa from task_numa_work and queue_pages_range(). The later
> may be an issue. So doing the below will help ?
> 
> -#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
> +#ifdef CONFIG_NUMA_BALANCING

I will defer to Mel and Rik (should we also CC Andrea ?)

Cheers,
Ben.
