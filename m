Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA1C2DDE9E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 19:43:55 +1100 (EST)
Date: Fri, 9 Mar 2007 08:43:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Complain about missing system calls.
Message-ID: <20070309084340.GA29959@flint.arm.linux.org.uk>
References: <1173394873.3461.510.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173394873.3461.510.camel@pmac.infradead.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2007 at 11:01:13PM +0000, David Woodhouse wrote:
> Most system calls seem to get added to i386 first. This patch
> automatically generates a warning for any new system call which is
> implemented on i386 but not the architecture currently being compiled.
> On PowerPC at the moment, for example, it results in these warnings:
> init/missing_syscalls.h:935:3: warning: #warning syscall sync_file_range not implemented
> init/missing_syscalls.h:947:3: warning: #warning syscall getcpu not implemented
> init/missing_syscalls.h:950:3: warning: #warning syscall epoll_pwait not implemented
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

You might also like to add:

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

since I did resolve the issues with getting a sed expression which
did the right thing, rather than your for loop, awk, echo, and
providing a way to ignore the lack of certain syscall numbers...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
