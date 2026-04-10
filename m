Return-Path: <linuxppc-dev+bounces-19565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B3CF44840
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:33:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZRn1cqRz2yZ6;
	Fri, 10 Apr 2026 21:33:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775820789;
	cv=none; b=YUflip3o3GdQEFGYoMQ+h8IBV8m/wToiJ5KoA0BuixemYArJvqfTxhvIlQOI6eicD6JfMsZsMEtN4hOrXN3MH1hRLkfdzoFXb+4YBoaHcNlntGCqJ4QB21wvYx+vXmkBU1CuGc1y4bFyzQxvrNXRNoYIeNOi07iI7nW7N/3lFTe78o1YAyEgp1dJCs+1st27JK5tZV6ga7EKQuQ9+EHwXRQVF4Sp+95tFpyT3TcC+uXP+0y0F3y8B7U34NcaUPq/2oxoD3RZOncpCmOU3fa1AVGDFF+pmBz0C7ZIJMJSNsuzMEI2gGws0X51hlD8TpbJL9+oICBxgBqhQ2qZJO5/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775820789; c=relaxed/relaxed;
	bh=GakzNTu39/DWytNBEla5OJij5ZIlE3iai0JY5JCF15w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SeXK+9g4nXz17YIpRPu7U+nsqpuZFoGh7L+bTuHW+Rz+YC3srMbAis4wMzIzCazUnZN/VOEOSTgX8VQzd172i9YzOVo6rZ8SavXhK8uCzu00IAvyEYrmLVQf2h7YqnLzTtyAuUEkJWtbCbzrb7uqMeYe8omTeUvwV0EfTkhonX+zdCWxkPE4nf418Ax6x10v80dHOnCf7EcfzX1BJFQCa1F58O/eBmtPdOxkDSqREsYs35KXzqmhAzXXFBCL8mUM3TZpYvEGtiQMw2jqMDMDPIhE1OkyVeVKq6dzv57kHRptEz/Ahx2Vu4BWPtj6yq97WiHYA0UozLzcciN+Vdvd9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TTWLZtYl; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TTWLZtYl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZRj3X3yz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:33:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775820786; x=1807356786;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=e4U7N25hchQ0OTw8zCGZ+OMwYFRYHOMJzZ6QqDxdozE=;
  b=TTWLZtYlDrXK3RgNlRe7GqMO5rneilU5q72YvKVhg1rfW2Eu50Eqv5gP
   xpbUWHOaneffpSOWlDXTVd+w5iYYHauzFof2sCJ7yuBD8iCZZGXB1/5W/
   IIPGgTKvyo8MC/jMqBUBWyh9pouGRQ3fcrDbWs3GM+xlI2W3FtQKkq0bz
   MehVub61H+3OPx4ewCErkpggi3jm9fpn+RryNVtRV5P4cOUMc8qc8Vyk5
   vXLj5+ziFlU/POCZH1lkIWvFyxS++XOKKXSqB6OD37/52yLA70Z2OWaYb
   vt5vP/nkcqzPQqgkbxoc8MKHVwJ8dfIOFYFTmneTEK00GuGJE0fQ8wbNn
   g==;
X-CSE-ConnectionGUID: AkIp1vjtTK6fB+FQHwKToA==
X-CSE-MsgGUID: xp2HzqvBTqapKcYTEMRebQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="99472917"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="99472917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:33:00 -0700
X-CSE-ConnectionGUID: pq0LdvgKRNOveewCKjRzXA==
X-CSE-MsgGUID: NCur4HzvQIiHzQCbo1QxPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228225436"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:32:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:32:43 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Christophe Leroy <chleroy@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Dexuan Cui <decui@microsoft.com>, 
    =?ISO-8859-2?Q?Krzysztof_Ha=B3asa?= <khalasa@piap.pl>, 
    Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Shuan He <heshuan@bytedance.com>, 
    Srivatsa Bhat <srivatsabhat@microsoft.com>, linux-pci@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
In-Reply-To: <20260410112132.GA1756033@rocinante>
Message-ID: <f6c036e1-9145-e784-8a37-2486fc72978e@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-14-kwilczynski@kernel.org> <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com> <20260410112132.GA1756033@rocinante>
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
Content-Type: multipart/mixed; BOUNDARY="8323328-135863821-1775820198=:1195"
Content-ID: <35660afc-f9b7-2ff0-7765-d108aab98c34@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-135863821-1775820198=:1195
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f0b0baec-2251-7aef-bc88-33c6227c1d57@linux.intel.com>

On Fri, 10 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Hello,
>=20
> > > Currently, __pci_mmap_fits() computes the BAR size using
> > > pci_resource_len() - 1, which wraps to a large value when the
> > > BAR length is zero, causing the bounds check to incorrectly
> > > succeed.
> > >=20
> > > Thus, add an early return for empty resources.
> > >=20
> > > Also, remove the WARN() that fires when userspace attempts to
> > > mmap beyond the BAR bounds.  The check still returns 0 to reject
> > > the mapping, but the warning is excessive for normal operation.
> > >=20
> > > A similar warning was removed from the PCI core in the commit
> > > 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files=
").
> >=20
> > This looks like entirely separate two changes to me which just happen=
=20
> > within the same context.
>=20
> True.  I could split this into two separate patches.  However, the early
> return is so trivial, that I decided to keep it here, in lieu of that the
> linked patch did, too.
>=20
> Thoughts?

It's not just adding the early return that would go to the first patch but=
=20
you also need to rearrange the len for that. Effectively, the change is=20
split in half, each becoming cleaner and more focused (both diff and the=20
changelog text).

As is I'm left on the borderline, while I can see it's "correct" after=20
splitting those changes inside my head, I also know it could have been=20
done better. I'd easily given rev-by for both if they'd have been done=20
individually, saved the time writing these emails about it, and=20
effectively "forgotten" the patches (including upcoming versions of the=20
series).

--=20
 i.
--8323328-135863821-1775820198=:1195--

