Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A3C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42BD601FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42BD601FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQLYB1hZLz3cZy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 23:11:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQLVL0TMPz30Cy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 23:09:13 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FQLVJ4Fwhz9vFT; Wed, 21 Apr 2021 23:09:12 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210416210216.380291-1-danielhb413@gmail.com>
References: <20210416210216.380291-1-danielhb413@gmail.com>
Subject: Re: [PATCH 0/2] pseries: UNISOLATE DRCs to signal device removal error
Message-Id: <161901049952.1961279.13963329908976762036.b4-ty@ellerman.id.au>
Date: Wed, 21 Apr 2021 23:08:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 16 Apr 2021 18:02:14 -0300, Daniel Henrique Barboza wrote:
> At this moment, PAPR [1] does not have a way to report errors during a device
> removal operation. This puts a strain in the hypervisor, which needs extra
> mechanisms to try to fallback and recover from an error that might have
> happened during the removal. The QEMU community has dealt with it during these
> years by either trying to preempt the error before sending the HP event or, in
> case of a guest side failure, reboot the guest to complete the removal process.
> 
> [...]

Applied to powerpc/next.

[1/2] dlpar.c: introduce dlpar_unisolate_drc()
      https://git.kernel.org/powerpc/c/0e3b3ff83ce24a7a01e467ca42e3e33e87195c0d
[2/2] hotplug-cpu.c: set UNISOLATE on dlpar_cpu_remove() failure
      https://git.kernel.org/powerpc/c/29c9a2699e71a7866a98ebdf6ea38135d31b4e1f

cheers
