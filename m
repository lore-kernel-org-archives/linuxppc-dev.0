Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17783.16290.783728.708434@cargo.ozlabs.ibm.com>
Date: Thu, 7 Dec 2006 09:09:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH/RFC] Change the program check exception from EXC_XFER_STD
	to EXC_XFER_EE.
In-Reply-To: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
References: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> Is there any reason why ProgramCheck needs to be EXC_XFER_STD?

Yes.  It used to be EXC_XFER_EE, but I changed it to EXC_XFER_STD
because I didn't want the possibility of preemption on the way from a
kernel breakpoint into a kernel debugger (xmon/kgdb/etc.).

I think the solution to your problem is to rearrange
program_check_exception a little, to make sure we do the
local_irq_enable before calling do_mathemu (but still after the
debugger_bpt call).

Paul.
