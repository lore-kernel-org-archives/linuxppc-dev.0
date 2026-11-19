Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD9606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPur/Mce
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVStL5dC9z2y2R;
	Thu, 19 Nov 2026 17:17:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795069034;
	cv=none; b=iw5DndJDZ+bUsS7FupNYg8Z/DQO3fWat7b6n3nDfpwJMS6avU2gI/5hgSf3MTSqwwaT1cEzcCPHErGFIwI1NrGfdUd8hJ0pZir7Ga0LtCGhHrhI8QoAlzmG3f8njLiYm1hqurFCwXnZgN42PbQo5cIJNSzjQyDazOdap891viNh+wGSJiLYuIPYFDy53HB0SaluF4cFUSk6CPBlqAX7FwI7sz4EvI3MProNiLSO5gFbwSp+zoPBV1Rz8/AVFydjwY4VxjdJF4Ft5TgK/DSUqallAWyCZ2fuSTTz6UWkwpoK8CVllrZTqpCEWO5RoHk0YpLlLmoM6RFd3YKHldneN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795069034; c=relaxed/relaxed;
	bh=jAZ3SnNAJjB6kTaL5eHDhSogy8KQgK6+JZEcWaMgZsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UCJpIc/GAWytxBo0695uYv3z1Gsi7rmJUcQyBwHvcet2DVz8oUVNXwpaQBUBYI3h/UMR82xAP49VZCBWiGqQt05Q0EZBGeX8zvQGVPs8PyNU/9bGLUxyCBJtBVIW8lry14Sytiwblnnpj7SSOPRjuSsuKHfU/7S20i4B73TbfwEd9lMH0IPebN3bdeRP1I2Ab+Xt68VF/SA6a+Sao3vKj3g67r7ngqfCU1+wbiAJykz1bRTNoMo+qgfCD0BidD/Z0fZ1QY16nBjDyxAxPyHkQN/1V08am2WvfwvRuInQavFbNfqox7I/NcOoPnkbXdosJXK1wXa4ulYxp4KvXVR2BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPur/Mce; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPur/Mce;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVStK5XzSz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 17:17:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3342B43CA0;
	Thu, 19 Nov 2026 06:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CBD1F000C4;
	Thu, 19 Nov 2026 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069031;
	bh=jAZ3SnNAJjB6kTaL5eHDhSogy8KQgK6+JZEcWaMgZsQ=;
	h=From:Subject:Date:To:Cc;
	b=QPur/Mced9X4RWzkGAt/MsAw+bqXt6yVON5lBH/7OyoiOaTbtzFItUhDCUIBWDdre
	 ZGouoE1rykai0wUQlOVqCf0GlA7TrbLaI2Mqs8gYX/JQ9Oo2Wv4yYD/dlpAaTFIAXX
	 7IftOiVoRagY/2JtvK8msJVyzyhR0zNeTTJ24nH7TIsTApifHRXe0eKDJ6rYh/TTub
	 jmzTR3ax1PmxnZG5lGOM7weBavns02NIAauS40hYqQBCpuwRdocLfEJkR7ay2DzFMT
	 sD7YpoQ9CvRkXi7y5T0RyOjL3xyq6FU+Kn1gekCcdzIt/umGs5YWm5g7jWFh3p4MWR
	 YpdheBZ8DOQsw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
Date: Thu, 19 Nov 2026 08:16:56 +0200
Message-Id: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5TURTlfK5CmKRGDcxiKSyC6pU9
 e4ksJynN7OCkjApXJoVhD6snFMBu2sAo0uBDN8LQ9d2g7X2bJxgNE/MaeRg/BF7b1s84WGAokx
 CIy+/3PX2Z337B+FcG/XhnZLx4hLGOmXhwGn/cjqTwLZ9AUFdywKQAAAA
X-Change-ID: 20261119-arch-kconfig-b7c4b10c8c56
To: Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
 Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, 
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The intention is to take it via kexec tree.

---
Mike Rapoport (Microsoft) (2):
      MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
      arch, kexec: declare kexec and crash capabilities in Kconfig.kexec

 MAINTAINERS            |  1 +
 arch/arm/Kconfig       | 12 +++---------
 arch/arm64/Kconfig     | 36 +++++++++---------------------------
 arch/loongarch/Kconfig | 20 +++++---------------
 arch/m68k/Kconfig      |  4 +---
 arch/mips/Kconfig      | 12 +++---------
 arch/parisc/Kconfig    |  8 ++------
 arch/powerpc/Kconfig   | 30 +++++++-----------------------
 arch/riscv/Kconfig     | 28 +++++++---------------------
 arch/s390/Kconfig      | 28 ++++++----------------------
 arch/sh/Kconfig        | 16 ++++------------
 arch/x86/Kconfig       | 48 ++++++++++++------------------------------------
 kernel/Kconfig.kexec   | 42 ++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 102 insertions(+), 183 deletions(-)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261119-arch-kconfig-b7c4b10c8c56

--
Sincerely yours,
Mike.


