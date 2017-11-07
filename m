Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWW125lFGzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 00:46:14 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA7Djjd6077051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Nov 2017 08:46:12 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e3bv2ytgh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Nov 2017 08:46:11 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 08:46:10 -0500
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
To: Nicholas Piggin <npiggin@gmail.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
 <20171107222228.0c8a50ff@roar.ozlabs.ibm.com>
 <20171107122825.posamr2dmzlzvs2p@node.shutemov.name>
 <20171108002448.6799462e@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 7 Nov 2017 19:15:58 +0530
MIME-Version: 1.0
In-Reply-To: <20171108002448.6799462e@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2ce0a91c-985c-aad8-abfa-e91bc088bb3e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> If it is decided to keep these kind of heuristics, can we get just a
> small but reasonably precise description of each change to the
> interface and ways for using the new functionality, such that would be
> suitable for the man page? I couldn't fix powerpc because nothing
> matches and even Aneesh and you differ on some details (MAP_FIXED
> behaviour).


I would consider MAP_FIXED as my mistake. We never discussed this 
explicitly and I kind of assumed it to behave the same way. ie, we 
search in lower address space (128TB) if the hint addr is below 128TB.

IIUC we agree on the below.

1) MAP_FIXED allow the addr to be used, even if hint addr is below 128TB 
but hint_addr + len is > 128TB.

2) For everything else we search in < 128TB space if hint addr is below 
128TB

3) We don't switch to large address space if hint_addr + len > 128TB. 
The decision to switch to large address space is primarily based on hint 
addr

Is there any other rule we need to outline? Or is any of the above not 
correct?

-aneesh
