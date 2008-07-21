Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C0E37DDE1D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 17:05:47 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [0/5] tuning options for PPC64
Date: Mon, 21 Jul 2008 09:02:47 +0200
MIME-Version: 1.0
Message-Id: <200807210902.48150.marvin24@gmx.de>
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

the following five patches should lay a foundation to more fine-grained tuning 
on PPC64 cpus. They must be applied in order. The motivation are the 
discussions of serveral cpu specific optimizations in the past on this list, 
cleanup of the wired Makefile/CONFIG_POWERx constructs and at least the 
ownership of a PS3.

The patches intoduce CONFIG_TUNE_some_cpu and CONFIG_OPT_EXCLUSIVE, with the 
aim to cover two common cases:

	- distributions want a common kernel, bootable on all ppc64 machines and tune 
for a certain cpu

	- high end users don't care about older cpus and want to compile a kernel 
with their favorite mcpu option

I know there is also the possibility of mcpu=x and mtune=y, y>x but this can 
be tackled in the next step (hopefully).

I know this will bring up some conserns, but my initial findings grepping the 
defconfigs show:

	- CONFIG_POWER3 enables BATS only
		it is also used the enable some configs
		it is used always in combination with CONFIG_POWER4

	- CONFIG_POWER4 is always combined with CONFIG_PPC64 and vice versa
		all POWER3 || POWER4 || PPC64 can be replaced by PPC64

	- There seems to be no support for 32-bit kernels on ppc64 machines

I hope for some feedback, so this new scheme (or some other) can be included 
to mainstream kernel. 

Greetings

Marvin
