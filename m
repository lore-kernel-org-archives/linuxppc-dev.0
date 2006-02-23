Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17406.15816.112314.494845@cargo.ozlabs.ibm.com>
Date: Fri, 24 Feb 2006 09:57:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC: Sleeping function called from invalid context at
	emulate_instruction()
In-Reply-To: <7A04DCF5-C5CF-46E2-A133-A7743BD83B17@kernel.crashing.org>
References: <200602222129.31700.mbuesch@freenet.de>
	<7A04DCF5-C5CF-46E2-A133-A7743BD83B17@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Michael Buesch <mbuesch@freenet.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Last time this was brought up we left it wondering why you had made  
> program_check_exception() run with interrupts disabled.  Any further  
> ideas on that one?

I think it was so that if we are entering the kernel debugger, we do
so on the same cpu that the exception was generated on.  This should
fix it.

Paul.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 7509aa6..98660ae 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -814,6 +814,8 @@ void __kprobes program_check_exception(s
 		return;
 	}
 
+	local_irq_enable();
+
 	/* Try to emulate it if we should. */
 	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
 		switch (emulate_instruction(regs)) {
