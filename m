Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D449367BCB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 01:25:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k58FPc0T003783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 11:25:38 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k58FPcBR250330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 11:25:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k58FPcMF013286
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 11:25:38 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: a problem of kernel-module version mismatch.
Date: Thu, 8 Jun 2006 17:25:37 +0200
References: <BAY110-F11CA5067CA16CB9E95E997B28B0@phx.gbl>
In-Reply-To: <BAY110-F11CA5067CA16CB9E95E997B28B0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606081725.37621.arnd.bergmann@de.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 08 June 2006 15:52, Ming Liu wrote:
> >The easiest way is usually to put the driver in your source tree
> >and compile everything together. That also makes it easier to
> >distribute the complete source tree to your users.
>=20
> Sorry that I am a novice in Linux. I don't know how can I put the driver =
in=20
> my source tree and compile everything together. It looks like that there =
is=20
> no option in the menuconfig to choose a specially customed peripheral. So=
 I=20
> think I only can include the customed peripheral as a module. Could you=20
> please say in a detail on how to do that?=20

The most simple way would be to put it into linux/drivers/misc and add it
to the Makefile in there.

> > > insmod: unresolved symbol XIo_In32
> > > insmod: unresolved symbol XIO_Out32
> >
> >that looks like part of your module is missing. Try to find where thses
> >functions are defined in there and why that isn't compiled.
>=20
> It's very strange because I have checked the source. In the header file o=
f=20
> xio.h, there are the following sentences,
>=20
> /************************** Function Prototypes=20
> ******************************/
>=20
> /* The following functions allow the software to be transportable across
> =A0* processors which may use memory mapped I/O or I/O which is mapped in=
to a
> =A0* seperate address space such as X86. =A0The functions are better suit=
ed for
> =A0* debugging and are therefore the default implementation. Macros can=20
> instead
> =A0* be used if USE_IO_MACROS is defined.
> =A0*/
> #ifndef USE_IO_MACROS

The comment tells you that you either need to implement these functions
youself or #define USE_IO_MACROS in the code before this.

> /* Functions */
> Xuint8 XIo_In8(XIo_Address InAddress);
> Xuint16 XIo_In16(XIo_Address InAddress);
> Xuint32 XIo_In32(XIo_Address InAddress);
>=20
> void XIo_Out8(XIo_Address OutAddress, Xuint8 Value);
> void XIo_Out16(XIo_Address OutAddress, Xuint16 Value);
> void XIo_Out32(XIo_Address OutAddress, Xuint32 Value);
>=20
> #else
>=20
> /* The following macros allow optimized I/O operations for memory mapped=
=20
> I/O
> =A0* Note that the SYNCHRONIZE_IO may be moved by the compiler during
> =A0* optimization.
> =A0*/
>=20
> #define XIo_In8(InputPtr) =A0(*(volatile Xuint8 =A0*)(InputPtr));=20
> SYNCHRONIZE_IO;
> #define XIo_In16(InputPtr) (*(volatile Xuint16 *)(InputPtr));=20
> SYNCHRONIZE_IO;
> #define XIo_In32(InputPtr) (*(volatile Xuint32 *)(InputPtr));=20
> SYNCHRONIZE_IO;
>=20
> #define XIo_Out8(OutputPtr, Value) =A0\
> =A0 =A0 { (*(volatile Xuint8 =A0*)(OutputPtr) =3D Value); SYNCHRONIZE_IO;=
 }
> #define XIo_Out16(OutputPtr, Value) \
> =A0 =A0 { (*(volatile Xuint16 *)(OutputPtr) =3D Value); SYNCHRONIZE_IO; }
> #define XIo_Out32(OutputPtr, Value) \
> =A0 =A0 { (*(volatile Xuint32 *)(OutputPtr) =3D Value); SYNCHRONIZE_IO; }
>=20
> #endif

These macros are probably broken on powerpc.

>=20
> I think these are the defination of XIo_In32 and XIo_Out32. Also, during=
=20
> the compilation, there is no error to complain that "XIo_In32 or XIo_Out3=
2=20
> undeclared".=20
>=20

I would suggest you remove that part of the header file completely, and
replace it with:

#define XIo_In32(p) in_le32(x)
#define XIO_Out32(p,v) out_le32(p, v)

	Arnd <><
