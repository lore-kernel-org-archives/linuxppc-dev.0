Return-Path: <linuxppc-dev+bounces-26535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4CBC624DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 08:30:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbqRf2QQZz2xlY;
	Fri, 04 Sep 2026 18:30:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788510654;
	cv=none; b=OzFZHjd6TfxHfIdvKEzv3AfYUpoJ92BNMbdNpoQKOvpFp8B6Ysob2Sm4bWcBNu5eJ44rMyPoQNKPaTtDlggN10cC6TvL0aRrVSsXMQqezpwwvFRmG4Y5P+qrvN1iNC9976I7Dbm7qkixDLNm2GjUkjvZ4Y2o4b4L8k13bS92iZF1UhPRzKn7ZFp7J6EertW8XcO/fe5MGDjd3xMSEC+ITvZ0f/7H9oApjIt1QunEEjBdUOpES1LpWCmtzQWUh6nXwOy8TSPa3ugC5e1koSbWhn6adyQ/EZvxyGzbI52yZs35GBUWUw3kv5s6Gitz17DkEKvpbDSha03EYF8wd7TXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788510654; c=relaxed/relaxed;
	bh=2P0jhS67aBG6K0qCh6emThFqmytz3kdbtlJysEkTaoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ak/TatCM5D2aZP+tNNZBVecnIsd43gpUXDdXTcUS6+21v1VZD584HbnrpkPAWzJ+Znk1n0IbcwRC5eRqbluqqUtqmnuKaTbvh1cxKklrUr6K9RNZPQC1lPb/1/8l/+xkAXVQXKWjIVDEUmkriHDUeSDqYdvMofd9EbPY9fG74OZh0xCaPbkDyz24F7RObAgz612puzpXsk1cFs6MX6sReryrLSAla9So9EM6obiPHhW1ClOA6vlLImkb8I1fZElbGo9ph1/PVSXYGHduoEEmc/3WVXQ5cxgEkAdU9CAao2b9/DyKp+Gq+nss38LKfQAh3VQpW77Vjsg9ShvN3ljoxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IfihUIZt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::8; helo=mail-pj2-x08.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IfihUIZt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::8; helo=mail-pj2-x08.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com [IPv6:2607:f8b0:4864:39::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbqRZ6mwrz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 18:30:49 +1000 (AEST)
Received: by mail-pj2-x08.google.com with SMTP id 98e67ed59e1d1-38fd9408220so179794a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510646; x=1789115446; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2P0jhS67aBG6K0qCh6emThFqmytz3kdbtlJysEkTaoA=;
        b=IfihUIZthl9UBT3Zb8b95//qkcx8+PvqaBBSA/PT0gXK72vacVBpyiBMQCfr+Jaj2Q
         i30zVkFsqb+4/4D5XLrg8grGyLcnSifmRzRvbX0oEt5ZdCabobPn3B4s70W/0+8SiVn3
         Kp2On0OpUL94+jPMaZlC6sV2VzxyDyY0onTdPx4TB97mvrw9Lw7P+j/YSMR6r+Tp1tV/
         adLVpIwKtir1Wqzgx1TWFL8su4NXOuO3sLIf7qBwZuSNY357uE57cbhsPriC7UCoWe4+
         Eys+epdJMRmwuk8N6ZGGnFEnMex/zMZ3jzk0A6szp/Sx1reeKELXjOyZ/ooFLMOp4Ius
         0uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510646; x=1789115446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2P0jhS67aBG6K0qCh6emThFqmytz3kdbtlJysEkTaoA=;
        b=rnkdvBsWK/jkrn0H8k2Rgq/0UZDwOAO8yScVKrFu9lT/i8DkJIk/0OS+d45+HPvLZP
         O32y0NG6L+qjANZJfmUpoYcNqw0UwSvvIlu1xr+ZT4xS/a8qNDwMV9ublDjWOKpxC8MR
         1F8YxiVhgtUwO2xImjf2YH0Bb8BBvRjqZv9LwcZd+i986cm1QeZO5LF4CjSeD+Ez9pAv
         arcv1P+B71YsfCIoKok/SjbFMl+GAsMsuYuh70OK+wjl65Qi5fHYU3Ba9uB/T5Bx+MLR
         FOpZ4rEaACUyiANW5Gy75fkSVbHuNot1KlerllyfkIbqH2oDvDWnGpN7SUWgBQzBQ13y
         s/lA==
X-Forwarded-Encrypted: i=1; AKwUvByK3UbRXExsQEouF2KHJZINiv5jHFM3HtetabtbEwV3PsovWByB4vf7g9tICJi0J2cwefzd3QIOmprSVy0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nbwhP5jggiwLtNL4x6kJWxtOhTAwxEEZ0hBLLyomqTwQu7+vZ0
	PMrhqfdh4qTnv2RjTkkpjAwGeqTe8trv2UJ2ZYEdqsEoZOjT8KbIMLsk
X-Gm-Gg: AYBFou3+u0l1pPGfoOqrk3BbpI5YSzqIw+8hywN6emqSlfktht5j5ALfhFS/hzLj1JR
	GVbh7rsl/CC+WHZvBiLp9d31XCv9lgjdjWbuplAkaZhwrWkQiBb6Kg7lhDH56fHcZg1vbpm8xhj
	YV7VGuNs/M8G8OH14J5R5c+VOMVB6UNAa0+2IGP3FJZycfDtur5AIKk8W5Jw6Wvzul6QYicKSsV
	YqSJWc0q7ZvYGSw2csVf4GGOMdi0zUTGSkvOVQWAWnlJSTvHx40JYAN9OKPLC1KotZqOiTohl6R
	yzqBwmuju/YUyg6b5H/vCbT993VSH4KdopJulcvucfL3IhcCI0MnP5LZxmpZyJdbcKoiR2YgX6w
	u+jDS4M4e3gO/Ui6xEds/jVe+wuayNFbq+3wNGIzQMux+YnizGe/vXj9DRqAHF6NeJgz6xBW3CI
	gC1LqHv7pNZDX5f0ogWPmZCWTnoNwJP2Qve39nv0oM3XMMByzcetrKV+jnEIcKhLIUIxElq3YGz
	kPdJC8gdN4DASyJMWKJIfp1w5BnbBkEfIouB55f7Tn+PPFHI/WUUxegEBgTbdfA56XG77/H07dC
	veyvCHYzVEPTPECfFuVYBccG/tN3oeJMLCHuW1E3q0KwNBVn6xSkhufUHuHkg5uhog==
X-Received: by 2002:a17:90b:4d87:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39b26100bfdmr6084263a91.6.1788510645492;
        Fri, 04 Sep 2026 01:30:45 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f787esm4477338eec.23.2026.09.04.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:30:44 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jakub Kicinski <kuba@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hisam Mehboob <hisamshar@gmail.com>,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Catalin Iacob <iacobcatalin@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Andrei Vagin <avagin@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wang Yan <wangyan01@kylinos.cn>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] bfs: remove the filesystem
Date: Fri,  4 Sep 2026 01:29:19 -0700
Message-ID: <20260904082954.48738-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit

