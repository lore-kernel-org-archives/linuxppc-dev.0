Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 38227DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 09:14:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Problems with PCI-E devices not being detected with switch
Date: Mon, 20 Oct 2008 17:14:48 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F832@tanisys-ex2.Tanisys.Local>
In-Reply-To: <1224539820.7654.173.camel@pasglop>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
	<1224278340.7654.103.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F830@tanisys-ex2.Tanisys.Local>
	<1224539820.7654.173.camel@pasglop>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>>>=20
>>> +	/* Check if setup is sensible at all */
>>> +	if ((buses & 0xff) !=3D bus->number ||
>>> +	    ((buses >> 8) & 0xff) !=3D <=3D bus->number) {
>>=20
>> Note that I removed the <=3D from the above line -- I did not think =
it
>> was correct.  Please let me know if that was wrong.
>=20
> My logic is that the current setup is incorrect if the primary bus of
> the bridge doesn't match the parent bus number, or if the secondary
> bus number of the bridge is not strictly superior to the parent bus
> number.  =20
>=20
> What sounds incorrect ?
>=20

The part that didn't look correct is this line (note the operators)

   ((buses >> 8) & 0xff) !=3D <=3D bus->number) {

               Operators ^^ ^^

>From reading through the code and your textual description of what was
supposed to be happening, I went ahead and changed it to ...=20

 ((buses >> 8) & 0xff) !=3D  bus->number) {

And this is the code that generated the results from my previous
message.


Hope that made sense ...

Regards,
Ayman
