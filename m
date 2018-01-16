Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00048.outbound.protection.outlook.com [40.107.0.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLckY20L3zF0Yd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 04:33:08 +1100 (AEDT)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Darren Stevens <darren@stevens-zone.net>
CC: Jamie Krueger <jamie@bitbybitsoftwaregroup.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: DPAA Ethernet problems with mainstream Linux kernels
Date: Tue, 16 Jan 2018 17:33:02 +0000
Message-ID: <DB3PR0402MB38496B4FB62904321A97186AECEA0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
References: <ccafbcca-172b-11ae-7916-8bcd4bfa419c@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C70D5760C3F21F881074EC170@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <d7478110-68ae-34b3-51c5-487bb3e12527@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C1D81C867CF2D5A65D0EECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <4b50ee845f3.281d6f13@auth.smtp.1and1.co.uk>
In-Reply-To: <4b50ee845f3.281d6f13@auth.smtp.1and1.co.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Darren Stevens [mailto:darren@stevens-zone.net]
> Sent: Tuesday, January 16, 2018 12:40 AM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> Cc: Jamie Krueger <jamie@bitbybitsoftwaregroup.com>; linuxppc-
> dev@lists.ozlabs.org; netdev@vger.kernel.org
> Subject: Re: DPAA Ethernet problems with mainstream Linux kernels
>=20
> Hello Madalin-cristian
>=20
> On 15/01/2018, Madalin-cristian Bucur wrote:
> >> > The device tree that you mention, cyrus_p5020.eth.dts is not found i=
n
> >> > the Linux kernel sources. The cyrus_p5020.dts file from the fsl ppc
> >> > device tree folder does not include the PHY information for the DPAA
> >> > interfaces. The problems that you experience may be caused by some
> >> > issues with the PHY configuration (i.e. internal delay).
> >> The cyrus_p5020.eth.dts is a modified version of the cyrus_p5020.dts,
> >> which of course was based off the original p5020ds.dts file. As you
> >> noted, the current cyrus_p5020.dts file is incomplete, and does not
> >> map the Ethernet connections properly.
>=20
> This is because the current linux kernel version of cyrus_p5020.dts
> includes 'p5020si-pre.dtsi' and 'p5020si-post.dtsi' include files, which
> orginally gave us working ethernet (when we used the SDK kernel) However
> at some point you moved the ethernet aliases from the board dts file to
> the p5020si-pre.dtsi file breaking the linkages for our board.
>=20
> cyrus-pre.dtsi is simply p5020si-pre.dtsi with only the correct aliases
> in.
>=20
> >> ** I have attached both the cyrus_p5020.eth.dts and cyrus-pre.dtsi
> >>  =A0=A0=A0=A0 files with this email for comparison. Please let me know=
 if you
> see
> >>  =A0=A0=A0=A0 any corrections that should be made to either file.
> >
> > At a first glance they look fine to me.
>=20
> That's good to know.
>=20
> >> I have started testing along that line, using Wireshark to view the
> >> traffic on the X5000/20 itself, and from another machine connected
> >> on the same subnet. So far (as indicated by some details of in my
> >> initial email), I can see outgoing broadcast requests (for DHCP)
> >> being sent out from the X5000/20, and these requests are correctly
> >> constructed and visible outside the X5000/20.
> >>
> >> However, no responses to the DHCP broadcasts appear to reach
> >> to X5000/20's DPAA Ethernet. I will need to setup some further
> >> tests to determine if the DHCP server saw the requests and responded
> >> to them. (I assume the DHCP server is getting them, and responding,
> >> as I can always get a successful DHCP response to the X5000/20
> >> when using an add-on Ethernet PICe card on the same subnet).
>=20
> This matches what I see, the interface I have connected to the network
> shows an increasing number of transmitted packets, but no received ones.
>=20
> Jamie also noticed the following error in dmesg (right after the ethernet
> port becomes active)
>=20
> [    4.112165] fsl_dpa dpaa-ethernet.0 eth0: Probed interface eth0
> [    4.116616] fsl_dpa dpaa-ethernet.1 eth1: Probed interface eth1
> [ ... ]
> [  106.501055] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> [  106.570944] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> [  106.605044] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [  106.674918] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [  108.702771] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  109.032798] fsl-pamu: pamu_av_isr: access violation interrupt
> [  109.032806] fsl-pamu: pamu_av_isr: POES1=3D00000000
> [  109.032808] fsl-pamu: pamu_av_isr: POES2=3D00000000
> [  109.032809] fsl-pamu: pamu_av_isr: AVS1=3D002d0081
> [  109.032811] fsl-pamu: pamu_av_isr: AVS2=3D00000081
> [  109.032813] fsl-pamu: pamu_av_isr: AVA=3D00000001f1328000
> [  109.032815] fsl-pamu: pamu_av_isr: UDAD=3D002d0001
> [  109.032817] fsl-pamu: pamu_av_isr: POEA=3D0000000000000000
>=20
> I haven't seen this anywhere else, and wondered if it is relevant.
>=20
> Regards
> Darren

The PAMU related errors may be relevant to the issue, if you have incorrect
settings you may have no traffic passing through. The PAMU configuration
should be made by the bootloader. Can you try to disable CONFIG_FSL_PAMU?

Madalin
