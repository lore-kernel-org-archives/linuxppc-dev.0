Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 999EB1A01E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:10:48 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 22:10:47 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 021392BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:10:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6GBrwQT53412032
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 21:53:58 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6GCAj1U010929
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 22:10:45 +1000
Date: Wed, 16 Jul 2014 22:10:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/6] powerpc/eeh: Refactor EEH flag accessors
Message-ID: <20140716121043.GA5313@shangw>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1405489819-26211-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1727472B@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1727472B@AcuExch.aculab.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 'Gavin Shan' <gwshan@linux.vnet.ibm.com>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2014 at 08:24:49AM +0000, David Laight wrote:
>From: Gavin Shan
>> There are multiple global EEH flags. Almost each flag has its own
>> accessor, which doesn't make sense. The patch refactors EEH flag
>> accessors so that they look unified:
>> 
>>   eeh_add_flag():   Add EEH flag
>
>eeh_set_flag() ??
>

I guess it's reasonable to keep eeh_add_flag(). eeh_set_flag() overwrites
the flags we had. I steal them from include/asm-generic/pci-bridge.h:

pci_set_flag()
pci_add_flag()
pci_clear_flag()

>>   eeh_clear_flag(): Clear EEH flag
>>   eeh_has_flag():   Check if one specific flag has been set
>
>Personally I find these sort of 'accessor' functions rather pointless.
>

Indeed, but it makes the code a bit clean. I needn't access
the global variable for flags directly.

Thanks,
Gavin

>	David
>
