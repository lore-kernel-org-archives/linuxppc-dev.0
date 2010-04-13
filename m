Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 074A2B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 18:44:43 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3D8evpd002799
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 18:40:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3D8cGLD1609766
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 18:38:16 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3D8if8Y006418
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 18:44:41 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 1/2] perf: Move arch specific code into separate arch
	directory
From: Ian Munsie <imunsie@au1.ibm.com>
To: Masami Hiramatsu <mhiramat@redhat.com>
In-reply-to: <4BC313EF.4040406@redhat.com>
References: <1271054596-26561-1-git-send-email-imunsie@au.ibm.com>
	<1271054596-26561-2-git-send-email-imunsie@au.ibm.com>
	<4BC313EF.4040406@redhat.com>
Date: Tue, 13 Apr 2010 18:44:14 +1000
Message-Id: <1271147886-sup-8960@au1.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Masami,

Thanks for the feedback

Excerpts from Masami Hiramatsu's message of Mon Apr 12 22:37:03 +1000 2010:
> Could you add a check whether the get_arch_regstr() is defined
> (or dwarf-regs.h is exist) in Makefile?
> If it is not defined, we'd better drop dwarf support(so set NO_DWARF),
> because it means we haven't ported perf probe on that architecture yet. :)

I was a little reluctant to do that when I first read your message
because it felt like adding autoconf stuff into the Makefile and the
code should already fail gracefully on architectures without the
register mappings. But, since the Makefile already has some autoconf
like magic and it would make the code cleaner, I'll play with the idea a
bit more tomorrow.

> > diff --git a/tools/perf/arch/x86/include/arch_dwarf-regs.h b/tools/perf/arch/x86/include/arch_dwarf-regs.h
> > new file mode 100644
> > index 0000000..9e8da6a
> > --- /dev/null
> > +++ b/tools/perf/arch/x86/include/arch_dwarf-regs.h
> > @@ -0,0 +1,6 @@
> > +#ifndef _PREF_ARCH_PPC_DWARF_REGS_H
> > +#define _PREF_ARCH_PPC_DWARF_REGS_H
> 
> _PREF_ARCH_X86_DWARF_REGS_H ?

Nice catch (oops)


Cheers,
-Ian
