Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5FDC12C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 05:02:08 +1100 (EST)
Date: Thu, 7 Feb 2013 12:01:56 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Why is the e500v2 core not using cpuidle?
To: Thomas Waldecker <Thomas.Waldecker@tqs.de>
References: <B88C075EE1324644BA0452D5EFDD582813952706@TQ-MAIL.tq-net.de>
In-Reply-To: <B88C075EE1324644BA0452D5EFDD582813952706@TQ-MAIL.tq-net.de>
 (from Thomas.Waldecker@tqs.de on Thu Feb  7 06:19:25 2013)
Message-ID: <1360260116.27002.3@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 02/07/2013 06:19:25 AM, Thomas Waldecker wrote:
> Hi Scott,
>=20
> I measured the power consumption of the whole system on the tqmp2020 =20
> ( http://tq-group.com/tqmp2020 )
> with a QorIQ P2020.
>=20
> Kernel:
> root@generic-powerpc-e500v2:/sys/power# uname -a
> Linux generic-powerpc-e500v2 3.7.0-rc8-00004-g6e93414 #4 SMP Tue Dec =20
> 11 08:53:23 CET 2012 ppc GNU/Linux
> root@generic-powerpc-e500v2:/sys/power# cat /etc/issue
> ELDK 5.2.1 \n \l
>=20
> In idle using doze I got:
> 545mA, 18V =3D> 9.81W
>=20
> In idle using nap I got:
> 500mA, 18V =3D> 9W
>=20
> That's a difference of 0.81W,
> 0.81W/9.81W =3D 0.083 (8.3 %)

Thanks.

> > The only way you'll get into sleep mode is through /sys/power/state.
>=20
> How can I use this interface?
>=20
> root@generic-powerpc-e500v2:/sys/power# ls -la
> total 0
> drwxr-xr-x  2 root root    0 Feb  1 15:39 .
> dr-xr-xr-x 12 root root    0 Feb  1 15:19 ..
> -rw-r--r--  1 root root 4096 Feb  1 15:39 state
> root@generic-powerpc-e500v2:/sys/power# cat state
> root@generic-powerpc-e500v2:/sys/power# echo "sleep" > state
> -sh: echo: write error: Function not implemented
> root@generic-powerpc-e500v2:/sys/power# echo 0 > state
> -sh: echo: write error: Function not implemented
> root@generic-powerpc-e500v2:/sys/power#

Make sure that CONFIG_FSL_PMC is enabled, and that you have a pmc node =20
in the device tree.  You'll only have standby, not sleep.  mpc8536 and =20
p1022 can support what the chip calls "deep sleep" and is exposed as =20
"sleep" rather than "standby", but it doesn't look like the code for =20
that has made it into mainline Linux yet.

-Scott=
