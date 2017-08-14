Return-Path: <srs0=kucv=7q=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWQc538DVzDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 05:27:33 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xWQc51y1yz8vNK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 05:27:33 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xWQc45Sbgz9t39
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2017 05:27:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EJNn3j023977
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 15:27:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cbe3j3c47-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2017 15:27:29 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 15:27:29 -0400
Date: Mon, 14 Aug 2017 12:27:15 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v6 14/17] powerpc: Add support for setting SPRN_TIDR
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-15-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502694131.9844.7.camel@neuling.org>
 <1502717435.4493.29.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502717435.4493.29.camel@au1.ibm.com>
Message-Id: <20170814192715.GC24096@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt [benh@au1.ibm.com] wrote:
> On Mon, 2017-08-14 at 17:02 +1000, Michael Neuling wrote:
> > > +/*
> > > + * We need to assign an unique thread id to each thread in a process. This
> > > + * thread id is intended to be used with the Fast Thread-wakeup (aka Core-
> > > + * to-core wakeup) mechanism being implemented on top of Virtual Accelerator
> > > + * Switchboard (VAS).
> > > + *
> > > + * To get a unique thread-id per process we could simply use task_pid_nr()
> > > + * but the problem is that task_pid_nr() is not yet available for the thread
> > > + * when copy_thread() is called. Fixing that would require changing more
> > > + * intrusive arch-neutral code in code path in copy_process()?.
> > > + *
> > > + * Further, to assign unique thread ids within each process, we need an
> > > + * atomic field (or an IDR) in task_struct, which again intrudes into the
> > > + * arch-neutral code.
> > 
> > Really?
> > 
> > > + * So try to assign globally unique thraed ids for now.
> > 
> > Yuck!

I know :-) copy_process() has:

        retval = copy_thread_tls(clone_flags, stack_start, stack_size, p, tls);
        if (retval)
                goto bad_fork_cleanup_io;

        if (pid != &init_struct_pid) {
                pid = alloc_pid(p->nsproxy->pid_ns_for_children);
                if (IS_ERR(pid)) {


so copy_thread() is called before a pid_nr is assigned to the task.

But see also response to Michael Ellerman.

> 
> Also CAPI has size limits for the TIDR afaik

Ok.

> 
> Ben.
