Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 90F431007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 20:13:02 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 00750-05 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 09:12:59 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] gianfar: Fall back to software tcp/udp checksum on
	oldercontrollers
Date: Fri, 28 Jan 2011 09:10:46 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2E@saturn3.aculab.com>
In-Reply-To: <640295.36173.qm@web37608.mail.mud.yahoo.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> +		if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12)
> +			     && ((unsigned long)fcb % 0x20) > 0x18)) {

You need to check the generated code, but I think you need:

    if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12))
	     && unlikely(((unsigned long)fcb % 0x20) > 0x18))

ie unlikely() around both the primitive comparisons.

	David
