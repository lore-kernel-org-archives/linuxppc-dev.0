Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D1DE42C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 00:21:47 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 16990-01 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 30 Sep 2013 15:21:37 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] powerpc/8xx: tqm8xx: fix incorrect placement of
 __initdata tag
Date: Mon, 30 Sep 2013 15:20:29 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B736B@saturn3.aculab.com>
In-Reply-To: <1589399.KSlGuZSdd2@amdc1032>
References: <1589399.KSlGuZSdd2@amdc1032>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
 "Vitaly Bordug" <vitb@kernel.crashing.org>
Cc: Marcelo Tosatti <marcelo@kvack.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.
...
> -static struct __initdata cpm_pin tqm8xx_pins[] =3D {
> +static struct cpm_pin tqm8xx_pins[] __initdata =3D {

As far as gcc is concerned it can go almost anywhere before the '=3D',
even before the 'static'.
Splitting 'struct cpm_pin' does seem an odd choice.

The Linux coding standards might suggest a location.
I'd have thought that either before or after the 'static' would be best
(ie as a storage class qualifier).

	David
