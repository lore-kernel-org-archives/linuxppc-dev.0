Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id B3A59679A6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2006 05:04:38 +1100 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: System time accuracy
Date: Thu, 9 Mar 2006 08:57:35 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603090857.36199.bcook@bpointsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm having a puzzling problem. On every 7448-based Linux system that I have 
worked on so far, including:

  Mac Mini, 1.5 Ghz
  Various PMC boards -  MV64460 system controller
  Freescale HPC II - TSI108 system controller

, the system clock loses approx 1 second every 5 minutes. In fact, I have been 
unable to even get NTP to sync these system clocks properly; it just doesn't 
adjust fast enough to keep up with the lag, leading to big drifts and adjtimex 
just doesn't keep up. Eventually the systems get more than 180 seconds out of 
sync and NTP stops trying.

Is this normal behavior, and if so, what have you done to work around it? Is 
this a general issue with PPC arch, Linux 2.6 (tried 2.6.11 - 2.6.15), or 
specific to the platforms I have tried so far?

Here is the result of running openntpd on a freshly synced system (this 
particular one is the HPC II running 2.6.11):

ntpd -sd
192.168.1.1: offset 0.000066 delay 0.000352, next query 5s
reply from 192.168.1.1: offset 0.010422 delay 0.000242, next query 5s
peer 192.168.1.1 now valid
reply from 192.168.1.1: offset 0.020899 delay 0.000256, next query 5s
reply from 192.168.1.1: offset 0.031362 delay 0.000306, next query 5s
reply from 192.168.1.1: offset 0.041838 delay 0.000316, next query 5s
reply from 192.168.1.1: offset 0.052244 delay 0.000226, next query 287s
reply from 192.168.1.1: offset 0.652178 delay 0.000343, next query 30s
adjusting local clock by 0.052244s
reply from 192.168.1.1: offset 0.684853 delay 0.000275, next query 30s
reply from 192.168.1.1: offset 0.725305 delay 0.000257, next query 30s
reply from 192.168.1.1: offset 0.788057 delay 0.000397, next query 30s
reply from 192.168.1.1: offset 0.850732 delay 0.000291, next query 30s
reply from 192.168.1.1: offset 0.913406 delay 0.000233, next query 30s
reply from 192.168.1.1: offset 0.976180 delay 0.000369, next query 30s
reply from 192.168.1.1: offset 1.038846 delay 0.000279, next query 30s
adjusting local clock by 0.913406s
reply from 192.168.1.1: offset 1.071584 delay 0.000309, next query 30s
reply from 192.168.1.1: offset 1.104273 delay 0.000289, next query 30s
reply from 192.168.1.1: offset 1.136919 delay 0.000273, next query 30s
reply from 192.168.1.1: offset 1.169708 delay 0.000342, next query 30s
reply from 192.168.1.1: offset 1.202390 delay 0.000295, next query 30s
reply from 192.168.1.1: offset 1.235082 delay 0.000252, next query 30s
adjusting local clock by 1.235082s
reply from 192.168.1.1: offset 1.267829 delay 0.000320, next query 30s

For comparison, this is an x86 PC doing the same thing:
ntpd -sd
ntp engine ready
reply from 192.168.1.1: offset -0.025448 delay 0.000618, next query 5s
reply from 192.168.1.1: offset -0.025973 delay 0.000285, next query 9s
reply from 192.168.1.1: offset -0.030136 delay 0.000248, next query 5s
peer 192.168.1.1 now valid
reply from 192.168.1.1: offset -0.033057 delay 0.000293, next query 6s
reply from 192.168.1.1: offset -0.036570 delay 0.000321, next query 5s
reply from 192.168.1.1: offset -0.039546 delay 0.000231, next query 5s
reply from 192.168.1.1: offset -0.042481 delay 0.000289, next query 34s
reply from 192.168.1.1: offset -0.062430 delay 0.000264, next query 32s
adjusting local clock by -0.039546s
reply from 192.168.1.1: offset -0.049193 delay 0.000264, next query 307s
reply from 192.168.1.1: offset -0.052205 delay 0.000299, next query 307s
reply from 192.168.1.1: offset -0.078816 delay 0.000284, next query 309s
reply from 192.168.1.1: offset -0.010273 delay 0.000336, next query 326s
reply from 192.168.1.1: offset -0.038518 delay 0.000279, next query 323s
reply from 192.168.1.1: offset -0.066434 delay 0.000314, next query 312s
adjusting local clock by -0.049193s

Now, none of these PPC systems has /dev/rtc (the x86 does), but that should 
not matter, since the real-time clock is usually used in Linux a boot or 
shutdown.
