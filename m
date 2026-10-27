Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2460A260E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T8eLvuI7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDlm64ZfCz2yjw;
	Wed, 28 Oct 2026 09:39:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1346"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793140758;
	cv=none; b=QHBwsjoRuteWbLRZ4oomuXmt/wkPTYPxxUq597SPqDPuFugFIkFecdEpSJHKpH+BwUWUODpmHYsfQnW6FbKvT6ZAb8K0OXQ2JEYBupBt+9wce28ZbOgQcX8Un9Qy7iGJiQrzSUeExgGRJ9cZ/yxW0uRx3MxDZTwbkhR4lNHLBYoog/6Ib7MTDolPVyEblUj3t91fSGll2y1F3F8vudWCp2dx+n5KixtlmjxwVsTB9RVY429ioxgZa9F0p1X1OIfRx8LApwfY1xaOnsbL/ZVGM93h6Tpy0mPPM8WnVBaTY64jh1EUrRYFxCIGq8FJNeUXdlW8uLjG5y3LnMeEz0xbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793140758; c=relaxed/relaxed;
	bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gF145Xfj80JyHvyNSgLNSj0TrDtaTHMiv7teEp0h+I9EtINpP3B2xWVk4hKsl65FIlV4RsQuyrJSUoBckSqHEMmRr/pKTpWO0H0U8Ybx9MbvwyoufQdUEwkHZvphafkwuy3CozKAxLSZwwdX0kgRm9jhz0WVFTvJ+3J5bC/mphOhUPZDmBwOoF/tlXXDlEGCmjdThFuawpZ/dEGC/n01x01UYParLhz3gQiFA3TQ3OaD75dPB4ny9pyoEe3YKKdZ4JRDMaFMiGcKCrRblbwtn/IZsgpOHYohr++qM/vy06BH18jlj2pSoAg6zGPHhWCvZORgbKpldNQNXacPSQE2zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T8eLvuI7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3eyjhagckdeyqzwomz0owwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T8eLvuI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--irogers.bounces.google.com (client-ip=2607:f8b0:4864:20::1346; helo=mail-dy1-x1346.google.com; envelope-from=3eyjhagckdeyqzwomz0owwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--irogers.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com [IPv6:2607:f8b0:4864:20::1346])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDlm563rhz2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 09:39:17 +1100 (AEDT)
Received: by mail-dy1-x1346.google.com with SMTP id 5a478bee46e88-35c3c370b17so500134eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140756; x=1793745556; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=T8eLvuI7svYc9ez4Rm1+WAJXd34dqK1qmG5RSMXOUWjzgwTKM0cHEucH+KkBF5EQH8
         GCYrAF3unBCYA1qND0hzqFYotNxIfcYsFoqB0eAeDHzDLbjXWeVqgXBVfx0qxWcnmbgo
         biPGzyOJOFNiMmU4eopd8nniAkWRSKmMZq1doYrEVgUZSHSZlz4PALMkp7kCFAxNs7yI
         Ss32rdmyjO6RS7g95wkTPwLYM+/Ysajoh8VJzXAPswPuQhStUg3EpNp9XPKkFMScJ6Uu
         uf+wKl6hHHfmdNK1DlXcVsrBspajDbCuEYVTcttMcDr5OkX/NxllTLEB1AY6uGUFzP0F
         L+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140756; x=1793745556;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZ/TSWTZAJNbAAfYXfetESQgQ8bp7xksXUAoJHJHiFs=;
        b=KR6vVLXQlT3Qupsl0f/D4EdJyh4mmFED0bRBoeCbK7rWP+IL8JSTkaPVemYW/ML12S
         CZ+wVXDnKzmUr8A6Kee6kVNzg4ba7wPlxeyqMM3nVfuXS8GYFuwtTqnc+mmWKO9bXF0e
         s2+h8mTJ8VSUns58zSsSq/s8wMFm94X6BxmfV/YPFw027jxbSQXXMlxVWaByD1w6bWGN
         9Jw3xB6mLXz7iSmmP/4VjKrPeQEVPwD71b4l411FE1LDlN0cFykq0IfTQbTmmda15+I+
         er/B9aWrMRL/ZXwZ8YneE4sdOQwGfC05TkjT/b+MBt0kj6fYPOJYyr3M3t1ZOn0DNSo3
         4zFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQbO0tQ/drf1yZrypnD5xswGbnMcftwWxKPZ2wilkECjne9zFvpUmmJ5x1vsSJFPf5gqhNWEJ/YuuP4pk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJpW5caK6olQWgbcxU7d1ho/SrhgSOS+rUGePOnmcNMglm2CmwT
	6NXPAgShsM0QIjhKZVvP+Vi/T3ZrCQev3t6uN20+1iGjOZiToDLhMCJf/Uuf2Tg87VWEm91FUma
	fcG1gKnNeLw==
X-Received: from dlbrl28.prod.google.com ([2002:a05:7022:f51c:b0:192:91:5cc4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618:b0:19f:527d:96da
 with SMTP id a92af1059eb24-1a6cdd3e006mr1194989c88.33.1793140755024; Tue, 27
 Oct 2026 15:39:15 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:37 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
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
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-3-irogers@google.com>
Subject: [PATCH v2 2/9] powerpc/secvar: Add missing kobject release callback
 to secvar_ktype
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Nayna Jain <nayna@linux.ibm.com>, Eric Richter <erichte@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In add_var(), a struct kobject is dynamically allocated with
kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
However, secvar_ktype does not define a .release callback, which results
in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).

Provide a secvar_release() callback that calls kfree(kobj).

Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index 395399bbab2c..f3f6ac25ea78 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_group = {
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
+static void secvar_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type secvar_ktype = {
+	.release	= secvar_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.default_groups = secvar_attr_groups,
 };
-- 
2.56.0.313.g2479322e68-goog


