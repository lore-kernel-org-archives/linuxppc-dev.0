Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 0622914008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 20:42:11 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 07907-09 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 27 Mar 2014 09:42:05 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mark Brown' <broonie@kernel.org>
Subject: RE: [PATCH] ASoC: fsl_sai: Add isr to deal with error flag
Date: Thu, 27 Mar 2014 09:41:20 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6EA538@AcuExch.aculab.com>
References: <1395834517-16426-1-git-send-email-Guangyu.Chen@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6E958E@AcuExch.aculab.com>
 <20140327011424.GB30768@sirena.org.uk>
In-Reply-To: <20140327011424.GB30768@sirena.org.uk>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 'Nicolin Chen' <Guangyu.Chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mark Brown
> On Wed, Mar 26, 2014 at 11:59:53AM +0000, David Laight wrote:
> > From: Nicolin Chen
>=20
> > > +	regmap_read(sai->regmap, FSL_SAI_TCSR, &xcsr);
> > > +	regmap_write(sai->regmap, FSL_SAI_TCSR, xcsr);
>=20
> > Assuming these are 'write to clear' bits, you might want
> > to make the write (above) and all the traces (below)
> > conditional on the value being non-zero.
>=20
> The trace is already conditional?  I'd also expect to see the driver
> only acknowledging sources it knows about and only reporting that the
> interrupt was handled if it saw one of them - right now all interrupts
> are unconditionally acknowleged.

The traces are separately conditional on their own bits.
That is a lot of checks that will normally be false.

Also the driver may need to clear all the active interrupt
bits in order to make the IRQ go away.
It should trace that bits it doesn't expect to be set though.

	David
