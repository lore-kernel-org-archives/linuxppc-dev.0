Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4lmH5JW7zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:59:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] powernv: Fix MCE handler to avoid trashing CR0/CR1
 registers.
In-Reply-To: <5208d498-ffa8-cf5f-dcae-2f8d0d1b0889@linux.vnet.ibm.com>
References: <20160301054655.15714.48085.stgit@mars.in.ibm.com>
 <20160301054817.15714.20605.stgit@mars.in.ibm.com>
 <87mvkt891s.fsf@linux.vnet.ibm.com>
 <5208d498-ffa8-cf5f-dcae-2f8d0d1b0889@linux.vnet.ibm.com>
Date: Thu, 04 Aug 2016 19:59:58 +1000
Message-ID: <878twcg8gx.fsf@concordia.ellerman.id.au>
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

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 08/04/2016 09:44 AM, Stewart Smith wrote:
>> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> The current implementation of MCE early handling modifies CR0/1 registers
>>> without saving its old values. Fix this by moving early check for
>>> powersaving mode to machine_check_handle_early().
>> 
>> From (internal bug report) it seems as though in a test where one
>> injects continuous SLB Multi Hit errors, this bug could lead to rebooting
>> "due to to Platform error" rather than continuing to recover
>> successfully. It might be a good idea to mention that in commit message
>> here.
>
> This patch does not address the specific internal bug that you talking
> about. I am still chasing that bug.
> 
>> Also, should this go to stable?
>
> However yes. This should go to stable tree.

Can you please rebase it on to Linus' master.

cheers
