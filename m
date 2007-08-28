Return-Path: <Udo.Visser@heidelberg.com>
Received: from wiems06002.ceu.heidelberg.com (wiems06002.ceu.heidelberg.com
	[193.99.214.201]) by ozlabs.org (Postfix) with ESMTP id 72660DDF01
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 19:55:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ppc/powerpc, remote debugging (ptrace), floating point variables
Date: Tue, 28 Aug 2007 11:40:17 +0200
Message-ID: <40D0BF15B1434F469B8639BF3A31D6F20B5F28@wiems02014.ceu.corp.heidelberg.com>
From: "Visser, Udo RD-IS-E23" <Udo.Visser@heidelberg.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello world, ;-)

when stepping through my own software, which is using floating point =
variables, gdb showed weird results (mostly NAN=B4s) for these =
variables. Running the software without gdb did not show any problems. =
The software is compiled with floating point instructions and the =
results (without gdb) are OK.

My setup:

MPC8349 target, "home grown", much like the MPC8349EMDS, running 2.6.16 =
(ppc)
GDB, gdbserver 6.3 connected via ethernet with my Linux Host.


What I did to get rid of the described problem:

In module:     arch/powerpc/kernel/process.c
In function:   void flush_fp_to_thread(struct tast_struct *tsk)

I changed the line:  giveup_fpu(current);
to:                  giveup_fpu(tsk);


Now my questions: Has anybody else had such problems?
                  Have I found a bug, or will I encounter any yet =
unknown problems in the near future?

I would appreciate any comment on my changes, especially from the =
maintainers.

Thank you very much

Udo Visser

Heidelberger Druckmaschinen AG
RD IMAGING SYSTEMS    RD-IS-E23


Confidentiality note:
The information in this email and any attachment may contain =
confidential and proprietary information of Heidelberger Druckmaschinen =
AG and/or its affiliates and may be privileged or otherwise protected =
from disclosure. If you are not the intended recipient, you are hereby =
notified that any review, reliance or distribution by others or =
forwarding without express permission is strictly prohibited and may =
cause liability. In case you have received this message due to an error =
in transmission, we kindly ask you to notify the sender immediately and =
to delete this email and any attachment from your system.
