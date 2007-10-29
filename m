Return-Path: <stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Mon, 29 Oct 2007 12:34:40 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
In-Reply-To: <47262E36.4030503@genesi-usa.com>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>	<4725FA58.4030505@genesi-usa.com><20071029172724.11354.qmail@farnsworth.org>
	<47262E36.4030503@genesi-usa.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Matt Sealey" <matt@genesi-usa.com>,
	"Dale Farnsworth" <dale@farnsworth.org>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Here's an example of what I'm trying to get at-- take=20
a node from a FSL device tree.  The ideas I've heard
for expressing the class are like this--

#1  don't express any class at all:

  ucc@2200 {
        compatible =3D "fsl,ucc_geth";
        model =3D "UCC";
        device-id =3D <3>;
        reg =3D <2200 200>;
        interrupts =3D <22>;
        interrupt-parent =3D < &qeic >;
        mac-address =3D [ 00 00 00 00 00 00 ];
        local-mac-address =3D [ 00 00 00 00 00 00 ];
        rx-clock =3D <19>;
        tx-clock =3D <1a>;
        phy-handle =3D < &phy3 >;
        pio-handle =3D < &pio3 >;
 =20

  > This is bad IMHO because the human reader has to
  > infer the class of device.  Can the human reader
  > tell if it implements a standardized binding or
  > not??

#2 use device_type

  ucc@2200 {
        device_type =3D "network";
        compatible =3D "fsl,ucc_geth";
        model =3D "UCC";
        device-id =3D <3>;
        reg =3D <2200 200>;
        interrupts =3D <22>;
        interrupt-parent =3D < &qeic >;
        mac-address =3D [ 00 00 00 00 00 00 ];
        local-mac-address =3D [ 00 00 00 00 00 00 ];
        rx-clock =3D <19>;
        tx-clock =3D <1a>;
        phy-handle =3D < &phy3 >;
        pio-handle =3D < &pio3 >;
  };

  > This is better...I can tell it implments the network
  > binding.   The problem is the past abuse and OF
  > connotations.

#3 use a new "class" property

  ucc@2200 {
        class =3D "network";
        compatible =3D "fsl,ucc_geth";
        model =3D "UCC";
        device-id =3D <3>;
        reg =3D <2200 200>;
        interrupts =3D <22>;
        interrupt-parent =3D < &qeic >;
        mac-address =3D [ 00 00 00 00 00 00 ];
        local-mac-address =3D [ 00 00 00 00 00 00 ];
        rx-clock =3D <19>;
        tx-clock =3D <1a>;
        phy-handle =3D < &phy3 >;
        pio-handle =3D < &pio3 >;
  };

  > This is good...I can tell it implments the "network"
  > binding.   There is no association with the abused
  > OF device_type.

#4 use "compatible"

  ucc@2200 {
        compatible =3D "fsl,ucc_geth","[official spec],network";
        model =3D "UCC";
        device-id =3D <3>;
        reg =3D <2200 200>;
        interrupts =3D <22>;
        interrupt-parent =3D < &qeic >;
        mac-address =3D [ 00 00 00 00 00 00 ];
        local-mac-address =3D [ 00 00 00 00 00 00 ];
        rx-clock =3D <19>;
        tx-clock =3D <1a>;
        phy-handle =3D < &phy3 >;
        pio-handle =3D < &pio3 >;
  };

  > I don't like this...we are overloading "compatible" with
  > stuff that is not specifying a programming interface.  compatible
  > is supposed to be specifying a programming interface which
  > the device complies to.


Stuart