BFS (not to be confused with BeFS, the BeOS filesystem) is the
filesystem UnixWare uses for its boot partition. It has extremely
limited functionality, only supporting contiguous files and no
subdirectories. Even though the bfs driver is very small and is
unlikely to cause future maintenance problems, given that the only type
of data stored on such a partition is likely to be kernels and
bootloader settings, there is very little reason anyone would want to
access it from Linux. Other old Unix filesystems (efs, freevxfs) have
been removed recently, and bfs is highly unlikely to have any users, so
remove it as well. Retain the UAPI header to be safe.

Also update the former maintainer's email address in CREDITS.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 CREDITS                                       |   2 +-
 Documentation/filesystems/befs.rst            |   4 +-
 Documentation/filesystems/bfs.rst             |  60 --
 Documentation/filesystems/index.rst           |   1 -
 MAINTAINERS                                   |   7 -
 arch/mips/configs/malta_defconfig             |   1 -
 arch/mips/configs/malta_kvm_defconfig         |   1 -
 arch/mips/configs/maltaup_xpa_defconfig       |   1 -
 arch/mips/configs/rm200_defconfig             |   1 -
 arch/powerpc/configs/fsl-emb-nonhw.config     |   1 -
 arch/powerpc/configs/ppc6xx_defconfig         |   1 -
 fs/Kconfig                                    |   1 -
 fs/Makefile                                   |   1 -
 fs/bfs/Kconfig                                |  21 -
 fs/bfs/Makefile                               |   8 -
 fs/bfs/bfs.h                                  |  69 ---
 fs/bfs/dir.c                                  | 356 ------------
 fs/bfs/file.c                                 | 203 -------
 fs/bfs/inode.c                                | 538 ------------------
 .../filesystems/statmount/statmount_test.c    |   2 +-
 20 files changed, 4 insertions(+), 1275 deletions(-)
 delete mode 100644 Documentation/filesystems/bfs.rst
 delete mode 100644 fs/bfs/Kconfig
 delete mode 100644 fs/bfs/Makefile
 delete mode 100644 fs/bfs/bfs.h
 delete mode 100644 fs/bfs/dir.c
 delete mode 100644 fs/bfs/file.c
 delete mode 100644 fs/bfs/inode.c

diff --git a/CREDITS b/CREDITS
index bba5071c29a5..c570dd7eebbd 100644
--- a/CREDITS
+++ b/CREDITS
@@ -57,7 +57,7 @@ S: Longford, Ireland
 S: Sydney, Australia
 
 N: Tigran A. Aivazian
-E: tigran@aivazian.fsnet.co.uk
+E: aivazian.tigran@gmail.com
 W: http://www.moses.uklinux.net/patches
 D: BFS filesystem
 D: Intel IA32 CPU microcode update support
diff --git a/Documentation/filesystems/befs.rst b/Documentation/filesystems/befs.rst
index a22f603b2938..c1dbfe9c95d2 100644
--- a/Documentation/filesystems/befs.rst
+++ b/Documentation/filesystems/befs.rst
@@ -44,8 +44,8 @@ implementation.
 Which is it, BFS or BEFS?
 =========================
 Be, Inc said, "BeOS Filesystem is officially called BFS, not BeFS".
-But Unixware Boot Filesystem is called bfs, too. And they are already in
-the kernel. Because of this naming conflict, on Linux the BeOS
+But the UnixWare Boot Filesystem is called bfs, too, and it was already
+in the kernel. Because of this naming conflict, on Linux the BeOS
 filesystem is called befs.
 
 How to Install
diff --git a/Documentation/filesystems/bfs.rst b/Documentation/filesystems/bfs.rst
deleted file mode 100644
index ce14b9018807..000000000000
--- a/Documentation/filesystems/bfs.rst
+++ /dev/null
@@ -1,60 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-========================
-BFS Filesystem for Linux
-========================
-
-The BFS filesystem is used by SCO UnixWare OS for the /stand slice, which
-usually contains the kernel image and a few other files required for the
-boot process.
-
-In order to access /stand partition under Linux you obviously need to
-know the partition number and the kernel must support UnixWare disk slices
-(CONFIG_UNIXWARE_DISKLABEL config option). However BFS support does not
-depend on having UnixWare disklabel support because one can also mount
-BFS filesystem via loopback::
-
-    # losetup /dev/loop0 stand.img
-    # mount -t bfs /dev/loop0 /mnt/stand
-
-where stand.img is a file containing the image of BFS filesystem.
-When you have finished using it and umounted you need to also deallocate
-/dev/loop0 device by::
-
-    # losetup -d /dev/loop0
-
-You can simplify mounting by just typing::
-
-    # mount -t bfs -o loop stand.img /mnt/stand
-
-this will allocate the first available loopback device (and load loop.o
-kernel module if necessary) automatically. If the loopback driver is not
-loaded automatically, make sure that you have compiled the module and
-that modprobe is functioning. Beware that umount will not deallocate
-/dev/loopN device if /etc/mtab file on your system is a symbolic link to
-/proc/mounts. You will need to do it manually using "-d" switch of
-losetup(8). Read losetup(8) manpage for more info.
-
-To create the BFS image under UnixWare you need to find out first which
-slice contains it. The command prtvtoc(1M) is your friend::
-
-    # prtvtoc /dev/rdsk/c0b0t0d0s0
-
-(assuming your root disk is on target=0, lun=0, bus=0, controller=0). Then you
-look for the slice with tag "STAND", which is usually slice 10. With this
-information you can use dd(1) to create the BFS image::
-
-    # umount /stand
-    # dd if=/dev/rdsk/c0b0t0d0sa of=stand.img bs=512
-
-Just in case, you can verify that you have done the right thing by checking
-the magic number::
-
-    # od -Ad -tx4 stand.img | more
-
-The first 4 bytes should be 0x1badface.
-
-If you have any patches, questions or suggestions regarding this BFS
-implementation please contact the author:
-
-Tigran Aivazian <aivazian.tigran@gmail.com>
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 734a45e51667..7cce7cc28d12 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -75,7 +75,6 @@ Documentation for filesystem implementations.
    autofs
    autofs-mount-control
    befs
-   bfs
    btrfs
    ceph
    coda
diff --git a/MAINTAINERS b/MAINTAINERS
index fc320b373656..385309556705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4627,13 +4627,6 @@ S:	Odd Fixes
 F:	Documentation/block/bfq-iosched.rst
 F:	block/bfq-*
 
-BFS FILE SYSTEM
-M:	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>
-S:	Maintained
-F:	Documentation/filesystems/bfs.rst
-F:	fs/bfs/
-F:	include/uapi/linux/bfs_fs.h
-
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 56a8f76dab41..4fb4d45f3cdc 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -333,7 +333,6 @@ CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
 CONFIG_JFFS2_FS=m
 CONFIG_JFFS2_FS_XATTR=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 85e95c0ae410..3d1c32d3475e 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -340,7 +340,6 @@ CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
 CONFIG_JFFS2_FS=m
 CONFIG_JFFS2_FS_XATTR=y
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 0498a0115349..2545168b75bb 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -339,7 +339,6 @@ CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
 CONFIG_JFFS2_FS=m
 CONFIG_JFFS2_FS_XATTR=y
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 09e006c7cd7c..cd2a831614c8 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -318,7 +318,6 @@ CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_HFS_FS=m
 CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
 CONFIG_CRAMFS=m
 CONFIG_VXFS_FS=m
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
index 391c99117ee0..688051b11ce1 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -2,7 +2,6 @@ CONFIG_ADFS_FS=m
 CONFIG_AFFS_FS=m
 CONFIG_AUDIT=y
 CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index acffc5c17f92..8aab229fb909 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -945,7 +945,6 @@ CONFIG_ECRYPT_FS=m
 CONFIG_HFS_FS=m
 CONFIG_HFSPLUS_FS=m
 CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
 CONFIG_CRAMFS=m
 CONFIG_VXFS_FS=m
