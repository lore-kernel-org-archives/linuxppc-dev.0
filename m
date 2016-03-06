Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7347E1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 10:55:57 +1100 (AEDT)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC9C914030F
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2016 10:55:56 +1100 (AEDT)
Received: by mail-pa0-x235.google.com with SMTP id bj10so67865595pad.2
 for <linuxppc-dev@ozlabs.org>; Sun, 06 Mar 2016 15:55:56 -0800 (PST)
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
To: Torsten Duwe <duwe@lst.de>, Petr Mladek <pmladek@suse.com>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <20160304124247.GA20914@lst.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56DCC382.1040105@gmail.com>
Date: Mon, 7 Mar 2016 10:55:46 +1100
MIME-Version: 1.0
In-Reply-To: <20160304124247.GA20914@lst.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/03/16 23:42, Torsten Duwe wrote:
> On Thu, Mar 03, 2016 at 05:52:01PM +0100, Petr Mladek wrote:
> [...]
>> index ec7f8aada697..2d5333c228f1 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -1265,6 +1271,31 @@ ftrace_call:
>>  	ld	r0, LRSAVE(r1)
>>  	mtlr	r0
>>  
>> +#ifdef CONFIG_LIVEPATCH
>> +	beq+	4f		/* likely(old_NIP == new_NIP) */
>> +	/*
>> +	 * For a local call, restore this TOC after calling the patch function.
>> +	 * For a global call, it does not matter what we restore here,
>> +	 * since the global caller does its own restore right afterwards,
>> +	 * anyway. Just insert a klp_return_helper frame in any case,
>> +	 * so a patch function can always count on the changed stack offsets.
>> +	 * The patch introduces a frame such that from the patched function
>> +	 * we return back to klp_return helper. For ABI compliance r12,
>> +	 * lr and LRSAVE(r1) contain the address of klp_return_helper.
>> +	 * We loaded ctr with the address of the patched function earlier
>> +	 */
>> +	stdu	r1, -32(r1)	/* open new mini stack frame */
>> +	std	r2, 24(r1)	/* save TOC now, unconditionally. */
>> +	bl	5f
>> +5:	mflr	r12
>> +	addi	r12, r12, (klp_return_helper + 4 - .)@l
>> +	std	r12, LRSAVE(r1)
>> +	mtlr	r12
>> +	mfctr	r12		/* allow for TOC calculation in newfunc */
>> +	bctr
>> +4:
>> +#endif
>> +
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  	stdu	r1, -112(r1)
>>  .globl ftrace_graph_call
>> @@ -1281,6 +1312,25 @@ _GLOBAL(ftrace_graph_stub)
>>  
>>  _GLOBAL(ftrace_stub)
>>  	blr
>> +#ifdef CONFIG_LIVEPATCH
>> +/* Helper function for local calls that are becoming global
>> + * due to live patching.
>> + * We can't simply patch the NOP after the original call,
>> + * because, depending on the consistency model, some kernel
>> + * threads may still have called the original, local function
>> + * *without* saving their TOC in the respective stack frame slot,
>> + * so the decision is made per-thread during function return by
>> + * maybe inserting a klp_return_helper frame or not.
>> +*/
>> +klp_return_helper:
>> +	ld	r2, 24(r1)	/* restore TOC (saved by ftrace_caller) */
>> +	addi r1, r1, 32		/* destroy mini stack frame */
>> +	ld	r0, LRSAVE(r1)	/* get the real return address */
>> +	mtlr	r0
>> +	blr
>> +#endif
>> +
>> +
>>  #else
>>  _GLOBAL_TOC(_mcount)
>>  	/* Taken from output of objdump from lib64/glibc */
> We need a caveat here, at least in the comments, even better
> in some documentation, that the klp_return_helper shifts the stack layout.
>
> This is relevant for functions with more than 8 fixed integer arguments
> or for any varargs creator. As soon as the patch function is to replace
> an original with arguments on the stack, the extra stack frame needs to
> be accounted for.
>
> Where shall we put this warning?
Good catch! We should just document it in livepatch.c (I suppose). I wonder if we can reuse the previous stack frame -- the caller into ftrace_caller. I think our arch.trampoline does bunch of the work anyway, klp_return_helper would just need to restore the right set of values

I hope I am thinking clearly on a Monday morning
Balbir Singh
