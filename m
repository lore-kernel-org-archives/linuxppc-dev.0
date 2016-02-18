Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE1381A0556
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 13:41:28 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 21:41:25 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AD90DC90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 21:41:20 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1I2fM8k29491344
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 02:41:23 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1I2fM9c013519
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 21:41:22 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix BUG_ON() reporting in real mode on powerpc
In-Reply-To: <CAKTCnzmYSZ+0+kkPECMPPAYB10OAD-=fsjOeGM8jB4ENYP7-dA@mail.gmail.com>
References: <1455684191.3089.3.camel@gmail.com>
 <20160217045606.GA19276@oak.ozlabs.ibm.com>
 <1455693365.3089.8.camel@gmail.com> <8760xnz7sn.fsf@linux.vnet.ibm.com>
 <CAKTCnzmYSZ+0+kkPECMPPAYB10OAD-=fsjOeGM8jB4ENYP7-dA@mail.gmail.com>
Date: Thu, 18 Feb 2016 08:11:19 +0530
Message-ID: <87r3ga91v4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

>>> Changelog:
>>>      Don't add PAGE_OFFSET blindly, check if REGION_ID is 0
>>>
>>> I ran into this issue while debugging an early boot problem.
>>> The system hit a BUG_ON() but report bug failed to print the
>>> line number and file name. The reason being that the system
>>> was running in real mode and report_bug() searches for
>>> addresses in the PAGE_OFFSET+ region
>>>
>>> Suggested-by: Paul Mackerras <paulus@samba.org>
>>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>
> <snip>
>
>> Can we add some comments around this. When i looked at this first, i was
>> wondering how nip can be in user region. But then realized that what we
>> are checking here is kernel address used in real mode. The use of
>> REGION_ID eventhough simpler is confusing. Hence adding the comment with
>> details Paul mentioned in email will help.
>>
>>
> I've tried and covered it in the changelog, I thought a code comment
> would make sense for the very non  obvious cases and not repeat what
> the code does as comment
>

The use of REGION_ID indicate that you are checking for region. Hence
the suggestion. Looking at this again, I suggest we should add a new
macro or will have to open code it. Because in the radix series we make
REGION_ID a hash config thing and this is generic stuff. 

-aneesh
