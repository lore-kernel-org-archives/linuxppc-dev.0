Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97715C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 07:55:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CCC60FED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 07:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16CCC60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gbfnp5xywz3cXF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jul 2021 17:55:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=T6hObKQm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=T6hObKQm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GbbF41JLzz3cHY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jul 2021 15:15:02 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AAA660F9B;
 Fri, 30 Jul 2021 05:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1627622098;
 bh=Rd0qV6oPrMRK9x5RQHEA0i4kdEU0U+RcVzNm4XOeux8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6hObKQmOk4AFgIpQT4y2Zsi4Q75SgNjFNnS8pRLR4KFvnEyagvEfbTCdxstRLsYG
 rjTcpLBlDG/oVJ8lnaqbcwXAZTVT9l8C6Cy6bhh3Fo+ilPrCNthbqlfZm24+7rNODV
 PAMI7xMjSKfCoNPXlo3uccVRt1pE46rn5PvW/dE4=
Date: Fri, 30 Jul 2021 07:14:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 0/5] PCI: Drop duplicated tracking of a pci_dev's
 bound driver
Message-ID: <YQOKz0l6aaU8PGLV@kroah.com>
References: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729203740.1377045-1-u.kleine-koenig@pengutronix.de>
X-Mailman-Approved-At: Fri, 30 Jul 2021 17:54:43 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Sathya Prakash <sathya.prakash@broadcom.com>, oss-drivers@corigine.com,
 Oliver O'Halloran <oohall@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-perf-users@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, x86@kernel.org, qat-linux@intel.com,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Fiona Trahe <fiona.trahe@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Simon Horman <simon.horman@corigine.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Michael Buesch <m@bues.ch>, Jiri Pirko <jiri@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Juergen Gross <jgross@suse.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>, xen-devel@lists.xenproject.org,
 Vadym Kochan <vkochan@marvell.com>, MPT-FusionLinux.pdl@broadcom.com,
 linux-usb@vger.kernel.org, Wojciech Ziemba <wojciech.ziemba@intel.com>,
 linux-kernel@vger.kernel.org, Taras Chornyi <tchornyi@marvell.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, linux-crypto@vger.kernel.org,
 kernel@pengutronix.de, netdev@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 29, 2021 at 10:37:35PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> struct pci_dev tracks the bound pci driver twice. This series is about
> removing this duplication.
> 
> The first two patches are just cleanups. The third patch introduces a
> wrapper that abstracts access to struct pci_dev->driver. In the next
> patch (hopefully) all users are converted to use the new wrapper and
> finally the fifth patch removes the duplication.
> 
> Note this series is only build tested (allmodconfig on several
> architectures).
> 
> I'm open to restructure this series if this simplifies things. E.g. the
> use of the new wrapper in drivers/pci could be squashed into the patch
> introducing the wrapper. Patch 4 could be split by maintainer tree or
> squashed into patch 3 completely.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (5):
>   PCI: Simplify pci_device_remove()
>   PCI: Drop useless check from pci_device_probe()
>   PCI: Provide wrapper to access a pci_dev's bound driver
>   PCI: Adapt all code locations to not use struct pci_dev::driver
>     directly
>   PCI: Drop duplicated tracking of a pci_dev's bound driver

Other than my objection to patch 5/5 lack of changelog, looks sane to
me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
