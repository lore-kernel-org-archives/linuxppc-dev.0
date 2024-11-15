Return-Path: <linuxppc-dev+bounces-3251-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F106D6DDE1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2024 13:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqdTc6f8nz2yng;
	Sat, 16 Nov 2024 00:41:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731678084;
	cv=none; b=kDohl3Oo/tcfAA3SOMYvJQV94yqzTrXBUG8i91oJ7kz1cgatGnEk9K44Gsgo3KGo+/yZBne6t7xhFDK6kr2CDpMOc9hzksEJsXfN42iPlHRfQKjD8MXE5WWTOXngUwAKrqo5EkTX4Z4Y6tbQVxEWUtqFV4gcz/j01BtipI3LHWkHmGU8ggyTax/gkIqMo/RrYs82K3ZzehElZmhR8zoxb+wSlt0ECKbbGMo/+73wdUlt3d1ugKOg2UGg0XCdEciaXjwKii5nWWuk5c0yQNAQ5oOznmE5UR6rHr7iey2bd9SRAVSN/2Uurun47pkVdrk4UpEVryqKKkY3NiapzMVQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731678084; c=relaxed/relaxed;
	bh=CWUey5ewpa0QOwduayBJGtFMN1WGhVsVPHWEh62bV1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHUB1oD+RDWSbOGlOmZzdY24tDDIMatvNo25C2kandYTwpX68pmSSvDtunp9CUMf9us+9gZ4XhFzIDParBnrOwc2IOc5V4icA2SzrZ0vyFOzgXFRImcxHN5XMER9FhB8XY6Q5xlRmtetrfuQEQm5rkg1sG5cTrGpnaUkUiw5Y66q+Gi6tjKEiWTOPGh7n0cGYAJQV0WpAQA6Ul+n/d6KnOh3973H3ohhA34GUGl6I8BtCn6sEl/AISnTcf9k4XHFdtRh+iCbMU1L/7yP8RgBwBeuyY5YsZ9eBOeB0Zyia0TwGkeHSf3b0mDDfvRmXZF48ZTnjVcwvKJzmmBLCy/w/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=boPmHIT2; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=boPmHIT2;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqdTZ1Fv2z2xs8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2024 00:41:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731678077;
	bh=CWUey5ewpa0QOwduayBJGtFMN1WGhVsVPHWEh62bV1U=;
	h=From:To:Cc:Subject:Date:From;
	b=boPmHIT2e8MSBzjaB3CU3MYrzSHuf+jieypvN7zjgkVmG94kSQhdWt2uc9Fde18Uh
	 j7RmIdj9gvpawaprZ1iFPb9aj7925BCQ+7yDAYWTwITg90aG8y/JRXU1ABHXBZKIf/
	 4RCR5aTHx/8BptsQAQmBVqv3qOkJkQKWY8l5aSEudeUYF7xphfP66K0HZoMswRmDww
	 /DttRaryn1a7gZW2vbitOcGEm4lTwtKjjjBPaQ7VFLnUluX5Ni0u7AAeP9Q++wMOV0
	 cDuYw1ONvtL5NWR9GVSCpA0+mh95tlWGiW3NWpKZ7A7A+m4A06HXA0vEtgH00qBqXm
	 OdVbpQS1rI7tA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XqdTT32Lcz4x6k;
	Sat, 16 Nov 2024 00:41:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: brauner@kernel.org
Cc: sforshee@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	<linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels
Date: Sat, 16 Nov 2024 00:41:14 +1100
Message-ID: <20241115134114.1219555-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the mount_setattr_test fails on machines with a 64K PAGE_SIZE,
with errors such as:

  #  RUN           mount_setattr_idmapped.invalid_fd_negative ...
  mkfs.ext4: No space left on device while writing out and closing file system
  # mount_setattr_test.c:1055:invalid_fd_negative:Expected system("mkfs.ext4 -q /mnt/C/ext4.img") (256) == 0 (0)
  # invalid_fd_negative: Test terminated by assertion
  #          FAIL  mount_setattr_idmapped.invalid_fd_negative
  not ok 12 mount_setattr_idmapped.invalid_fd_negative

The code creates a 100,000 byte tmpfs:

	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
			"size=100000,mode=700"), 0);

And then a little later creates a 2MB ext4 filesystem in that tmpfs:

	ASSERT_EQ(ftruncate(img_fd, 1024 * 2048), 0);
	ASSERT_EQ(system("mkfs.ext4 -q /mnt/C/ext4.img"), 0);

At first glance it seems like that should never work, after all 2MB is
larger than 100,000 bytes. However the filesystem image doesn't actually
occupy 2MB on "disk" (actually RAM, due to tmpfs). On 4K kernels the
ext4.img uses ~84KB of actual space (according to du), which just fits.

However on 64K PAGE_SIZE kernels the ext4.img takes at least 256KB,
which is too large to fit in the tmpfs, hence the errors.

It seems fraught to rely on the ext4.img taking less space on disk than
the allocated size, so instead create the tmpfs with a size of 2MB. With
that all 21 tests pass on 64K PAGE_SIZE kernels.

Fixes: 01eadc8dd96d ("tests: add mount_setattr() selftests")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 68801e1a9ec2..70f65eb320a7 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1026,7 +1026,7 @@ FIXTURE_SETUP(mount_setattr_idmapped)
 			"size=100000,mode=700"), 0);
 
 	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
-			"size=100000,mode=700"), 0);
+			"size=2m,mode=700"), 0);
 
 	ASSERT_EQ(mkdir("/mnt/A", 0777), 0);
 
-- 
2.47.0


