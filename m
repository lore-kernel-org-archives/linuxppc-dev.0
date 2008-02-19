Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1F412DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 00:19:28 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1JDJDUP008909
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 00:19:13 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1JDJS8m3956836
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 00:19:28 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1JDJRPL004069
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 00:19:28 +1100
Message-ID: <47BAD75C.9030406@linux.vnet.ibm.com>
Date: Tue, 19 Feb 2008 18:49:24 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [BUG] Linux 2.6.25-rc2 - Regression from 2.6.24-rc1-git1
	softlockup while bootup on powerpc
References: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
	<47B67E5E.4010001@linux.vnet.ibm.com>
	<20080217192913.GO23197@kernel.dk>
	<20080219170432.9c04376f.kamezawa.hiroyu@jp.fujitsu.com>
	<20080219083633.GN23197@kernel.dk>
In-Reply-To: <20080219083633.GN23197@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jens Axboe wrote:
> On Tue, Feb 19 2008, KAMEZAWA Hiroyuki wrote:
>> On Sun, 17 Feb 2008 20:29:13 +0100
>> Jens Axboe <jens.axboe@oracle.com> wrote:
>>
>>> It's odd stuff. Could you perhaps try and add some printks to
>>> block/cfq-iosched.c:call_for_each_cic(), like dumping the 'nr' return
>>> from radix_tree_gang_lookup() and the pointer value of cics[i] in the
>>> for() loop after the lookup?
>>>
>> I met the same issue on ia64/NUMA box.
>> seems cisc[]->key is NULL and index for radix_tree_gang_lookup() was
>> always '1'.
> 
> Why does it keep repeating then? If ->key is NULL, the next lookup index
> should be 1UL.
> 
> But I think the radix 'scan over entire tree' is a bit fragile. This
> patch adds a parallel hlist for ease of properly browsing the members,
> does that work for you? It compiles, but I haven't booted it here yet...
> 
>> Attached patch works well for me, but I don't know much about cfq.
>> please confirm. 
> 
> It doesn't make a lot of sense, I'm afraid.
> 
>  block/blk-ioc.c           |   35 +++++++++++++++--------------------
>  block/cfq-iosched.c       |   37 +++++++++++--------------------------
>  include/linux/iocontext.h |    2 ++
>  3 files changed, 28 insertions(+), 46 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 80245dc..73c7002 100644
> --- a/block/blk-ioc.c

<snip>

Hi Jens,

Thanks for the patch. The patch works fine, machine boots up without the kernel panic.


-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
