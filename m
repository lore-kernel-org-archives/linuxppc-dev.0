Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 1E3B1B70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Oct 2011 01:11:35 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 02908-03 for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 15:11:27 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] mlx4_en: fix transmit of packages when blue frame
	isenabled
Date: Thu, 6 Oct 2011 15:10:28 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE76@saturn3.aculab.com>
In-Reply-To: <20111006135759.GH2681@mtldesk30>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Eli Cohen" <eli@dev.mellanox.co.il>,
	"Thadeu Lima de Souza Cascardo" <cascardo@linux.vnet.ibm.com>
Cc: Eli Cohen <eli@mellanox.co.il>, Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>  static void mlx4_bf_copy(unsigned long *dst, unsigned long *src,
unsigned bytecnt) {
> +	int i;
> +	__le32 *psrc =3D (__le32 *)src;
> +
> +	/*
> +	 * the buffer is already in big endian. For little endian
machines that's
> +	 * fine. For big endain machines we must swap since the chipset
swaps again
> +	 */
> +	for (i =3D 0; i < bytecnt / 4; ++i)
> +		psrc[i] =3D le32_to_cpu(psrc[i]);
> +
>  	__iowrite64_copy(dst, src, bytecnt / 8);
>  }

That code looks horrid...
1) I'm not sure the caller expects the buffer to be corrupted.
2) It contains a lot of memory cycles.
3) It looked from the calls that this code is copying descriptors,
   so the transfer length is probably 1 or 2 words - so the loop
   is inefficient.
4) ppc doesn't have a fast byteswap instruction (very new gcc might
   use the byteswapping memery access for the le32_to_cpu() though),
   so it would be better getting the byteswap done inside
   __iowrite64_copy() - since that is probably requesting a byteswap
   anyway.
OTOH I'm not at all clear about the 64bit xfers....
