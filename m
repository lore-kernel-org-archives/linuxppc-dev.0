Return-Path: <B21989@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DFC32C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 17:51:57 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Anthony Foiani <tkil@scrye.com>
Subject: RE: SATA hang on 8315E triggered by heavy flash write?
Date: Mon, 27 May 2013 07:50:17 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C90B1E567D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
 <g4ndt3f5q.fsf@dworkin.scrye.com>
In-Reply-To: <g4ndt3f5q.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > So it seems the NOR write break the signal Integrity of SATA.
> > I don't have schematic and board right now, could you please measure
> > signals related to NOR write to see if anything abnormal? Is the board
> > use FPGA or CPLD to control signal?
>=20
> I'll have to pass these questions on to my hardware vendor; I'm not
> equipped to do this level of hardware debugging (neither hardware nor
> knowledge!).
>=20
> > If stop NOR write, could the SATA recover and work?
>=20
> Earlier in my development, I was seeing this error and it would
> recover:
>=20
>   ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
>   ata2: PHY RDY changed
>   ata2: hard resetting link
>   ata2: Signature Update detected @ 0 msecs
>   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>   ata2.00: configured for UDMA/133
>   ata2: EH complete
>=20
> At the current time, however, it seems that it does not recover.
>=20
> I don't know whether this is due to the speed limiting code, or if it's
> because we are doing more disk accesses (when the actual product is up
> and running).
[S.H] it seems it's not due to speed limiting code, 1.5Gbps is still used t=
o recover link.

>=20
> I can re-do the tests with the speed limit disabled, but I won't be able
> to get to that for a few hours yet.  You can read about the speed limit
> issues in this thread:
>=20
>   http://article.gmane.org/gmane.linux.ports.ppc.embedded/50652
>=20
> And my final patch (yes, a year later):
>=20
>   http://article.gmane.org/gmane.linux.ports.ppc.embedded/58969
[S.H] for the speed limit issue, I checked 3.4.rc7 kernel, there seems a pl=
ace can be used to limit the speed for 8315:
	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-sata")) {
		temp =3D ioread32(csr_base + TRANSCFG);
		temp =3D temp & 0xffffffe0;
		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
	} else {
		/* the speed limitation code for 8315 may can be put here.
		* just move the original code which wrapped by "#ifdef CONFIG_MPC8315_DS"=
 here.
		* please let me know if you will give a try. */
	}


Best Regards,=20
Shaohui Xie
