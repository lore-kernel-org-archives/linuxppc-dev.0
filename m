Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [209.183.211.17])
	by ozlabs.org (Postfix) with ESMTP id C99B52BDA6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 23:55:19 +1000 (EST)
Received: from [192.168.180.211] ([132.250.144.104])
	by mail.theptrgroup.com (8.11.6/linuxconf) with ESMTP id i8ODtFP21361
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 09:55:19 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1096034125.8121.15.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Fri, 24 Sep 2004 09:55:25 -0400
Subject: MPC8260 SCC2 UART hang
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I am having a problem with the SCC2 uart whereby the system hangs
whenever I try to use that device.  It happens using both the Denx
kernel and the kernel.org 2.4.27 kernel.

I was hoping that somebody can tell me if SCC2 works as expected on
their MPC8260 hardware so that I can reduce the scope of my debug
effort.

Here is the relevant info from the 2.4.27 kenel:

<snip>
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG1
ttyS1 on SMC2 at 0x0040, BRG2
ttyS2 on SCC1 at 0x8000, BRG3
ttyS3 on SCC2 at 0x8100, BRG4
<snip>

Here is the simple test that causes the problem.  Once I try to access
/dev/tts/3 the system hangs.

bash-2.05b# echo "something" > /dev/tts/0
something
bash-2.05b# echo "something" > /dev/tts/1
bash-2.05b# echo "something" > /dev/tts/2
bash-2.05b# echo "something" > /dev/tts/3
[system is dead, no console, cannot ping, no nothing...]

FWIW, my hardware is the Embedded Planet EP8260 H2 1.3.

Jeff Angielski
The PTR Group
