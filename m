Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96B241A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 16:47:17 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E43121402AB
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 16:47:16 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 13 Jul 2015 12:17:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 915B8125807E
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 12:19:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6D6ko7x5505500
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 12:16:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6D6kjQ0009563
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 12:16:46 +0530
Message-ID: <55A35ECF.5050106@linux.vnet.ibm.com>
Date: Mon, 13 Jul 2015 12:16:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH V2] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
References: <1436435189-11152-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1436512241.4895.2.camel@neuling.org> <55A34B85.3090902@linux.vnet.ibm.com>
 <1436766076.15957.0.camel@ellerman.id.au>
In-Reply-To: <1436766076.15957.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/13/2015 11:11 AM, Michael Ellerman wrote:
> On Mon, 2015-07-13 at 10:54 +0530, Anshuman Khandual wrote:
>> On 07/10/2015 12:40 PM, Michael Neuling wrote:
>>> What's the performance impact of this?  If you run this test with --fp,
>>> --altivec or --vector what is the impact of adding this patch?
>>>
>>> http://ozlabs.org/~anton/junkcode/context_switch2.c
>>>
>>> eg 
>>>   ./context_switch2 --fp 0 0 
>>
>> Please find the results here which looks similar with or without
>> the patch being applied.
> 
> No they don't look similar with or without.
> 
>> (A) Floating point context switches (context_switch2 --fp 0 0)
> 
> If you just sort them you see:
> 
> 316478	after
> 316540	after
> 316650	after
> 318448	after
> 318904 before
> 320216 before
> 321206 before
> 321308 before
> 323460	after
> 324596 before
> 
> 
> It looks like ~1% degradation. Please run the test more times (maybe 1000) and
> see how the numbers look.

Average of 1000 iterations looks better.

With    the patch : 322599.57  (Average of 1000 results)
Without the patch : 320464.924 (Average of 1000 results)
