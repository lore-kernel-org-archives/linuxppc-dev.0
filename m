Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc2-s23.blu139.hotmail.com
	(blu139-omc2-s23.blu139.hotmail.com [65.55.175.193])
	by ozlabs.org (Postfix) with ESMTP id 0DB04DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Dec 2007 00:45:50 +1100 (EST)
Message-ID: <BLU106-W1997B7AF3C31D3CBB7432DCA5C0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <ravi.rao@rflelect.com>
Subject: RE: Getting this error when mounting the jffs2 partition created
	using	mkImage..
Date: Wed, 19 Dec 2007 14:45:49 +0100
In-Reply-To: <OF34CAF9D6.42FCCF0E-ON852573B6.004903E5-852573B6.0049E457@slpower.com>
References: <BLU106-W420C40497B4E7C784AC4B6CA5C0@phx.gbl>
	<OF34CAF9D6.42FCCF0E-ON852573B6.004903E5-852573B6.0049E457@slpower.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: linuxppc-embedded-bounces+ravi.rao=rflelect.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Ravi wrote:
=20
> Hi,
>    The flash I am using on this board has 512 sectors each of 64kilobytes=
 so the erase block size should be 64kb=3D0x10000.
> I also have boards which use spansion flash which has 256 sectors each of=
 128kilo bytes. Erase block for them is 128kb=3D0x20000.
> Both of the flashes behave the same way. I get the same error..
> I noticed one thing. If I do memorydump of the sectors which donot have t=
he jffs2 image I see the begining of the sector as 19852003 0000000c f060dc=
98
> =3D>md FE7A0000
> fe7a0000: 19852003 0000000c f060dc98 ffffffff    .. ......`......
> fe7a0010: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0020: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0030: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0040: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0050: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0060: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0070: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0080: ffffffff ffffffff ffffffff ffffffff    ................
> fe7a0090: ffffffff ffffffff ffffffff ffffffff    ................
>=20
> But If I do a md of a sector which has the contents of jffs2 image then I=
 do not see the header.
> =3D>md fc020000
> fc020000: b58dc90c 0ce12b39 6c6a38a3 f40a3819    ......+9lj8...8.
> fc020010: 1a1c9a18 78807e51 700008a0 79ff2580    ....x.~Qp...y.%.
> fc020020: 7682ec63 04d50b40 bbf240f6 ccbe0310    v..c...@..@.....
> fc020030: 40203180 00030081 c9b057ff ffffffff    @ 1.......W.....
> fc020040: 19852003 0000000c f060dc98 1985e002    .. ......`......
> fc020050: 00000625 c800d476 00000009 0000003a    ...%...v.......:
> fc020060: 000081ed 00000000 000cecf3 47681135    ............Gh.5
> fc020070: 47681135 47681135 0003878e 000005e1    Gh.5Gh.5........
> fc020080: 00000872 06000000 c54a53f1 9b07730a    ...r.....JS...s.
> fc020090: 785e7455 516c5365 143e775b 9a966de1    x^tUQlSe.>w[..m.
>=20
> So I am not sure if this is normal.. Any help or pointers to solve this w=
ill be of great help.
>=20
> Strange thing is everything works fine except I get these message printed=
. I can access the jffs2 partition i.e read/write/execute files from it.

Wich kernel version are you using? Because I had a very similar problem and=
 realized that any file with a name longer than 8 characters was bad writte=
n, although everything seemed to be ok and I could mount the partition. It =
was a bug in the JFFS2 kernel driver (I think I was using 2.6.22.6) and it =
was corrected later.
Maybe you should check this long names issue just to be sure.

Pedro.

> Thanks,
> Ravishankar Govindarao
> RFL Electronics Inc.
> E-mail : Ravi.Rao@rflelect.com
> Voice: 973.334.3100 Ext. 233
> Fax: 973.334.3863
>=20
>=20
>=20
> CONFIDENTIALITY NOTE
>=20
> This e-mail, including any attachments, may contain confidential and/or l=
egally privileged information.  The Information is intended only for the us=
e of the individual or entity named on this e-mail .  If you are not the in=
tended recipient, you are hereby notified that any disclosure, copying, dis=
tribution, or the taking of any action in reliance on the contents of this =
transmitted Information is strictly prohibited.  Further, if you are not th=
e intended recipient, please notify us by return e-mail and delete the Info=
rmation promptly.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> "Pedro Luis D. L."=20
> Sent by: linuxppc-embedded-bounces+ravi.rao=3Drflelect.com@ozlabs.org
>=20
> 12/19/2007 04:38 AM
> To
>=20
> cc
> Subject
> RE: Getting this error when mounting the jffs2 partition created        u=
sing        mkImage..
>=20
>=20
>=20
>=20
>=20
>=20
> Ravi wrote:
>>
>> Hi All,
>>       I have u-boot based bootloader on our custom board based on ppc405=
EP.
>> Various partitions are..
>> Amd/Fujitsu Extended Query Table at 0x0040
>> RoadRunner: CFI does not contain boot bank location. Assuming top.
>> number of CFI chips: 2
>> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
>> Creating 5 MTD partitions on "RoadRunner":
>> 0x03fc0000-0x04000000 : "U-Boot based RR Boot loader"
>> 0x03fa0000-0x03fc0000 : "U-Boot Env Storage"
>> 0x03f80000-0x03fa0000 : "U-Boot Redundant Env Storage"
>> 0x027c0000-0x03f80000 : "Kernel Image"
>> 0x00000000-0x027c0000 : "JFFS2 Linux FS"
>>
>> I have used the following command to create the jffs2 file system image.
>> $BLDTOOLS/mkfs.jffs2 -b -e 0x10000 -d $JFFS2 -p 0x27c0000 -o rr-app_64.i=
mg
>> ${MKIMAGE} -T filesystem -n 'RR App Image for AMD' -d rr-app_64.img uRR-=
app_64
>=20
> Hi,
> I'm not using that board so I can not tell which is the correct value, bu=
t looking at the output you send it looks like the erase size you passed wh=
en creating the image file is wrong. I suggest you to find the appropiate v=
alue and create the image. For an mpc5200b it happened to be 0x20000. May t=
his would help.
>=20
> Good luck.
>=20
> Pedro.
>=20
> _________________________________________________________________
> La vida de los famosos al desnudo en MSN Entretenimiento
> http://entretenimiento.es.msn.com/
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
MSN Noticias
http://noticias.msn.es/comunidad.aspx=
