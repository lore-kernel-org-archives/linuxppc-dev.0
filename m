Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C08A2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 02:19:26 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 24 Aug 2012 02:18:13 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7NGJKMQ27721890
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 02:19:20 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7NGJJ8F007882
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 02:19:20 +1000
Date: Thu, 23 Aug 2012 21:47:37 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120823161737.GG25338@linux.vnet.ibm.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com>
 <1345696100.3338.21.camel@concordia>
 <20120823053234.GE25338@linux.vnet.ibm.com>
 <1345716378.29170.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345716378.29170.4.camel@pasglop>
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2012-08-23 20:06:18]:

> On Thu, 2012-08-23 at 11:02 +0530, Srikar Dronamraju wrote:
> > > 
> > 
> > insn is updated/accessed in the arch independent code. Size of
> > uprobe_opcode_t could be different for different archs.
> > uprobe_opcode_t
> > represents the size of the smallest breakpoint instruction for an
> > arch.
> > 
> > Hence u8 works out the best. I know we could still use uprobe_opcode_t
> > and achieve the same. In which case, we would have to interpret
> > MAX_UINSN_BYTES differently. Do you see any advantages of using
> > uprobe_opcode_t instead of u8 across archs?
> 
> But don't you actively rely on the fact that on powerpc, unlike x86, you
> -can- atomically replace an instruction with a single 32-bit store ?
> 

We are not doing a replace here, we are only copying from the ->vm_file
for the largest size instruction possible for that instruction. For
powerpc, this is easy because of fixed size instructions.  

On other archs, at this point, we dont even know the length of the
underlying instruction.

Now there are 3 ways to handle this:
1. use arch independent copy_insn() (current.) (handles if the
instruction spreads across multiple pages on non fixed instruction
archs). 

2. make the copy_insn() arch specific, that would mean every arch will
have to do read_mapping_page etc.

3. have a arch specific hook in arch independent copy_insn code that
either does a memcpy for non fixed instruction archs or does an
assignment in archs like powerpc.

I think you are suggesting option 3.
But instead of adding another call that does the arch specific stuff, we
are probably be better of doing a memcpy. Right?

For all powerpc references to insn we could refer to it as u32 as
suggested by Oleg.

-- 
Thanks and Regards
Srikar


> If you don't you should consider it, and that makes defining this as a
> u8 array non-sensical (as is using memcpy)
> 
> Ben.
> 
> 
