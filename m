Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHbKn2QSzzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 23:19:09 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6QDIxuw078772
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 09:19:07 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bxqghdprq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 09:19:06 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 10:19:03 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6QDJ0TD38863000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 10:19:00 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6QAJ0cJ029376
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:19:00 -0300
Date: Wed, 26 Jul 2017 10:18:48 -0300
From: joserz@linux.vnet.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, oohall@gmail.com
Subject: Re: KVM guests freeze under upstream kernel
References: <20170719194634.GA1222@pacoca>
 <1500507770.3350.41.camel@kernel.crashing.org>
 <20170720030222.GA21034@pacoca>
 <20170720052159.GB8602@fergus.ozlabs.ibm.com>
 <20170721011818.GC13187@pacoca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170721011818.GC13187@pacoca>
Message-Id: <20170726131848.GA13783@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 20, 2017 at 10:18:18PM -0300, joserz@linux.vnet.ibm.com wrote:
> On Thu, Jul 20, 2017 at 03:21:59PM +1000, Paul Mackerras wrote:
> > On Thu, Jul 20, 2017 at 12:02:23AM -0300, joserz@linux.vnet.ibm.com wrote:
> > > On Thu, Jul 20, 2017 at 09:42:50AM +1000, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2017-07-19 at 16:46 -0300, joserz@linux.vnet.ibm.com wrote:
> > > > > Hello!
> > > > > 
> > > > > We're not able to boot any KVM guest using upstream kernel (cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4.13.0-rc1+).
> > > > > After reaching the SLOF initial counting, the guest simply freezes:
> > > > 
> > > > Can you send our .config ?
> > > 
> > > Sure,
> > > 
> > > Answering Michael as well:
> > > 
> > > It's a P9 with RHEL kernel 4.11.0-10.el7a.ppc64le installed. The problem
> > > was noticed with kernel > 4.13 (I'm currently running 4.13.0-rc1+).
> > > 
> > > QEMU is https://github.com/dgibson/qemu (ppc-for-2.10) but I gave the
> > > default packaged Qemu a try.
> > > 
> > > For the guest, I tried both a vanilla Ubuntu 17.04 and the host kernel.
> > > But they had never a chance to run since the freezing happened in SLOF.
> > > 
> > > Note that using the 4.11.0-10.el7a.ppc64le kernel it works fine
> > > (for any of these Qemu/Guest setup). With 4.13.0-rc1 I have it run after
> > > reverting that referred commit.
> > 
> > Is the host kernel running in radix mode?
> 
> yes
> 
> > 
> > Did you check the host kernel logs for any oops messages?
> 
> dmesg was clean but after sometime waiting (I forgot QEMU running in
> another terminal) I got the oops below (after rebooting the host I 
> couldn't reproduce it again).
> 
> Another test that I did was:
> Compile with transparent huge pages disabled: KVM works fine
> Compile with transparent huge pages enabled: doesn't work
>   + disabling it in /sys/kernel/mm/transparent_hugepage: doesn't work
> 
> Just out of my own curiosity I made this small change:
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> b/arch/powerpc/include
> index c0737c8..f94a3b6 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -80,7 +80,7 @@
>  
>   #define _PAGE_SOFT_DIRTY       _RPAGE_SW3 /* software: software dirty
>   tracking 
>    #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special page */
>    -#define _PAGE_DEVMAP           _RPAGE_SW1 /* software: ZONE_DEVICE page */
>    +#define _PAGE_DEVMAP           _RPAGE_RSV3
>     #define __HAVE_ARCH_PTE_DEVMAP
> 
> and it works. I chose _RPAGE_RSV3 because it uses the same value that
> x86 uses (0x0400000000000000UL) but I don't if it could have any side
> effect
> 

Does this change make any sense to you people?
I didn't see any side effect expect that devices backed memory will have
a bigger address space in transparent huge pages IF I understand that
correctly.

If so I can send a patch with this change.

Thank you!!
