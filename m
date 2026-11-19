Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82637606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4RsFvpp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVStZ1typz2y2R;
	Thu, 19 Nov 2026 17:17:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795069046;
	cv=none; b=R+F2MWVsYOH3r3smvTh3lWdBifN5AXWyjRYLYd7JwdXTXchP8CZmCVYLSPrKq7+8MAUD1lrHvGya9iW/xA/RaPjzTAO1FADmDaCEv/otdEXKi6GzooBZ0AE30wD8hj3x5R/0Qpri8bt1T35QnX7ChxcF0oQmRj3xVtS2ASMrKWbIOuz/umc1IKcb1cjuou4+b0X37Qv4gcp7fBg5liRR5jntw3C84HlZ2nnFE2wmLOchbiSsWoM0E5HqKHEgJPncwUrDvK0lfS9FC3iGau1kT9zsCn9P/HHhU4bmMU0XdMe1i661LCuD5Z4oqcN979XMvMVOfWS/CJON5aK7k6Z3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795069046; c=relaxed/relaxed;
	bh=RCALj7r6ipQ65VvrYt8UYoxBLY7ziLYM55JY1qfnc/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbmuz44FWmelvajgP6ortq7UregbtaOPyptUY9Xc4QrH8X1wqH0wFJOJPdfVLBRYVUeAxiFcPQI6SqjbG4A58WZ7iNX+z0vo1jgZVFuFELi5Sqyt2XxoV21tJn6buvbwJr/laBWKystNXe5aiImdikn3nDSLHnmmyIrEaw2CFMPoI1k7oTZXoZcqiCcBIBk/vRbFL0/Mnka44EmNFFsdKBQRsWPPO9TBVHNzk+LuEn0mJktmVCB2YdHPQD0Bo1jfzblWlHkyB/zCi9+9LFiKDHNMKQnhTeovdy2TWySWb2ky/MgF/tG1ZfoD1e1vNT0xUwHgE03ZTcR8Vkx6IFtkHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4RsFvpp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4RsFvpp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVStY4L83z2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 17:17:25 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 42FC861F63;
	Thu, 19 Nov 2026 06:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6BC1F000C5;
	Thu, 19 Nov 2026 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069042;
	bh=RCALj7r6ipQ65VvrYt8UYoxBLY7ziLYM55JY1qfnc/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4RsFvpp42re8uGBqIQQaz0PqGBIw37xPLwUslFEUgkmtfZ+L4DJ5tF9O6rwFB/pv
	 oTwcMalP+8YPREtTdZ/mO/uTE4CmQs2HCIVDtU9aDm0/l6ErDkOsAtNCDy3Owc2dfw
	 NhTWj7mEPGBVVIEkqz/SNG4/lnaJ1Ckq1d9I080njZAAP4lOXWETkMzicnDdMGwSZa
	 IuzwpjwfJJm/EsTZ1ALj7RxDfmTdqZwGJkhENJAdmNDATjggpuNt1CBYTdf69f4D4y
	 gn7NwSaO9QjgPGJeNtc+ljTmnnsG4TxH+MTkTbIp9qZ3L4/OYHNVJr062yUMTDzgJT
	 te95/HcZEQPRQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 19 Nov 2026 08:16:57 +0200
Subject: [PATCH 1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
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
Message-Id: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel/Kconfig.kexec is not matched by the KEXEC entry, so
get_maintainer.pl does not report kexec maintainers for changes in that
file.

Add it to the KEXEC entry.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d738990161bd0..c61a1f0ad330e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14782,6 +14782,7 @@ W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
+F:	kernel/Kconfig.kexec
 F:	kernel/kexec*
 
 KEXEC HANDOVER (KHO)

-- 
2.53.0


