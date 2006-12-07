Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8BBB167C42
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 17:16:27 +1100 (EST)
Date: Thu, 7 Dec 2006 17:16:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: albertl@mail.com
Subject: Re: Oops in pata_pdc2027x
Message-Id: <20061207171623.fa0384c5.sfr@canb.auug.org.au>
In-Reply-To: <457790F0.2070208@tw.ibm.com>
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
	<457790F0.2070208@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Albert Lee <albertcc@tw.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 07 Dec 2006 11:56:32 +0800 Albert Lee <albertcc@tw.ibm.com> wrote:
>
> It seems the opps occurred in the ata_exec_internal(). Could you please
> try the attached patch and see if the older ata_exec_internal() works?
> This can help to narrow it down.

This worked much better:

Waiting for /dev to be fully populated...pata_pdc2027x 0001:cc:01.0: PLL input clock 32721 kHz
ata1: PATA max UDMA/133 cmd 0xD0000800801457C0 ctl 0xD000080080145FDA bmdma 0xD000080080145000 irq 324
ata2: PATA max UDMA/133 cmd 0xD0000800801455C0 ctl 0xD000080080145DDA bmdma 0xD000080080145008 irq 324
scsi1 : pata_pdc2027x
ata1.00: ATAPI, max UDMA/66
ata1.00: configured for UDMA/66
scsi2 : pata_pdc2027x
ATA: abnormal status 0x8 on port 0xD0000800801455DF
scsi 1:0:0:0: CD-ROM            IBM      DROM00205L1   H0 P533 PQ: 0 ANSI: 2
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg4 type 5
done.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFd7G3FdBgD/zoJvwRAnvrAKCISQ59ZqrcorBm0FgYlLSv+iGDXgCePdwM
vf+/qufsnb2xGdqNniWJH88=
=NbCo
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Dec_2006_17_16_23_+1100_jDScxizf0QVQEAtA--
