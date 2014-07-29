Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F0571A018C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 16:55:59 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 16:55:49 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 39C262CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 16:55:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T6tWiD15532090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 16:55:33 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T6tstA021275
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 16:55:54 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: thp: Add write barrier after updating the valid
 bit
In-Reply-To: <1406066112.22200.28.camel@pasglop>
References: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1406006862.22200.7.camel@pasglop> <8761iptebe.fsf@linux.vnet.ibm.com>
 <1406066112.22200.28.camel@pasglop>
Date: Tue, 29 Jul 2014 12:25:51 +0530
Message-ID: <8761igu008.fsf@linux.vnet.ibm.com>
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

> On Wed, 2014-07-23 at 00:23 +0530, Aneesh Kumar K.V wrote:
>> > A better place for this would be right before the last write to the PMD
>> > (that's also clearing BUSY) in __hash_page_thp(). Basically, it's the
>> > normal lock ordering that's missing here, nothing specific to
>> > mark_hpte_slot_valid() but instead, any state relative to the BUSY bit
>> > in the PMD (including the actual hash writes in update_pp etc...)
>> >
>> 
>> IIUC updatepp already have required barriers. ie in updatepp we do tlbie
>> which should take care of the ordering right ?
>
> Only if it succeeds but that doesn't matter, I'd rather we get the
> semantics right. The clearing of the busy bit is an unlock, it should
> have the appropriate barriers like it does in other variants of hash
> page.

ok

>> 
>> Now the reason i moved that spm_wmb() to mark_hpte_slot_valid was to
>> pair it with smb_rmb() in get_hpte_slot_array().
>
> Which is also probably in the wrong place. Care to explain to me the
> exact relationship ?

We want to make sure for usage like below we don't reorder the  load.

if (pmd_trans_huge(*pmdp)){

   get_hpte_slot_array(pmdp)
}

-aneesh
