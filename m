Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHcz5xfkzDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:47:15 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id f27so522801pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 22:47:15 -0700 (PDT)
Message-ID: <1496814428.18257.4.camel@gmail.com>
Subject: Re: [PATCH v3 2/9] powerpc/kprobes: Move kprobes over to
 patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 christophe.leroy@c-s.fr,  paulus@samba.org
Date: Wed, 07 Jun 2017 15:47:08 +1000
In-Reply-To: <20170606190529.GF19390@naverao1-tp.localdomain>
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-3-bsingharora@gmail.com>
 <20170606190529.GF19390@naverao1-tp.localdomain>
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

On Wed, 2017-06-07 at 00:35 +0530, Naveen N. Rao wrote:
> Hi Balbir,
> 
> On 2017/06/06 02:29PM, Balbir Singh wrote:
> > arch_arm/disarm_probe use direct assignment for copying
> > instructions, replace them with patch_instruction
> > 
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >  arch/powerpc/kernel/kprobes.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index fc43435..b49f8f0 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -158,7 +158,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
> > 
> >  void arch_arm_kprobe(struct kprobe *p)
> >  {
> > -	*p->addr = BREAKPOINT_INSTRUCTION;
> > +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
> >  	flush_icache_range((unsigned long) p->addr,
> >  			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
> 
> Do we still need flush_icache_range() after patch_instruction()?
>

Good catch! No, we don't

Balbir Singh. 
