Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AC201A0BA8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 16:12:53 +1100 (AEDT)
Date: Wed, 7 Jan 2015 16:12:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable in
 current_thread_info
Message-ID: <20150107161247.55591e93@kryten>
In-Reply-To: <20141231122453.GH5183@bubble.grove.modra.org>
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>
 <5490D981.7040905@suse.de>
 <1418879514.13333.2.camel@ellerman.id.au>
 <20141218172546.432de7f2@kryten>
 <20141231122453.GH5183@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alexander Graf <agraf@suse.de>, ulrich.weigand@de.ibm.com, paulus@samba.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alan,

> Right.  This is really an rs6000 backend bug.  We describe one of the
> indirect calls that go wrong here as
> 
> (call_insn 108 107 109 13 (parallel [
>             (set (reg:DI 3 3)
>                 (call (mem:SI (reg:DI 288) [0 *_67 S4 A8])
>                     (const_int 64 [0x40])))
>             (use (mem:DI (plus:DI (reg/f:DI 287 [ ops_44(D)->update ])
>                         (const_int 8 [0x8])) [0  S8 A8]))
>             (set (reg:DI 2 2)
>                 (mem/v/c:DI (plus:DI (reg/f:DI 1 1)
>                         (const_int 40 [0x28])) [0  S8 A8]))
>             (clobber (reg:DI 65 lr))
>         ]) net/core/skbuff.c:2085 680 {*call_value_indirect_aixdi}
> 	<notes and arg uses omitted for clarity>
> )
> 
> Notice that the RTL contains a "parallel".  As you might guess, gcc
> treats the vector of expressions inside the square brackets of the
> parallel as happening "in parallel".  Meaning that as far as gcc is
> concerned the toc restore part (third element) happens at the same
> time as the call (first element).  So if gcc replaces (reg:DI 1) in
> the toc restore with some other register known to have the same value
> *before* the call, gcc's RTL analysis will conclude that such a
> replacement is valid.

Thanks for looking into this. Does that mean we were just getting lucky
with the previous version:

static inline struct thread_info *current_thread_info(void)
{
        register unsigned long sp asm("r1");

        return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
}
 
ie a static register asm instead of a global one. If so the safest fix
for now might be to just eat the overead of a register move:

static inline struct thread_info *current_thread_info(void)
{
        unsigned long sp;

        asm("mr %0,1": "=r"(sp));
        return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
}

Anton
