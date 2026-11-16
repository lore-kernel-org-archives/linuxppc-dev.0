Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA8606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSkp357xHz2xtC;
	Mon, 16 Nov 2026 21:37:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794825451;
	cv=none; b=dW0bDP7bn3zPgDqpv6TbpyjR8IuwnbWwLuTyoL7W17gSWy821HalD/Peq+GfPkeD3vkab94tFD/O9KhWky/hcLnkaPKGdpC/XiVTJwAUmePIGaWeD6Je/cpQ6RBXnxd4jxG4CiMaqypPQwv30Il7haX1sO5ropKR817D39M0UsZ2HUONxDEtCQytbyv08DW0v4mFNBBmvkbj3XWi2AL/Rm376hR+jRV+8smgjTR1Tn+8A8vGeuCh7KIHHQ3olC305uFtTjLHi6e7u/r13IVJ0cCMUVPafS7vySoiPy8LO7kt25wjSHKbmfYoDD/u5kzpzukqS/J+ptETIW5rc60GGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794825451; c=relaxed/relaxed;
	bh=0Gu+Ukkm9LaTMjLC6EylFPESV3dPO3uZmybp5fKqeAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCHg9j0CSennrJEjyItMSY3Osj1AXP7f26T0FiuCmeHtZ0gWKQm5A9SfzemFQkI/pVd6NVYTYp+d1MQ1lN+/GXJ4A8vX+lhiGYvckYU/FwkPmyWtUQaU4vWq/BfymkHuwCdeGG3cq0dZrDXXXEW6wl/BtcKT0BiluQ3TFq84mPNqrot/fByswQTcKjQf5KwDgbmHAL4eZWWZ2bOfWuh6YZ1a7qzCSSKjIokZn0pLVTj9QtONjuVMxI4XHuYisr95pQFYxlutGnpARFdkExiR3x71VWO8uFWeIgnQnaa267ZKqQ9aMPoTbZRoXH1JnTJxnn64defCxk24rkz/QguHqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhX+Vel6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=thuth@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSkp2162Jz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 21:37:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794825445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Gu+Ukkm9LaTMjLC6EylFPESV3dPO3uZmybp5fKqeAw=;
	b=IhX+Vel6NjYaNx4rQIDK78nwdJzaVQhWorVRmqGvoIUYEs3J4yr48PydxPKVcRIcVhMdf3
	g96KR7MFrdwMzQ3VbPdrWyJ8IX+fshaJuQjD/N91eIMQz9Kl2Y1yZq7tcXzGUArhgD81Fi
	i4AGwgr7EYONwB0twGTaiFgtBdbai/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794825445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Gu+Ukkm9LaTMjLC6EylFPESV3dPO3uZmybp5fKqeAw=;
	b=IhX+Vel6NjYaNx4rQIDK78nwdJzaVQhWorVRmqGvoIUYEs3J4yr48PydxPKVcRIcVhMdf3
	g96KR7MFrdwMzQ3VbPdrWyJ8IX+fshaJuQjD/N91eIMQz9Kl2Y1yZq7tcXzGUArhgD81Fi
	i4AGwgr7EYONwB0twGTaiFgtBdbai/s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794825445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Gu+Ukkm9LaTMjLC6EylFPESV3dPO3uZmybp5fKqeAw=;
	b=IhX+Vel6NjYaNx4rQIDK78nwdJzaVQhWorVRmqGvoIUYEs3J4yr48PydxPKVcRIcVhMdf3
	g96KR7MFrdwMzQ3VbPdrWyJ8IX+fshaJuQjD/N91eIMQz9Kl2Y1yZq7tcXzGUArhgD81Fi
	i4AGwgr7EYONwB0twGTaiFgtBdbai/s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-xrhj7BO1MY-zWGsEGWyiSQ-1; Mon,
 16 Nov 2026 05:37:18 -0500
X-MC-Unique: xrhj7BO1MY-zWGsEGWyiSQ-1
X-Mimecast-MFC-AGG-ID: xrhj7BO1MY-zWGsEGWyiSQ_1794825437
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADFCD180044D;
	Mon, 16 Nov 2026 10:37:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 573A41956088;
	Mon, 16 Nov 2026 10:37:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: Fix set-but-not-used errors with GCC v16.2
Date: Mon, 16 Nov 2026 11:37:10 +0100
Message-ID: <20261116103710.674746-1-thuth@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: hZ6sS_OCXjUJdidwTah8n_oxp98Jw661UgEB06yZhcY_1794825437
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When compiling the powerpc selftests with GCC v16.2, the compilation
fails with:

 ../pmu/lib.c: In function ‘eat_cpu_child’:
 ../pmu/lib.c:86:22: error: variable ‘i’ set but not used [-Werror=unused-but-set-variable=]
    86 |         volatile int i = 0;
       |                      ^

and:

 ebb.c: In function ‘ebb_child’:
 ebb.c:352:18: error: variable ‘val’ set but not used [-Werror=unused-but-set-variable=]
   352 |         uint64_t val;
       |                  ^~~
 cc1: all warnings being treated as errors

Add some "asm volatile" statements here to make to mark the variables
as used and to avoid that the compiler might optimize the code away.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c | 1 +
 tools/testing/selftests/powerpc/pmu/lib.c     | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index 21537d6eb6b7d..f4ef92bacd9ab 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -391,6 +391,7 @@ int ebb_child(union pipe read_pipe, union pipe write_pipe)
 		val  = mfspr(SPRN_MMCRA);
 		val |= mfspr(SPRN_MMCR2);
 		val |= mfspr(SPRN_MMCR0);
+		asm volatile("" :: "r"(val) : "memory");
 	}
 
 	ebb_global_disable();
diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index 3213579874084..32cafd40d2c56 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -95,7 +95,10 @@ static int eat_cpu_child(union pipe read_pipe, union pipe write_pipe)
 	wait_for_parent(read_pipe);
 
 	/* Soak up cpu forever */
-	while (1) i++;
+	while (1) {
+		i++;
+		asm volatile("" :: "r"(i) : "memory");
+	}
 
 	return 0;
 }
-- 
2.56.0


