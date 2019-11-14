Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F79C432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 13:59:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C03206DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 13:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzUgS6QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C03206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DNQV10ymzF7hs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 00:59:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RzUgS6QA"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DNHz1GYwzF6hc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2019 00:54:06 +1100 (AEDT)
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C0652075E;
 Thu, 14 Nov 2019 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573739643;
 bh=chRsb111oIkb8Tzn2xgWqviCPKmTcyrTGOQXYvjbrPM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=RzUgS6QAWtYQM41uHu/0NEkORyOPiv325Qhmm7647HI3Gp1vfvxwBbT/ANNLl87/e
 u20KA1F4oSl3xM2vUxLtICSGhHdsM4iAM1WjWJbxbCwJHVXx1btx/0hLRQlcSCSKGT
 li4+815TmqcxzSwQPemQnofeF2RPOZqXeYjoe+AQ=
Date: Thu, 14 Nov 2019 07:54:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Disable native PCIe port management
Message-ID: <20191114135402.GA200503@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CHzBJjxOd0f-CZcGPDW6S5GXMvw+6VmzBADJWeP2y1WAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-pci@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 15, 2019 at 12:34:50AM +1100, Oliver O'Halloran wrote:
> On Thu, Nov 14, 2019 at 1:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > This is fine, but it feels like sort of a blunt instrument.  Is there
> > any practical way to clear pci_host_bridge.native_pcie_hotplug (and
> > native_aer if appropriate) for the PHBs in question? That would also
> > prevent pciehp from binding.
> 
> It is a large hammer, but I don't see a better way to handle it for
> the moment. I had another look and my initial assessment was wrong in
> that it's the portbus driver which claims the MSI rather than pciehp
> itself. The MSI in the PCIe capability is shared between hotplug
> events, PMEs, and BW notifications so to make the portbus concept work
> the portbus driver needs to own the interrupt. Basicly, pnv_php and
> portbus are fundamentally at odds with each other and can't be used
> concurrently.

Yeah, that makes sense.  Is there a Kconfig symbol for pnv_php?  If
so, you could make CONFIG_PCIEPORTBUS unselectable in the first place.

But I'm guessing there isn't such a symbol because you probably want
to be able to build generic kernels that run on machines that *can*
use portdrv as well as on PowerNV.

So I'm find with the patch as posted.

Bjorn
