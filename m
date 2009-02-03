Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 190FDDE063
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 19:39:36 +1100 (EST)
Subject: therm_adt746x: CPU fan speed inversion
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Colin Leroy <colin@colino.net>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2009 09:33:57 +0100
Message-Id: <1233650037.6784.350.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On my PowerBook5,8, every now and then (haven't figured out any pattern
to when it happens) the therm_adt746x module stops controlling the fan
speed properly. The problem seems to be that the fan speed range is
inverted, i.e. the fan stops when therm_adt746x thinks it's setting it
to full speed and vice versa. See below for a log of therm_adt746x
loaded with verbose=3D1 while the problem is in effect; while it looks
like the fan speed ramps up and down again, the GNOME sensors applet
agrees with my ears that the opposite happened. I haven't found any way
to recover from this other than rebooting.

Has anyone else seen this? Any ideas what the problem could be, or how
to track it down?

FWIW I'm currently running 2.6.28 kernels self-built from the kernel.org
stable tree, but I first noticed this a long time ago, possibly forever
since I've used this module. Now it's finally bothered me enough to
report it. :)


[150811.783627] adt746x: version 1 (supported)
[150811.783639] adt746x: Thermostat bus: 0, address: 0x2e, limit_adjust: 0,=
 fan_speed: -1
[150811.783648] sensor 0: CPU/INTREPID BOTTOMSIDE
[150811.783653] sensor 1: CPU BOTTOMSIDE
[150811.783658] sensor 2: PWR SUPPLY BOTTOMSIDE
[150811.800813] adt746x: ADT7467 initializing
[150811.803623] adt746x: Lowering max temperatures from 81, 80, 87 to 70, 5=
0, 70
[150811.803699] adt746x: Setting speed to 0 for CPU BOTTOMSIDE fan.
[153827.141765] adt746x: Setting fans speed to 64 (limit exceeded by 0 on C=
PU BOTTOMSIDE)=20
[153827.141773] adt746x: Setting speed to 64 for CPU BOTTOMSIDE fan.
[153861.697327] adt746x: Setting fans speed to 91 (limit exceeded by 2 on C=
PU BOTTOMSIDE)=20
[153861.697335] adt746x: Setting speed to 91 for CPU BOTTOMSIDE fan.
[153898.391372] adt746x: Setting fans speed to 145 (limit exceeded by 4 on =
CPU BOTTOMSIDE)=20
[153898.391379] adt746x: Setting speed to 145 for CPU BOTTOMSIDE fan.
[153936.733051] adt746x: Setting fans speed to 199 (limit exceeded by 6 on =
CPU BOTTOMSIDE)=20
[153936.733059] adt746x: Setting speed to 199 for CPU BOTTOMSIDE fan.
[153977.150356] adt746x: Setting fans speed to 253 (limit exceeded by 8 on =
CPU BOTTOMSIDE)=20
[153977.150363] adt746x: Setting speed to 253 for CPU BOTTOMSIDE fan.
[154017.403671] adt746x: Setting fans speed to 199 (limit exceeded by 6 on =
CPU BOTTOMSIDE)=20
[154017.403682] adt746x: Setting speed to 199 for CPU BOTTOMSIDE fan.
[154047.440196] adt746x: Setting fans speed to 145 (limit exceeded by 4 on =
CPU BOTTOMSIDE)=20
[154047.440208] adt746x: Setting speed to 145 for CPU BOTTOMSIDE fan.
[154073.466771] adt746x: Setting fans speed to 91 (limit exceeded by 2 on C=
PU BOTTOMSIDE)=20
[154073.466783] adt746x: Setting speed to 91 for CPU BOTTOMSIDE fan.
[154101.502629] adt746x: Setting fans speed to 64 (limit exceeded by 0 on C=
PU BOTTOMSIDE)=20
[154101.502640] adt746x: Setting speed to 64 for CPU BOTTOMSIDE fan.
[154153.606437] adt746x: Stopping fans.
[154153.606449] adt746x: Setting speed to 0 for CPU BOTTOMSIDE fan.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
