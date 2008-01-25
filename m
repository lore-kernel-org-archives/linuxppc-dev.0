Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id ADDF4DDF7C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jan 2008 11:00:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Failed to mount rootfs
Date: Fri, 25 Jan 2008 08:47:12 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1A9FA@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <47998D8B.8050100@denx.de>
References: <mailman.1307.1201212280.6908.linuxppc-embedded@ozlabs.org>
	<47998D8B.8050100@denx.de>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: <hs@denx.de>
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

=20
Hi Heiko,=20
> "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com> wrote:
> > Our custom board is leveraged from MPC8541cds from freescale.
> > We have been running Linux 2.6.11 on it recently I have=20
> tried to boot=20
> > the system with the latest Linux 2.6.22-rc4 from PowerPC git tree.
> > =20
> > I did ported the libfdt to our older version of the uboot and were=20
> > able to
>=20
> Hmm... why you didnt use actual code?
>=20
> [...]
> >     chosen {
> >         linux,stdout-path =3D "/soc8541@e0000000/serial@4600";
> >     };
> >     chosen {
> >         name =3D "chosen";
> >         bootargs =3D "root=3D/dev/ram rw console=3DttyS1,115200";
> >         linux,platform =3D <600>;
> >         linux,initrd-start =3D <1ef33000>;
> >         linux,initrd-end =3D <1fe190aa>;
> >         linux,stdout-path =3D "/soc8541@e0000000/serial@4600";
> >     };
> > };
>=20
> Here is your problem, you have 2 choosen nodes:
>=20
> 64k data, 108k bss, 116k init) Mount-cache hash table entries: 512
> device-tree: Duplicate name in /, renamed to "chosen#1"
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -> Linux didnt find your commandline ...
>=20
> Hmm... do you have CONFIG_OF_FLAT_TREE and CONFIG_OF_LIBFDT defined?
> If so, this would explain, why you have 2 choosen nodes.

Yes I do have both CONFIG_OF_FLAT_TREE and CONFIG_OF_LIBFDT defined. Is
there a document to tell more about these options please?

Thanks,
Bizhan
