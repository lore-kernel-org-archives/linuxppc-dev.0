Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F061E2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 05:54:29 +1000 (EST)
Date: Wed, 1 May 2013 14:54:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: PowerPC, P2020RDB, application debug when the application is in
 tight loop, Sysrq
To: saikrishna gajula <saysai.gajula@gmail.com>
In-Reply-To: <CAGstqXHrHWdiE=RvZ=1sV+=mPd9LiUZHL0gHPa89AVZRSND2Tg@mail.gmail.com> (from
 saysai.gajula@gmail.com on Wed Apr 17 00:04:10 2013)
Message-ID: <1367438057.29231.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2013 12:04:10 AM, saikrishna gajula wrote:
> HI All,
>=20
>              I am new to this group. I am working on Freescale P2020
> platform running linux 2.6.21.   I am looking for debug =20
> mechanism/utility,
> when a multi threaded application running on linux , appears to be =20
> hung (
> running in a tight loop,deadlock)  while not able to access the board
> through serial/SSH/Telnet.
>=20
>    I was looking at Magic sysrq option in linux to generate the stack,
> register dump when the application is hung. I am able to dump the call
> trace in normal working conditions. But i can't use  echo  t >
> /proc/sysrq-trigger and debug when the application hung.
>=20
>  I am using below piece of code(drivers/serial/8250.c) on P2020RDB to =20
> debug
> the application where in , in hung situation, when i press 'y'  =20
> followed by
> 't'  on serial console it should go to sysrq handler, and dump the =20
> call
> trace, but it is not happening.(simply board hung)
>=20
> {
>            if(sysrq_enable_flag)
>                   handle_sysrq(ch, up->port.info->tty);
>=20
>         sysrq_enable_flag =3D 0;
>=20
>         if(ch =3D=3D 'y')
>             sysrq_enable_flag =3D 1;
> }
>=20
> It would be helpful if you provide any hint on the issue, or any =20
> other way
> to debug the application in hang situations.

There's an erratum regarding breaks in Freescale's serial port =20
implementation that has been worked around in more recent kernels.  =20
2.6.21 is six years old.  If you update to a kernel that has the =20
workaround, or backport the workaround yourself to your old kernel, you =20
should be able to use a break instead of hacking in a check for 'y'.

Other than that, either the kernel is hung too badly to respond to =20
serial input at all (in which case use JTAG to debug) or there's =20
something wrong with your 'y' hack (sysrq_enable_flag doesn't even =20
appear in current kernels so I can't see if this is the case without =20
digging through old code).

In any case, upgrade to a newer kernel -- maybe you're hitting a bug =20
that has been fixed since then.

-Scott=
