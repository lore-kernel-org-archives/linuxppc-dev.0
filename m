Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id EC240DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 03:37:15 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so26957yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 10:37:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1240852719.3495.0@antares>
References: <1240852719.3495.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Apr 2009 11:36:58 -0600
Message-ID: <fa686aa40904271036n5c610fdehe1c7906fff2b893b@mail.gmail.com>
Subject: Re: How to use Localbus on 5200B w/ 2.6.29.1
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 11:18 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Hi all,
>
> I have a question about the definition of the localbus on the Freescale
> 5200B (I'm testing with the Lite5200B board) with Kernel 2.6.29.1 which I
> could not figure out with the docs and the list archives...
>
> When I use 'compatible =3D "fsl,mpc5200b-lpb";' in the dts file, the loca=
lbus
> and any nodes below it don't show up in /sys/devices.

For completeness use: compatible =3D
"fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";  Then it will work.

The kernel doesn't currently bind on the 'b' string, but we put it in
the list anyway to completely describe the hardware, just in case it
ever becomes important in the future.


[...]
> =A0 =A0 =A0 =A0mydev@3,0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "mydev";

"mydev" should be in the form: "<vendor>,<device>".

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x0 0x100>; =A0 =A0 =A0 =A0 =A0=
 =A0// 256 Bytes, 32 used

If this is on CS3, then reg should be:
               reg =3D <3 0x0 0x100>;            // 256 Bytes, 32 used

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <1 3 2>; =A0 =A0 =A0 =A0 =
=A0 // todo - level?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
> =A0 =A0 =A0 =A0};
> };
> # ls -al /sys/devices/f0000300.localbus/
> drwxr-xr-x =A0 =A04 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 .
> drwxr-xr-x =A0 =A07 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 ..
> -r--r--r-- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A04096 Jan =
=A01 00:00 devspec
> drwxr-xr-x =A0 =A02 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 fc000000.flash
> drwxr-xr-x =A0 =A02 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 fc000000.mydev
> -r--r--r-- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A04096 Jan =
=A01 00:00 modalias
> -r--r--r-- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A04096 Jan =
=A01 00:00 name
> lrwxrwxrwx =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 subsystem ->
> ../../bus/of_platform
> -rw-r--r-- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A04096 Jan =
=A01 00:00 uevent
> </snip>
>
> which is also confusing, as both devices appear to have the same address?
> =A0Any idea what goes wrong here?

Because the reg property for mydev is wrong (see above).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
