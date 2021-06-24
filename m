Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E74C49EA6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:05:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8F9613EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8F9613EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9hkG0W35z3cFm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 00:05:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9hhD2pKgz309S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 00:04:12 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G9hhC1n5tz9sX2; Fri, 25 Jun 2021 00:04:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G9hhB6mfqz9sXk; Fri, 25 Jun 2021 00:04:10 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
In-Reply-To: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
References: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
Subject: Re: [PATCH v2 0/9] powerpc: Add support for Microwatt soft-core
Message-Id: <162454340108.2931445.3945456927378699814.b4-ty@ellerman.id.au>
Date: Fri, 25 Jun 2021 00:03:21 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 18 Jun 2021 13:42:53 +1000, Paul Mackerras wrote:
> This series of patches adds support for the Microwatt soft-core.
> Microwatt is an open-source 64-bit Power ISA processor written in VHDL
> which targets medium-sized FPGAs such as the Xilinx Artix-7 or the
> Lattice ECP5.  Microwatt currently implements the scalar fixed plus
> floating-point subset of Power ISA v3.0B plus the radix MMU, but not
> logical partitioning (i.e. it does not have hypervisor mode or nested
> radix translation).
> 
> [...]

Applied to powerpc/next.

[1/9] powerpc: Add Microwatt platform
      https://git.kernel.org/powerpc/c/53d143fe08c24c2ce44ee329e41c2a6aad57ebb5
[2/9] powerpc: Add Microwatt device tree
      https://git.kernel.org/powerpc/c/151b88e8482167f6eb3117d82e4905efb5e72662
[3/9] powerpc/microwatt: Populate platform bus from device-tree
      https://git.kernel.org/powerpc/c/0d0f9e5f2fa7aacf22892078a1065fa5d0ce941b
[4/9] powerpc/xics: Add a native ICS backend for microwatt
      https://git.kernel.org/powerpc/c/aa9c5adf2f61da39c92280d9336e091852e292ff
[5/9] powerpc/microwatt: Use standard 16550 UART for console
      https://git.kernel.org/powerpc/c/48b545b8018db61ab4978d29c73c16b9fbfad12c
[6/9] powerpc/microwatt: Add support for hardware random number generator
      https://git.kernel.org/powerpc/c/c25769fddaec13509b6cdc7ad17458f239c4cee7
[7/9] powerpc/microwatt: Add microwatt_defconfig
      https://git.kernel.org/powerpc/c/4a1511eb342bd80c6ea0e8a7ce0bbe68aac96ac5
[8/9] powerpc/boot: Fixup device-tree on little endian
      https://git.kernel.org/powerpc/c/c93f80849bdd9b45d834053ae1336e28f0026c84
[9/9] powerpc/boot: Add a boot wrapper for Microwatt
      https://git.kernel.org/powerpc/c/4a21192e2796c3338c4b0083b494a84a61311aaf

cheers
