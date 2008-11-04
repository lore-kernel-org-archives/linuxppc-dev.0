Return-Path: <AymanE@tanisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Device tree configuration for I2C eeprom
Date: Tue, 4 Nov 2008 15:00:03 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F85B@tanisys-ex2.Tanisys.Local>
In-Reply-To: <4910AAC4.2090303@embedded-sol.com>
References: <9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>	<20080919050441.GD25528@secretlab.ca>	<16691A8B34B5D9458EA3A1C37A11555A0137F857@tanisys-ex2.Tanisys.Local>	<49107C46.8060205@embedded-sol.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F85A@tanisys-ex2.Tanisys.Local>
	<4910AAC4.2090303@embedded-sol.com>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Felix,

Thanks, below is what I finally did that works ...

Felix Radensky <mailto:felix@embedded-sol.com> said on Tuesday, November
04, 2008 2:04 PM:
>>=20
> The first entry in the table matches "compatible" property in device
> tree, the second one - i2c driver name, and the third one - i2c
> device name in the driver id table (see at24_ids[] in at24.c). So in
> your case it should look like this:
>=20
> {"atmel,at24c128",  "at24",   "24c128"}
> {"spd,at24c02",       "at24",   "spd"}

Then I modified my device tree to read, per an example I found
elsewhere.  The combination
of these two changes made everything work.  Again, thanks!

                                at24@50 {
                                        compatible =3D "at,24c128";
                                        reg =3D <0x50>;
                                };
                                spd@51 {
                                        compatible =3D "spd,24c02";
                                        reg =3D <0x51>;
                                };
                                at24@52 {
                                        compatible =3D "at,24c128";
                                        reg =3D <0x52>;
                                };
                                at24@53 {
                                        compatible =3D "at,24c128";
                                        reg =3D <0x53>;
                                };
