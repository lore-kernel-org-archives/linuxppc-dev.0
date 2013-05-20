Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FA612C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 19:26:31 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 May 2013 19:13:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BADA32BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 19:26:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4K9QFSL22544546
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 19:26:15 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4K9QMYt021490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 19:26:22 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: use smp_rmb when looking at deposisted
 pgtable to store hash index
In-Reply-To: <1369031318.6387.1.camel@pasglop>
References: <1368778503-23230-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <26735.1369012726@ale.ozlabs.ibm.com> <87vc6e9sxx.fsf@linux.vnet.ibm.com>
 <1369031318.6387.1.camel@pasglop>
Date: Mon, 20 May 2013 14:56:18 +0530
Message-ID: <87a9nq57et.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 paulus@samba.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2013-05-20 at 09:57 +0530, Aneesh Kumar K.V wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>> 
>> > Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> >
>> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> >> 
>> >> We need to use smb_rmb when looking at hpte slot array. Otherwise we could
>> >> reorder the hpte_slot array load bfore even we marked the pmd trans huge.
>> >
>> > Does this need to go back into the stable series?
>> >
>> 
>> No the changes are not yet upstream. hpte_slot_array changes are in the
>> THP series. I didn't want to post the entire series again with the 
>> above two patches. 
>
> Note that any patch that adds such a rmb should have a very clear
> description of what is the corresponding wmb. It's almost never right to
> have one without the other. IE. What is it that you are ordering
> against.

Will update the commit message. Some of that smb_wmb() are in the
core THP, and the others in ppc64 code. Will update with more info.

When we deposit pgtable we use pgtable_trans_huge_deposit that calls
related smb_wmb(). When we read pgtable via pgtable_trans_huge_withdraw,
core THP code does the related smb_wmb() after setting the right
PTE information in the pgtable.

-aneesh
