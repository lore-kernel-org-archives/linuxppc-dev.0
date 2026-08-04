Return-Path: <linuxppc-dev+bounces-25360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0060BC55838
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrhM3Gknz2yMl;
	Tue, 04 Aug 2026 21:21:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785842467;
	cv=none; b=cP6v08oHOAffG2PrjeSgof9td7D4hzXQXX1F+qgShItb23LH8y+KiyLwIk4PD+he50GRqjbD4PUqCIqz55AQNz4pBn7+XlpevN1dJO/eIdN4fKQx6+Aj5FXiLwWxkHMb8oeTPPwxDYwU53D1g34G6x9gfd+9TQAja60YAZ6zeVGjyGI3TU8fUVEi2duSw5tVOzC2NaxoV0aAwgKjytTcCgkgxlUrdNbB78jpI+cBKfEyB7hSaN6U9bUUqLVhYHYxDBLYBuGOtHMMAZgph/TLgNCE4yyFBxI+zSLWczu053HIjHXJPmRDMHi/wcjFTmVqj+1jovFpx1+kn6UjeL8VsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785842467; c=relaxed/relaxed;
	bh=4mr5daeqt5fKnewbMpqWnCC7jArhYcGTBtc9ufR6IWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klF1CYgOr+u4MbfdzOkgl/hQSUo1OX1mJUgLlZ9lLNpGNqYHXza/TPZxlZm0tk2PSryizi9TYNGwEtrRTZGdbJdFXqlGNt7zEHxdXd9b2T94T+jjmuaJa1aJeGAvPZpSLhXTDx00T3hOHYOy17lWZQIosxp35vLrs4macG43lEwMjpczMUiayXuXqF/gtFrlRW77Si3sH2Eyv+i7KI9kc+K4B4yomQXq4gofPVsHJQxENjByOWBJ77J6UDlodzqKBu7Y4mcnUeGL/4UbdCDVs+04h15ZawJm/sc57PM2szBcnYYfuSzWQ61Uc6ajmcZ9lKOgwFpBNjY7HW7AJPUChQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aC0IXmTK; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aC0IXmTK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrhL1jCYz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:21:05 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785842445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mr5daeqt5fKnewbMpqWnCC7jArhYcGTBtc9ufR6IWo=;
	b=aC0IXmTKb/y72xq8c4DbOsHFjuoeBqEZl8urxWLO85s50bh3aPPyysG8b/9kes5/NqCI9M
	pZ5I4aPrvDZENGQNbb6apV7kkWxlGnicQAkt5/lBDFzIpWKFNkhsZiehpBv9NLxpqOv7TR
	WKdg7NQKxjk0uHBWqswaQM/FwyssunE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()
Date: Tue,  4 Aug 2026 13:20:13 +0200
Message-ID: <20260804112011.59416-4-thorsten.blum@linux.dev>
In-Reply-To: <20260804112011.59416-3-thorsten.blum@linux.dev>
References: <20260804112011.59416-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=thorsten.blum@linux.dev; h=from:subject; bh=XRdPPPO2hqRYZCus6bFSfmdOS7A257YA5jWpdDEAfbo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmFp77Z2kR9rTBcULJgJaPtN8c6Fr81ScWiDObGGZ583 1VfyGd0lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwES+rGX4zTpFdIHub2F5Ceb1 tsm7So19LGtW6pcx2igoNaUJL9mlxcgwRaeaqbNxp0LG/YczzLWtJ2zojD1X0bJ92vpfG58KLjz ABwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace min_t() with the simpler min() macro since the values are
unsigned and compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kvm/powerpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..f76322be907d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -635,9 +635,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		 * implementations just count online CPUs.
 		 */
 		if (hv_enabled)
-			r = min_t(unsigned int, num_present_cpus(), KVM_MAX_VCPUS);
+			r = min(num_present_cpus(), KVM_MAX_VCPUS);
 		else
-			r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
+			r = min(num_online_cpus(), KVM_MAX_VCPUS);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;

