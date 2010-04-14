Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.17.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3A7BB7D22
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 02:59:51 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.1/8.13.1) with ESMTP id o3EGxaTF001735
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 16:59:36 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o3EGxa2U1593386
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 18:59:36 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o3EGxZKf026382
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2010 18:59:35 +0200
Date: Wed, 14 Apr 2010 19:00:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Masami Hiramatsu <mhiramat@redhat.com>
Subject: Re: [PATCH v2 1/2] perf: Move arch specific code into separate
	arch directory
Message-ID: <20100414170008.GA2359@osiris.boeblingen.de.ibm.com>
References: <1271221600-25533-1-git-send-email-imunsie@au.ibm.com>
	<1271221600-25533-2-git-send-email-imunsie@au.ibm.com>
	<4BC5D534.8010508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BC5D534.8010508@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 14, 2010 at 07:46:12AM -0700, Masami Hiramatsu wrote:
> Ian Munsie wrote:
> > From: Ian Munsie <imunsie@au.ibm.com>
> > 
> > The perf userspace tool included some architecture specific code to map
> > registers from the DWARF register number into the names used by the regs
> > and stack access API.
> > 
> > This patch moves the architecture specific code out into a separate
> > arch/x86 directory along with the infrastructure required to use it.
> > 
> > Signed-off-by: Ian Munsie <imunsie@au.ibm.com>
> > ---
> > Changes since v1: From Masami Hiramatsu's suggestion, I added a check in the
> > Makefile for if the arch specific Makefile defines PERF_HAVE_DWARF_REGS,
> > printing a message during build if it has not. This simplifies the code
> > removing the odd macro from the previous version and the need for an arch
> > specific arch_dwarf-regs.h. I have not entirely disabled DWARF support for
> > architectures that don't implement the register mappings, so that they can
> > still add a probe based on a line number (they will be missing the ability to
> > capture the value of a variable from a register).
> 
> Hmm, sorry, I don't think it is a good way to go... IMHO, porting dwarf-regs.c
> is so easy (you can just refer systemtap/runtime/loc2c-runtime.h), easier
> than porting kprobe-tracer on another arch. And perf is a part of kernel tree.
> It means that someone who are porting kprobe-tracer, he should port
> dwarf-regs.c too. In that case, PERF_HAVE_DWARF_REGS flag will be used only
> between those two patches in same patchset. So, I suggested you to drop dwarf
> support if dwarf-regs mapping doesn't exist.
> 
> AFAIK, at this point, only s390 users are affected. I'd like to ask
> them to just port a register mapping on perf and test it too.

Hm, I'm a bit lost here. Probably due to lack of context. What would be missing
on s390 and what am I supposed to implement and how can I test it?
Any pointers to git commits?
