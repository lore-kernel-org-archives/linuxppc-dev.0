Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 340E3B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Feb 2011 19:44:36 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 19465-01 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Feb 2011 08:44:18 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Fri, 18 Feb 2011 08:41:44 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC57@saturn3.aculab.com>
In-Reply-To: <1298007298-12511-1-git-send-email-prabhakar@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Prabhakar Kushwaha" <prabhakar@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: Ashish Kalra <B00888@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> +			if ((ffs(dereg)-1) < ap->nr_pmp_links) {
> +				/* array start from 0 */
> +				link =3D &ap->pmp_link[ffs(dereg)-1];

I'd only call ffs() once - it could be a slow library function.
Any comment should note that ffs() returns 0 when no bits
are set - rather than anything about array indexes.

	David
