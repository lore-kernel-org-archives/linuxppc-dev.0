Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id B3C08DE08D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 05:59:25 +1000 (EST)
Message-ID: <47FBCE99.8050108@matrix-vision.de>
Date: Tue, 08 Apr 2008 21:59:21 +0200
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
	<20080408164853.GH2552@loki.buserror.net>
In-Reply-To: <20080408164853.GH2552@loki.buserror.net>
Content-Type: multipart/alternative;
	boundary="------------030706020002060401000602"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030706020002060401000602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Scott Wood wrote:
> On Tue, Apr 08, 2008 at 03:50:26PM +0200, Andre Schwarz wrote:
>  =20
>> after building a debug kernel and attaching the bdi2000 it looks like =
=20
>> the crash occurs during "console_init()" ...
>>    =20
>
> Does your device tree have a /chosen node after u-boot is done with it?=
=20
> find_legacy_serial_ports() can crash otherwise (we really should fix th=
at).
>
>  =20
latest u-boot does add the chosen node.
As far as I know it's for initrd setup ... don't know if it's complete.
>> Since we're using a dtb I omit the "console=3D..." argument for the =20
>> kernel. Is this correct ?
>>    =20
>
> It's OK if you have /chosen/linux,stdout-path.
>
>  =20
that sounds promising ! Haven't seen this and will have a closer look.
>> If "console=3D/dev/ttyS0,115200N8" argument is given the serial consol=
e =20
>> stops working after console_init....
>>
>>
>> On other PowerPC system I could see something like this during boot :
>>
>> -> find_legacy_serial_port()
>> stdout is /soc8568@e0000000/serial@4600
>> legacy_serial_console =3D 1
>> default console speed =3D 115340
>> <- find_legacy_serial_port()
>>
>>
>> Should I see this message also ?
>>    =20
>
> Only if you enable debug messages in legacy_serial.c.
>
>  =20
ok.
>> Have I misconfigured anything ?
>>    =20
>
> One thing that sticks out from the above is that you ask for ttyS0, but=
 the
> stdout you list from the other system corresponds to ttyS1.  Is this ju=
st a
> difference between the two systems?
>
>  =20
Yes - the log from the MPC8568 is a copy&paste from another posting.=20
It's not my system.
I want ttyS0.
> -Scott
>  =20
I appreciate your help !

Thanks,
Andr=E9


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------030706020002060401000602
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Scott Wood wrote:
<blockquote cite="mid:20080408164853.GH2552@loki.buserror.net"
 type="cite">
  <pre wrap="">On Tue, Apr 08, 2008 at 03:50:26PM +0200, Andre Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">after building a debug kernel and attaching the bdi2000 it looks like  
the crash occurs during "console_init()" ...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Does your device tree have a /chosen node after u-boot is done with it? 
find_legacy_serial_ports() can crash otherwise (we really should fix that).

  </pre>
</blockquote>
latest u-boot does add the chosen node.<br>
As far as I know it's for initrd setup ... don't know if it's complete.<br>
<blockquote cite="mid:20080408164853.GH2552@loki.buserror.net"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">Since we're using a dtb I omit the "console=..." argument for the  
kernel. Is this correct ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It's OK if you have /chosen/linux,stdout-path.

  </pre>
</blockquote>
that sounds promising ! Haven't seen this and will have a closer look.<br>
<blockquote cite="mid:20080408164853.GH2552@loki.buserror.net"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">If "console=/dev/ttyS0,115200N8" argument is given the serial console  
stops working after console_init....


On other PowerPC system I could see something like this during boot :

-&gt; find_legacy_serial_port()
stdout is /soc8568@e0000000/serial@4600
legacy_serial_console = 1
default console speed = 115340
&lt;- find_legacy_serial_port()


Should I see this message also ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Only if you enable debug messages in legacy_serial.c.

  </pre>
</blockquote>
ok.<br>
<blockquote cite="mid:20080408164853.GH2552@loki.buserror.net"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">Have I misconfigured anything ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
One thing that sticks out from the above is that you ask for ttyS0, but the
stdout you list from the other system corresponds to ttyS1.  Is this just a
difference between the two systems?

  </pre>
</blockquote>
Yes - the log from the MPC8568 is a copy&amp;paste from another
posting. It's not my system.<br>
I want ttyS0.<br>
<blockquote cite="mid:20080408164853.GH2552@loki.buserror.net"
 type="cite">
  <pre wrap="">-Scott
  </pre>
</blockquote>
I appreciate your help !<br>
<br>
Thanks,<br>
Andr&eacute;<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------030706020002060401000602--
