Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85BF71A01C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:55:57 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 04:55:54 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9CE632CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:55:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6MIcvZT65667156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:38:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6MItq8n023214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 04:55:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: thp: invalidate old 64K based hash page
 mapping before insert
In-Reply-To: <1406007123.22200.11.camel@pasglop>
References: <1405435927-24027-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1405435927-24027-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1406007123.22200.11.camel@pasglop>
Date: Wed, 23 Jul 2014 00:25:48 +0530
Message-ID: <8738dtte8b.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2014-07-15 at 20:22 +0530, Aneesh Kumar K.V wrote:
>> If we changed base page size of the segment, either via sub_page_protect
>> or via remap_4k_pfn, we do a demote_segment which doesn't flush the hash
>> table entries. We do that when inserting a new hash pte by checking the
>> _PAGE_COMBO flag. We missed to do that when inserting hash for a new 16MB
>> page. Add the same. This patch mark the 4k base page size 16MB hugepage
>> via _PAGE_COMBO.
>
> please improve the above, I don't understand it.

I have reworked this patch and will send an updated version. We also
need to handle _PAGE_COMBO condition on hugepage_flush. I will add more
comments in the next update.

-aneesh
