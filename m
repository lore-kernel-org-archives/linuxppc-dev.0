Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D78C433FF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 05:03:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DA3206E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 05:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="HL7zp8pO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DA3206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45yPb86L9RzDqQh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 15:03:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yPYG1jKmzDqQT;
 Tue, 30 Jul 2019 15:01:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="HL7zp8pO"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 45yPYF0NxWz9s3Z;
 Tue, 30 Jul 2019 15:01:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1564462913;
 bh=Vgdma4M3NjY+571qzaaGNdc2/IobJXlKXEZw6X3gf8k=;
 h=Subject:From:To:Cc:Date:From;
 b=HL7zp8pO6qQEj4dGzi3XO2/xjjxFw+mjFHz9ELt1et+Qb5Kg1SP+80KBlrU3bnHLP
 i2T3e4+XYcH6f9pVp2gvL5+J2e12HgKos6AigFv04AnbPj+tLVy2dxoXVaJ7QeueUS
 nzDHNN0S5SqRSTY+EgWo909aN5sPTE4rVkr8ccVJHSGGg4yfm5/2SsD3oW1EZl2+mM
 UW1Or3Rg35OuZPHc6moAgT4G6tXWVIIXpjgdQ/J3pHMt4zR80QTjWlo0X5M+7pa6OK
 VMpd1GmwNAzgo7vEZ89nri2jDKn+OzIGqsVeF2wE74JOCcrFcEfBz4Dmx07gXTV7fK
 +/AGVgaRQ3Zqw==
Received: by neuling.org (Postfix, from userid 1000)
 id 04BF52A17B3; Tue, 30 Jul 2019 15:01:52 +1000 (AEST)
Message-ID: <67db82ab73dbb630c45003795f7597274f30983e.camel@neuling.org>
Subject: CVE-2019-13648: Linux kernel: powerpc: kernel crash in TM handling
 triggerable by any local user
From: Michael Neuling <mikey@neuling.org>
To: oss-security@lists.openwall.com
Date: Tue, 30 Jul 2019 15:01:52 +1000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
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
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linuxppc-users <linuxppc-users@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Linux kernel for powerpc since v3.9 has a bug in the TM handling  where=
 any
unprivileged local user may crash the operating system.

This bug affects machines using 64-bit CPUs where Transactional Memory (TM)=
 is
not present or has been disabled (see below for more details on affected CP=
Us).

To trigger the bug a process constructs a signal context which still has th=
e MSR
TS bits set. That process then passes this signal context to the sigreturn(=
)
system call. When returning back to userspace, the kernel then crashes with=
 a
bad TM transition (TM Bad Thing) or by executing TM code on a non-TM system=
.

All 64bit machines where TM is not present are affected. This includes Powe=
rPC
970 (G5), PA6T, POWER5/6/7 VMs under KVM or LPARs under PowerVM and POWER9 =
bare
metal.=20

Additionally systems with TM hardware but where TM is disabled in software =
(via
ppc_tm=3Doff kernel cmdline) are also affected. This includes POWER8/9 VMs =
under
KVM or LPARs under PowerVM and POWER8 bare metal.

The bug was introduced in commit:
  2b0a576d15e0 ("powerpc: Add new transactional memory state to the signal =
context")

Which was originally merged in v3.9.=20

The upstream fix is here:
  https://git.kernel.org/torvalds/c/f16d80b75a096c52354c6e0a574993f3b0dfbdf=
e

The fix can be verified by running `sigfuz -m` from the kernel selftests:
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/to=
ols/testing/selftests/powerpc/signal/sigfuz.c?h=3Dv5.2

cheers
Mikey

