Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 748112C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 02:04:00 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 24 Aug 2012 02:03:11 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7NFtBFA29163630
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 01:55:11 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7NG3rPu016056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 02:03:54 +1000
Date: Thu, 23 Aug 2012 21:32:10 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120823160210.GF25338@linux.vnet.ibm.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com>
 <1345696100.3338.21.camel@concordia>
 <20120823053234.GE25338@linux.vnet.ibm.com>
 <1345716378.29170.4.camel@pasglop>
 <20120823090209.GA4630@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120823090209.GA4630@redhat.com>
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Oleg Nesterov <oleg@redhat.com> [2012-08-23 11:02:09]:

> On 08/23, Benjamin Herrenschmidt wrote:
> >
> > On Thu, 2012-08-23 at 11:02 +0530, Srikar Dronamraju wrote:
> > > >
> > >
> > > insn is updated/accessed in the arch independent code. Size of
> > > uprobe_opcode_t could be different for different archs.
> > > uprobe_opcode_t
> > > represents the size of the smallest breakpoint instruction for an
> > > arch.
> > >
> > > Hence u8 works out the best. I know we could still use uprobe_opcode_t
> > > and achieve the same. In which case, we would have to interpret
> > > MAX_UINSN_BYTES differently. Do you see any advantages of using
> > > uprobe_opcode_t instead of u8 across archs?
> >
> > But don't you actively rely on the fact that on powerpc, unlike x86, you
> > -can- atomically replace an instruction with a single 32-bit store ?
> 
> I must have missed something...
> 
> But powerpc does not replace an instruction, the arch independent code
> does this and it assumes that uprobe->arch.insn is u8[MAX_UINSN_BYTES].
> 
> Perhaps you meant that on powerpc it is "safe" to replace the insn
> even if this can race with some CPU executing this code? But uprobes
> has to replace the original page anyway, we should not write to
> ->vm_file.

I think Ben is referring to the fact that because we use an array we
endup using memcpy to copy the original instruction from the ->vm_file.

> 
> I agree that memcpy() in arch_uprobe_analyze_insn() and
> arch_uprobe_skip_sstep() looks a bit strange. May be powerpc can do
> 
> 	struct arch_uprobe {
> 		union {
> 			u8		insn[MAX_UINSN_BYTES];
> 			u32		ainsn;
> 		};
> 	};
> 
> and use auprobe->ainsn directly, I dunno.

I think this should work.

Ben  would this suffice?
