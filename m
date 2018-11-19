Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F0C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 17:42:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801E92145D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 17:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801E92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zGPH3jHhzF3Kb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 04:42:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=keith.busch@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zGLg5lQVzF3KB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 04:39:54 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2018 09:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; d="scan'208";a="107575587"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2018 09:39:51 -0800
Date: Mon, 19 Nov 2018 10:36:35 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Message-ID: <20181119173635.GD26595@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
Cc: alex_gagniuc@dellteam.com, helgaas@google.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, Shyam_Iyer@dell.com, rjw@rjwysocki.net,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org, lukas@wunner.de, oohall@gmail.com,
 mr.nuke.me@gmail.com, Tyler Baicar <baicar.tyler@gmail.com>,
 bhelgaas@google.com, austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 19, 2018 at 12:32:42PM -0500, Sinan Kaya wrote:
> On 11/19/2018 11:53 AM, Keith Busch wrote:
> > On Mon, Nov 19, 2018 at 11:53:05AM -0500, Tyler Baicar wrote:
> > > On Thu, Nov 15, 2018 at 8:49 PM Sinan Kaya <okaya@kernel.org> wrote:
> > > > 
> > > > On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> > > > > I've asked around a few people at Dell and they unanimously agree that
> > > > > _OSC is the correct way to determine ownership of AER. In linux, we
> > > > > use the result of _OSC to enable AER services, but we use HEST to
> > > > > determine AER ownership. That's inconsistent. This series drops the
> > > > > use of HEST in favor of _OSC.
> > > > > 
> > > > > [1]https://lkml.org/lkml/2018/11/15/62
> > > > 
> > > > This change breaks the existing systems that rely on the HEST table
> > > > telling the operating system about firmware first presence.
> > > > 
> > > > Besides, HEST table has much more granularity about which PCI component
> > > > needs firmware such as global/device/switch.
> > > > 
> > > > You should probably circulate these ideas for wider consumption in UEFI
> > > > forum as UEFI owns the HEST table definition.
> > > 
> > > I agree with Sinan, this will break existing systems, and the granularity of the
> > > HEST definition is more useful than the single bit in _OSC.
> > 
> > But we're not using HEST as a fine grain control. We disable native AER
> > handling if *any* device has FF set in HEST, and that just forces people
> > to use pcie_ports=native to get around that.
> > 
> 
> I don't see *any* in the code.  aer_hest_parse() does the HEST table parsing.
> It switches to firmware first mode if global flag in HEST is set. Otherwise
> for each BDF in device, hest_match_pci() is used to do a cross-matching against
> HEST table contents.
> 
> Am I missing something?

You might be. :)

static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
{
<snip>
        /*
         * If no specific device is supplied, determine whether
         * FIRMWARE_FIRST is set for *any* PCIe device.
         */
        if (!info->pci_dev) {
                info->firmware_first |= ff;
                return 0;
        }

