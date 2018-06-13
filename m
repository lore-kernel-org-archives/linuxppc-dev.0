Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Cv16TxWzF0xS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 14:09:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/5] powerpc: Fix inverted active predicate for
 setting the EBB regset
In-Reply-To: <87fu1rtot3.fsf@concordia.ellerman.id.au>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
 <20180607152534.29427-2-pedromfc@linux.vnet.ibm.com>
 <87fu1rtot3.fsf@concordia.ellerman.id.au>
Date: Wed, 13 Jun 2018 14:09:33 +1000
Message-ID: <871sdbtjia.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com> writes:
>
>> Currently, the ebb_set function for writing to the EBB regset returns
>> ENODATA when ebb is active in the thread, and copies in the data when
>> it is inactive. This patch inverts the condition so that it matches
>> ebb_get and ebb_active.
>> ---
>>  arch/powerpc/kernel/ptrace.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi Pedro,
>
> Thanks for looking into this, how did you detect this? Do you have a
> test case?

I thought we had a test case for this, and it seems that we did, but it
never made it into mainline.

Anshuman wrote it originally but then passed it onto Simon who
resubmitted it and I merged it, but then I must have reverted the EBB
test because it was failing, see:

  http://patchwork.ozlabs.org/patch/676833/


So it would be good to get that test case working reliably. I'm not sure
if would have found this bug anyway, but it would be a start.

cheers
