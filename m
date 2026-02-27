Return-Path: <linuxppc-dev+bounces-17385-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB9FD7F90
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 10:47:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMlQh3nH9z3bmR;
	Fri, 27 Feb 2026 21:47:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.95.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772189260;
	cv=none; b=cEu6aIagCSVg34hlcU61e4mExwfAL+SIsgHombEImR5/ZS2AYzYFdmi0T5MDe1b3TSYsb5yEEri9rGc81URkLgM/z7cWApLnGmD+OSimmeRFfEmHW0YVfPXX3zq9DKHwek4EBvvtiaf0vNrpasH2gJs0X7d65CPAcuvcf0pj/eifOHE2TSIScf6Tg/JLtMwroLNh/gn5FJGU/AAYG4vWAsUDt4/hRAE3ebqps+JM4e39zSIzsJqbV56AskT9/+Xqy0nRbTt1pRMYKb0sjCRGGT82iYZl+7XoEygCJUYsXVZoPBBj7WKBlAz/Sk1b8fiDP/L+Al8i7fmKGwujZo8Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772189260; c=relaxed/relaxed;
	bh=uzRgfIWoT6V19WGBBA361FyQ3WKPXmlU9iBpyYHezLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Nukn9tVFTvSK6LC1q8MseR6n0gejL6FEJ2g7cBh2Fh8ri0KshcKUwIoDGU/9Zivr7Y60gpd9XPYvAsUWXiW/bxYwj9Oiiru/n1WewapXcvrlFnIpkBtE5pjbZcoqvBtx6y902i1dh1y5J3FgNCnzaKQrBF6Cq+BBEo1ZygzzojrhvgYwHSAhiHJH4i0hWQy/eKL4CjDikyYKR7ibbRzZsKfxI6jsODSopPLRNztMYQ8QDS+xka3MLXMlVMj4fjILcG5Cx7TEyLOmnPY6TjA0wBKPFhj4v7uoiPZv6sYBNFSXlOZE8oYFkj+NojDl+uujLkF4bb0gC93t60Ow1rbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.95.100; helo=bmailout1.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout1.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout1.hostsharing.net (client-ip=83.223.95.100; helo=bmailout1.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMlQg1ChCz3blr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 21:47:39 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8AF3F2020218;
	Fri, 27 Feb 2026 11:47:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 86E064F39A; Fri, 27 Feb 2026 11:47:24 +0100 (CET)
Date: Fri, 27 Feb 2026 11:47:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
Message-ID: <aaF2PAOZsHr4PuC_@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <aYCujqZIvxElSsOE@wunner.de>
 <aYESh4bCE2lzTg2S@wunner.de>
 <924dce22-171e-4508-907c-74f57f1bdea8@linux.alibaba.com>
 <234dcf9e-05ff-485c-a330-019a4fbb5f3b@linux.alibaba.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234dcf9e-05ff-485c-a330-019a4fbb5f3b@linux.alibaba.com>

On Fri, Feb 27, 2026 at 04:28:59PM +0800, Shuai Xue wrote:
> On 2/7/26 3:48 PM, Shuai Xue wrote:
> > Regarding pci_restore_state() in slot_reset(): I see now that it does
> > call pci_aer_clear_status(dev) (at line 1844 in pci.c), which will
> > clear the AER Status registers. So if we walk the hierarchy after
> > the slot_reset callbacks, the error bits accumulated during DPC will
> > already be cleared.
> > 
> > To avoid losing those errors, I think the walk should happen after
> > dpc_reset_link() succeeds but *before* pcie_do_recovery() invokes the
> > slot_reset callbacks. That way, we can capture the AER Status bits
> > before pci_restore_state() clears them.
> > 
> > Does that sound like the right approach, or would you prefer a
> > different placement?

The problem is that if the hierarchy that was reset is deeper than
one level, you first need to call pci_restore_state() on all the
PCIe Upstream and Downstream Ports that were reset before you can
access the Endpoints at the bottom of the hierarchy.

E.g. if DPC occurs at a Root Port with multiple nested PCIe switches
below, the Endpoints at the "leafs" of that tree are only accessible
once Config Space has been restored at all the PCIe switches
in-between the Endpoints and the DPC-capable Root Port.

Hence your proposal unfortunately won't work.

I think the solution is to move pci_aer_clear_status() out of
pci_restore_state() into the callers that actually need it.
But that requires going through every single caller.
I've begun doing that last week and am about 60% done.

Once pci_restore_state() no longer clears the error bits, we can
report and clear them after the "report_slot_reset" stage (which
is where drivers call pci_restore_state()).

I've also changed my mind and I think reporting and clearing
the error bits *could* happen in pcie_do_recovery() even if it
were used for EEH and s390 because those platforms may plug in
AER-capable devices as well and so we do need to clear the bits
regardless of the error recovery mechanism used.

Let me get back to you once I've gone through all the callers of
pci_restore_state().  Please be patient.

Thank you!

Lukas

