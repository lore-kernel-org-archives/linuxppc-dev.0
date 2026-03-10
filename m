Return-Path: <linuxppc-dev+bounces-17963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2094DFD2D88
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 13:37:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVZh54Kgbz3bjb;
	Wed, 11 Mar 2026 00:37:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773149877;
	cv=none; b=m6YPzqEpUMPVg9jqQOMeePY0yyclt4Oi6h/xq4rF5YZaO5pjnukTwKnNXQT/Cq+hqCSC+A88r7T7hY1AFguRYu0D9YxJInS9c8zVLu8ri6cFjj4BtG0hHdE13fg6wHisXJdrPHeJSegV3NrA1TuFwl0tAeK7xgi3VX+oveg36iH2Yv43MtynV49k8FzxpeIaNNG2CB5ikj5QLLXOJlT0ISKHADnaVZ7u5N2N6Y4hRjv6/j2rK5js7JNwGctz5715cefGV1F0GqyRca87Zc5GECzHlhnBb9bKb3GcttI1kq/qN9t16Y4YBaIU5QbiMTqxu+CBppJOJbYE6pkg/ZsYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773149877; c=relaxed/relaxed;
	bh=j2y11TztidFb9gX358CPpWDLxwG42gGstwtjC9lyfVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jypjneBw3Byn3YbQ0cHqIIYuUY0nLPaLOKe11iMCrZXz0sXyciBg05lRbBhcnQPPNgLLEdQre8r3iuf+5qvvLn6mfEA5VjiN3jkIqF5k80XwO6Df2xaixB4rtG8f1nkdvgnWt8OHKyH4pLjMyoMETJo6vdZ9k6RsOdXi6lMErcCBhHNNtMylNDqR7REHQHGXOOfXis0Tk7lGYF4aRiED0cFQvxC7erh+Xph8FL+nqaagcGdkRDutJxvJFaKjVodh3muEnhfw8dIyrfX1gKkAWnvp/9Ecxs7OSo/TDBbvUCsZe5x1RlwHmWaPHjlj7AaKHVBToF8eam9bzU2L+7GwaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wfg6Pb3J; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Wfg6Pb3J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVZh45ZtBz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 00:37:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D4FDA600B0;
	Tue, 10 Mar 2026 13:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E847C19423;
	Tue, 10 Mar 2026 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773149874;
	bh=7n4LiLaeOu7Y781LaaH2FD19YKv/KTfp5uLzE86UGvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wfg6Pb3Jv9nz87f4TL4NjXyJ5y2dr7izkZZumUwjox9UckLpwcrxyLugMkVY+Fey7
	 SfYvsQTEuFF2OfasvZRT2nw7myg1Oo+0tpDr4v1qpwoxvtd+ZkHD0PTQEuXq7PqGPD
	 VANFVMhmUBZpDbWl3YRwC++GuB6Cjau8tEg2hWOXuW/zpDPqnyJzDayYz9eU9Nx3CH
	 9FK6bCQ6MNNb+lTG6RIyqf2b0qh7VM1vKivIZkCqrqJ5w25XEKS5hiJJf1wJLL76Pw
	 M0Cfc/d/TzPtaGqx4SK9wWTSCS8weZqpmNtfBtEfEAtfujyVf0xgDxIHy3dGER0wnr
	 +juElQl3Sas9A==
Date: Tue, 10 Mar 2026 19:07:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <mevtdhght66tds7yhmr5a6xg5a75fb667b6lyvguoxqexmc74p@mroqidhzptxk>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
 <aHokdhpJUhSZ5FSp@ryzen>
 <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>
 <aJ743hJw-T9y3waX@ryzen>
 <lakgphb7ym3cybwmpdqyipzi4tlkwbfijzhd4r6hvhho3pc7iu@6ludgw6wqkjh>
 <aLmcO8ukT-CDZMuT@ryzen>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLmcO8ukT-CDZMuT@ryzen>

Hi Niklas,

