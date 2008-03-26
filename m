Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38A57DDFCD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 23:43:52 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2QChkp6026621 for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 05:43:46 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m2QChh7K017723
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 07:43:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
Date: Wed, 26 Mar 2008 20:43:42 +0800
Message-ID: <989B956029373F45A0B8AF029708189001D198BC@zch01exm26.fsl.freescale.net>
In-Reply-To: <1206436671.7589.208.camel@gentoo-jocke.transmode.se>
References: <>
	<1205853088-30171-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<989B956029373F45A0B8AF029708189001D19565@zch01exm26.fsl.freescale.net>
	<46CAC1281D7CB94A9AEFFB131F9569CA227627@tmnt04.transmode.se>
	<1206436671.7589.208.camel@gentoo-jocke.transmode.se>
From: "Li Yang" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>
Cc: Netdev <netdev@vger.kernel.org>,
	"Linuxppc-Embedded@Ozlabs.Org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]=20
> Sent: Tuesday, March 25, 2008 5:18 PM
> To: Li Yang
> Cc: Netdev; Linuxppc-Embedded@Ozlabs.Org
> Subject: Re: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
>=20
>=20
> On Sat, 2008-03-22 at 12:51 +0100, Joakim Tjernlund wrote:
> > >> -----Original Message-----
> > >> From: netdev-owner@vger.kernel.org
> > >> [mailto:netdev-owner@vger.kernel.org] On Behalf Of=20
> Joakim Tjernlund
> > > Sent: Tuesday, March 18, 2008 11:11 PM
> > >> To: Netdev; Li Yang
> > >> Cc: Joakim Tjernlund
> > >>Subject: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
> > >>
> > >> Creating a VLAN interface on top of ucc_geth adds 4 bytes to the=20
> > >> frame and the HW controller is not prepared to TX a frame bigger=20
> > >> than 1518 bytes which is 4 bytes too small for a full=20
> VLAN frame.=20
> > >> Also add 4 extra bytes for future expansion.
> > >=20
> > > IMO, VLAN and Jumbo packet support is not general case of=20
> Ethernet.
> > > Could you make this change optional?  Thanks.
> > >=20
> > > - Leo
> >=20
> > hmm, I do not agree. VLAN is common today.
> >=20
> > If you were to enable HW support for VLAN then the ethernet=20
> controller=20
> > would inject an extra 4 bytes into the frame.
> > This change does not change the visible MTU for the user.=20
> As is now,=20
> > soft VLAN is silently broken. Do you really want the user=20
> to find and=20
> > turn on a controller specific feature to use VLAN?
> >=20
> > What does netdev people think?=20
> >=20
> >  Jocke
>=20
> hmm, I misread the HW specs. The change has nothing to do=20
> with TX, it is the MAX RX frame size that was too small for=20
> VLAN and that is what the patch addresses. I see that tg3.c=20
> adds 4 bytes to MAX RX pkgs:
>  	/* MTU + ethernet header + FCS + optional VLAN tag */
> 	tw32(MAC_RX_MTU_SIZE, tp->dev->mtu + ETH_HLEN + 8); So=20
> I don't think this change should be hidden behind a new=20
> CONFIG option. Updated patch below with changed description.

Hi Jocke,

QUICC engine supports dynamic maximum frame length.  If you are not
expecting to receive only tagged frames, I recommend to use this feature
by setting dynamicMaxFrameLength and dynamicMinFrameLength in ug_info
instead of increasing the MaxLength for both tagged and untagged frames.
See the following part from the reference manual.

The MFLR entry in the Global Parameter RAM defines the length of the
largest frame, excluding Q TAG
but including FCS, that is still valid. When REMODER[DXE]=3D1, a tagged
frame that has length equals
MaxLength+4 considered valid, and a non tagged frame that has length
equals MaxLength is the longest
that is still considered valid. When REMODER[DXE]=3D0, any frame longer
than MaxLength consider
erroneous frame.
For systems with only tagged frames, set REMODER[DXE]=3D0 and set
MaxLength =3D Max LLC size+4.

- Leo
