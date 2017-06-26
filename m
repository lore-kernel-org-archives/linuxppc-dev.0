Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwxhT44KdzDr20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 15:00:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, paulus@samba.org
Subject: Re: [PATCH v3 2/9] powerpc/kprobes: Move kprobes over to
 patch_instruction
In-Reply-To: <1496814428.18257.4.camel@gmail.com>
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-3-bsingharora@gmail.com>
 <20170606190529.GF19390@naverao1-tp.localdomain>
 <1496814428.18257.4.camel@gmail.com>
Date: Mon, 26 Jun 2017 15:00:38 +1000
Message-ID: <87podre421.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Wed, 2017-06-07 at 00:35 +0530, Naveen N. Rao wrote:
>> Hi Balbir,
>> 
>> On 2017/06/06 02:29PM, Balbir Singh wrote:
>> > arch_arm/disarm_probe use direct assignment for copying
>> > instructions, replace them with patch_instruction
>> > 
>> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> > ---
>> >  arch/powerpc/kernel/kprobes.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
>> > index fc43435..b49f8f0 100644
>> > --- a/arch/powerpc/kernel/kprobes.c
>> > +++ b/arch/powerpc/kernel/kprobes.c
>> > @@ -158,7 +158,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
>> > 
>> >  void arch_arm_kprobe(struct kprobe *p)
>> >  {
>> > -	*p->addr = BREAKPOINT_INSTRUCTION;
>> > +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
>> >  	flush_icache_range((unsigned long) p->addr,
>> >  			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>> 
>> Do we still need flush_icache_range() after patch_instruction()?
>
> Good catch! No, we don't

I picked this up independently.

cheers
