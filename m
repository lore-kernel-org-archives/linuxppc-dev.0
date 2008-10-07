Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id AF8C1DE059
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 03:48:12 +1100 (EST)
Received: by gxk14 with SMTP id 14so9322949gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Oct 2008 09:48:11 -0700 (PDT)
Date: Tue, 7 Oct 2008 12:46:41 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix error path in kernel_thread function
Message-ID: <20081007164641.GA5788@yoda.jdub.homelinux.org>
References: <20081007161003.GA5727@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081007161003.GA5727@yoda.jdub.homelinux.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, jpoimboe@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 07, 2008 at 12:10:03PM -0400, Josh Boyer wrote:
>From: Josh Poimboeuf <jpoimboe@us.ibm.com>
>
>The powerpc 32-bit and 64-bit kernel_thread functions don't properly
>propagate errors being returned by the clone syscall.  (In the case of
>error, the syscall exit code returns a positive errno in r3 and sets
>the CR0[SO] bit.)
>
>This patch fixes that by negating r3 if CR0[SO] is set after the syscall.
>
>Signed-off-by: Josh Poimboeuf <jpoimboe@us.ibm.com>
>Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

FYI, I boot tested this on a G5 this morning.  A variant for an older
kernel was also tested on a 440-based board.

Not what I would call exhaustive testing, but at least it didn't
crash and burn.

josh
