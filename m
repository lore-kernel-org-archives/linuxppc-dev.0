Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wchf5352hzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:17:17 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UI8uBG092912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:17:11 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2as9w1cb85-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:17:11 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 31 May 2017 04:17:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4UIGwai1835358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:17:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4UIGXgm004337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:16:33 +1000
Date: Tue, 30 May 2017 23:46:16 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/jprobes: Save and restore the parameter save
 area
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170517101248.7b3d2a5f38fff1a765df9687@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517101248.7b3d2a5f38fff1a765df9687@kernel.org>
Message-Id: <20170530181616.GS19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/17 10:12AM, Masami Hiramatsu wrote:
> On Mon, 15 May 2017 23:35:03 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> > index a83821f33ea3..b6960ef213ac 100644
> > --- a/arch/powerpc/include/asm/kprobes.h
> > +++ b/arch/powerpc/include/asm/kprobes.h
> > @@ -61,6 +61,15 @@ extern kprobe_opcode_t optprobe_template_end[];
> >  #define MAX_OPTINSN_SIZE	(optprobe_template_end - optprobe_template_entry)
> >  #define RELATIVEJUMP_SIZE	sizeof(kprobe_opcode_t)	/* 4 bytes */
> >  
> > +/* Save upto 16 parameters along with the stack frame header */
> > +#define MAX_STACK_SIZE		(STACK_FRAME_PARM_SAVE + (16 * sizeof(unsigned long)))
> > +#define MIN_STACK_SIZE(ADDR)					       \
> > +	(((MAX_STACK_SIZE) < (((unsigned long)current_thread_info()) + \
> > +			      THREAD_SIZE - (unsigned long)(ADDR)))    \
> > +	 ? (MAX_STACK_SIZE)					       \
> > +	 : (((unsigned long)current_thread_info()) +		       \
> > +	    THREAD_SIZE - (unsigned long)(ADDR)))
> 
> Could you add CUR_STACK_SIZE(addr) as x86 does instead of repeating similar code?

Sure, thanks for calling me out on this ;D

- Naveen
