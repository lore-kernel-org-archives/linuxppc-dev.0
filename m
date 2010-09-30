Return-Path: <david-b@pacbell.net>
Received: from n76.bullet.mail.sp1.yahoo.com (n76.bullet.mail.sp1.yahoo.com
	[98.136.44.48]) by ozlabs.org (Postfix) with SMTP id D4061B70AB
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 20:46:27 +1000 (EST)
Message-ID: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
Date: Thu, 30 Sep 2010 03:46:25 -0700 (PDT)
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, Mingkai Hu <Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A--- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu@freescale.com> wrote:=0A=0A>=
 From: Mingkai Hu <Mingkai.hu@freescale.com>=0A> Subject: [PATCH v3 6/7] mt=
d: m25p80: add a read function to read page by page=0A=0ANAK.=0A=0AWe went =
over this before.=0A=0A=A0 The bug is in your SPI master controller driver,=
=0Aand the fix there involves mapping large reads=0A into multiple smaller =
reads.=A0 (Example, 128K=0Aread as two 64K reads instead of one of 128K.=0A=
=0AIt's *NEVER* appropriate to commit to patching all=0Aupper level drivers=
 in order to work around bugs=0Ain lower level ones.=A0 The set of such upp=
er level=0Adrivers that may need bugfixing is quite large,=0Amost will neve=
r be used with your buggy controller=0Adriver, and all such patches will ne=
ed testing (but=0Athe test resources are probably not available).=0A=0AWhat=
ever SPI controller driver you're working with=0Ais clearly buggy ... but n=
ot unfixably so.=0A=0ADO NOT head down the path of requiring every SPI=0Ade=
vice driver to include workarounds for this odd=0Alittle SPI master driver =
bug.=0A=0A- Dave=0A=0A=0A=0A=0A=0A
