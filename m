Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) by ozlabs.org (Postfix) with ESMTP id 53F76B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 04:27:35 +1100 (EST)
Received: by qyk36 with SMTP id 36so1186637qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 10:27:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CAB39F4.3030208@freescale.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
	<4CAB39F4.3030208@freescale.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Mon, 11 Oct 2010 19:27:13 +0200
Message-ID: <AANLkTimKbibzzNc3+DSJHcLC4gA0H5JiM+EHW2k4znZ-@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: John Traill <JTRAILL@freescale.com>, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: multipart/alternative; boundary=0016364ed874f68eb004925aac25
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364ed874f68eb004925aac25
Content-Type: text/plain; charset=ISO-8859-1

Hi,

We have found a poorly documented jumper on our boards that force pci-mode
to 32bit instead of 64bit. It seems to have an effect on RapidIO aswell
since the host now completes the enumeration process including finding the
other board. However, as soon as the agent starts the peer discovery
process, ALL RapidIO related registers on the agent are set to 0xFF4A.
Which, offcourse, caused unpredicted behaviour. All other jumpers are set as
they should be, especially the reference clock (100Mhz) and linkspeed
settings (1.25Gbps). I am currently having some trouble understanding why
this happens.

I've double checked Accept All on both boards in the registers and on both
boards it has been set correctly before discovery/enumeration.

Here is the LAW configuration from u-boot for the agent and host:

Local Access Window Configuration
LAWBAR00: 0x00000000 LAWAR0x00: 0x80f0001b
        (EN: 1 TGT: 0x0f SIZE: 256 MiB)
LAWBAR01: 0x00080000 LAWAR0x01: 0x8000001c
        (EN: 1 TGT: 0x00 SIZE: 512 MiB)
LAWBAR02: 0x000e2000 LAWAR0x02: 0x80000016
        (EN: 1 TGT: 0x00 SIZE: 8 MiB)
LAWBAR03: 0x000f0000 LAWAR0x03: 0x8040001b
        (EN: 1 TGT: 0x04 SIZE: 256 MiB)
LAWBAR04: 0x000c0000 LAWAR0x04: 0x80c0001c
        (EN: 1 TGT: 0x0c SIZE: 512 MiB)
LAWBAR05: 0x00000000 LAWAR0x05: 0x00000000
        (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
LAWBAR06: 0x00000000 LAWAR0x06: 0x00000000
        (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
LAWBAR07: 0x00000000 LAWAR0x07: 0x00000000
        (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
LAWBAR08: 0x00000000 LAWAR0x08: 0x00000000
        (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
LAWBAR09: 0x00000000 LAWAR0x09: 0x00000000
        (EN: 0 TGT: 0x00 SIZE: 2 Bytes)

We have removed the RapidIO TLB Entries from u-boot.

Kind regards,
Bastiaan Nijkamp

--0016364ed874f68eb004925aac25
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,=A0</div><div><br></div><div>We have found a poorly documented jump=
er on our boards that force pci-mode to 32bit instead of 64bit. It seems to=
 have an effect on RapidIO aswell since the host now completes the enumerat=
ion process including finding the other board. However, as soon as the agen=
t starts the peer discovery process, ALL RapidIO related registers on the a=
gent are set to 0xFF4A. Which, offcourse, caused unpredicted behaviour. All=
 other jumpers are set as they should be, especially the reference clock (1=
00Mhz) and linkspeed settings (1.25Gbps). I am currently having some troubl=
e understanding why this happens.</div>

<div><br></div><div>I&#39;ve double checked Accept All on both boards in th=
e registers and on both boards it has been set correctly before discovery/e=
numeration.=A0</div><div><br></div><div>Here is the LAW configuration from =
u-boot for the agent and host:</div>

<div><br></div><div>Local Access Window Configuration</div><div>LAWBAR00: 0=
x00000000 LAWAR0x00: 0x80f0001b</div><div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x0=
f SIZE: 256 MiB)</div><div>LAWBAR01: 0x00080000 LAWAR0x01: 0x8000001c</div>=
<div>
=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x00 SIZE: 512 MiB)</div>
<div>LAWBAR02: 0x000e2000 LAWAR0x02: 0x80000016</div><div>=A0=A0 =A0 =A0 =
=A0(EN: 1 TGT: 0x00 SIZE: 8 MiB)</div><div>LAWBAR03: 0x000f0000 LAWAR0x03: =
0x8040001b</div><div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x04 SIZE: 256 MiB)</div=
><div>LAWBAR04: 0x000c0000 LAWAR0x04: 0x80c0001c</div>

<div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x0c SIZE: 512 MiB)</div><div>LAWBAR05: =
0x00000000 LAWAR0x05: 0x00000000</div><div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x=
00 SIZE: 2 Bytes)</div><div>LAWBAR06: 0x00000000 LAWAR0x06: 0x00000000</div=
><div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div>

<div>LAWBAR07: 0x00000000 LAWAR0x07: 0x00000000</div><div>=A0=A0 =A0 =A0 =
=A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div><div>LAWBAR08: 0x00000000 LAWAR0x08=
: 0x00000000</div><div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</d=
iv><div>LAWBAR09: 0x00000000 LAWAR0x09: 0x00000000</div>

<div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div><div><br></div>=
<div>We have removed the RapidIO TLB Entries from u-boot.</div><div><br></d=
iv><div>Kind regards,</div><div>Bastiaan Nijkamp</div><div><br></div><div><=
br></div>

<div><br></div>

--0016364ed874f68eb004925aac25--
