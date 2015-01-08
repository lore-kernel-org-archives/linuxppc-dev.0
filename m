Return-Path: <amodra@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C52131A0F8E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 17:36:31 +1100 (AEDT)
Received: by mail-pa0-f50.google.com with SMTP id bj1so9820855pad.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jan 2015 22:36:29 -0800 (PST)
Date: Thu, 8 Jan 2015 17:06:24 +1030
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable in
 current_thread_info
Message-ID: <20150108063624.GB10535@bubble.grove.modra.org>
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>
 <5490D981.7040905@suse.de>
 <1418879514.13333.2.camel@ellerman.id.au>
 <20141218172546.432de7f2@kryten>
 <20141231122453.GH5183@bubble.grove.modra.org>
 <20150107161247.55591e93@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150107161247.55591e93@kryten>
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

On Wed, Jan 07, 2015 at 04:12:47PM +1100, Anton Blanchard wrote:
> Hi Alan,
> 
> > Right.  This is really an rs6000 backend bug.  We describe one of the
> > indirect calls that go wrong here as
> > 
> > (call_insn 108 107 109 13 (parallel [
> >             (set (reg:DI 3 3)
> >                 (call (mem:SI (reg:DI 288) [0 *_67 S4 A8])
> >                     (const_int 64 [0x40])))
> >             (use (mem:DI (plus:DI (reg/f:DI 287 [ ops_44(D)->update ])
> >                         (const_int 8 [0x8])) [0  S8 A8]))
> >             (set (reg:DI 2 2)
> >                 (mem/v/c:DI (plus:DI (reg/f:DI 1 1)
> >                         (const_int 40 [0x28])) [0  S8 A8]))
> >             (clobber (reg:DI 65 lr))
> >         ]) net/core/skbuff.c:2085 680 {*call_value_indirect_aixdi}
> > 	<notes and arg uses omitted for clarity>
> > )
> > 
> > Notice that the RTL contains a "parallel".  As you might guess, gcc
> > treats the vector of expressions inside the square brackets of the
> > parallel as happening "in parallel".  Meaning that as far as gcc is
> > concerned the toc restore part (third element) happens at the same
> > time as the call (first element).  So if gcc replaces (reg:DI 1) in
> > the toc restore with some other register known to have the same value
> > *before* the call, gcc's RTL analysis will conclude that such a
> > replacement is valid.
> 
> Thanks for looking into this. Does that mean we were just getting lucky
> with the previous version:
> 
> static inline struct thread_info *current_thread_info(void)
> {
>         register unsigned long sp asm("r1");
> 
>         return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
> }

With both versions, the original rtl for current_thread_info consists
of two instructions, copy r1 to a pseudo reg, then the "and".  With
the above version, fwprop1 manages to combine this to a single "and"
insn.  When using a global reg var, fprop1 leaves the two
instructions, the copy causing the trouble in the following cprop1
pass.  So it's not that we are getting lucky in cprop1, but that
fwprop1 behaves differently with global vs. local registers.

-- 
Alan Modra
Australia Development Lab, IBM
