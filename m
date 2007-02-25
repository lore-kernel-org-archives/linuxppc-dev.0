Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 24012DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 06:51:15 +1100 (EST)
Subject: SPI controller hangs in 2.6 and not in 2.4 (on MPC875)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75916.4D8EA9D2"
Date: Sun, 25 Feb 2007 20:51:12 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E264927@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75916.4D8EA9D2
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Melinda,

the problem in my case was caused by the following instructions to =
allocate the buffers for SPI controller tx and rx:

        rxbuffer =3D (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE); =20
        txbuffer =3D (u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);=20
        // Set the bd's rx and tx buffer address pointers
        rbdf->cbd_bufaddr =3D virt_to_bus((void *)rxbuffer);             =
                   =20
        tbdf->cbd_bufaddr =3D virt_to_bus((void *)txbuffer);  =20

I don't know why (I'm asking an opinion to Vitaly Bordug), I replaced =
the allocation of rx and tx buffers with:

...->cbd_bufaddr =3D __pa(__get_free_page(GFP_KERNEL | GFP_DMA))

but it will better to use dma_alloc_coherent.
In my case the use of m8xx_cpm_hostalloc led to an immediate kernel hang =
after giving the start command to the spi controller.

Bye,
Antonio.


                            =20

------_=_NextPart_001_01C75916.4D8EA9D2
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7234.20">
<TITLE>SPI controller hangs in 2.6 and not in 2.4 (on MPC875)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Melinda,<BR>
<BR>
the problem in my case was caused by the following instructions to =
allocate the buffers for SPI controller tx and rx:<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxbuffer =3D =
(u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txbuffer =3D =
(u8*)m8xx_cpm_hostalloc(SPI_MAX_BUFFER_SIZE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Set the bd's rx and tx =
buffer address pointers<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbdf-&gt;cbd_bufaddr =3D =
virt_to_bus((void =
*)rxbuffer);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbdf-&gt;cbd_bufaddr =3D =
virt_to_bus((void *)txbuffer);&nbsp;&nbsp;<BR>
<BR>
I don't know why (I'm asking an opinion to Vitaly Bordug), I replaced =
the allocation of rx and tx buffers with:<BR>
<BR>
...-&gt;cbd_bufaddr =3D __pa(__get_free_page(GFP_KERNEL | GFP_DMA))<BR>
<BR>
but it will better to use dma_alloc_coherent.<BR>
In my case the use of m8xx_cpm_hostalloc led to an immediate kernel hang =
after giving the start command to the spi controller.<BR>
<BR>
Bye,<BR>
Antonio.<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75916.4D8EA9D2--