diff --git a/fs/Kconfig b/fs/Kconfig
index e05917adcd60..1cb0b3a8b12c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -314,7 +314,6 @@ source "fs/ecryptfs/Kconfig"
 source "fs/hfs/Kconfig"
 source "fs/hfsplus/Kconfig"
 source "fs/befs/Kconfig"
-source "fs/bfs/Kconfig"
 source "fs/jffs2/Kconfig"
 # UBIFS File system configuration
 source "fs/ubifs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 055dfc23d82b..16f1108b64e1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -76,7 +76,6 @@ obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
 obj-$(CONFIG_EXFAT_FS)		+= exfat/
-obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
 obj-$(CONFIG_HFS_FS)		+= hfs/
diff --git a/fs/bfs/Kconfig b/fs/bfs/Kconfig
deleted file mode 100644
index 8e7ef866b62a..000000000000
--- a/fs/bfs/Kconfig
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config BFS_FS
-	tristate "BFS file system support"
-	depends on BLOCK
-	select BUFFER_HEAD
-	help
-	  Boot File System (BFS) is a file system used under SCO UnixWare to
-	  allow the bootloader access to the kernel image and other important
-	  files during the boot process.  It is usually mounted under /stand
-	  and corresponds to the slice marked as "STAND" in the UnixWare
-	  partition.  You should say Y if you want to read or write the files
-	  on your /stand slice from within Linux.  You then also need to say Y
-	  to "UnixWare slices support", below.  More information about the BFS
-	  file system is contained in the file
-	  <file:Documentation/filesystems/bfs.rst>.
-
-	  If you don't know what this is about, say N.
-
-	  To compile this as a module, choose M here: the module will be called
-	  bfs.  Note that the file system of your root partition (the one
-	  containing the directory /) cannot be compiled as a module.
diff --git a/fs/bfs/Makefile b/fs/bfs/Makefile
deleted file mode 100644
index 2b6bc5eb4de9..000000000000
--- a/fs/bfs/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for BFS filesystem.
-#
-
-obj-$(CONFIG_BFS_FS) += bfs.o
-
-bfs-objs := inode.o file.o dir.o
diff --git a/fs/bfs/bfs.h b/fs/bfs/bfs.h
deleted file mode 100644
index b08afe733e63..000000000000
--- a/fs/bfs/bfs.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	fs/bfs/bfs.h
- *	Copyright (C) 1999-2018 Tigran Aivazian <aivazian.tigran@gmail.com>
- */
-#ifndef _FS_BFS_BFS_H
-#define _FS_BFS_BFS_H
-
-#include <linux/bfs_fs.h>
-
-/* In theory BFS supports up to 512 inodes, numbered from 2 (for /) up to 513 inclusive.
-   In actual fact, attempting to create the 512th inode (i.e. inode No. 513 or file No. 511)
-   will fail with ENOSPC in bfs_add_entry(): the root directory cannot contain so many entries, counting '..'.
-   So, mkfs.bfs(8) should really limit its -N option to 511 and not 512. For now, we just print a warning
-   if a filesystem is mounted with such "impossible to fill up" number of inodes */
-#define BFS_MAX_LASTI	513
-
-/*
- * BFS file system in-core superblock info
- */
-struct bfs_sb_info {
-	unsigned long si_blocks;
-	unsigned long si_freeb;
-	unsigned long si_freei;
-	unsigned long si_lf_eblk;
-	unsigned long si_lasti;
-	DECLARE_BITMAP(si_imap, BFS_MAX_LASTI+1);
-	struct mutex bfs_lock;
-};
-
-/*
- * BFS file system in-core inode info
- */
-struct bfs_inode_info {
-	unsigned long i_dsk_ino; /* inode number from the disk, can be 0 */
-	unsigned long i_sblock;
-	unsigned long i_eblock;
-	struct mapping_metadata_bhs i_metadata_bhs;
-	struct inode vfs_inode;
-};
-
-static inline struct bfs_sb_info *BFS_SB(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
-static inline struct bfs_inode_info *BFS_I(struct inode *inode)
-{
-	return container_of(inode, struct bfs_inode_info, vfs_inode);
-}
-
-
-#define printf(format, args...) \
-	printk(KERN_ERR "BFS-fs: %s(): " format, __func__, ## args)
-
-/* inode.c */
-extern struct inode *bfs_iget(struct super_block *sb, unsigned long ino);
-extern void bfs_dump_imap(const char *, struct super_block *);
-
-/* file.c */
-extern const struct inode_operations bfs_file_inops;
-extern const struct file_operations bfs_file_operations;
-extern const struct address_space_operations bfs_aops;
-
-/* dir.c */
-extern const struct inode_operations bfs_dir_inops;
-extern const struct file_operations bfs_dir_operations;
-
-#endif /* _FS_BFS_BFS_H */
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
deleted file mode 100644
index 91a4871fa051..000000000000
--- a/fs/bfs/dir.c
+++ /dev/null
@@ -1,356 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	fs/bfs/dir.c
- *	BFS directory operations.
- *	Copyright (C) 1999-2018  Tigran Aivazian <aivazian.tigran@gmail.com>
- *  Made endianness-clean by Andrew Stribblehill <ads@wompom.org> 2005
- */
-
-#include <linux/time.h>
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/buffer_head.h>
-#include <linux/sched.h>
-#include "bfs.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define dprintf(x...)	printf(x)
-#else
-#define dprintf(x...)
-#endif
-
-static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino);
-static struct buffer_head *bfs_find_entry(struct inode *dir,
-				const struct qstr *child,
-				struct bfs_dirent **res_dir);
-
-static int bfs_readdir(struct file *f, struct dir_context *ctx)
-{
-	struct inode *dir = file_inode(f);
-	struct buffer_head *bh;
-	struct bfs_dirent *de;
-	unsigned int offset;
-	int block;
-
-	if (ctx->pos & (BFS_DIRENT_SIZE - 1)) {
-		printf("Bad f_pos=%08lx for %s:%08llx\n",
-					(unsigned long)ctx->pos,
-					dir->i_sb->s_id, dir->i_ino);
-		return -EINVAL;
-	}
-
-	while (ctx->pos < dir->i_size) {
-		offset = ctx->pos & (BFS_BSIZE - 1);
-		block = BFS_I(dir)->i_sblock + (ctx->pos >> BFS_BSIZE_BITS);
-		bh = sb_bread(dir->i_sb, block);
-		if (!bh) {
-			ctx->pos += BFS_BSIZE - offset;
-			continue;
-		}
-		do {
-			de = (struct bfs_dirent *)(bh->b_data + offset);
-			if (de->ino) {
-				int size = strnlen(de->name, BFS_NAMELEN);
-				if (!dir_emit(ctx, de->name, size,
-						le16_to_cpu(de->ino),
-						DT_UNKNOWN)) {
-					brelse(bh);
-					return 0;
-				}
-			}
-			offset += BFS_DIRENT_SIZE;
-			ctx->pos += BFS_DIRENT_SIZE;
-		} while ((offset < BFS_BSIZE) && (ctx->pos < dir->i_size));
-		brelse(bh);
-	}
-	return 0;
-}
-
-const struct file_operations bfs_dir_operations = {
-	.read		= generic_read_dir,
-	.iterate_shared	= bfs_readdir,
-	.fsync		= simple_fsync,
-	.llseek		= generic_file_llseek,
-};
-
-static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
-{
-	int err;
-	struct inode *inode;
-	struct super_block *s = dir->i_sb;
-	struct bfs_sb_info *info = BFS_SB(s);
-	unsigned long ino;
-
-	inode = new_inode(s);
-	if (!inode)
-		return -ENOMEM;
-	mutex_lock(&info->bfs_lock);
-	ino = find_first_zero_bit(info->si_imap, info->si_lasti + 1);
-	if (ino > info->si_lasti) {
-		mutex_unlock(&info->bfs_lock);
-		iput(inode);
-		return -ENOSPC;
-	}
-	set_bit(ino, info->si_imap);
-	info->si_freei--;
-	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
-	simple_inode_init_ts(inode);
-	inode->i_blocks = 0;
-	inode->i_op = &bfs_file_inops;
-	inode->i_fop = &bfs_file_operations;
-	inode->i_mapping->a_ops = &bfs_aops;
-	inode->i_ino = ino;
-	BFS_I(inode)->i_dsk_ino = ino;
-	BFS_I(inode)->i_sblock = 0;
-	BFS_I(inode)->i_eblock = 0;
-	insert_inode_hash(inode);
-        mark_inode_dirty(inode);
-	bfs_dump_imap("create", s);
-
-	err = bfs_add_entry(dir, &dentry->d_name, inode->i_ino);
-	if (err) {
-		inode_dec_link_count(inode);
-		mutex_unlock(&info->bfs_lock);
-		iput(inode);
-		return err;
-	}
-	mutex_unlock(&info->bfs_lock);
-	d_instantiate(dentry, inode);
-	return 0;
-}
-
-static struct dentry *bfs_lookup(struct inode *dir, struct dentry *dentry,
-						unsigned int flags)
-{
-	struct inode *inode = NULL;
-	struct buffer_head *bh;
-	struct bfs_dirent *de;
-	struct bfs_sb_info *info = BFS_SB(dir->i_sb);
-
-	if (dentry->d_name.len > BFS_NAMELEN)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	mutex_lock(&info->bfs_lock);
-	bh = bfs_find_entry(dir, &dentry->d_name, &de);
-	if (bh) {
-		unsigned long ino = (unsigned long)le16_to_cpu(de->ino);
-		brelse(bh);
-		inode = bfs_iget(dir->i_sb, ino);
-	}
-	mutex_unlock(&info->bfs_lock);
-	return d_splice_alias(inode, dentry);
-}
-
-static int bfs_link(struct dentry *old, struct inode *dir,
-						struct dentry *new)
-{
-	struct inode *inode = d_inode(old);
-	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
-	int err;
-
-	mutex_lock(&info->bfs_lock);
-	err = bfs_add_entry(dir, &new->d_name, inode->i_ino);
-	if (err) {
-		mutex_unlock(&info->bfs_lock);
-		return err;
-	}
-	inc_nlink(inode);
-	inode_set_ctime_current(inode);
-	mark_inode_dirty(inode);
-	ihold(inode);
-	d_instantiate(new, inode);
-	mutex_unlock(&info->bfs_lock);
-	return 0;
-}
-
-static int bfs_unlink(struct inode *dir, struct dentry *dentry)
-{
-	int error = -ENOENT;
-	struct inode *inode = d_inode(dentry);
-	struct buffer_head *bh;
-	struct bfs_dirent *de;
-	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
-
-	mutex_lock(&info->bfs_lock);
-	bh = bfs_find_entry(dir, &dentry->d_name, &de);
-	if (!bh || (le16_to_cpu(de->ino) != inode->i_ino))
-		goto out_brelse;
-
-	if (!inode->i_nlink) {
-		printf("unlinking non-existent file %s:%llu (nlink=%d)\n",
-					inode->i_sb->s_id, inode->i_ino,
-					inode->i_nlink);
-		set_nlink(inode, 1);
-	}
-	de->ino = 0;
-	mmb_mark_buffer_dirty(bh, &BFS_I(dir)->i_metadata_bhs);
-	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	mark_inode_dirty(dir);
-	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
-	inode_dec_link_count(inode);
-	error = 0;
-
-out_brelse:
-	brelse(bh);
-	mutex_unlock(&info->bfs_lock);
-	return error;
-}
-
-static int bfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
-		      struct dentry *old_dentry, struct inode *new_dir,
-		      struct dentry *new_dentry, unsigned int flags)
-{
-	struct inode *old_inode, *new_inode;
-	struct buffer_head *old_bh, *new_bh;
-	struct bfs_dirent *old_de, *new_de;
-	struct bfs_sb_info *info;
-	int error = -ENOENT;
-
-	if (flags & ~RENAME_NOREPLACE)
-		return -EINVAL;
-
-	old_bh = new_bh = NULL;
-	old_inode = d_inode(old_dentry);
-	if (S_ISDIR(old_inode->i_mode))
-		return -EINVAL;
-
-	info = BFS_SB(old_inode->i_sb);
-
-	mutex_lock(&info->bfs_lock);
-	old_bh = bfs_find_entry(old_dir, &old_dentry->d_name, &old_de);
-
-	if (!old_bh || (le16_to_cpu(old_de->ino) != old_inode->i_ino))
-		goto end_rename;
-
-	error = -EPERM;
-	new_inode = d_inode(new_dentry);
-	new_bh = bfs_find_entry(new_dir, &new_dentry->d_name, &new_de);
-
-	if (new_bh && !new_inode) {
-		brelse(new_bh);
-		new_bh = NULL;
-	}
-	if (!new_bh) {
-		error = bfs_add_entry(new_dir, &new_dentry->d_name,
-					old_inode->i_ino);
-		if (error)
-			goto end_rename;
-	}
-	old_de->ino = 0;
-	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
-	mark_inode_dirty(old_dir);
-	if (new_inode) {
-		inode_set_ctime_current(new_inode);
-		inode_dec_link_count(new_inode);
-	}
-	mmb_mark_buffer_dirty(old_bh, &BFS_I(old_dir)->i_metadata_bhs);
-	error = 0;
-
-end_rename:
-	mutex_unlock(&info->bfs_lock);
-	brelse(old_bh);
-	brelse(new_bh);
-	return error;
-}
-
-const struct inode_operations bfs_dir_inops = {
-	.create			= bfs_create,
-	.lookup			= bfs_lookup,
-	.link			= bfs_link,
-	.unlink			= bfs_unlink,
-	.rename			= bfs_rename,
-};
-
-static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
-{
-	const unsigned char *name = child->name;
-	int namelen = child->len;
-	struct buffer_head *bh;
-	struct bfs_dirent *de;
-	int block, sblock, eblock, off, pos;
-	int i;
-
-	dprintf("name=%s, namelen=%d\n", name, namelen);
-
-	sblock = BFS_I(dir)->i_sblock;
-	eblock = BFS_I(dir)->i_eblock;
-	for (block = sblock; block <= eblock; block++) {
-		bh = sb_bread(dir->i_sb, block);
-		if (!bh)
-			return -EIO;
-		for (off = 0; off < BFS_BSIZE; off += BFS_DIRENT_SIZE) {
-			de = (struct bfs_dirent *)(bh->b_data + off);
-			if (!de->ino) {
-				pos = (block - sblock) * BFS_BSIZE + off;
-				if (pos >= dir->i_size) {
-					dir->i_size += BFS_DIRENT_SIZE;
-					inode_set_ctime_current(dir);
-				}
-				inode_set_mtime_to_ts(dir,
-						      inode_set_ctime_current(dir));
-				mark_inode_dirty(dir);
-				de->ino = cpu_to_le16((u16)ino);
-				for (i = 0; i < BFS_NAMELEN; i++)
-					de->name[i] =
-						(i < namelen) ? name[i] : 0;
-				mmb_mark_buffer_dirty(bh,
-						&BFS_I(dir)->i_metadata_bhs);
-				brelse(bh);
-				return 0;
-			}
-		}
-		brelse(bh);
-	}
-	return -ENOSPC;
-}
-
-static inline int bfs_namecmp(int len, const unsigned char *name,
-							const char *buffer)
-{
-	if ((len < BFS_NAMELEN) && buffer[len])
-		return 0;
-	return !memcmp(name, buffer, len);
-}
-
-static struct buffer_head *bfs_find_entry(struct inode *dir,
-			const struct qstr *child,
-			struct bfs_dirent **res_dir)
-{
-	unsigned long block = 0, offset = 0;
-	struct buffer_head *bh = NULL;
-	struct bfs_dirent *de;
-	const unsigned char *name = child->name;
-	int namelen = child->len;
-
-	*res_dir = NULL;
-	if (namelen > BFS_NAMELEN)
-		return NULL;
-
-	while (block * BFS_BSIZE + offset < dir->i_size) {
-		if (!bh) {
-			bh = sb_bread(dir->i_sb, BFS_I(dir)->i_sblock + block);
-			if (!bh) {
-				block++;
-				continue;
-			}
-		}
-		de = (struct bfs_dirent *)(bh->b_data + offset);
-		offset += BFS_DIRENT_SIZE;
-		if (le16_to_cpu(de->ino) &&
-				bfs_namecmp(namelen, name, de->name)) {
-			*res_dir = de;
-			return bh;
-		}
-		if (offset < bh->b_size)
-			continue;
-		brelse(bh);
-		bh = NULL;
-		offset = 0;
-		block++;
-	}
-	brelse(bh);
-	return NULL;
-}
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
deleted file mode 100644
index d33d6bde992b..000000000000
--- a/fs/bfs/file.c
+++ /dev/null
@@ -1,203 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	fs/bfs/file.c
- *	BFS file operations.
- *	Copyright (C) 1999-2018 Tigran Aivazian <aivazian.tigran@gmail.com>
- *
- *	Make the file block allocation algorithm understand the size
- *	of the underlying block device.
- *	Copyright (C) 2007 Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
- *
- */
-
-#include <linux/fs.h>
-#include <linux/mpage.h>
-#include <linux/buffer_head.h>
-#include "bfs.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define dprintf(x...)	printf(x)
-#else
-#define dprintf(x...)
-#endif
-
-const struct file_operations bfs_file_operations = {
-	.llseek 	= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
-	.mmap_prepare	= generic_file_mmap_prepare,
-	.splice_read	= filemap_splice_read,
-};
-
-static int bfs_move_block(unsigned long from, unsigned long to,
-					struct super_block *sb)
-{
-	struct buffer_head *bh, *new;
-
-	bh = sb_bread(sb, from);
-	if (!bh)
-		return -EIO;
-	new = sb_getblk(sb, to);
-	memcpy(new->b_data, bh->b_data, bh->b_size);
-	mark_buffer_dirty(new);
-	bforget(bh);
-	brelse(new);
-	return 0;
-}
-
-static int bfs_move_blocks(struct super_block *sb, unsigned long start,
-				unsigned long end, unsigned long where)
-{
-	unsigned long i;
-
-	dprintf("%08lx-%08lx->%08lx\n", start, end, where);
-	for (i = start; i <= end; i++)
-		if(bfs_move_block(i, where + i, sb)) {
-			dprintf("failed to move block %08lx -> %08lx\n", i,
-								where + i);
-			return -EIO;
-		}
-	return 0;
-}
-
-static int bfs_get_block(struct inode *inode, sector_t block,
-			struct buffer_head *bh_result, int create)
-{
-	unsigned long phys;
-	int err;
-	struct super_block *sb = inode->i_sb;
-	struct bfs_sb_info *info = BFS_SB(sb);
-	struct bfs_inode_info *bi = BFS_I(inode);
-
-	phys = bi->i_sblock + block;
-	if (!create) {
-		if (phys <= bi->i_eblock) {
-			dprintf("c=%d, b=%08lx, phys=%09lx (granted)\n",
-                                create, (unsigned long)block, phys);
-			map_bh(bh_result, sb, phys);
-		}
-		return 0;
-	}
-
-	/*
-	 * If the file is not empty and the requested block is within the
-	 * range of blocks allocated for this file, we can grant it.
-	 */
-	if (bi->i_sblock && (phys <= bi->i_eblock)) {
-		dprintf("c=%d, b=%08lx, phys=%08lx (interim block granted)\n", 
-				create, (unsigned long)block, phys);
-		map_bh(bh_result, sb, phys);
-		return 0;
-	}
-
-	/* The file will be extended, so let's see if there is enough space. */
-	if (phys >= info->si_blocks)
-		return -ENOSPC;
-
-	/* The rest has to be protected against itself. */
-	mutex_lock(&info->bfs_lock);
-
-	/*
-	 * If the last data block for this file is the last allocated
-	 * block, we can extend the file trivially, without moving it
-	 * anywhere.
-	 */
-	if (bi->i_eblock == info->si_lf_eblk) {
-		dprintf("c=%d, b=%08lx, phys=%08lx (simple extension)\n", 
-				create, (unsigned long)block, phys);
-		map_bh(bh_result, sb, phys);
-		info->si_freeb -= phys - bi->i_eblock;
-		info->si_lf_eblk = bi->i_eblock = phys;
-		mark_inode_dirty(inode);
-		err = 0;
-		goto out;
-	}
-
-	/* Ok, we have to move this entire file to the next free block. */
-	phys = info->si_lf_eblk + 1;
-	if (phys + block >= info->si_blocks) {
-		err = -ENOSPC;
-		goto out;
-	}
-
-	if (bi->i_sblock) {
-		err = bfs_move_blocks(inode->i_sb, bi->i_sblock, 
-						bi->i_eblock, phys);
-		if (err) {
-			dprintf("failed to move ino=%08lx -> fs corruption\n",
-								inode->i_ino);
-			goto out;
-		}
-	} else
-		err = 0;
-
-	dprintf("c=%d, b=%08lx, phys=%08lx (moved)\n",
-                create, (unsigned long)block, phys);
-	bi->i_sblock = phys;
-	phys += block;
-	info->si_lf_eblk = bi->i_eblock = phys;
-
-	/*
-	 * This assumes nothing can write the inode back while we are here
-	 * and thus update inode->i_blocks! (XXX)
-	 */
-	info->si_freeb -= bi->i_eblock - bi->i_sblock + 1 - inode->i_blocks;
-	mark_inode_dirty(inode);
-	map_bh(bh_result, sb, phys);
-out:
-	mutex_unlock(&info->bfs_lock);
-	return err;
-}
-
-static int bfs_writepages(struct address_space *mapping,
-		struct writeback_control *wbc)
-{
-	return mpage_writepages(mapping, wbc, bfs_get_block);
-}
-
-static int bfs_read_folio(struct file *file, struct folio *folio)
-{
-	return block_read_full_folio(folio, bfs_get_block);
-}
-
-static void bfs_write_failed(struct address_space *mapping, loff_t to)
-{
-	struct inode *inode = mapping->host;
-
-	if (to > inode->i_size)
-		truncate_pagecache(inode, inode->i_size);
-}
-
-static int bfs_write_begin(const struct kiocb *iocb,
-			   struct address_space *mapping,
-			   loff_t pos, unsigned len,
-			   struct folio **foliop, void **fsdata)
-{
-	int ret;
-
-	ret = block_write_begin(mapping, pos, len, foliop, bfs_get_block);
-	if (unlikely(ret))
-		bfs_write_failed(mapping, pos + len);
-
-	return ret;
-}
-
-static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
-{
-	return generic_block_bmap(mapping, block, bfs_get_block);
-}
-
-const struct address_space_operations bfs_aops = {
-	.dirty_folio	= block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
-	.read_folio	= bfs_read_folio,
-	.writepages	= bfs_writepages,
-	.write_begin	= bfs_write_begin,
-	.write_end	= generic_write_end,
-	.migrate_folio	= buffer_migrate_folio,
-	.bmap		= bfs_bmap,
-};
-
-const struct inode_operations bfs_file_inops;
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
deleted file mode 100644
index 06e3a848b4ef..000000000000
--- a/fs/bfs/inode.c
+++ /dev/null
@@ -1,538 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *	fs/bfs/inode.c
- *	BFS superblock and inode operations.
- *	Copyright (C) 1999-2018 Tigran Aivazian <aivazian.tigran@gmail.com>
- *	From fs/minix, Copyright (C) 1991, 1992 Linus Torvalds.
- *	Made endianness-clean by Andrew Stribblehill <ads@wompom.org>, 2005.
- */
-
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/buffer_head.h>
-#include <linux/vfs.h>
-#include <linux/writeback.h>
-#include <linux/uio.h>
-#include <linux/uaccess.h>
-#include <linux/fs_context.h>
-#include "bfs.h"
-
-MODULE_AUTHOR("Tigran Aivazian <aivazian.tigran@gmail.com>");
-MODULE_DESCRIPTION("SCO UnixWare BFS filesystem for Linux");
-MODULE_LICENSE("GPL");
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define dprintf(x...)	printf(x)
-#else
-#define dprintf(x...)
-#endif
-
-struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
-{
-	struct bfs_inode *di;
-	struct inode *inode;
-	struct buffer_head *bh;
-	int block, off;
-
-	inode = iget_locked(sb, ino);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
-	if (!(inode_state_read_once(inode) & I_NEW))
-		return inode;
-
-	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(inode->i_sb)->si_lasti)) {
-		printf("Bad inode number %s:%08lx\n", inode->i_sb->s_id, ino);
-		goto error;
-	}
-
-	block = (ino - BFS_ROOT_INO) / BFS_INODES_PER_BLOCK + 1;
-	bh = sb_bread(inode->i_sb, block);
-	if (!bh) {
-		printf("Unable to read inode %s:%08lx\n", inode->i_sb->s_id,
-									ino);
-		goto error;
-	}
-
-	off = (ino - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
-	di = (struct bfs_inode *)bh->b_data + off;
-
-	/*
-	 * https://martin.hinner.info/fs/bfs/bfs-structure.html explains that
-	 * BFS in SCO UnixWare environment used only lower 9 bits of di->i_mode
-	 * value. This means that, although bfs_write_inode() saves whole
-	 * inode->i_mode bits (which include S_IFMT bits and S_IS{UID,GID,VTX}
-	 * bits), middle 7 bits of di->i_mode value can be garbage when these
-	 * bits were not saved by bfs_write_inode().
-	 * Since we can't tell whether middle 7 bits are garbage, use only
-	 * lower 12 bits (i.e. tolerate S_IS{UID,GID,VTX} bits possibly being
-	 * garbage) and reconstruct S_IFMT bits for Linux environment from
-	 * di->i_vtype value.
-	 */
-	inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);
-	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
-		inode->i_mode |= S_IFDIR;
-		inode->i_op = &bfs_dir_inops;
-		inode->i_fop = &bfs_dir_operations;
-	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG) {
-		inode->i_mode |= S_IFREG;
-		inode->i_op = &bfs_file_inops;
-		inode->i_fop = &bfs_file_operations;
-		inode->i_mapping->a_ops = &bfs_aops;
-	} else {
-		brelse(bh);
-		printf("Unknown vtype=%u %s:%08lx\n",
-		       le32_to_cpu(di->i_vtype), inode->i_sb->s_id, ino);
-		goto error;
-	}
-
-	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
-	BFS_I(inode)->i_eblock =  le32_to_cpu(di->i_eblock);
-	BFS_I(inode)->i_dsk_ino = le16_to_cpu(di->i_ino);
-	i_uid_write(inode, le32_to_cpu(di->i_uid));
-	i_gid_write(inode,  le32_to_cpu(di->i_gid));
-	set_nlink(inode, le32_to_cpu(di->i_nlink));
-	inode->i_size = BFS_FILESIZE(di);
-	inode->i_blocks = BFS_FILEBLOCKS(di);
-	inode_set_atime(inode, le32_to_cpu(di->i_atime), 0);
-	inode_set_mtime(inode, le32_to_cpu(di->i_mtime), 0);
-	inode_set_ctime(inode, le32_to_cpu(di->i_ctime), 0);
-
-	brelse(bh);
-	unlock_new_inode(inode);
-	return inode;
-
-error:
-	iget_failed(inode);
-	return ERR_PTR(-EIO);
-}
-
-static struct bfs_inode *find_inode(struct super_block *sb, u16 ino, struct buffer_head **p)
-{
-	if ((ino < BFS_ROOT_INO) || (ino > BFS_SB(sb)->si_lasti)) {
-		printf("Bad inode number %s:%08x\n", sb->s_id, ino);
-		return ERR_PTR(-EIO);
-	}
-
-	ino -= BFS_ROOT_INO;
-
-	*p = sb_bread(sb, 1 + ino / BFS_INODES_PER_BLOCK);
-	if (!*p) {
-		printf("Unable to read inode %s:%08x\n", sb->s_id, ino);
-		return ERR_PTR(-EIO);
-	}
-
-	return (struct bfs_inode *)(*p)->b_data +  ino % BFS_INODES_PER_BLOCK;
-}
-
-static int bfs_write_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	struct bfs_sb_info *info = BFS_SB(inode->i_sb);
-	unsigned int ino = (u16)inode->i_ino;
-	unsigned long i_sblock;
-	struct bfs_inode *di;
-	struct buffer_head *bh;
-
-	dprintf("ino=%08x\n", ino);
-
-	di = find_inode(inode->i_sb, ino, &bh);
-	if (IS_ERR(di))
-		return PTR_ERR(di);
-
-	mutex_lock(&info->bfs_lock);
-
-	if (ino == BFS_ROOT_INO)
-		di->i_vtype = cpu_to_le32(BFS_VDIR);
-	else
-		di->i_vtype = cpu_to_le32(BFS_VREG);
-
-	di->i_ino = cpu_to_le16(ino);
-	di->i_mode = cpu_to_le32(inode->i_mode);
-	di->i_uid = cpu_to_le32(i_uid_read(inode));
-	di->i_gid = cpu_to_le32(i_gid_read(inode));
-	di->i_nlink = cpu_to_le32(inode->i_nlink);
-	di->i_atime = cpu_to_le32(inode_get_atime_sec(inode));
-	di->i_mtime = cpu_to_le32(inode_get_mtime_sec(inode));
-	di->i_ctime = cpu_to_le32(inode_get_ctime_sec(inode));
-	i_sblock = BFS_I(inode)->i_sblock;
-	di->i_sblock = cpu_to_le32(i_sblock);
-	di->i_eblock = cpu_to_le32(BFS_I(inode)->i_eblock);
-	di->i_eoffset = cpu_to_le32(i_sblock * BFS_BSIZE + inode->i_size - 1);
-
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	mutex_unlock(&info->bfs_lock);
-	set_inode_metadata_writeback(inode);
-	return 0;
-}
-
-static int bfs_sync_inode_metadata(struct inode *inode,
-				   struct writeback_control *wbc)
-{
-	int err = 0;
-	struct bfs_inode *di;
-	struct buffer_head *bh;
-
-	di = find_inode(inode->i_sb, (u16)inode->i_ino, &bh);
-	if (IS_ERR(di))
-		return PTR_ERR(di);
-
-	sync_dirty_buffer(bh);
-	if (buffer_write_io_error(bh)) {
-		err = -EIO;
-		goto out;
-	}
-	err = mmb_sync(&BFS_I(inode)->i_metadata_bhs);
-out:
-	brelse(bh);
-	return err;
-}
-
-static void bfs_evict_inode(struct inode *inode)
-{
-	unsigned long ino = inode->i_ino;
-	struct bfs_inode *di;
-	struct buffer_head *bh;
-	struct super_block *s = inode->i_sb;
-	struct bfs_sb_info *info = BFS_SB(s);
-	struct bfs_inode_info *bi = BFS_I(inode);
-
-	dprintf("ino=%08lx\n", ino);
-
-	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_nlink)
-		mmb_sync(&BFS_I(inode)->i_metadata_bhs);
-	mmb_invalidate(&BFS_I(inode)->i_metadata_bhs);
-	clear_inode(inode);
-
-	if (inode->i_nlink)
-		return;
-
-	di = find_inode(s, inode->i_ino, &bh);
-	if (IS_ERR(di))
-		return;
-
-	mutex_lock(&info->bfs_lock);
-	/* clear on-disk inode */
-	memset(di, 0, sizeof(struct bfs_inode));
-	mark_buffer_dirty(bh);
-	brelse(bh);
-
-	if (bi->i_dsk_ino) {
-		if (bi->i_sblock)
-			info->si_freeb += bi->i_eblock + 1 - bi->i_sblock;
-		info->si_freei++;
-		clear_bit(ino, info->si_imap);
-		bfs_dump_imap("evict_inode", s);
-	}
-
-	/*
-	 * If this was the last file, make the previous block
-	 * "last block of the last file" even if there is no
-	 * real file there, saves us 1 gap.
-	 */
-	if (info->si_lf_eblk == bi->i_eblock)
-		info->si_lf_eblk = bi->i_sblock - 1;
-	mutex_unlock(&info->bfs_lock);
-}
-
-static void bfs_put_super(struct super_block *s)
-{
-	struct bfs_sb_info *info = BFS_SB(s);
-
-	if (!info)
-		return;
-
-	mutex_destroy(&info->bfs_lock);
-	kfree(info);
-	s->s_fs_info = NULL;
-}
-
-static int bfs_statfs(struct dentry *dentry, struct kstatfs *buf)
-{
-	struct super_block *s = dentry->d_sb;
-	struct bfs_sb_info *info = BFS_SB(s);
-	u64 id = huge_encode_dev(s->s_bdev->bd_dev);
-	buf->f_type = BFS_MAGIC;
-	buf->f_bsize = s->s_blocksize;
-	buf->f_blocks = info->si_blocks;
-	buf->f_bfree = buf->f_bavail = info->si_freeb;
-	buf->f_files = info->si_lasti + 1 - BFS_ROOT_INO;
-	buf->f_ffree = info->si_freei;
-	buf->f_fsid = u64_to_fsid(id);
-	buf->f_namelen = BFS_NAMELEN;
-	return 0;
-}
-
-static struct kmem_cache *bfs_inode_cachep;
-
-static struct inode *bfs_alloc_inode(struct super_block *sb)
-{
-	struct bfs_inode_info *bi;
-	bi = alloc_inode_sb(sb, bfs_inode_cachep, GFP_KERNEL);
-	if (!bi)
-		return NULL;
-	mmb_init(&bi->i_metadata_bhs, &bi->vfs_inode.i_data);
-
-	return &bi->vfs_inode;
-}
-
-static void bfs_free_inode(struct inode *inode)
-{
-	kmem_cache_free(bfs_inode_cachep, BFS_I(inode));
-}
-
-static void init_once(void *foo)
-{
-	struct bfs_inode_info *bi = foo;
-
-	inode_init_once(&bi->vfs_inode);
-}
-
-static int __init init_inodecache(void)
-{
-	bfs_inode_cachep = kmem_cache_create("bfs_inode_cache",
-					     sizeof(struct bfs_inode_info),
-					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_ACCOUNT),
-					     init_once);
-	if (bfs_inode_cachep == NULL)
-		return -ENOMEM;
-	return 0;
-}
-
-static void destroy_inodecache(void)
-{
-	/*
-	 * Make sure all delayed rcu free inodes are flushed before we
-	 * destroy cache.
-	 */
-	rcu_barrier();
-	kmem_cache_destroy(bfs_inode_cachep);
-}
-
-static const struct super_operations bfs_sops = {
-	.alloc_inode	= bfs_alloc_inode,
-	.free_inode	= bfs_free_inode,
-	.write_inode	= bfs_write_inode,
-	.sync_inode_metadata = bfs_sync_inode_metadata,
-	.evict_inode	= bfs_evict_inode,
-	.put_super	= bfs_put_super,
-	.statfs		= bfs_statfs,
-};
-
-void bfs_dump_imap(const char *prefix, struct super_block *s)
-{
-#ifdef DEBUG
-	int i;
-	char *tmpbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
-
-	if (!tmpbuf)
-		return;
-	for (i = BFS_SB(s)->si_lasti; i >= 0; i--) {
-		if (i > PAGE_SIZE - 100) break;
-		if (test_bit(i, BFS_SB(s)->si_imap))
-			strcat(tmpbuf, "1");
-		else
-			strcat(tmpbuf, "0");
-	}
-	printf("%s: lasti=%08lx <%s>\n", prefix, BFS_SB(s)->si_lasti, tmpbuf);
-	kfree(tmpbuf);
-#endif
-}
-
-static int bfs_fill_super(struct super_block *s, struct fs_context *fc)
-{
-	struct buffer_head *bh, *sbh;
-	struct bfs_super_block *bfs_sb;
-	struct inode *inode;
-	unsigned i;
-	struct bfs_sb_info *info;
-	int ret = -EINVAL;
-	unsigned long i_sblock, i_eblock, i_eoff, s_size;
-	int silent = fc->sb_flags & SB_SILENT;
-
-	info = kzalloc_obj(*info);
-	if (!info)
-		return -ENOMEM;
-	mutex_init(&info->bfs_lock);
-	s->s_fs_info = info;
-	s->s_time_min = 0;
-	s->s_time_max = U32_MAX;
-
-	if (!sb_set_blocksize(s, BFS_BSIZE))
-		goto out;
-
-	sbh = sb_bread(s, 0);
-	if (!sbh)
-		goto out;
-	bfs_sb = (struct bfs_super_block *)sbh->b_data;
-	if (le32_to_cpu(bfs_sb->s_magic) != BFS_MAGIC) {
-		if (!silent)
-			printf("No BFS filesystem on %s (magic=%08x)\n", s->s_id,  le32_to_cpu(bfs_sb->s_magic));
-		goto out1;
-	}
-	if (BFS_UNCLEAN(bfs_sb, s) && !silent)
-		printf("%s is unclean, continuing\n", s->s_id);
-
-	s->s_magic = BFS_MAGIC;
-
-	if (le32_to_cpu(bfs_sb->s_start) > le32_to_cpu(bfs_sb->s_end) ||
-	    le32_to_cpu(bfs_sb->s_start) < sizeof(struct bfs_super_block) + sizeof(struct bfs_dirent)) {
-		printf("Superblock is corrupted on %s\n", s->s_id);
-		goto out1;
-	}
-
-	info->si_lasti = (le32_to_cpu(bfs_sb->s_start) - BFS_BSIZE) / sizeof(struct bfs_inode) + BFS_ROOT_INO - 1;
-	if (info->si_lasti == BFS_MAX_LASTI)
-		printf("NOTE: filesystem %s was created with 512 inodes, the real maximum is 511, mounting anyway\n", s->s_id);
-	else if (info->si_lasti > BFS_MAX_LASTI) {
-		printf("Impossible last inode number %lu > %d on %s\n", info->si_lasti, BFS_MAX_LASTI, s->s_id);
-		goto out1;
-	}
-	for (i = 0; i < BFS_ROOT_INO; i++)
-		set_bit(i, info->si_imap);
-
-	s->s_op = &bfs_sops;
-	inode = bfs_iget(s, BFS_ROOT_INO);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		goto out1;
-	}
-	s->s_root = d_make_root(inode);
-	if (!s->s_root) {
-		ret = -ENOMEM;
-		goto out1;
-	}
-
-	info->si_blocks = (le32_to_cpu(bfs_sb->s_end) + 1) >> BFS_BSIZE_BITS;
-	info->si_freeb = (le32_to_cpu(bfs_sb->s_end) + 1 - le32_to_cpu(bfs_sb->s_start)) >> BFS_BSIZE_BITS;
-	info->si_freei = 0;
-	info->si_lf_eblk = 0;
-
-	/* can we read the last block? */
-	bh = sb_bread(s, info->si_blocks - 1);
-	if (!bh) {
-		printf("Last block not available on %s: %lu\n", s->s_id, info->si_blocks - 1);
-		ret = -EIO;
-		goto out2;
-	}
-	brelse(bh);
-
-	bh = NULL;
-	for (i = BFS_ROOT_INO; i <= info->si_lasti; i++) {
-		struct bfs_inode *di;
-		int block = (i - BFS_ROOT_INO) / BFS_INODES_PER_BLOCK + 1;
-		int off = (i - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
-		unsigned long eblock;
-
-		if (!off) {
-			brelse(bh);
-			bh = sb_bread(s, block);
-		}
-
-		if (!bh)
-			continue;
-
-		di = (struct bfs_inode *)bh->b_data + off;
-
-		/* test if filesystem is not corrupted */
-
-		i_eoff = le32_to_cpu(di->i_eoffset);
-		i_sblock = le32_to_cpu(di->i_sblock);
-		i_eblock = le32_to_cpu(di->i_eblock);
-		s_size = le32_to_cpu(bfs_sb->s_end);
-
-		if (i_sblock > info->si_blocks ||
-			i_eblock > info->si_blocks ||
-			i_sblock > i_eblock ||
-			(i_eoff != le32_to_cpu(-1) && i_eoff > s_size) ||
-			i_sblock * BFS_BSIZE > i_eoff) {
-
-			printf("Inode 0x%08x corrupted on %s\n", i, s->s_id);
-
-			brelse(bh);
-			ret = -EIO;
-			goto out2;
-		}
-
-		if (!di->i_ino) {
-			info->si_freei++;
-			continue;
-		}
-		set_bit(i, info->si_imap);
-		info->si_freeb -= BFS_FILEBLOCKS(di);
-
-		eblock =  le32_to_cpu(di->i_eblock);
-		if (eblock > info->si_lf_eblk)
-			info->si_lf_eblk = eblock;
-	}
-	brelse(bh);
-	brelse(sbh);
-	bfs_dump_imap("fill_super", s);
-	return 0;
-
-out2:
-	dput(s->s_root);
-	s->s_root = NULL;
-out1:
-	brelse(sbh);
-out:
-	mutex_destroy(&info->bfs_lock);
-	kfree(info);
-	s->s_fs_info = NULL;
-	return ret;
-}
-
-static int bfs_get_tree(struct fs_context *fc)
-{
-	return get_tree_bdev(fc, bfs_fill_super);
-}
-
-static const struct fs_context_operations bfs_context_ops = {
-	.get_tree = bfs_get_tree,
-};
-
-static int bfs_init_fs_context(struct fs_context *fc)
-{
-	fc->ops = &bfs_context_ops;
-
-	return 0;
-}
-
-static struct file_system_type bfs_fs_type = {
-	.owner			= THIS_MODULE,
-	.name			= "bfs",
-	.init_fs_context	= bfs_init_fs_context,
-	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV,
-};
-MODULE_ALIAS_FS("bfs");
-
-static int __init init_bfs_fs(void)
-{
-	int err = init_inodecache();
-	if (err)
-		goto out1;
-	err = register_filesystem(&bfs_fs_type);
-	if (err)
-		goto out;
-	return 0;
-out:
-	destroy_inodecache();
-out1:
-	return err;
-}
-
-static void __exit exit_bfs_fs(void)
-{
-	unregister_filesystem(&bfs_fs_type);
-	destroy_inodecache();
-}
-
-module_init(init_bfs_fs)
-module_exit(exit_bfs_fs)
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index 60c2c544db6a..52544512edc7 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -17,7 +17,7 @@
 
 static const char *const known_fs[] = {
 	"9p", "adfs", "affs", "afs", "aio", "anon_inodefs", "apparmorfs",
-	"autofs", "bcachefs", "bdev", "befs", "bfs", "binder", "binfmt_misc",
+	"autofs", "bcachefs", "bdev", "befs", "binder", "binfmt_misc",
 	"bpf", "btrfs", "btrfs_test_fs", "ceph", "cgroup", "cgroup2", "cifs",
 	"coda", "configfs", "cpuset", "cramfs", "cxl", "dax", "debugfs",
 	"devpts", "devtmpfs", "dmabuf", "drm", "ecryptfs", "efivarfs", "efs",
-- 
2.43.0


