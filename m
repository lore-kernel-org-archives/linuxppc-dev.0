Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com
 [IPv6:2607:f8b0:4002:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 652031A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:26:03 +1100 (AEDT)
Received: by mail-yw0-x232.google.com with SMTP id g127so27758870ywf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 16:26:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8760xnz7sn.fsf@linux.vnet.ibm.com>
References: <1455684191.3089.3.camel@gmail.com>
 <20160217045606.GA19276@oak.ozlabs.ibm.com>
 <1455693365.3089.8.camel@gmail.com>
 <8760xnz7sn.fsf@linux.vnet.ibm.com>
Date: Thu, 18 Feb 2016 11:25:59 +1100
Message-ID: <CAKTCnzmYSZ+0+kkPECMPPAYB10OAD-=fsjOeGM8jB4ENYP7-dA@mail.gmail.com>
Subject: Re: Fix BUG_ON() reporting in real mode on powerpc
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Changelog:
>>      Don't add PAGE_OFFSET blindly, check if REGION_ID is 0
>>
>> I ran into this issue while debugging an early boot problem.
>> The system hit a BUG_ON() but report bug failed to print the
>> line number and file name. The reason being that the system
>> was running in real mode and report_bug() searches for
>> addresses in the PAGE_OFFSET+ region
>>
>> Suggested-by: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

<snip>

> Can we add some comments around this. When i looked at this first, i was
> wondering how nip can be in user region. But then realized that what we
> are checking here is kernel address used in real mode. The use of
> REGION_ID eventhough simpler is confusing. Hence adding the comment with
> details Paul mentioned in email will help.
>
>
I've tried and covered it in the changelog, I thought a code comment
would make sense for the very non  obvious cases and not repeat what
the code does as comment

Balbir Singh.
