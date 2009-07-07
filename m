Return-Path: <markn@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5DAC8B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 10:13:23 +1000 (EST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28890DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 10:13:21 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n670D08G026414
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 10:13:00 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n670DB1j1191970
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 10:13:11 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n670DBIP018723
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jul 2009 10:13:11 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: =?iso-8859-1?q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
Subject: Re: dma_ops->map_page == NULL
Date: Tue, 7 Jul 2009 10:15:23 +1000
References: <4A523984.2080904@marel.com>
In-Reply-To: <4A523984.2080904@marel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907071015.24097.markn@au1.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 07 July 2009 03:51:00 K=E1ri Dav=ED=F0sson wrote:
> I am doing a driver that uses dma_map_single().
>=20
> After changing to to linux 2.6.29.3 I am getting
> segfaults in dma_map_single() because dma_ops->map_page is NULL.
> Actually dma_ops looks funky too.

When the 32 and 64bit DMA code was merged in .28 , map_/unmap_page() was
added in favour of map_/unmap_single() (which was later removed in .29)
so you'll have to replace your calls to dma_map_single() with
dma_map_page(). Just pass it the page and offset rather than the address.

Hope that helps!
Mark.

>=20
> The driver is an of_platform_driver which is declared as an child of
> the lbp (fsl,lpb) node of the device tree.
>=20
> This is on powerpc 5200b platform.
>=20
> rg
> kd
