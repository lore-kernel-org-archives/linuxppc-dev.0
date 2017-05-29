Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc9vB027nzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 08:11:49 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f27so13624774pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 15:11:49 -0700 (PDT)
Message-ID: <1496095866.21894.11.camel@gmail.com>
Subject: Re: [PATCH v1 2/8] powerpc/kprobes: Move kprobes over to
 patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org,  mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
Date: Tue, 30 May 2017 08:11:06 +1000
In-Reply-To: <f5ce15b1-2c50-cad6-36f1-c7e7bc8c4f2d@c-s.fr>
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-3-bsingharora@gmail.com>
 <f5ce15b1-2c50-cad6-36f1-c7e7bc8c4f2d@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-29 at 10:50 +0200, Christophe LEROY wrote:
> 
> Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> > arch_arm/disarm_probe use direct assignment for copying
> > instructions, replace them with patch_instruction
> > 
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >   arch/powerpc/kernel/kprobes.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index 160ae0f..5e1fa86 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -158,7 +158,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
> >   
> >   void arch_arm_kprobe(struct kprobe *p)
> >   {
> > -	*p->addr = BREAKPOINT_INSTRUCTION;
> > +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
> >   	flush_icache_range((unsigned long) p->addr,
> >   			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
> >   }
> > @@ -166,7 +166,7 @@ NOKPROBE_SYMBOL(arch_arm_kprobe);
> >   
> >   void arch_disarm_kprobe(struct kprobe *p)
> >   {
> > -	*p->addr = p->opcode;
> > +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
> 
> Shouldn't it be the following instead ?
> 
> patch_instruction(p->addr, p->opcode);

Yes, thanks for catching this!  I'll do a v2 on top of what you
posted.

Balbir Singh
