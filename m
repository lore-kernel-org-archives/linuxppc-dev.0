Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DAAC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 02:03:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B972208A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 02:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef0W7qnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B972208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x1jn0B5LzF37K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 13:03:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ef0W7qnB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=okaya@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ef0W7qnB"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x1PW1SDwzF3ck
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 12:49:32 +1100 (AEDT)
Received: from [172.30.63.234] (unknown [64.114.255.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A162E2146D;
 Fri, 16 Nov 2018 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542332969;
 bh=KjC34rPqd9W1miLB2rd4VATCNgsDuIF9QN8kpMDlUmI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ef0W7qnBijmcpiPgeXwgB9jLIagUDTg//ztbUp6PFwWt9Owce2k2XbNmM9w68uJ1O
 9ZbcfghvC3Lc78tdtaBLfNSW51jcTsw7TzOUw0m2FP3VpZH8kIvKbmMr2Jd2NYpcDg
 V4pillgbhBhJ+7scFAUFNH8IqckS8ufos8xul1Wg=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, helgaas@google.com
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
Date: Thu, 15 Nov 2018 17:49:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 16 Nov 2018 13:01:29 +1100
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
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 linux-pci@vger.kernel.org, Shyam_Iyer@Dell.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER. In linux, we
> use the result of _OSC to enable AER services, but we use HEST to
> determine AER ownership. That's inconsistent. This series drops the
> use of HEST in favor of _OSC.
> 
> [1]https://lkml.org/lkml/2018/11/15/62

This change breaks the existing systems that rely on the HEST table
telling the operating system about firmware first presence.

Besides, HEST table has much more granularity about which PCI component
needs firmware such as global/device/switch.

You should probably circulate these ideas for wider consumption in UEFI
forum as UEFI owns the HEST table definition.
