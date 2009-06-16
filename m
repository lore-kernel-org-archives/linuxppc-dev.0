Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3EBEAB7195
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 22:52:51 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <20090616090435.GA21321@pengutronix.de>
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>
	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>
	<fa686aa40906140740m43e9dd8am4d242310f681c95c@mail.gmail.com>
	<20090616090435.GA21321@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Jun 2009 06:46:47 -0600
Message-ID: <fa686aa40906160546q73765b66h204334e3ca081de0@mail.gmail.com>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, "Hans J. Koch" <hjk@linutronix.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 16, 2009 at 3:04 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
>
>> > diff --git a/Documentation/powerpc/dts-bindings/uio-generic.txt b/Docu=
mentation/powerpc/dts-bindings/uio-generic.txt
>> > new file mode 100644
>> > index 0000000..8ad9861
>> > --- /dev/null
>> > +++ b/Documentation/powerpc/dts-bindings/uio-generic.txt
>> > @@ -0,0 +1,16 @@
>> > +UIO for custom devices
>> > +
>> > +A device which will be mapped using the UIO subsystem.
>> > +
>> > +Properties:
>> > + - compatible : should contain the specific model used, followed by
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"generic-uio".
>> > + - reg : address range(s) of the device (up to MAX_UIO_MAPS)
>> > + - interrupts : interrupt of the device
>> > +
>> > +Example:
>> > + =A0 =A0 =A0 =A0c64fpga@0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ptx,c64fpga001", "gen=
eric-uio";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x0 0x10000>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <0 0 3>;
>> > + =A0 =A0 =A0 =A0};
>>
>> Hmmm, I'm not happy about this. =A0The device tree describes the
>> hardware, not the way Linux uses the hardware. =A0UIO definitely falls
>> into the category of Linux implementation detail.
>
> Yes, I am aware of that. I just started with the mechanisms which are ava=
ilable
> today and hoped we could find some compatible-value which will suit all n=
eeds.

Trouble is a value that suits all needs today probably won't a year
from now.  :-)

>> This should be approached from the other way around. =A0Either the
>> generic-uio of_platform driver should contain an explicit list of
>> devices to be handled by UIO,
>
> Well, that could lead to a quite huge match_table over time.
>
>> or the OF infrastructure should be modified to allow things like force
>> binding of_devices to of_drivers at runtime.
>
> That is an interesting idea. I could imagine something like a 'new_compat=
ible"
> entry in the sysfs-section of the driver similar to 'new_id' for PCI. Aft=
er
> writing a new compatible-string into it, matching will triggered again wi=
th the
> new entry added. That could (should?) also be placed at the of-core-level=
. Or
> did you have something else in mind?

Yeah, that sounds appropriate.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
