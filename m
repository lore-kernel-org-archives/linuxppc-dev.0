Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNMlN1mxlzDvXq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:53:36 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMAn9YV034847
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:53:34 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vkwsmfyf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:53:33 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 16:23:30 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 47E79394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 16:23:28 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAMAqvc329360210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 16:22:57 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAMArPr5030301
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 16:23:27 +0530
Date: Tue, 22 Nov 2016 16:23:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc: kprobes: invoke handlers directly
References: <9dd0626d840e60b15603d767ce1576630fe1376d.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <1bde4adb6da9695007f409af9ea4db6be400ca54.1479745635.git.naveen.n.rao@linux.vnet.ibm.com>
 <20161122142537.42e365a22d866026aa726bfe@kernel.org>
 <20161122062549.GJ4019@naverao1-tp.localdomain>
 <87r363vlpr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r363vlpr.fsf@concordia.ellerman.id.au>
Message-Id: <20161122105313.GK4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/22 09:43PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > On 2016/11/22 02:25PM, Masami Hiramatsu wrote:
> >> On Mon, 21 Nov 2016 22:36:41 +0530
> >> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> >> > index 2c9759bd..da30dc3 100644
> >> > --- a/arch/powerpc/include/asm/kprobes.h
> >> > +++ b/arch/powerpc/include/asm/kprobes.h
> >> > @@ -32,6 +32,7 @@
> >> >  #include <asm/probes.h>
> >> >  #include <asm/code-patching.h>
> >> >  
> >> > +#ifdef CONFIG_KPROBES
> >> >  #define  __ARCH_WANT_KPROBES_INSN_SLOT
> >> >  
> >> >  struct pt_regs;
> >> > @@ -127,5 +128,11 @@ struct kprobe_ctlblk {
> >> >  extern int kprobe_exceptions_notify(struct notifier_block *self,
> >> >  					unsigned long val, void *data);
> >> >  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> >> > +extern int kprobe_handler(struct pt_regs *regs);
> >> > +extern int kprobe_post_handler(struct pt_regs *regs);
> >> > +#else
> >> > +static int kprobe_handler(struct pt_regs *regs) { return 0; }
> >> > +static int kprobe_post_handler(struct pt_regs *regs) { return 0; }
> >> 
> >> These should be "static inline int kprobe_...", you lost 'inline' here.
> >> Others are OK for me.
> >
> > Ah, indeed. Good catch. Thanks.
> >  
> > Michael,
> > Would you be ok to make this change when applying this, if you're ok 
> > with the rest of the patch?
> 
> Yep done.
> 
> Why do we still need kprobe_exceptions_notify() now that it's empty?
> Just to keep the generic code happy?

Yup. I took a look to see if we can get rid of it, but there are other 
architectures that need it.

Thanks!
- Naveen
