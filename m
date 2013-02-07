Return-Path: <Thomas.Waldecker@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [82.210.228.1])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "IronPort Appliance Demo Certificate",
 Issuer "IronPort Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74ED22C007A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 23:19:30 +1100 (EST)
From: Thomas Waldecker <Thomas.Waldecker@tqs.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Why is the e500v2 core not using cpuidle?
Date: Thu, 7 Feb 2013 12:19:25 +0000
Message-ID: <B88C075EE1324644BA0452D5EFDD582813952706@TQ-MAIL.tq-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "Linux PPC dev mailing list \(linuxppc-dev@lists.ozlabs.org\)"
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

I measured the power consumption of the whole system on the tqmp2020 ( http=
://tq-group.com/tqmp2020 )
with a QorIQ P2020.

Kernel:
root@generic-powerpc-e500v2:/sys/power# uname -a
Linux generic-powerpc-e500v2 3.7.0-rc8-00004-g6e93414 #4 SMP Tue Dec 11 08:=
53:23 CET 2012 ppc GNU/Linux
root@generic-powerpc-e500v2:/sys/power# cat /etc/issue
ELDK 5.2.1 \n \l

In idle using doze I got:
545mA, 18V =3D> 9.81W

In idle using nap I got:
500mA, 18V =3D> 9W

That's a difference of 0.81W,
0.81W/9.81W =3D 0.083 (8.3 %)

> The only way you'll get into sleep mode is through /sys/power/state.

How can I use this interface?

root@generic-powerpc-e500v2:/sys/power# ls -la
total 0
drwxr-xr-x  2 root root    0 Feb  1 15:39 .
dr-xr-xr-x 12 root root    0 Feb  1 15:19 ..
-rw-r--r--  1 root root 4096 Feb  1 15:39 state
root@generic-powerpc-e500v2:/sys/power# cat state
root@generic-powerpc-e500v2:/sys/power# echo "sleep" > state
-sh: echo: write error: Function not implemented
root@generic-powerpc-e500v2:/sys/power# echo 0 > state
-sh: echo: write error: Function not implemented
root@generic-powerpc-e500v2:/sys/power#

Kind regards
Thomas Waldecker
