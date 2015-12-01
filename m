Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17A571A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 10:31:09 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so20047564pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2015 15:31:06 -0800 (PST)
Subject: Re: [PATCH 2/3] selftests/powerpc: Add test for forking inside
 transaction
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
 <1448946504-11653-3-git-send-email-rashmicy@gmail.com>
 <565D563F.3010709@linux.vnet.ibm.com>
From: Rashmica <rashmicy@gmail.com>
Message-ID: <565E2DB4.4030908@gmail.com>
Date: Wed, 2 Dec 2015 10:31:00 +1100
MIME-Version: 1.0
In-Reply-To: <565D563F.3010709@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As far as I'm aware, the kernel used to crash when forking inside a 
transaction (see powerpc/tm: Fix crash when forking inside a 
transaction). So this is to check that the transaction aborts rather 
than your whole kernel crashing.

On 01/12/15 19:11, Anshuman Khandual wrote:
> On 12/01/2015 10:38 AM, Rashmica Gupta wrote:
>> +int test_fork(void)
>> +{
>> +	SKIP_IF(!have_htm());
>> +
>> +	asm __volatile__(
>> +		"tbegin.;"
>> +		"blt    1f; "
>> +		"li     0, 2;"  /* fork syscall */
>> +		"sc  ;"
>> +		"tend.;"
>> +		"1: ;"
>> +		: : : "memory", "r0");
>> +	/* If we reach here, we've passed.  Otherwise we've probably crashed
>> +	 * the kernel */
> The transaction inside the parent process will abort. What
> is expected inside the child process ? Why should the kernel
> crash ?
>
