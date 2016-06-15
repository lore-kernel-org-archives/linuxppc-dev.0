Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTyYk63vxzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 17:19:06 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 62so1147491pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 00:19:06 -0700 (PDT)
Subject: Re: [V2][PATCH] New MMU feature for new hpte format in ISA3
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <f57f41e9-487d-0d64-0ef3-141a2aabac8f@gmail.com>
 <87shwfaf3i.fsf@skywalker.in.ibm.com>
 <CAKTCnz=q5ubKytJ=_hObzQ58taVdCCKYSp6mFU7mcB4Ty-ttJg@mail.gmail.com>
 <20a3b6f5-ba76-81e0-ef94-e6d10798679b@gmail.com>
 <87porj9fez.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8938f698-7311-9e04-acd8-a8d6a54461c6@gmail.com>
Date: Wed, 15 Jun 2016 17:19:00 +1000
MIME-Version: 1.0
In-Reply-To: <87porj9fez.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/06/16 15:42, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> On 15/06/16 10:38, Balbir Singh wrote:
>>>
>>> Thanks for a review, I'll do a V2 with some changes
>>>
>>> Balbir
>>>
>>
>> Michael, please review and check if you like the #ifdef,
>> since we are crossing the 32 bit boundary, I've used a
>> conditional define to select the feature.
> 
> 
> We really don't need to make it unsigned long. Take a look at
> 
> http://mid.gmane.org/1465395958-21349-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com


The comment in the file states that


/*
 * First half is MMU families
 */

So effectively the first 16 bits are for families. Unless we decide to override
that decision. One can also debate the description of what a MMU family is :)


> 
> But I still am not sure why we need an mmu feature for selecting new hpte
> format. Why would the exiting ISA 3.0 check won't work?
> 

I thought I answered it in my previous email. The check for CPU_FTR_ARCH_300 is
too large and we don't want to use it unless advertised via ibm,pa-features.

> 
> For the pa-feature 58 byte look at
> http://mid.gmane.org/1465397003-26812-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com
