Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNMWl00f0zDvrt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:43:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc: kprobes: invoke handlers directly
In-Reply-To: <20161122062549.GJ4019@naverao1-tp.localdomain>
References: <9dd0626d840e60b15603d767ce1576630fe1376d.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <1bde4adb6da9695007f409af9ea4db6be400ca54.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <20161122142537.42e365a22d866026aa726bfe@kernel.org>
 <20161122062549.GJ4019@naverao1-tp.localdomain>
Date: Tue, 22 Nov 2016 21:43:28 +1100
Message-ID: <87r363vlpr.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> On 2016/11/22 02:25PM, Masami Hiramatsu wrote:
>> On Mon, 21 Nov 2016 22:36:41 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
>> > index 2c9759bd..da30dc3 100644
>> > --- a/arch/powerpc/include/asm/kprobes.h
>> > +++ b/arch/powerpc/include/asm/kprobes.h
>> > @@ -32,6 +32,7 @@
>> >  #include <asm/probes.h>
>> >  #include <asm/code-patching.h>
>> >  
>> > +#ifdef CONFIG_KPROBES
>> >  #define  __ARCH_WANT_KPROBES_INSN_SLOT
>> >  
>> >  struct pt_regs;
>> > @@ -127,5 +128,11 @@ struct kprobe_ctlblk {
>> >  extern int kprobe_exceptions_notify(struct notifier_block *self,
>> >  					unsigned long val, void *data);
>> >  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
>> > +extern int kprobe_handler(struct pt_regs *regs);
>> > +extern int kprobe_post_handler(struct pt_regs *regs);
>> > +#else
>> > +static int kprobe_handler(struct pt_regs *regs) { return 0; }
>> > +static int kprobe_post_handler(struct pt_regs *regs) { return 0; }
>> 
>> These should be "static inline int kprobe_...", you lost 'inline' here.
>> Others are OK for me.
>
> Ah, indeed. Good catch. Thanks.
>  
> Michael,
> Would you be ok to make this change when applying this, if you're ok 
> with the rest of the patch?

Yep done.

Why do we still need kprobe_exceptions_notify() now that it's empty?
Just to keep the generic code happy?

cheers
