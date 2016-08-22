Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHZyL5yMJzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 11:01:14 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id h186so5257028pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 18:01:14 -0700 (PDT)
Message-ID: <1471827666.758.3.camel@gmail.com>
Subject: Re: [PATCH] ppc64: allow ptrace to set TM bits
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Date: Mon, 22 Aug 2016 11:01:06 +1000
In-Reply-To: <20160802054351.GA16975@simonLocalRHEL7.x64>
References: <1469785882-9892-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20160802054351.GA16975@simonLocalRHEL7.x64>
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

On Tue, 2016-08-02 at 13:43 +0800, Simon Guo wrote:
> Hi Laurent,
> On Fri, Jul 29, 2016 at 11:51:22AM +0200, Laurent Dufour wrote:
> > 
> >  static int set_user_msr(struct task_struct *task, unsigned long
> > msr)
> >  {
> > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> > +	if (!(task->thread.regs->msr & MSR_TM)) {
> > +		/* If TM is not available, discard TM bits changes
> > */
> > +		msr &= ~(MSR_TM | MSR_TS_MASK);
> > +	}
> > +#endif
> 
> I am not sure whether following is an issue:
> Per PowerISA, any exception/interrupt will disable MSR[TM] bit 
> automatically and mark MSR_TS to be suspended when it is 
> transactional. It is possible that MSR[TM] = 0 and MSR[MSR_TS] != 0
> (suspended). 
> 
> Will set_user_msr() be able to escape from the above?
>  For example, one user space application encountered 
> page fault during transaction, its task->thread.regs->msr & MSR_TM ==
> 0
> and MSR[MSR_TS] == suspended.  Then it is being traced and 
> set_user_msr() is invoked on it. I think it will be incorrect to 
> clear its  MSR_TS_MASK bits.....
> 
> (suspended).ible that MSRTM] = 0 and MSR[MSR_TS] != 0> (suspended).

> Please correct me if I am wrong.

I'm not very familiar with ptracing and exactly what can happen but I
agree with Simon. Trying to change an MSR with that possible condition
stated ("It is possible that MSR[TM] = 0 and MSR[MSR_TS] !=
0> (suspended)") to MSR_TS and MSR_TS_MASK bits all 0 will cause a Bad
Thing.

Cyril

> 
> Thanks,
> - Simon
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
