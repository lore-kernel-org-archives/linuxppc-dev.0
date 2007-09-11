Return-Path: <shannon.nelson@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id DEBACDDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 01:16:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Date: Tue, 11 Sep 2007 08:15:30 -0700
Message-ID: <BAE9DCEF64577A439B3A37F36F9B691C03023D9E@orsmsx418.amr.corp.intel.com>
In-Reply-To: <20070911142014.GG1932@ld0162-tx32.am.freescale.net>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<BAE9DCEF64577A439B3A37F36F9B691C02FF08A1@orsmsx418.amr.corp.intel.com>
	<46B96294322F7D458F9648B60E15112C85D61E@zch01exm26.fsl.freescale.net>
	<20070911142014.GG1932@ld0162-tx32.am.freescale.net>
From: "Nelson, Shannon" <shannon.nelson@intel.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, "Williams, Dan J" <dan.j.williams@intel.com>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From: Scott Wood [mailto:scottwood@freescale.com]=20
>Sent: Tuesday, September 11, 2007 7:20 AM
>To: Zhang Wei-r63237
>Cc: Nelson, Shannon; paulus@samba.org;=20
>linuxppc-dev@ozlabs.org; Williams, Dan J; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale=20
>MPC85xx processors.
>
>On Tue, Sep 11, 2007 at 06:10:53PM +0800, Zhang Wei-r63237 wrote:
>> > >+
>> > >+	fsl_dma_memcpy_issue_pending(chan);
>> > >+	while (fsl_dma_is_complete(chan, cookie, NULL, NULL)
>> > >+			!=3D DMA_SUCCESS);
>> >=20
>> > Again, is it possible to hang your thread here?
>> >=20
>> > [...]
>>=20
>> I'll add msleep here.
>
>I think what was being sought was a timout, causing the test to return
>failure.
>
>-Scott
>

Either a timeout to stop the polling, or msleep() followed by a single
call to fsl_dma_is_complete().  However, using the msleep() method is
likely to be kinder to the rest of the kernel than polling for very
long.

sln
