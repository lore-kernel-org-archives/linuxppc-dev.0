Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46445C83004
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05A12073E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 10:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A12073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Bvfj0NJhzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 20:20:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.79.203; helo=10.mo68.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 8408 seconds by postgrey-1.36 at bilbo;
 Wed, 29 Apr 2020 20:18:44 AEST
Received: from 10.mo68.mail-out.ovh.net (10.mo68.mail-out.ovh.net
 [46.105.79.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BvcN0k27zDq72
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 20:18:38 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.110.208.202])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5FB58164FC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 09:51:27 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id E13E411CA9131;
 Wed, 29 Apr 2020 07:51:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/3] powerpc/xive: PCI hotplug fixes under PowerVM 
Date: Wed, 29 Apr 2020 09:51:19 +0200
Message-Id: <20200429075122.1216388-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3602598230992980913
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedvgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhg
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
Cc: linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

Here are a couple of fixes for PCI hotplug issues for machines running
under the POWER hypervisor using hash MMU and the XIVE interrupt mode.

Commit 1ca3dec2b2df ("powerpc/xive: Prevent page fault issues in the
machine crash handler") forced the mapping of the XIVE ESB page and
this is now blocking the removal of a passthrough IO adapter because
the PCI isolation fails with "valid outstanding translations". Under
KVM, the ESB pages for the adapter interrupts are un-mapped from the
guest by the hypervisor in the KVM XIVE native device. This is is now
redundant but it's harmless.

Last is a fix to disable the XIVE debugfs file when XIVE is disabled.

Thanks,

C.

Cédric Le Goater (3):
  powerpc/xive: Clear the page tables for the ESB IO mapping
  powerpc/pci: unmap legacy INTx interrupts of passthrough IO adapters
  powerpc/xive: Do not expose a debugfs file when XIVE is disabled

 arch/powerpc/kernel/pci-hotplug.c |  2 ++
 arch/powerpc/sysdev/xive/common.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.25.4

