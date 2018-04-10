Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L9bw06X5zF2G9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 01:11:07 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3AEpng6022285
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 11:11:05 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h8w118wfr-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 11:11:05 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 10 Apr 2018 16:11:02 +0100
Subject: Re: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
To: David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 akpm@linux-foundation.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
 Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180409175757.GA12938@infradead.org>
 <alpine.DEB.2.21.1804091307480.56406@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 17:10:52 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804091307480.56406@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <3a330851-d545-ebd8-e74c-c44e12220c24@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2018 22:08, David Rientjes wrote:
> On Mon, 9 Apr 2018, Christoph Hellwig wrote:
> 
>>> -#ifdef __HAVE_ARCH_PTE_SPECIAL
>>> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>>  # define HAVE_PTE_SPECIAL 1
>>>  #else
>>>  # define HAVE_PTE_SPECIAL 0
>>
>> I'd say kill this odd indirection and just use the
>> CONFIG_ARCH_HAS_PTE_SPECIAL symbol directly.
>>
>>
> 
> Agree, and I think it would be easier to audit/review if patches 1 and 3 
> were folded together to see the relationship between the newly added 
> selects and what #define's it is replacing.  Otherwise, looks good!
>

Ok I will fold the 3 patches and introduce a new one removing HAVE_PTE_SPECIAL.

Thanks,
Laurent.
