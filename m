Return-Path: <news@alea.gnuu.de>
Received: from uucp.gnuu.de (banki.eumelnet.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id B3863DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 02:12:46 +1100 (EST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>) id 1IvZCV-0006r7-0u
	for linuxppc-dev@ozlabs.org; Fri, 23 Nov 2007 15:08:11 +0100
To: linuxppc-dev@ozlabs.org
From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: time accounting problem (powerpc only?)
Date: Fri, 23 Nov 2007 14:08:10 +0000 (UTC)
Message-ID: <slrnfkdnma.681.joerg@alea.gnuu.de>
References: <1195814816.4149.94.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@alea.gnuu.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo Johannes,

Johannes Berg <johannes@sipsolutions.net> wrote:
> Doing some scripting to read /proc/stat every half second and print the
> differences, I get output like this on a mostly idle system:
>
> # for reference:
> # [user, nice, system, idle, iowait, irq, softirq, steal, guest]
>
> [4, 0, 3, 46, 0, 264, 0, 0, 0]
>
> As you can see, the "irq" time is very high so that "user" (mostly my
> CPU burning program) only accounts for maybe 15%. This leads to
> powernowd thinking that all is fine and no switching is required. Also,
> the whole stuff leads to top(1) displaying about 80-90% "hi" (hard irq?
> calculated as irq - softirq?) time.

I've the same problem and I see these interrupts in /proc/interrups:

% diff /proc/interrupts <(sleep 2; cat /proc/interrupts)
--- /proc/interrupts    2007-11-23 15:04:06.004846901 +0100
+++ /proc/self/fd/11    2007-11-23 15:04:05.952841422 +0100
@@ -1,15 +1,15 @@
            CPU0       
  21:          5   MPIC 1    Edge      PMac Output
  24:         68   MPIC 1    Level     ide1
- 25:   18063968   MPIC 1    Level     VIA-PMU
+ 25:   18064241   MPIC 1    Level     VIA-PMU
  26:       2426   MPIC 1    Level     keywest i2c
  29:          1   MPIC 1    Level     ohci_hcd:usb2
  30:          1   MPIC 1    Edge      PMac Input
  39:     843910   MPIC 1    Level     ide0
  41:     990592   MPIC 1    Level     eth0
- 42:    1415066   MPIC 1    Level     keywest i2c
- 47:    2075159   MPIC 1    Level     GPIO1 ADB
- 48:    6686659   MPIC 1    Level     radeon@pci:0000:00:10.0
+ 42:    1415084   MPIC 1    Level     keywest i2c
+ 47:    2075193   MPIC 1    Level     GPIO1 ADB
+ 48:    6686778   MPIC 1    Level     radeon@pci:0000:00:10.0
  61:          0   MPIC 1    Edge      Sound Headphone Detection
  63:      94238   MPIC 1    Level     ehci_hcd:usb1, ohci_hcd:usb3, ohci_hcd:usb4
 BAD:         19

I don't know where they come from, but that's the cause of the high IRQ
time.

Bye, Jörg.
-- 
Je planmäßiger ein Mensch vorgeht,
desto stärker mag ihn der Zufall treffen.
		    Erich Krunau ‚Die Physiker‘
