Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) by ozlabs.org (Postfix) with ESMTP id 5638CB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 19:31:03 +1100 (EST)
Received: by qyk36 with SMTP id 36so3885301qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 01:31:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimKbibzzNc3+DSJHcLC4gA0H5JiM+EHW2k4znZ-@mail.gmail.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<4CAB2729.6080402@freescale.com>
	<AANLkTik46NsiMhWo=GkHz4UbdDJeBLwFATJzhk-M3hSP@mail.gmail.com>
	<4CAB39F4.3030208@freescale.com>
	<AANLkTimKbibzzNc3+DSJHcLC4gA0H5JiM+EHW2k4znZ-@mail.gmail.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Wed, 13 Oct 2010 10:30:39 +0200
Message-ID: <AANLkTimk2hRhyX4WufjdviDz-OTj7VRfjA94oyoXL9mM@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: John Traill <JTRAILL@freescale.com>, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: multipart/alternative; boundary=0016364274a0ca90a304927b69ad
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364274a0ca90a304927b69ad
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I want to rectify my last e-mail. It seemed to be a weird bug in the tool
suite that we are using, since it would be impossible that all the read-only
registers also had that same strange value, it did not happen again
either. I do have another question, however.

Has the driver ever been tested/used without a switch attached? Because when
the host (which has ID 0x0) enumerates the other board it also assigns ID
0x0 to the agent, it seems that the agent should have been assigned 0x1 as
ID. Another thing is that the agent is now hanging on the discovery process.

Regards,
Bastiaan Nijkamp

2010/10/11 Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>

> Hi,
>
> We have found a poorly documented jumper on our boards that force pci-mode
> to 32bit instead of 64bit. It seems to have an effect on RapidIO aswell
> since the host now completes the enumeration process including finding the
> other board. However, as soon as the agent starts the peer discovery
> process, ALL RapidIO related registers on the agent are set to 0xFF4A.
> Which, offcourse, caused unpredicted behaviour. All other jumpers are set as
> they should be, especially the reference clock (100Mhz) and linkspeed
> settings (1.25Gbps). I am currently having some trouble understanding why
> this happens.
>
> I've double checked Accept All on both boards in the registers and on both
> boards it has been set correctly before discovery/enumeration.
>
> Here is the LAW configuration from u-boot for the agent and host:
>
> Local Access Window Configuration
> LAWBAR00: 0x00000000 LAWAR0x00: 0x80f0001b
>         (EN: 1 TGT: 0x0f SIZE: 256 MiB)
> LAWBAR01: 0x00080000 LAWAR0x01: 0x8000001c
>         (EN: 1 TGT: 0x00 SIZE: 512 MiB)
> LAWBAR02: 0x000e2000 LAWAR0x02: 0x80000016
>         (EN: 1 TGT: 0x00 SIZE: 8 MiB)
> LAWBAR03: 0x000f0000 LAWAR0x03: 0x8040001b
>         (EN: 1 TGT: 0x04 SIZE: 256 MiB)
> LAWBAR04: 0x000c0000 LAWAR0x04: 0x80c0001c
>         (EN: 1 TGT: 0x0c SIZE: 512 MiB)
> LAWBAR05: 0x00000000 LAWAR0x05: 0x00000000
>         (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
> LAWBAR06: 0x00000000 LAWAR0x06: 0x00000000
>         (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
> LAWBAR07: 0x00000000 LAWAR0x07: 0x00000000
>         (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
> LAWBAR08: 0x00000000 LAWAR0x08: 0x00000000
>         (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
> LAWBAR09: 0x00000000 LAWAR0x09: 0x00000000
>         (EN: 0 TGT: 0x00 SIZE: 2 Bytes)
>
> We have removed the RapidIO TLB Entries from u-boot.
>
> Kind regards,
> Bastiaan Nijkamp
>
>
>
>

--0016364274a0ca90a304927b69ad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>I want to rectify my last e-mail. It seemed to be a weird bug in the t=
ool suite that we are using, since it would be impossible that all the read=
-only registers also had that same strange value, it did not happen again e=
ither.=A0I do have another question, however. </div>


<div>=A0</div>
<div>Has the driver ever been tested/used without a switch attached? Becaus=
e when the host (which has ID 0x0) enumerates the other board it also assig=
ns ID 0x0 to the agent, it seems that the agent should have=A0been assigned=
 0x1 as ID.=A0Another thing is that the agent is now hanging on the discove=
ry process.</div>


<div>=A0</div>
<div>Regards,</div>
<div>Bastiaan Nijkamp</div>
<div>=A0</div>
<div class=3D"gmail_quote">2010/10/11 Bastiaan Nijkamp <span dir=3D"ltr">&l=
t;<a href=3D"mailto:bastiaan.nijkamp@gmail.com">bastiaan.nijkamp@gmail.com<=
/a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi,=A0</div>
<div><br></div>
<div>We have found a poorly documented jumper on our boards that force pci-=
mode to 32bit instead of 64bit. It seems to have an effect on RapidIO aswel=
l since the host now completes the enumeration process including finding th=
e other board. However, as soon as the agent starts the peer discovery proc=
ess, ALL RapidIO related registers on the agent are set to 0xFF4A. Which, o=
ffcourse, caused unpredicted behaviour. All other jumpers are set as they s=
hould be, especially the reference clock (100Mhz) and linkspeed settings (1=
.25Gbps). I am currently having some trouble understanding why this happens=
.</div>


<div><br></div>
<div>I&#39;ve double checked Accept All on both boards in the registers and=
 on both boards it has been set correctly before discovery/enumeration.=A0<=
/div>
<div><br></div>
<div>Here is the LAW configuration from u-boot for the agent and host:</div=
>
<div><br></div>
<div>Local Access Window Configuration</div>
<div>LAWBAR00: 0x00000000 LAWAR0x00: 0x80f0001b</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x0f SIZE: 256 MiB)</div>
<div>LAWBAR01: 0x00080000 LAWAR0x01: 0x8000001c</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x00 SIZE: 512 MiB)</div>
<div>LAWBAR02: 0x000e2000 LAWAR0x02: 0x80000016</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x00 SIZE: 8 MiB)</div>
<div>LAWBAR03: 0x000f0000 LAWAR0x03: 0x8040001b</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x04 SIZE: 256 MiB)</div>
<div>LAWBAR04: 0x000c0000 LAWAR0x04: 0x80c0001c</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 1 TGT: 0x0c SIZE: 512 MiB)</div>
<div>LAWBAR05: 0x00000000 LAWAR0x05: 0x00000000</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div>
<div>LAWBAR06: 0x00000000 LAWAR0x06: 0x00000000</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div>
<div>LAWBAR07: 0x00000000 LAWAR0x07: 0x00000000</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div>
<div>LAWBAR08: 0x00000000 LAWAR0x08: 0x00000000</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div>
<div>LAWBAR09: 0x00000000 LAWAR0x09: 0x00000000</div>
<div>=A0=A0 =A0 =A0 =A0(EN: 0 TGT: 0x00 SIZE: 2 Bytes)</div>
<div><br></div>
<div>We have removed the RapidIO TLB Entries from u-boot.</div>
<div><br></div>
<div>Kind regards,</div>
<div>Bastiaan Nijkamp</div><font color=3D"#888888">
<div><br></div>
<div><br></div>
<div><br></div></font></blockquote></div><br>

--0016364274a0ca90a304927b69ad--
