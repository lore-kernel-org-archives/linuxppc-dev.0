Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8E47DDEC4
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 02:12:14 +1100 (EST)
Sender: ak@suse.de
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Complain about missing system calls.
References: <1173394873.3461.510.camel@pmac.infradead.org>
From: Andi Kleen <andi@firstfloor.org>
Date: 09 Mar 2007 17:11:10 +0100
In-Reply-To: <1173394873.3461.510.camel@pmac.infradead.org>
Message-ID: <p737itqbdnl.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sam@ravnborg.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse <dwmw2@infradead.org> writes:

> Most system calls seem to get added to i386 first. This patch
> automatically generates a warning for any new system call which is
> implemented on i386 but not the architecture currently being compiled.
> On PowerPC at the moment, for example, it results in these warnings:
> init/missing_syscalls.h:935:3: warning: #warning syscall sync_file_range not implemented
> init/missing_syscalls.h:947:3: warning: #warning syscall getcpu not implemented
> init/missing_syscalls.h:950:3: warning: #warning syscall epoll_pwait not implemented

I think a better solution would be to finally switch to auto generated
system call tables for newer system calls. The original reason why the
architectures have different system call numbers -- compatibility with
another "native" Unix -- is completely obsolete now. This leaves only
minor differences of compat stub vs non compat stub and a few
architecture specific calls.

Of course the existing syscall numbers can't be changed, but for all new 
calls one could just add automatically for everybody.

A global table with two entries (compat and non compat) and a per arch 
override table should be sufficient.

Comments?

-Andi
