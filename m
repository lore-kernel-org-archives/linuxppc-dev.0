Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id B2716DDF4E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 06:09:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: BUG with U-boot 1.1.4 and kernel 2.6.23 scanning PCIe on a MPC8641D
	board
Date: Tue, 22 Jul 2008 13:09:24 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D702CE2CDE@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.363.1216733649.2828.linuxppc-embedded@ozlabs.org>
References: <mailman.363.1216733649.2828.linuxppc-embedded@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <joachim.bader@diehl-aerospace.de>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Joachim,

We did not had a crash, but had some problem with assigning resources
for PCI bus on 8641D. Your issue may be related or not, I am not really
sure.

You might want to check out MSI patch. Currently this is already there
for few other FSL processors like 85xx, but not for 86xx.

- Siva
=20


joachim.bader@diehl-aerospace.de Wrote:

Hello folks,

we run a proprietary board with Freescale MPC8641D using U-boot 1.1.4
and=20
Linux kernel 2.6.23

First of all, we are no experts in PCIe-Bus handling and management.
We started with the problem that U-Boot was able to scan the devices=20
connected to PCIe-Bus where the kernel fails.
Using the information provided by Vince Asbridge regarding the different

numbering of devices on PCIe bus by U-Boot and kernel we were able to
get=20
the kernel up recognizing the devices correctly.
Thanks for this info.

But now we are blocked by an exception in kernel mode during=20
initialisation of the PCIe-Buses and devices. We instrumented the kernel

additional to the standard print outs to get more information and to=20
understand the behavior of the scan and allocation process. But now we
get=20
lost. I assume that the problem is caused by the transparent bridges.

I appent here after the trace log. Perhaps someone knows this problem=20
already or can give me a hint .

I read in the logs some messages that 2.6.23 does contain some bugs=20
related to PCIe and it would be a good choice to upgrade to 2.6.25. Is=20
this one of that cases?
Currently we would like to prevent switching the kernel version.

Any help is appreciated.

Thanks in advance.

Joachim
