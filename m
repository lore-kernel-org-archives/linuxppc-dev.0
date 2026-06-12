Return-Path: <linuxppc-dev+bounces-22552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2C0CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 11:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcHrs2CB3z2ykX;
	Fri, 12 Jun 2026 21:50:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781265037;
	cv=none; b=LY7VFhKP32774u2M+3p6MoVGBTFtkS+JefOPLdsp1GoP8xAjtJkdgWCarwKVcJAUUPPKYZMycwe+DjePb2mBu3t84SnMhj2UUNRh9ZDqxKVH3l7UjTgg92h902QhU0wvbW5/KrhC0jl8GDHOIN92oIQSdGn18SJSoOH6i19WgFvMAYm6ipqfTEbkfQNiDgdLGtYyApywOu2yxt4IIKkmBraAQFlbR0ek7ty3B7RsRmr7hHDqDxthE3rwnRJePucCVjFX/VUABk6mtyuR/m7qXTEG4cO1fB8QFzyuNVyu6r7qUyNNLuZ+eWYjekXTeqXW25c1NSFgGKCeEH1EUsEu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781265037; c=relaxed/relaxed;
	bh=5rEICosf2HVUzSwyySyvGPDBPt1a38j13M9yF66Iz3o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BQQ/6bpB+C0LO8efGnKzjY4UM+L10uPD1T9u8yqIcGwCrLltWwpqY5KwJ9KV/GFRHIlgJFBWjB09AJ1u1YlKeHACD8hyFf1GHb4Tpk/Ni+LaxpD9lCxRzNPbe7V98ti5G7D0K+vEwZXfL+4pNJVsDz+nN1KWePGpfVNef1Vnqd8MAX9b/070pk4ELk5ZxqfCqptxuO3o1UVU4vIsRIvCJgEaOYYUzNNGP6yYKeFI5ePOqyO04PPFKN8bYzSt574B+QmMExJzOZgW0cEY8BEZvFCcr8ZqGEyo4GP0wVNwn7j5uyPFwVPIJ5MzTk1wIFryaH0h7OYBQc0L7pKbXxwDGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mr2ccnwJ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mr2ccnwJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcHrn2T2tz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 21:50:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781265034; x=1812801034;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J6GLAr2FW67tGJ9wFG3aEziqOWOjQ80L6GvpcFfNQns=;
  b=Mr2ccnwJ9cDiQFI95rIDEp0snu5g6U2CRUYGhdAbsSK+0b7a7Zs5Oh2F
   i7ft27dV04AJFXFPnDYuMzp4CqtL9ZGztE2XS98wKKpNDZBngzvrbVkeU
   sXBYAWFOTf/Tgsi2+tAHwn3jdUQoZybn3H213b0N4uSxlmVyKw74XiMqk
   zsP/OGH6dc9iwS/7AflNE6Hwq2yfEjuQD/ho8rT+r35Det79t67Fyhna6
   3ypwdNvk4/ezyFPK3skRP1xdQOZfUBzvVtWK5qUsfeU2MtKKAVhBQk7Xy
   FAd1Xe2k5t+PmiXvB18XubON0viGS3mX76h9yPdODvn9o4xLKpGwu2SEi
   g==;
X-CSE-ConnectionGUID: bUhA9HaiTZiu1AvpHqt9Qw==
X-CSE-MsgGUID: Na+spDCZQP6CyAznWaLBWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84661982"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="84661982"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:50:25 -0700
X-CSE-ConnectionGUID: 9qzTIavXSZmlXNMa03/diA==
X-CSE-MsgGUID: njm1IhwSS0GiY/IEb9WuOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="242420679"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 04:50:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jun 2026 14:50:17 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Shawn Jin <shawn.jin@asteralabs.com>, 
    linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] PCI: Lower bound bridge window alignment
In-Reply-To: <20260429122617.7324-11-ilpo.jarvinen@linux.intel.com>
Message-ID: <4a35f669-b13b-c07a-fbd6-a8ea1ce9a38b@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com> <20260429122617.7324-11-ilpo.jarvinen@linux.intel.com>
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
Content-Type: multipart/mixed; boundary="8323328-143881065-1781265017=:1266"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-143881065-1781265017=:1266
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Apr 2026, Ilpo J=C3=A4rvinen wrote:

> pci_resource_alignment() does not consider bridge windows special,
> yet their alignment is subject to different requirements from BAR
> alignment.
>=20
> Add lower bound to bridge window alignment to help callers out to
> always have large enough alignment.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Hi Bjorn,

Could you please pull this change and the subsequent one, the commits in=20
pci/resource:

ae09d28ecbbc ("PCI: Lower bound bridge window alignment")
cf996b886675 ("PCI: Return valid alignment for assigned resources")

The rest of the changes in this series seem okay and can proceed if you're=
=20
okay with keeping a partial series.

The reason for this request is the dev->bus vs dev->subordinate issue=20
sashiko mentioned in its review.

I've tried to come up with a solution to that but it has become so ugly
I have not been very happy with it. Maybe there's no other way but the=20
problem boils down with pci_min_window_alignment() having to be capable of=
=20
dealing two cases, each lacking one of the key pointers (bus or bridge=20
dev):

1) root bus without bus->self
2) bridge without a subordinate bus struct (if subordinate bus' alloc=20
   failed)

Only way to solve that I could think of is passing both the bus and the=20
bridge device to pci_min_window_alignment() and the related arch side=20
function pcibios_window_alignment(). The ugliest parts then involve=20
getting a bus pointer compatible with both of those cases, like this:

=09struct pci_controller *phb =3D pci_bus_to_host(bus ? bus : bridge->bus);

But it's too late in the cycle now to try even that, IMO, so better to=20
wait to the next cycle.

--=20
 i.

--8323328-143881065-1781265017=:1266--

