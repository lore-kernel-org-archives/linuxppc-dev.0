Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 54F82B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 22:42:07 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 06933-07 for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:41:54 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH][v2] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Tue, 8 Mar 2011 11:39:02 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC6E@saturn3.aculab.com>
In-Reply-To: <1299555095-2967-1-git-send-email-prabhakar@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Prabhakar Kushwaha" <prabhakar@freescale.com>, <linux-ide@vger.kernel.org>
Cc: meet2prabhu@gmail.com, Ashish Kalra <B00888@freescale.com>,
	jgarzik@pobox.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>  Case when ffs return will never arise.This scenario is=20
> already been discussed
>  on linuxppc-dev@lists.ozlabs.org. Please see below explanation:
>  sata_fsl_error_intr() is called during device error.The=20
> mentioned scenario
>  will never comes. It can be observed via code:-
>         if (cereg) {   --> cereg is set on command error.=20
> Means there is at least 1 device present.

This all relies on the hardware working properly, and
nothing else accidentally clearing the device 'error'
bit mask.

Being slightly defensive when the out of range value
causes an array subscript error seems sensible.

It isn't as though the code size or execution time
matters here.

	David
