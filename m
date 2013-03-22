Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EE7D32C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 02:07:19 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 22 Mar 2013 11:07:17 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DF05138C806F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 11:07:13 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2MF7Drc29425902
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 11:07:13 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2MF7D4m014316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 12:07:13 -0300
Date: Fri, 22 Mar 2013 20:37:01 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/3] uprobes: add trap variant helper
Message-ID: <20130322150701.GA20010@in.ibm.com>
References: <20130322114446.GG26183@in.ibm.com>
 <20130322145406.GB17286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322145406.GB17286@redhat.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 22, 2013 at 03:54:06PM +0100, Oleg Nesterov wrote:
> On 03/22, Ananth N Mavinakayanahalli wrote:
> >
> > +/**
> > + * is_trap_insn - check if instruction is breakpoint instruction.
> > + * @insn: instruction to be checked.
> > + * Default implementation of is_trap_insn
> > + * Returns true if @insn is a breakpoint instruction.
> > + *
> > + * This function is needed for the case where an architecture has multiple
> > + * trap instructions (like powerpc).
> > + */
> > +bool __weak is_trap_insn(uprobe_opcode_t *insn)
> > +{
> > +	return is_swbp_insn(insn);
> > +}
> 
> OK, thanks, the whole series looks fine, just one note...

OK.

> My patch also changed prepare_uprobe() to use is_trap_insn(), and I think
> this is right. Exactly because of 3/3 which removes is_trap() from
> arch_uprobe_analyze_insn().
> 
> If the original insn is_trap(), we do not want to singlestep it and get
> another trap after we hit handle_swbp().

OK, I'll send a v2 with that change.

Ananth
