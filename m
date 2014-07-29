Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 573EB1A0199
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 20:37:39 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 20:37:18 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 25AA72CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 20:37:36 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6TAbDVI15794366
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 20:37:13 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6TAbZXZ003949
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 20:37:35 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: thp: Add write barrier after updating the valid
 bit
In-Reply-To: <1406617244.4935.81.camel@pasglop>
References: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1406006862.22200.7.camel@pasglop> <8761iptebe.fsf@linux.vnet.ibm.com>
 <1406066112.22200.28.camel@pasglop> <8761igu008.fsf@linux.vnet.ibm.com>
 <1406617244.4935.81.camel@pasglop>
Date: Tue, 29 Jul 2014 16:07:32 +0530
Message-ID: <87iomgwivn.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2014-07-29 at 12:25 +0530, Aneesh Kumar K.V wrote:
>> We want to make sure for usage like below we don't reorder the  load.
>> 
>> if (pmd_trans_huge(*pmdp)){
>> 
>>    get_hpte_slot_array(pmdp)
>> }
>
> Shouldn't we also make sure that we don't have lock set ? (In case it's
> in the middle of being updated).

The reace against withdraw is not a real problem. We use
get_hpte_slot_array in huge page invalidate and hash page. In the first
case we are holding pmd_trans_huge_lock and in the later we have the
_PAGE_BUSY check.

-aneesh
