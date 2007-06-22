Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc1-s20.bay0.hotmail.com (bay0-omc1-s20.bay0.hotmail.com
	[65.54.246.92]) by ozlabs.org (Postfix) with ESMTP id 240B9DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 07:21:34 +1000 (EST)
Message-ID: <BAY115-W15D3F48E0682BA719E73C4B2170@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: RE: Virtex 4 Avnet Mini-Module Networking.
Date: Fri, 22 Jun 2007 21:21:33 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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


Andrei,

well you are correct, using EDK9.1SP2 I created a custome design for ML405 =
and implemented it. My design was exactly the same as what xapp941 presents=
.=20

I have not access to ML405, but examining implementation results for two de=
signs it is obvious that they are different. logic resource usage for xapp9=
41 is over 6000 slices but for the custome design it is near 5700 slices.=20

In addition the fan out value for PLB TEMAC clock is near 5000 for xapp941 =
and near 3000 for our custome design. this means that plb temac module in x=
app941 is much larger than our plb temac module.=20

I examined the MHS files for both designs carefully, they are really the sa=
me. Of course it seems that the mhs file for xapp941 is edited by hand or a=
t least is not created by the usual method we use. This is because signal n=
ames and module names are completely different from an automatic EDK9.1 gen=
erated design.=20

Finally why not ask the two authors of this app note about what they have d=
one in their desing? is it some kind of secret?=20

and have you ever tried using ngc file for plb temac of xapp941 in a custom=
e design? .... should not be really neccessary of course.



----------------------------------------
> Date: Thu, 21 Jun 2007 22:18:52 +0400
> From: akonovalov@ru.mvista.com
> To: mamsadegh@hotmail.com
> CC: linuxppc-embedded@ozlabs.org
> Subject: Re: Virtex 4 Avnet Mini-Module Networking.
>=20
> Mohammad Sadegh Sadri wrote:
> >=20
> > very interesting
> >=20
> > the provided xps project from xapp941 results 230Mbits but your custome=
 system is 83.0Mbits, yes?
>=20
> yes
>=20
> > just, are you sure the ppc core has the same core clock frequency in bo=
th designs? I mean may be the xapp941 is running at 300MHz but yours at 100=
MHz.=20
>=20
> both run at 300MHz
>=20
> > And what about a custom system with 9.1SP2? does that gives the same pe=
rformance?
>=20
> haven't tried this yet
>=20
> > Finally If possible please release the test results for TCP streams. ( =
9.1 no SP and 9.1 SP2 )
>=20
> The TEMAC driver is from EDK 9.1.02 (IOW, SP2).
>=20
> bitstream made by myself with EDK 9.1.00:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168.119.1=
 -i 10, 2 -I 99,10 -t TCP_STREAM -- -m 32768 -s 262144
> TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.119.1 (1=
92.168.119.1) port 0 AF_INET : =B15.0% @ 99% conf.
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
>=20
>   87380 217088  32768    30.00      41.66
>=20
> bitstream from XAPP941:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168.119.1=
 -i 10, 2 -I 99,10 -t TCP_STREAM -- -m 32768 -s 262144
> TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.119.1 (1=
92.168.119.1) port 0 AF_INET : =B15.0% @ 99% conf.
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
>=20
>   87380 217088  32768    30.00     111.86
>=20
> And I didn't test ML405 receive performance.
>=20
> Thanks,
> Andrei
>=20
> > thanks
> >=20
> >=20
> >=20
> > ----------------------------------------
> >> Date: Thu, 21 Jun 2007 18:53:49 +0400
> >> From: akonovalov@ru.mvista.com
> >> To: mamsadegh@hotmail.com
> >> CC: linuxppc-embedded@ozlabs.org; kashiwagi@co-nss.co.jp; glenn.g.hart=
@us.westinghouse.com
> >> Subject: Re: Virtex 4 Avnet Mini-Module Networking.
> >>
> >> Mohammad Sadegh Sadri wrote:
> >>> I'm wondering where are the original developers of TEMAC driver these=
 days, I have not seen any posts from any of andrei
> >>> nor grant in the recent weeks. may be they are involved in other proj=
ects.
> >> As for me - no, not until the end of this week..
> >>
> >> I am puzzled with the following:
> >>
> >> I've got ML405 recently. There is a prebuilt bitstream with TEMAC in S=
GDMA mode for this board made by Xilinx (XAPP941).
> >> With the TEMAC driver from EDK 9.1SP2 and the XAPP941 bitstream I've g=
ot (no jumbo frames):
> >>
> >>    XTemac: using sgDMA mode.
> >>    XTemac: using TxDRE mode
> >>    XTemac: using RxDRE mode
> >>    XTemac: buffer descriptor size: 32768 (0x8000)
> >>    XTemac: (buffer_descriptor_init) phy: 0x3cf8000, virt: 0xff100000, =
size: 0x8000
> >>    eth%d: XTemac: PHY detected at address 7.
> >>    eth0: Xilinx TEMAC #0 at 0x80000000 mapped to 0xC5060000, irq=3D0
> >>    eth0: XTemac id 1.0f, block id 5, type 8
> >>
> >>    eth0: XTemac: Options: 0xb8f2
> >>    eth0: XTemac: We renegotiated the speed to: 1000
> >>    eth0: XTemac: speed set to 1000Mb/s
> >>    eth0: XTemac: Send Threshold =3D 16, Receive Threshold =3D 2
> >>    eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =3D 1
> >>
> >>    root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168=
.119.1 -i 10,
> >>    2 -I 99,10 -t UDP_STREAM -- -m 32768 -s 262144
> >>    UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET =
to 192.168.11
> >>    9.1 (192.168.119.1) port 0 AF_INET : =B15.0% @ 99% conf.
> >>    Socket  Message  Elapsed      Messages
> >>    Size    Size     Time         Okay Errors   Throughput
> >>    bytes   bytes    secs            #      #   10^6bits/sec
> >>
> >>    217088   32768   30.00       26391      0     230.60
> >>    107520           30.00       26377            230.48
> >>
> >> Not that bad for this setup.
> >>
> >> With xps (EDK 9.1 without any SPs) I've tried creating exact the same =
design.
> >> So that exact the same kernel etc could be used for the both bitstream=
s.
> >> And with the self-made one I see exact the same output with the only d=
ifference:
> >>
> >>    root@192.168.119.11:~/netperf-2.4.1/src# ./netperf -l 30 -H 192.168=
.119.1 -i 10,
> >>    2 -I 99,10 -t UDP_STREAM -- -m 32768 -s 262144
> >>    UDP UNIDIRECTIONAL SEND TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET =
to 192.168.11
> >>    9.1 (192.168.119.1) port 0 AF_INET : =B15.0% @ 99% conf.
> >>    Socket  Message  Elapsed      Messages
> >>    Size    Size     Time         Okay Errors   Throughput
> >>    bytes   bytes    secs            #      #   10^6bits/sec
> >>
> >>    217088   32768   30.00        9593      0      83.82
> >>    107520           30.00        9586             83.76
> >>
> >> :o(
> >>
> >> Rebuilding the XAPP941 project with EDK 9.1.00 still leaves 230Mb/sec.
> >> I also pulled the additional timing constraints from XAPP941's data/sy=
stem.ucf
> >> into the self-made data/system.ucf, but this haven't change anything.
> >>
> >> I've run out of ideas, and switched from TEMAC to other Xilinx stuff f=
or a while.
> >>
> >>
> >> Thanks,
> >> Andrei
> >=20
> > _________________________________________________________________
> > Connect to the next generation of MSN Messenger=20
> > http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&s=
ource=3Dwlmailtagline
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
