Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 4BDE067A64
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2005 17:56:17 +1000 (EST)
Date: Tue, 29 Mar 2005 23:25:58 -0800
From: Brad Boyer <flar@allandria.com>
To: ashwin tanugula <ashwin.tanugula@gmail.com>
Message-ID: <20050330072558.GA13087@pants.nu>
References: <838f7c50050329170146631318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <838f7c50050329170146631318@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ptrace and ORIG_EAX on ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2005 at 08:01:06PM -0500, ashwin tanugula wrote:
> Hi!
> Can somebody tell me how to set references to ORIG_EAX in ppc kernel.
> We know ORIG_EAX is defined in unistd.h of i386. How do i make the
> following program print two same pids in ppc?

The ORIG_EAX is a reference to a register as saved in the stack. The
equivalent on ppc would seem to be PT_ORIG_R3. You're digging around
in an area that is extremely non-portable. This program appears to
be messing around with the syscall number before dispatch in the
syscall table. The implementation of ptrace on ppc and ppc64
explicitly does not allow changing this value, so I think you'll need
to find a completely different way to achieve your desired result.

Just to lessen the confusion, what are you trying to accomplish? Not
in the low-level detail sense, but what is the big picture goal?

	Brad Boyer
	flar@allandria.com
