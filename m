Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 6CC0FB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 20:24:35 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 05359-03 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 09:24:29 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][v1] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Mon, 21 Feb 2011 09:21:52 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC59@saturn3.aculab.com>
In-Reply-To: <1298259096-3426-1-git-send-email-prabhakar@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Prabhakar Kushwaha" <prabhakar@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: meet2prabhu@gmail.com, Ashish Kalra <B00888@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch changes the code to:

>  		if (ap->nr_pmp_links) {
> +			int dev_num;
>  			dereg =3D ioread32(hcr_base + DE);
...
> +			dev_num =3D ffs(dereg)-1;
> +			if (dev_num < ap->nr_pmp_links) {
> +				link =3D &ap->pmp_link[dev_num];

On the off chance that no bits are set in 'DE' this
code depends on nr_pmp_links being unsigned (since
dev_num becomes -1.

Changing 'dev_num' to 'unsigned int' would be better.

	David
