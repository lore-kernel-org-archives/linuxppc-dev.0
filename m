Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC9C1DDF5E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 06:25:36 +1100 (EST)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Siewior <bigeasy@linutronix.de>
In-Reply-To: <20080901142302.GA13754@www.tglx.de>
References: <20080901142302.GA13754@www.tglx.de>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 14:25:20 -0500
Message-Id: <1224012320.7879.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-09-01 at 16:23 +0200, Sebastian Siewior wrote:
> those two are requried on my fresh gcc 4.3.1
> 
> Signed-off-by: Thiemo Seufer <ths@linutronix.de>
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
> ---
> Not sure if this is intendent or a gcc bug but with -mno-spe
> the spe opcodes were not used floating point anymore but
> for 64bit save/restore for instance.

I wouldn't say this is due to a broken compiler. As I understand it,
-mabi=no-spe and -mspe=no serve two different purposes.  One is for
disabling the SPE instructions and the other controls the ABI (which
would make those 64-bit save/restores I'm guessing).  I don't know why
you'd ever want to use the SPE ABI without -mspe=yes, but gcc does
provide that flexibility.

	-mno-spe: Deprecated way to say "no SPE instructions"
	-mspe=no: New way to do -mno-spe
	-mabi=no-spe: Disable SPE ABI

Some compilers may enable "-mabi=spe" and/or "-mspe=yes" by default, so
explicitly disabling both is necessary.  I recently built a SPE
toolchain which enabled both by default, so I ran into the "SPE used in
kernel" problem when the kernel only passed "-mno-spe".
	
- Nate Case <ncase@xes-inc.com>
