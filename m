Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNFpf4KWKzDw6V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 17:26:02 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM6NWvT021616
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 01:25:59 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v8cka6ga-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 01:25:59 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 16:25:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F1E52CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 17:25:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAM6PrVw57081890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 17:25:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAM6PqbJ017903
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 17:25:53 +1100
Date: Tue, 22 Nov 2016 11:55:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc: kprobes: invoke handlers directly
References: <9dd0626d840e60b15603d767ce1576630fe1376d.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <1bde4adb6da9695007f409af9ea4db6be400ca54.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <20161122142537.42e365a22d866026aa726bfe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161122142537.42e365a22d866026aa726bfe@kernel.org>
Message-Id: <20161122062549.GJ4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/22 02:25PM, Masami Hiramatsu wrote:
> Hello Naveen,

Hi Masami,

> 
> On Mon, 21 Nov 2016 22:36:41 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > ... rather than through notify_die(), to reduce path taken for handling
> > kprobes. Similar to commit 6f6343f53d13 ("kprobes/x86: Call exception
> > handlers directly from do_int3/do_debug").
> > 
> > While at it, rename post_kprobe_handler() to kprobe_post_handler() for
> > more uniform naming.
> > 
> > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > Changes since v1:
> > - Removed CONFIG_KPROBES guard in traps.c
> > - Introduce CONFIG_KPROBES guard in asm/kprobes.h to prevent conflicts when
> >   including both linux/kprobes.h as well as asm/kprobes.h
> > 
> >  arch/powerpc/include/asm/kprobes.h |  7 +++++++
> >  arch/powerpc/kernel/kprobes.c      | 29 +++++++----------------------
> >  arch/powerpc/kernel/traps.c        | 13 +++++++++++++
> >  3 files changed, 27 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> > index 2c9759bd..da30dc3 100644
> > --- a/arch/powerpc/include/asm/kprobes.h
> > +++ b/arch/powerpc/include/asm/kprobes.h
> > @@ -32,6 +32,7 @@
> >  #include <asm/probes.h>
> >  #include <asm/code-patching.h>
> >  
> > +#ifdef CONFIG_KPROBES
> >  #define  __ARCH_WANT_KPROBES_INSN_SLOT
> >  
> >  struct pt_regs;
> > @@ -127,5 +128,11 @@ struct kprobe_ctlblk {
> >  extern int kprobe_exceptions_notify(struct notifier_block *self,
> >  					unsigned long val, void *data);
> >  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> > +extern int kprobe_handler(struct pt_regs *regs);
> > +extern int kprobe_post_handler(struct pt_regs *regs);
> > +#else
> > +static int kprobe_handler(struct pt_regs *regs) { return 0; }
> > +static int kprobe_post_handler(struct pt_regs *regs) { return 0; }
> 
> These should be "static inline int kprobe_...", you lost 'inline' here.
> Others are OK for me.

Ah, indeed. Good catch. Thanks.
 
Michael,
Would you be ok to make this change when applying this, if you're ok 
with the rest of the patch? If not, please let me know and I will send 
an updated version.

Thanks,
Naveen
