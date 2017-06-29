Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyycp1X0HzDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:49:30 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TBnGkE091015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 07:49:28 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcpx4xacv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 07:49:27 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 21:49:25 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TBnFiE2949506
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:49:23 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TBmobC028248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:48:50 +1000
Date: Thu, 29 Jun 2017 17:18:32 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/7] powerpc64/elfv1: Only dereference function
 descriptor for non-text symbols
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <46b6f6aaec8dd297c2d8e811c82dc2303ff13508.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170629204945.03bf29b8@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629204945.03bf29b8@roar.ozlabs.ibm.com>
Message-Id: <20170629114832.znasdovk2cl7o3wc@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/29 08:49PM, Nicholas Piggin wrote:
> On Thu, 29 Jun 2017 16:11:04 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Currently, we assume that the function pointer we receive in
> > ppc_function_entry() points to a function descriptor. However, this is
> > not always the case. In particular, assembly symbols without the right
> > annotation do not have an associated function descriptor. Some of these
> > symbols are added to the kprobe blacklist using _ASM_NOKPROBE_SYMBOL().
> > 
> > When such addresses are subsequently processed through
> > arch_deref_entry_point() in populate_kprobe_blacklist(), we see the
> > below errors during bootup:
> >     [    0.663963] Failed to find blacklist at 7d9b02a648029b6c
> >     [    0.663970] Failed to find blacklist at a14d03d0394a0001
> >     [    0.663972] Failed to find blacklist at 7d5302a6f94d0388
> >     [    0.663973] Failed to find blacklist at 48027d11e8610178
> >     [    0.663974] Failed to find blacklist at f8010070f8410080
> >     [    0.663976] Failed to find blacklist at 386100704801f89d
> >     [    0.663977] Failed to find blacklist at 7d5302a6f94d00b0
> > 
> > Fix this by checking if the function pointer we receive in
> > ppc_function_entry() already points to kernel text. If so, we just
> > return it as is. If not, we assume that this is a function descriptor
> > and proceed to dereference it.
> > 
> > Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/code-patching.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> > index abef812de7f8..5482928eea1b 100644
> > --- a/arch/powerpc/include/asm/code-patching.h
> > +++ b/arch/powerpc/include/asm/code-patching.h
> > @@ -83,8 +83,16 @@ static inline unsigned long ppc_function_entry(void *func)
> >  	 * On PPC64 ABIv1 the function pointer actually points to the
> >  	 * function's descriptor. The first entry in the descriptor is the
> >  	 * address of the function text.
> > +	 *
> > +	 * However, we may also receive pointer to an assembly symbol. To
> > +	 * detect that, we first check if the function pointer we receive
> > +	 * already points to kernel/module text and we only dereference it
> > +	 * if it doesn't.
> >  	 */
> > -	return ((func_descr_t *)func)->entry;
> > +	if (kernel_text_address((unsigned long)func))
> > +		return (unsigned long)func;
> > +	else
> > +		return ((func_descr_t *)func)->entry;
> 
> This seems good to me now. I guess it should do the right thing with
> modules too, looking at kernel_text_address implementation.

Yes, I've tested that by exercizing the jprobe sample module. We use 
this to lookup the address of the jprobe handler which happens to be in 
the jprobe module and it is working properly:
  $ sudo modprobe jprobe_example
  $ dmesg | grep Planted
  [ 4817.649072] Planted jprobe at c0000000000ed7b0, handler addr d0000000074b03e8
  $ sudo grep j_do_fork /proc/kallsyms
  d0000000074b03e8 d j_do_fork	[jprobe_example]
  d0000000074b0000 t .j_do_fork	[jprobe_example]

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

Thanks for the review,
- Naveen
