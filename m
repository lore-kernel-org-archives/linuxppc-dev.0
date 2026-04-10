Return-Path: <linuxppc-dev+bounces-19554-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4483E99071
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 10:19:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsXpP2W4Gz2yZ6;
	Fri, 10 Apr 2026 20:19:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775816349;
	cv=none; b=XDZH4nQsuQK850F7fmwn7UVAvie3iGypsuX7R5DrI2aVsWpzzyWSxvPCn5h7M1AdNrZ8t9COoc8FYEqRYUZh04x9nq6AWD4Qt2Xk2Roo6FKlGqHEuprcfRarsJv0N2SdEugpCLZUtzxiAztBnscodshHhzkxV8zX81WP8WSPNxwTHP9Bvg5eb4AWhVPK8e6ee2aH/xVDYInQtel6wD3Y6muFsZ02l0RJIE3A6zjCa6eUtf4xGrcT9i/8v8XkD+WXK6MdQVfjbra1gDEGdI8Kakxgm1EHRac62Kp66rW+7gfOZDd3J2jl4N9LOLGl43ObnORDx1adL7mbjTBMaon59w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775816349; c=relaxed/relaxed;
	bh=vFaGX6ZmLYUchXB0jpeW6gCU36JGliVsHKfEF0C6DMA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S82CKuG1V+g88EchNF0zQbmcSa9tDc86LDqBCmf902CrmrqVksb4oF7xFfUezIaHaG4JEkPrfjtDpxPKOJ0bfrjveAfPpG4fVnkJLstlLqZNBr9b1bq4PVnYGY3UqG8LmeMqBu4FMSbw+QzIujcPL8qv28mMTPpyMVpVco7r2SqeTTuoglmjDTSQH6wqY05TGh5RJHPMSNV0OtOp056Ey7VYsjU9zdIKFB0cqZ7RMyGvhBgp6GRNtxvaeRxGXojViBUiThYYQY578nSX2Uwz0S+WuDkTPMAP6AiDG20LiXs7or2FtSjKCwtI2UWbp06foHlR2Fjw5c23LocbAI348g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBzXEcEQ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBzXEcEQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsXpK6lHqz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 20:19:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775816346; x=1807352346;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sJjahAyArFT38iar0FyVHZtbbpGo+U5iy6pPkK42kPc=;
  b=cBzXEcEQauJfUXxHDLnRmLrvo8o/2K6tefF/ukZAx1a1WPId+MLh458s
   6FQuVdn16LsMtoqqvogDub2fQCl0RnmmR7jVr9mr+la4uLHmLYpVxOb2l
   ypwh01KwaK6lUy00TuQVRm+OrepecvcJaIQDPKJwBapVOuKRMOMdETfrb
   wMQozkU+PrxJ0sAIwjGGBZgstVOb+i8ch5NzL96yYRAAnqmyQncDYPGQP
   LWdoZvfjJ61TdUDvPkIxcshYuLOAGzRdRzu8TWk43ipePTWH0FBOCkQMZ
   3kuUa6ngjgicT4TVawfN9TcOCPuik1cuXqxRKn3GCvvAgiRkE7c7CqV+A
   A==;
X-CSE-ConnectionGUID: e+wK17T/TQWKSkWjGWtA1w==
X-CSE-MsgGUID: i/cMDOXpRv2hXu8FgRzPng==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80723107"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="80723107"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 03:18:59 -0700
X-CSE-ConnectionGUID: 0SVrldBuSXepU1rqThYmYw==
X-CSE-MsgGUID: ei3zn7N0QJCCee3wDOarkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="222559193"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 03:18:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 13:18:43 +0300 (EEST)
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
Subject: Re: [PATCH 04/20] PCI/sysfs: Add CAP_SYS_ADMIN check to
 __resource_resize_store()
In-Reply-To: <20260410055040.39233-5-kwilczynski@kernel.org>
Message-ID: <37f2e32a-804d-7c59-d3d0-7148ef2cd95a@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-5-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-297789617-1775816323=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-297789617-1775816323=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, the __resource_resize_store() allows writing to the
> resourceN_resize sysfs attribute to change a BAR's size without
> checking for capabilities, currently relying only on the file
> access check.
>=20
> Resizing a BAR modifies PCI device configuration and can disrupt
> active drivers.  After the upcoming conversion to static attributes,
> it will also trigger resource file updates via sysfs_update_groups().
>=20
> Thus, add a CAP_SYS_ADMIN check to prevent unprivileged users from
> performing BAR resize operations.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ac4e7c516e78..6b8c8e62f68a 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1619,6 +1619,9 @@ static ssize_t __resource_resize_store(struct devic=
e *dev, int n,
>  =09int ret;
>  =09u16 cmd;
> =20
> +=09if (!capable(CAP_SYS_ADMIN))
> +=09=09return -EPERM;
> +
>  =09if (kstrtoul(buf, 0, &size) < 0)
>  =09=09return -EINVAL;
> =20
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-297789617-1775816323=:1195--

