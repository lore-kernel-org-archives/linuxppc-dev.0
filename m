Return-Path: <ananth@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A313FB6F77
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:35:54 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 6 Jun 2012 03:35:51 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 256E1C90052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 05:35:46 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q569Zknw100174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 05:35:46 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q569Zj4n031069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 06:35:46 -0300
Date: Wed, 6 Jun 2012 15:05:41 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] [POWERPC] uprobes: powerpc port
Message-ID: <20120606093541.GA29580@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <20120606092150.GC6745@in.ibm.com> <1338974822.2749.89.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338974822.2749.89.camel@twins>
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

On Wed, Jun 06, 2012 at 11:27:02AM +0200, Peter Zijlstra wrote:
> On Wed, 2012-06-06 at 14:51 +0530, Ananth N Mavinakayanahalli wrote:
> > One TODO in this port compared to x86 is the uprobe abort_xol() logic.
> > x86 depends on the thread_struct.trap_nr (absent in powerpc) to determine
> > if a signal was caused when the uprobed instruction was single-stepped/
> > emulated, in which case, we reset the instruction pointer to the probed
> > address and retry the probe again. 
> 
> Another curious difference is that x86 uses an instruction decoder and
> contains massive tables to validate we can probe a particular
> instruction.
> 
> Can we probe all possible PPC instructions?

For the kernel, the only ones that are off limits are rfi (return from
interrupt), mtmsr (move to msr). All other instructions can be probed.

Both those instructions are supervisor level, so we won't see them in
userspace at all; so we should be able to probe all user level
instructions.

I am not aware of specific caveats for vector/altivec instructions;
maybe Paul or Ben are more suitable to comment on that.

Ananth
