Return-Path: <ananth@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F00B0B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:37:54 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 6 Jun 2012 05:37:52 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C0EE338C8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 05:37:49 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q569bnFB147636
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 05:37:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q569blpD004891
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 06:37:49 -0300
Date: Wed, 6 Jun 2012 15:07:44 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120606093744.GB29580@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com> <1338974632.2749.87.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338974632.2749.87.camel@twins>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2012 at 11:23:52AM +0200, Peter Zijlstra wrote:
> On Wed, 2012-06-06 at 14:49 +0530, Ananth N Mavinakayanahalli wrote:
> > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, loff_t vaddr)
> 
> Don't we traditionally use unsigned long to pass vaddrs?

Right. But the vaddr we pass here is vma_info->vaddr which is loff_t.
I guess I should've made that clear in the patch description.

Ananth
