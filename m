Return-Path: <ananth@in.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B447B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 14:33:50 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 8 Jun 2012 00:33:45 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EC5026E8049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 00:33:20 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q584XKXh183120
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 00:33:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q584XJb6023048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 01:33:20 -0300
Date: Fri, 8 Jun 2012 10:03:19 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120608043319.GA13409@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <1338974632.2749.87.camel@twins> <20120606093744.GB29580@in.ibm.com>
 <20120606094014.GD9495@gmail.com> <20120606114423.GA32094@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606114423.GA32094@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2012 at 05:14:23PM +0530, Srikar Dronamraju wrote:
> * Ingo Molnar <mingo@kernel.org> [2012-06-06 11:40:15]:
> 
> > 
> > * Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
> > 
> > > On Wed, Jun 06, 2012 at 11:23:52AM +0200, Peter Zijlstra wrote:
> > > > On Wed, 2012-06-06 at 14:49 +0530, Ananth N Mavinakayanahalli wrote:
> > > > > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, loff_t vaddr)
> > > > 
> > > > Don't we traditionally use unsigned long to pass vaddrs?
> > > 
> > > Right. But the vaddr we pass here is vma_info->vaddr which is loff_t.
> > > I guess I should've made that clear in the patch description.
> > 
> > Why not fix struct vma_info's vaddr type?
> > 
> 
> Calculating and comparing vaddr results either uses variables of type loff_t. 
> To avoid typecasting and avoid overflow at each of these places, we used
> loff_t. 
> 
> Ananth, install_breakpoint() already has a variable of type addr of type
> unsigned long.  Why dont you use addr instead of vaddr. 

Ok, makes sense. I'll change it in v2.

Ananth
