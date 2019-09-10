Return-Path: <SRS0=Blre=XF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2544C4740A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 13:35:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7647320863
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 13:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="oUUf9Q64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7647320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46SQyG1WDKzDsV6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 23:35:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46SQY41FGVzDrcF;
 Tue, 10 Sep 2019 23:16:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="oUUf9Q64"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 46SQY16KHnz9sP6;
 Tue, 10 Sep 2019 23:16:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1568121413;
 bh=AuX99LUqbp1Lf5Waj0ruq7cGRnU1eycOTwzoHk5YkPk=;
 h=Subject:From:To:Cc:Date:From;
 b=oUUf9Q64Li8hy7ydebbi2lLVMvsD3aRYrfl8Q4F5PTGojl/aBh202eNYsD9haEyjX
 oKYKjO72NZoacLd8SPMjb057qAXCf3ZfjcmNPS5U0zyVF/1ZTDKyQhulDqHfi/ho2z
 H3UgB3zbZK1gYRvDrFJ/HVYjEGpL0oS29fXO0WTBxvZAAZ+3UhVkRJxzl4Vhk21EEn
 VgXONSN+j4pZeCd3Ia/IaFDAIbKP3SvKAb8EJ7BZS9xjjcC0r4uFvnK3XE/CUkyyXS
 bu5YExcfGHPWBRulBgjw6KtOgzn8U89hIZGJJdxLtW+Nw1PobTSwCB1+r6+/dO1b/k
 pvdLmCgyrlnpQ==
Received: by neuling.org (Postfix, from userid 1000)
 id BB6EE2A276E; Tue, 10 Sep 2019 23:16:53 +1000 (AEST)
Message-ID: <2b9f664b4763f745dee7efa526285eb891c99c72.camel@neuling.org>
Subject: CVE-2019-15031: Linux kernel: powerpc: data leak with FP/VMX 
 triggerable by interrupt in transaction
From: Michael Neuling <mikey@neuling.org>
To: oss-security <oss-security@lists.openwall.com>
Date: Tue, 10 Sep 2019 23:16:53 +1000
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
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linuxppc-users <linuxppc-users@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Linux kernel for powerpc since v4.15 has a bug in it's TM handling duri=
ng
interrupts where any user can read the FP/VMX registers of a difference use=
r's
process. Users of TM + FP/VMX can also experience corruption of their FP/VM=
X
state.

To trigger the bug, a process starts a transaction with FP/VMX off and then
takes an interrupt. Due to the kernels incorrect handling of the interrupt,
FP/VMX is turned on but the checkpointed state is not updated. If this
transaction then rolls back, the checkpointed state may contain the state o=
f a
different process. This checkpointed state can then be read by the process =
hence
leaking data from one process to another.

The trigger for this bug is an interrupt inside a transaction where FP/VMX =
is
off, hence the process needs FP/VMX off when starting the transaction. FP/V=
MX
availability is under the control of the kernel and is transparent to the u=
ser,
hence the user has to retry the transaction many times to trigger this bug.=
 High
interrupt loads also help trigger this bug.

All 64-bit machines where TM is present are affected. This includes all POW=
ER8
variants and POWER9 VMs under KVM or LPARs under PowerVM. POWER9 bare metal
doesn't support TM and hence is not affected.

The bug was introduced in commit:
  fa7771176b439 ("powerpc: Don't enable FP/Altivec if not checkpointed")
Which was originally merged in v4.15

The upstream fix is here:
  https://git.kernel.org/torvalds/c/a8318c13e79badb92bc6640704a64cc022a6eb9=
7

The fix can be verified by running the tm-poison from the kernel selftests.=
 This
test is in a patch here:
https://patchwork.ozlabs.org/patch/1157467/
which should eventually end up here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/testing/selftests/powerpc/tm/tm-poison.c

cheers
Mikey





