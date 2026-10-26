Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75F606A31B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrks6mQ0z2yQH;
	Mon, 26 Oct 2026 22:20:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793013605;
	cv=none; b=ZBKePhhPENldc5WPDqEi04ymORauXj1TUmWDS4k+FpZ78lMdz07cMVwO+nMaOxTG4cnZbYeAGH1ZKxNnvllS9xkY1Ha6g7iMf1pdiag2hwSsE2W/DWOrDTzH/u0eypeU5bu0UkbRK1FvDVY0P6pXXPNBqB3upMujksNzVa+ScIlNNmNZ0iIw2GsncSylOoxU0TsyXYCtIhFLus9wZLafKMptnbhsqonruZo+v4YNQVRS/ABfki2opzU5HocCa11yXvJopdcH4LDGcaJckZjECbZclv68h5037W+n9j59PJjApaBtlIphsRTxe8vsZrZujfXOxtHRtt/bvd8QgB/1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793013605; c=relaxed/relaxed;
	bh=b+DCJkrwcuXKWzPX0QxpX1ccVGXrsTMiQkeEh3cGqxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=efCPgOddYkqZmi+4cbk4kLeZY8n4tY2LK3SCCAMQ2nb7XvJTAdHELkppwMYkCxcvA0+4iukmD5QSoZruNUhTznaWMogPkn3MLN5L5YX+yHBQr58INpGLDlCqtUBy7iCk5ChjHdM/tSayPYaubbf0y7QmB1l37rfOf/fqoKDAa3hjYfLh/eWRYy8fd3opQXctsILnK6lVyBnaYRlHGYcTZ71FN1gZP9ZlpkR12bA72p4RDmSKTR4Qze0wer99fqgGJMRRoQW+vxe/e24o+u3WSF4I/umjo15M/M39KBCyI1/zhfR6oFwh9M86E5p62i2ywr7lbTv6m74zOX+XwxJ5fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxHmfY7l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrkr6HFcz2yKp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 22:20:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b+DCJkrwcuXKWzPX0QxpX1ccVGXrsTMiQkeEh3cGqxQ=;
	b=MxHmfY7lXM/yJyXrMw4Sxvl83KtQVUe60OqesYSP9Oj23nTRtRU9ZKWItlohDZnDx2fW+c
	NrqxZNVZQJFUXJg8NQzWJpr4nETNwcDrQ+80iXclmIA+BDWPSdxTgOLF+COnAu6pSgqyK3
	yHcWI6BKNqm/mM+5mdTwH1e7z1AULoo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b+DCJkrwcuXKWzPX0QxpX1ccVGXrsTMiQkeEh3cGqxQ=;
	b=MxHmfY7lXM/yJyXrMw4Sxvl83KtQVUe60OqesYSP9Oj23nTRtRU9ZKWItlohDZnDx2fW+c
	NrqxZNVZQJFUXJg8NQzWJpr4nETNwcDrQ+80iXclmIA+BDWPSdxTgOLF+COnAu6pSgqyK3
	yHcWI6BKNqm/mM+5mdTwH1e7z1AULoo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b+DCJkrwcuXKWzPX0QxpX1ccVGXrsTMiQkeEh3cGqxQ=;
	b=MxHmfY7lXM/yJyXrMw4Sxvl83KtQVUe60OqesYSP9Oj23nTRtRU9ZKWItlohDZnDx2fW+c
	NrqxZNVZQJFUXJg8NQzWJpr4nETNwcDrQ+80iXclmIA+BDWPSdxTgOLF+COnAu6pSgqyK3
	yHcWI6BKNqm/mM+5mdTwH1e7z1AULoo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-w4DS_Q8MPOSm-ovV3-ggYQ-1; Mon,
 26 Oct 2026 07:18:35 -0400
X-MC-Unique: w4DS_Q8MPOSm-ovV3-ggYQ-1
X-Mimecast-MFC-AGG-ID: w4DS_Q8MPOSm-ovV3-ggYQ_1793013512
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DF8318001D1;
	Mon, 26 Oct 2026 11:18:30 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3665D1956087;
	Mon, 26 Oct 2026 11:18:23 +0000 (UTC)
From: Jerome Marchand <jmarchan@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH 0/7] Remove the unused non-atomic local_t and local_64t functions
Date: Mon, 26 Oct 2026 12:18:15 +0100
Message-ID: <20261026111822.458404-1-jmarchan@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: gGfSUOl9ioyN51aLGYqdqBR-0pPV6dVYj10zex0KtGw_1793013512
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While working on a fix for a tracing soft lockup , it came to my
attention that __local_dec() was broken on ppc64 and other arches (it
actually increment the value). My first instinct was to fix it but the
fact that this function was utterly broken for so long, decades for
some arches makes me thing that those functions have not been used for
a long time, if ever.

At any rate, they're not used now, so it's probably better to remove
them.

The local64_t don't have broken arch specific versions, but aren't
used either, so remove them too.

Jerome Marchand (7):
  alpha: Remove the unused non-atomic local_t functions
  loongarch: Remove the unused non-atomic local_t functions
  mips: Remove the unused non-atomic local_t functions
  powerpc: Remove the unused non-atomic local_t functions
  x86: Remove the unused non-atomic local_t functions
  asm-generic: Remove the unused non-atomic local_t functions
  asm-generic: Remove the unused non-atomic local64_t functions

 arch/alpha/include/asm/local.h     |  6 ------
 arch/loongarch/include/asm/local.h | 10 ----------
 arch/mips/include/asm/local.h      | 10 ----------
 arch/powerpc/include/asm/local.h   | 10 ----------
 arch/x86/include/asm/local.h       |  9 ---------
 include/asm-generic/local.h        |  7 -------
 include/asm-generic/local64.h      | 14 --------------
 7 files changed, 66 deletions(-)

-- 
2.56.0


