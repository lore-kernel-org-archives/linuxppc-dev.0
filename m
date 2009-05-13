Return-Path: <kosmo@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D03CDDFB4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 19:00:09 +1000 (EST)
From: Piotr =?iso-8859-2?q?Zi=EAcik?= <kosmo@semihalf.com>
To: John Rigby <jcrigby@gmail.com>
Subject: Re: [PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
Date: Wed, 13 May 2009 10:41:45 +0200
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-7-git-send-email-wd@denx.de>
	<4b73d43f0905072030n1b014dafmea840387ab0f3a6d@mail.gmail.com>
In-Reply-To: <4b73d43f0905072030n1b014dafmea840387ab0f3a6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200905131041.45944.kosmo@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46riday 08 May 2009 05:30:15 John Rigby napisa=B3(a):
> Did you choose to not support hardware ECC so you could use the spare are=
a?
> The original driver only supported hardware ECC but unfortuneatly the
> hardware ECC includes the spare area so the spare area cannot be written
> separately.

In short yes. There are fundamental problems which you described. Flash=20
filesystems expect that ECC is calculated from main area only and writes to=
=20
spare area not change it. MPC5121 NAND flash controller calculates ECC from=
=20
both areas except few bytes holding ECC. This makes flash filesystems=20
unusable when we turn on hardware ECC.

This could be fixed by disabling spare area usage in flash filesystems but
this probably requires changes in the MTD/filesystem infrastructure.

=2D-=20
Best Regards.
Piotr Zi=EAcik
