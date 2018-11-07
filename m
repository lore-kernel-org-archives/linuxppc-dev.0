Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA6C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 10:42:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B3320827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 10:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B3320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qjf01bfMzF3H0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 21:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qjc114NSzF37l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 21:40:16 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wA7Adiab003112;
 Wed, 7 Nov 2018 04:39:46 -0600
Message-ID: <9dbae86776aefb2aee44cada3ab4cfacb471774b.camel@kernel.crashing.org>
Subject: Re: [PATCH 12/24] powerpc/mm: Fix reporting of kernel execute faults
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 07 Nov 2018 21:39:44 +1100
In-Reply-To: <64d43dc0-60ad-4346-96c9-2ff46867d9c9@c-s.fr>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-12-benh@kernel.crashing.org>
 <64d43dc0-60ad-4346-96c9-2ff46867d9c9@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-07 at 09:35 +0100, Christophe LEROY wrote:
> Hi Ben,
> 
> I have an issue on the 8xx with this change

Ah ouch...

 .../...
  
> > +/* Is this a bad kernel fault ? */
> > +static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
> > +			     unsigned long address)
> > +{
> > +	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT))) {
> 
> Do you mind if we had DSISR_PROTFAULT here as well ?

Off the top of my mind, I don't see a problem with that... but it would
definitely require an explanation comment.

> > +		printk_ratelimited(KERN_CRIT "kernel tried to execute"
> > +				   " exec-protected page (%lx) -"
> > +				   "exploit attempt? (uid: %d)\n",
> > +				   address, from_kuid(&init_user_ns,
> > +						      current_uid()));
> > +	}
> > +	return is_exec || (address >= TASK_SIZE);
> > +}
> > +
> >   /*
> >    * Define the correct "is_write" bit in error_code based
> >    * on the processor family
> > @@ -252,7 +266,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
> >   	 * The kernel should never take an execute fault nor should it
> >   	 * take a page fault to a kernel address.
> >   	 */
> > -	if (!is_user && (is_exec || (address >= TASK_SIZE)))
> > +	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
> >   		return SIGSEGV;
> >   
> >   	/* We restore the interrupt state now */
> > @@ -491,11 +505,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
> >   		return 0;
> >   	}
> >   
> > -	if (is_exec && (error_code & DSISR_PROTFAULT))
> > -		printk_ratelimited(KERN_CRIT "kernel tried to execute NX-protected"
> > -				   " page (%lx) - exploit attempt? (uid: %d)\n",
> > -				   address, from_kuid(&init_user_ns, current_uid()));
> > -
> >   	return SIGSEGV;
> >   }
> >   NOKPROBE_SYMBOL(__do_page_fault);
> > 