Sorry for replying very late. I lost access to my EP setup, and just got it
back.

On Thu, Sep 04, 2025 at 04:03:39PM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Fri, Aug 29, 2025 at 09:44:08PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Aug 15, 2025 at 11:07:42AM GMT, Niklas Cassel wrote:
> 
> (snip)
> 
> > > > > > ## On EP side:
> > > > > > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> > > > > >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > > > > > 
> > > > > > Basically all tests timeout
> > > > > > # FAILED: 1 / 16 tests passed.
> > > > > > 
> > > > > > Which is the same as before this patch series.
> > > > 
> > > > This is kind of expected since the pci_endpoint_test driver doesn't have the AER
> > > > err_handlers defined.
> > > 
> > > I see.
> > > Would be nice if we could add them then, so that we can verify that this
> > > series is working as intended.
> 
> (snip)
> 
> > Ok, thanks for the logs. I guess what is happening here is that we are not
> > saving/restoring the config space of the devices under the Root Port if linkdown
> > is happens. TBH, we cannot do that from the PCI core since once linkdown
> > happens, we cannot access any devices underneath the Root Port. But if
> > err_handlers are available for drivers for all devices, they could do something
> > smart like below:
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index c4e5e2c977be..9aabf1fe902e 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -989,6 +989,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> >  
> >         pci_set_drvdata(pdev, test);
> >  
> > +       pci_save_state(pdev);
> > +
> >         id = ida_alloc(&pci_endpoint_test_ida, GFP_KERNEL);
> >         if (id < 0) {
> >                 ret = id;
> > @@ -1140,12 +1142,31 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
> >  };
> >  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> >  
> > +static pci_ers_result_t pci_endpoint_test_error_detected(struct pci_dev *pdev,
> > +                                              pci_channel_state_t state)
> > +{
> > +       return PCI_ERS_RESULT_NEED_RESET;
> > +}
> > +
> > +static pci_ers_result_t pci_endpoint_test_slot_reset(struct pci_dev *pdev)
> > +{
> > +       pci_restore_state(pdev);
> > +
> > +       return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> > +static const struct pci_error_handlers pci_endpoint_test_err_handler = {
> > +       .error_detected = pci_endpoint_test_error_detected,
> > +       .slot_reset = pci_endpoint_test_slot_reset,
> > +};
> > +
> >  static struct pci_driver pci_endpoint_test_driver = {
> >         .name           = DRV_MODULE_NAME,
> >         .id_table       = pci_endpoint_test_tbl,
> >         .probe          = pci_endpoint_test_probe,
> >         .remove         = pci_endpoint_test_remove,
> >         .sriov_configure = pci_sriov_configure_simple,
> > +       .err_handler    = &pci_endpoint_test_err_handler,
> >  };
> >  module_pci_driver(pci_endpoint_test_driver);
> > 
> > This essentially saves the good known config space during probe and restores it
> > during the slot_reset callback. Ofc, the state would've been overwritten if
> > suspend/resume happens in-between, but the point I'm making is that unless all
> > device drivers restore their known config space, devices cannot be resumed
> > properly post linkdown recovery.
> > 
> > I can add a patch based on the above diff in next revision if that helps. Right
> > now, I do not have access to my endpoint test setup. So can't test anything.
> 
> I tested your patch series + your suggested change above, and after a:
> 
> ## On EP side:
> # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
>   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> 
> Instead of:
> 
> # FAILED: 1 / 16 tests passed.
> 
> I now get:
> # FAILED: 7 / 16 tests passed.
> 
> Test cases 1-7 now passes (the test cases related to BARs),
> all other test cases still fail:
> 
> # /pcitest 
> TAP version 13
> 1..16
> # Starting 16 tests from 9 test cases.
> #  RUN           pci_ep_bar.BAR0.BAR_TEST ...
> #            OK  pci_ep_bar.BAR0.BAR_TEST
> ok 1 pci_ep_bar.BAR0.BAR_TEST
> #  RUN           pci_ep_bar.BAR1.BAR_TEST ...
> #            OK  pci_ep_bar.BAR1.BAR_TEST
> ok 2 pci_ep_bar.BAR1.BAR_TEST
> #  RUN           pci_ep_bar.BAR2.BAR_TEST ...
> #            OK  pci_ep_bar.BAR2.BAR_TEST
> ok 3 pci_ep_bar.BAR2.BAR_TEST
> #  RUN           pci_ep_bar.BAR3.BAR_TEST ...
> #            OK  pci_ep_bar.BAR3.BAR_TEST
> ok 4 pci_ep_bar.BAR3.BAR_TEST
> #  RUN           pci_ep_bar.BAR4.BAR_TEST ...
> #      SKIP      BAR is disabled
> #            OK  pci_ep_bar.BAR4.BAR_TEST
> ok 5 pci_ep_bar.BAR4.BAR_TEST # SKIP BAR is disabled
> #  RUN           pci_ep_bar.BAR5.BAR_TEST ...
> #            OK  pci_ep_bar.BAR5.BAR_TEST
> ok 6 pci_ep_bar.BAR5.BAR_TEST
> #  RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
> #            OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
> ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
> #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
> # pci_endpoint_test.c:106:LEGACY_IRQ_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:106:LEGACY_IRQ_TEST:Test failed for Legacy IRQ
> # LEGACY_IRQ_TEST: Test failed
> #          FAIL  pci_ep_basic.LEGACY_IRQ_TEST
> not ok 8 pci_ep_basic.LEGACY_IRQ_TEST
> #  RUN           pci_ep_basic.MSI_TEST ...
> # pci_endpoint_test.c:118:MSI_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:118:MSI_TEST:Test failed for MSI1
> # pci_endpoint_test.c:118:MSI_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:118:MSI_TEST:Test failed for MSI2
> # pci_endpoint_test.c:118:MSI_TEST:Expected 0 (0) == ret (-110)
> # pci_endpoint_test.c:118:MSI_TEST:Test failed for MSI3
> ...
> 
> 
> I think I know the reason.. you save the state before the IRQs have been allocated.
> 
> Perhaps we need to save the state after enabling IRQs?
> 
> I tried this patch on top of your patch:
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -851,6 +851,8 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>                 return ret;
>         }
>  
> +       pci_save_state(pdev);
> +
>         return 0;
>  }
> 
> 
> But still:
> # FAILED: 7 / 16 tests passed.
> 
> So... apparently that did not help...
> 
> I tried with the following change as well (on top of my patch above):
> 
> +static pci_ers_result_t pci_endpoint_test_slot_reset(struct pci_dev *pdev)
> +{
> +       struct pci_endpoint_test *test = pci_get_drvdata(pdev);
> +       int irq_type = test->irq_type;
> +
> +       pci_restore_state(pdev);
> +
> +       if (irq_type != PCITEST_IRQ_TYPE_UNDEFINED) {
> +               pci_endpoint_test_clear_irq(test);
> +               pci_endpoint_test_set_irq(test, irq_type);
> +       }
> +
> +       return PCI_ERS_RESULT_RECOVERED;
> +}
> 
> But still only:
> # FAILED: 7 / 16 tests passed.
> 
> Do you have any suggestions?
> 

I guess what is going wrong here is that you might be rebooting the device
*after* restoring the config space in 'slot_reset()' callback. So all the
previous config space contents would be lost and the device would've started
afresh.

I don't think we can restore the config space after rebooting the EP device,
because host has no idea about it. It can only restore the content after
recovering the device through platform specific means.

So I think you should just remove the PCI device from sysfs before rebooting and
rescan the bus. If your Root Port supports Data Link Layer interrupts such as
Link up/down, then you might get Hotplug MSIs which will take care of removing
the device and rescanning the bus again once it has rebooted.

The core idea behind this series is that to make the PCI bus useable on the host
after LDn and without rebooting. So if the device can recover with the help of
recovery steps carried out by the host, it should be in a useable state again.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

