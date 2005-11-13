Return-Path: <SRS0+0c11b2d6486fa6634c62+812+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAA9268713
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 20:41:33 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17270.58406.370195.733887@cargo.ozlabs.ibm.com>
References: <1131745047.21212.194.camel@hades.cambridge.redhat.com>
	<17269.14127.936147.778781@cargo.ozlabs.ibm.com>
	<1131756526.27347.212.camel@baythorne.infradead.org>
	<17270.58406.370195.733887@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 09:41:26 +0000
Message-Id: <1131874887.27347.221.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Attempt to clean up sigsuspend et al
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-11-13 at 17:58 +1100, Paul Mackerras wrote:
> Or have a mark in the syscall table (e.g. set the bottom bit of the
> address) for the syscalls that need the full register set.  That does
> mean an extra conditional branch in the syscall entry path for all
> syscalls, though.

We don't need to do it on entry; we can do it on exit. If do_signal()
sees that the nvgprs weren't saved in the pt_regs it's playing with,
then it can set a new TIF_SAVENVPGRS_TO_SIG_FRAME bit. I don't think we
even need to store a pointer saying where to put them -- the signal
frame will always be at the top of the userspace stack.

As long as we handle the new bit before TIF_SIGPENDING and before
another call to do_signal(), we don't need to worry about recursive
signals and having to fill in more than one signal frame.

-- 
dwmw2
