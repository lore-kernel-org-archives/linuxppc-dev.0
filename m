Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804FFC4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Aug 2021 00:48:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77D161167
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Aug 2021 00:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C77D161167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GhNy55vTqz3dGY
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Aug 2021 10:48:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=goH/1yJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=goH/1yJM; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GhJQw6Y3Fz30JK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Aug 2021 07:24:56 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4064360EE8;
 Fri,  6 Aug 2021 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628285093;
 bh=OJXVvQV1lg0BTpnm4/Nv7ym7sLl0HIhqKTRdfOznYwg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=goH/1yJM9CgOOo+OcwLI85KOcKMTJKy8qsbi9kmA/eUKLp96x9J8M/JAw+C0HoXtl
 LLP9C54GqLgkjnKpGR9kkrYUXUKz/g5bCUA/CpaOzR6XQzlUTgr5y3Dk7zGrmBxX8N
 en5fOF69mFY7iz78CR1nGEcyNekjfw/CZ0EQbDXeU3Hh82nmIhL0nXS2kQ3mhduoVP
 XswzHNEybaPpFHtw5KHBi3RP5f5dPsW9v9eFEsYvxzj76KiOdi8Bw4rMEV5B6PvQ1z
 CLKL2wH1wGanKV5ZinDF8ZSKormkVT85L0UCSY8TizkDvEv+r8Jkclod/etLJWRRFl
 2rifLx8uQfKtA==
Date: Fri, 6 Aug 2021 16:24:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 0/6] PCI: Drop duplicated tracking of a pci_dev's
 bound driver
Message-ID: <20210806212452.GA1867870@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210806064623.3lxl4clzbjpmchef@pengutronix.de>
X-Mailman-Approved-At: Sat, 07 Aug 2021 10:48:21 +1000
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
 Alexander Duyck <alexanderduyck@fb.com>, x86@kernel.org,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Taras Chornyi <tchornyi@marvell.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Sathya Prakash <sathya.prakash@broadcom.com>, qat-linux@intel.com,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Fiona Trahe <fiona.trahe@intel.com>, Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Ido Schimmel <idosch@nvidia.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Michael Buesch <m@bues.ch>, Jiri Pirko <jiri@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Juergen Gross <jgross@suse.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>, xen-devel@lists.xenproject.org,
 Vadym Kochan <vkochan@marvell.com>, MPT-FusionLinux.pdl@broadcom.com,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Zhou Wang <wangzhou1@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-crypto@vger.kernel.org, kernel@pengutronix.de,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Simon Horman <simon.horman@corigine.com>,
 Wojciech Ziemba <wojciech.ziemba@intel.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 06, 2021 at 08:46:23AM +0200, Uwe Kleine-König wrote:
> On Thu, Aug 05, 2021 at 06:42:34PM -0500, Bjorn Helgaas wrote:

> > I looked at all the bus_type.probe() methods, it looks like pci_dev is
> > not the only offender here.  At least the following also have a driver
> > pointer in the device struct:
> > 
> >   parisc_device.driver
> >   acpi_device.driver
> >   dio_dev.driver
> >   hid_device.driver
> >   pci_dev.driver
> >   pnp_dev.driver
> >   rio_dev.driver
> >   zorro_dev.driver
> 
> Right, when I converted zorro_dev it was pointed out that the code was
> copied from pci and the latter has the same construct. :-)
> See
> https://lore.kernel.org/r/20210730191035.1455248-5-u.kleine-koenig@pengutronix.de
> for the patch, I don't find where pci was pointed out, maybe it was on
> irc only.

Oh, thanks!  I looked to see if you'd done something similar
elsewhere, but I missed this one.

> > Looking through the places that care about pci_dev.driver (the ones
> > updated by patch 5/6), many of them are ... a little dubious to begin
> > with.  A few need the "struct pci_error_handlers *err_handler"
> > pointer, so that's probably legitimate.  But many just need a name,
> > and should probably be using dev_driver_string() instead.
> 
> Yeah, I considered adding a function to get the driver name from a
> pci_dev and a function to get the error handlers. Maybe it's an idea to
> introduce these two and then use to_pci_driver(pdev->dev.driver) for the
> few remaining users? Maybe doing that on top of my current series makes
> sense to have a clean switch from pdev->driver to pdev->dev.driver?!

I'd propose using dev_driver_string() for these places:

  eeh_driver_name() (could change callers to use dev_driver_string())
  bcma_host_pci_probe()
  qm_alloc_uacce()
  hns3_get_drvinfo()
  prestera_pci_probe()
  mlxsw_pci_probe()
  nfp_get_drvinfo()
  ssb_pcihost_probe()

The use in mpt_device_driver_register() looks unnecessary: it's only
to get a struct pci_device_id *, which is passed to ->probe()
functions that don't need it.

The use in adf_enable_aer() looks wrong: it sets the err_handler
pointer in one of the adf_driver structs.  I think those structs
should be basically immutable, and the drivers that call
adf_enable_aer() from their .probe() methods should set
".err_handler = &adf_err_handler" in their static adf_driver
definitions instead.

I think that basically leaves these:

  uncore_pci_probe()     # .id_table, custom driver "registration"
  match_id()             # .id_table, arch/x86/kernel/probe_roms.c
  xhci_pci_quirks()      # .id_table
  pci_error_handlers()   # roll-your-own AER handling, drivers/misc/cxl/guest.c

I think it would be fine to use to_pci_driver(pdev->dev.driver) for
these few.

Bjorn
