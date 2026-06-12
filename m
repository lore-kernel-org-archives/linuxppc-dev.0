Return-Path: <linuxppc-dev+bounces-22557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBBCCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:12:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcM0x1C2vz2ykX;
	Sat, 13 Jun 2026 00:12:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781273569;
	cv=none; b=Igh6w5d+hTD+iD6y6qseY6da9yu4DRhaipCASlSEjiQcVFLQ+2AzmX3Cg9kuQuJAFeTleMIekU5dQy+QPiuHvHFjSkgeOrlp5HfCd9GvY8cqkqlJoRYj1+N9sOHm8BWKGL28IthFzcCrotrfRW8/ER9oRAw5hVcNh/+Thnb9Jtvm8CJCEs+KhK61Qlnb5EKGkPqkmyXVw9c6kZcm/hPyhDQHdN+3QxT1ihAzLD+mxzkztkTZFhjy5Z1W3cNodqrh07ixhgWxWbdOq/sVN2IcLXfZ7h09Lpqk3EPtXfmMcSApaMmrirhwolQdRVX2BpXxsicG9cxHinO3XOWMYtgaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781273569; c=relaxed/relaxed;
	bh=gkRlOqWLDOL9V+xajZiBlg7nENjsjV7EqIVO2RaSGlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VyXvnqaTDh85dCJ4QV7lDK2kaCRNu1m1Mt/0NCYDA7tkmmX0Ilyarm7INn+CN8vCtBJ8blfqEfG6Z7POZf4dRs+OWj3CKGUyJPgbDd8ds8aUQ3UoWY2JrPBFByLSUh07dd51uGfyRPr7l5hRWKR4IPhUwPub/COG3vjFNdge20wG2gVKtnpqyJDCqLgwc6Drl+ftgWwo3k75L1mRtEm5Q6T0GcDrHvTmJRUu8Z3zJC5Lihxby8hOZL1st922U2+o3n9ThHPNvP3QtFkBkHw6G9iv6YHwf3He9lSmPSdz27whZH8AeMI+D6qghTzwIma0c7C8OH5lAjNpXXZOeo0t7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnVXc1H/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnVXc1H/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcM0w1lSqz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 00:12:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0A9C160008;
	Fri, 12 Jun 2026 14:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815BA1F000E9;
	Fri, 12 Jun 2026 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781273564;
	bh=gkRlOqWLDOL9V+xajZiBlg7nENjsjV7EqIVO2RaSGlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QnVXc1H/a8sNOm8x1VwpAxSFKDIfDkRD5dUSM49LtKBcWLfxkmHekfPrhUyNNTf8L
	 5ezf0IHHCUrGBfbuV9tUuDwmblmbqRve/V9MZisaCk8PZuWjaVo6RGNPM8W0xWVO3u
	 9tTKsI1lrCVlMmJPBYwFP4w2LEffEFx6+phQ+4HGZp0JuutB/h3Q6gh1FtfRGJrEBb
	 r7BqkkcPquea/RjbpysjQYMzWT6yPECsQY7LzvMTpq0jMmJjZGQvYxrKW9X9KdtyN6
	 Kn9YCW9Y+aU9n6hAXD8v5+Kb+I4q+kY9Ab+8BXDE8rd/OaD2/5O1GaF+JKNf6h0LFd
	 qZuUBhHAj7eTQ==
Date: Fri, 12 Jun 2026 09:12:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Shawn Jin <shawn.jin@asteralabs.com>, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] PCI: Lower bound bridge window alignment
Message-ID: <20260612141243.GA596363@bhelgaas>
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
In-Reply-To: <4a35f669-b13b-c07a-fbd6-a8ea1ce9a38b@linux.intel.com>

On Fri, Jun 12, 2026 at 02:50:17PM +0300, Ilpo Järvinen wrote:
> On Wed, 29 Apr 2026, Ilpo Järvinen wrote:
> 
> > pci_resource_alignment() does not consider bridge windows special,
> > yet their alignment is subject to different requirements from BAR
> > alignment.
> > 
> > Add lower bound to bridge window alignment to help callers out to
> > always have large enough alignment.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Hi Bjorn,
> 
> Could you please pull this change and the subsequent one, the commits in 
> pci/resource:
> 
> ae09d28ecbbc ("PCI: Lower bound bridge window alignment")
> cf996b886675 ("PCI: Return valid alignment for assigned resources")

Sure, I dropped these two patches from pci/resource.  The rest are
still heading to v7.2.  Thanks!

> The rest of the changes in this series seem okay and can proceed if you're 
> okay with keeping a partial series.
> 
> The reason for this request is the dev->bus vs dev->subordinate issue 
> sashiko mentioned in its review.
> 
> I've tried to come up with a solution to that but it has become so ugly
> I have not been very happy with it. Maybe there's no other way but the 
> problem boils down with pci_min_window_alignment() having to be capable of 
> dealing two cases, each lacking one of the key pointers (bus or bridge 
> dev):
> 
> 1) root bus without bus->self
> 2) bridge without a subordinate bus struct (if subordinate bus' alloc 
>    failed)
> 
> Only way to solve that I could think of is passing both the bus and the 
> bridge device to pci_min_window_alignment() and the related arch side 
> function pcibios_window_alignment(). The ugliest parts then involve 
> getting a bus pointer compatible with both of those cases, like this:
> 
> 	struct pci_controller *phb = pci_bus_to_host(bus ? bus : bridge->bus);
> 
> But it's too late in the cycle now to try even that, IMO, so better to 
> wait to the next cycle.
> 
> -- 
>  i.


