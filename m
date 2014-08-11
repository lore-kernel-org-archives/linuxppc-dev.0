Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C5F31A0717
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 14:00:08 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 11 Aug 2014 14:00:07 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7544B2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 14:00:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7B3anZV7406016
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 13:36:49 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7B402gf022330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 14:00:03 +1000
Message-ID: <53E83FBF.2040607@linux.vnet.ibm.com>
Date: Mon, 11 Aug 2014 09:29:59 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20140803155108.GA19710@gate.crashing.org>
In-Reply-To: <20140803155108.GA19710@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 03 August 2014 09:21 PM, Segher Boessenkool wrote:
>> +/*
>> + * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting Software Breakpoint.
>> + * Based on PowerISA v2.07, Instruction with opcode 0s will be treated as illegal
>> + * instruction.
>> + */
> 
> "primary opcode 0" instead?
> 
ok sure.

>> +#define OP_ZERO                 0x0
> 
> Using 0x0 where you mean 0, making a #define for 0 in the first place...
> This all looks rather silly doesn't it.
> 

I wanted to avoid zero mentioned in the case statement, but can add a
comment explaining it.

>> +	case OP_ZERO:
>> +		if((inst & 0x00FFFF00) == KVMPPC_INST_BOOK3S_DEBUG) {
> 
> You either shouldn't mask at all here, or the mask is wrong (the primary
> op is the top six bits, not the top eight).
>
Yes. I guess I dont need to check here. Will resend the patch.

Thanks for review
Regards
Maddy

> 
> Segher
> 
