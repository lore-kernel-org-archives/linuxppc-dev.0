Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKwvN5KCrzDvvt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:37:04 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIBYtPn130293
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:37:02 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26sytek55c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:37:02 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 21:37:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6996E3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:36:58 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAIBawYa6095218
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:36:58 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAIBavuO017564
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:36:58 +1100
Date: Fri, 18 Nov 2016 17:06:54 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 1/4] powerpc: asm: introduce new macros for assembly
 globals
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <e4e5fb867e0190aea3f30591fb5025b55bb8f2c5.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <87poltgm6e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87poltgm6e.fsf@concordia.ellerman.id.au>
Message-Id: <20161118113654.GH4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/18 08:41PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > - Introduce _GLOBAL_SYM() for global symbols in assembly. This helps
> > reduce verbosity of assembly files.
> 
> Unfortunately you've walked into a bit of mine field here :)
> 
> In user space they use FUNC_START() to declare the start of a function,
> and we should do the same. Anton added FUNC_START/END, but didn't quite
> get around to converting everything, see 151f25112ff7 ("powerpc: define
> FUNC_START/FUNC_END").
> 
> So what I'd like is all uses of _GLOBAL() to become FUNC_START(), and
> then we can change _GLOBAL() to just define a global symbol.

Can't say I didn't get tempted to rename _GLOBAL() to _GLOBAL_FUNC() :D
I'll convert the files I touch.

> 
> We can probably decouple that from most of this series though, as I
> mentioned in my other reply, just by using _ASM_NOKPROBE_SYMBOL().

Sure.

Thanks!
- Naveen
