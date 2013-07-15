Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id B744D2C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 18:55:29 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 32699-06 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 15 Jul 2013 09:47:24 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
Date: Mon, 15 Jul 2013 09:45:36 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72E1@saturn3.aculab.com>
In-Reply-To: <1373677412-24329-1-git-send-email-scottwood@freescale.com>
References: <1373677412-24329-1-git-send-email-scottwood@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Scott Wood" <scottwood@freescale.com>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#define MFTB(dest, scratch1, scratch2)	\
> +90:	mftbu	scratch1;		\
> +	mftbl	dest;			\
> +	mftbu	scratch2;		\
> +	cmpw	scratch1,scratch2;	\
> +	bne	90b;			\
> +	rldimi	dest,scratch1,32,0;

Are the three mftbu/l instructions guaranteed to be executed
in order?

Also, if the high word changes, there is no need to loop.
Just return the second value with a low word of zero
(the returned count happened while the function was active).

If the mftbx instructions are synchronizing ones (or need
sequencing), then it might be possible to only have 2 of them
by reading the 64bit value and the high 32bits.
(The correct order depends on the exact definition of the errata!)

Another option is that the 64bit value returned by mftb is
(presumably) only likely to be wrong when the low 32bits is
very near zero (either side).
A second mftb could be done in this case only with some logic
to work out a valid result (I think):
  High changed - 2nd high, low zero.
  First low -ve - first value.
  First low +ve - second value.

	David
