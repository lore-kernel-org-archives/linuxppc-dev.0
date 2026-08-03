Return-Path: <linuxppc-dev+bounces-25305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A2C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 22:45:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDWwG2PYPz2xyj;
	Tue, 04 Aug 2026 08:45:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785797118;
	cv=none; b=gxThs07DnvmAPynow7dkZkIHtJAwzwwIy4aRFA0YQtn+TFZpdTnqOdrjgBRPx0+wI3USt7g3ayx8E6IALrcdib2vJjVq8AEvj25XdP1kOSfrHqeqWY4Tpzf9akQB/5HTjjuADC0vXRUMTP6l8lT5p4PToCOoW7lFYeki3XPz4PFlIdDIf0Dcwd83WTQKs2dvamWe0SsW9XkJnQUvO6l2oWssnbsYSlSIevr7+eWQb8hZv3uCNEEhXsXX9eSlPy7TWqjLRQHKQpPvcN23K9qfjkZoXuj0FL6h3JIvlmSNtpc6DAfiWxa6MCSwqsJpRj9rpFjyttky2DKw8msmxSyZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785797118; c=relaxed/relaxed;
	bh=qqqqVGc6jaYN3+uA6R5LJyehJP+dHa3JVUe2Bmwx21c=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=by3OHgLXqvkWNUVgxjhpleW7GhrTG+p0LYTjciEHcfqZVNDBu38uFJNQitLgTliEcS/SP8tplHTXL0akziw5B5CY1WIbleQLo25PBVQRdGyNCNcA5nlrn5ykSw0j0TQJ6fmRkQqOJPwk86GLneiRiK9uXyeXmuWE6Keb7Hn3CAstlByEKKqy9vP7Z8LjPeMzHYqiyZwhyHT7bcao+OaYZ5vm1lusAXdp6m98drBBgREU7mEiQZwBjDxNh1GO+Eo/L2IGFELzgtzYAbeQdu1m9nG255xkQbQlPzN9SmrdAs5xDNL/uf83hfCLF9bNcffsO74zoNBC/zy+VMIP7BnD5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=OywI2dE8; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=OywI2dE8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 353 seconds by postgrey-1.37 at boromir; Tue, 04 Aug 2026 08:45:15 AEST
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDWwC2czjz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 08:45:15 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2381D779283D
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 17:39:18 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zcR87vdOzCVl for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2026 17:39:17 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A9EAF779285A
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 17:39:17 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com A9EAF779285A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1785796757; bh=qqqqVGc6jaYN3+uA6R5LJyehJP+dHa3JVUe2Bmwx21c=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=OywI2dE8Zy7wWmvDgLRoYaY8X+vXTXsOleAMm9GuveAYN35MCNlYryuihL94UurW9
	 6YnG5U7RL0f/o1zHK45A99oP5F7bGZv+McQOZMaZFy2YyZVGfS0qnOzCZas0urA8MR
	 ELh8zww7k42iDA6cLujb1EkMN1pgt1ZxOUNQUjCQ=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HX_yrmleJ20e for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2026 17:39:17 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8C90077926B6
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 17:39:17 -0500 (CDT)
Date: Mon, 3 Aug 2026 17:39:14 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
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
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC151 (Linux)/8.5.0_GA_3042)
Thread-Index: 9LxrnSw+cEMdPsRCafYWajf8BqSmeQ==
Thread-Topic: VFIO on POWER9 / QEMU fails to allocate 32-bit DMA

On Linux 6.18, and potentially earlier Linux versions, attempting to pass through any PCI device via VFIO that requires 32-bit DMA results in the following error in the guest VM:

[   11.705413] cx23885 0000:00:02.0: Warning: IOMMU offset too big for device mask
[   11.709245] cx23885 0000:00:02.0: mask: 0xffffffff, table offset: 0x800000000000000

The same devices work correctly on the host kernel.  It appears that somehow 32-bit DMA is not available within a pSeries guest on a PowerNV host.

