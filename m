Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRb3d24BzzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 23:34:37 +1000 (AEST)
Subject: Re: [v6 11/15] arm64/kasan: explicitly zero kasan shadow memory
To: David Laight <David.Laight@ACULAB.COM>, Will Deacon <will.deacon@arm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "sam@ravnborg.org" <sam@ravnborg.org>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "mhocko@kernel.org" <mhocko@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-12-git-send-email-pasha.tatashin@oracle.com>
 <20170808090743.GA12887@arm.com>
 <f8b2b9ed-abf0-0c16-faa2-98b66dcbed78@oracle.com>
 <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <43c261e5-7568-0d5b-70ab-d1f82ef257ec@oracle.com>
Date: Tue, 8 Aug 2017 09:30:58 -0400
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD004DA79@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-08-08 09:15, David Laight wrote:
> From: Pasha Tatashin
>> Sent: 08 August 2017 12:49
>> Thank you for looking at this change. What you described was in my
>> previous iterations of this project.
>>
>> See for example here: https://lkml.org/lkml/2017/5/5/369
>>
>> I was asked to remove that flag, and only zero memory in place when
>> needed. Overall the current approach is better everywhere else in the
>> kernel, but it adds a little extra code to kasan initialization.
> 
> Perhaps you could #define the function prototype(s?) so that the flags
> are not passed unless it is a kasan build?
> 

Hi David,

Thank you for suggestion. I think a kasan specific vmemmap (what I 
described in the previous e-mail) would be a better solution over having 
different prototypes with different builds.  It would be cleaner to have 
all kasan specific code in one place.

Pasha
