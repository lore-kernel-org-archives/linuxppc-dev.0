Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D2606A330
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkxlDIKP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL36y66qTz2xN4;
	Fri, 06 Nov 2026 00:28:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793853663;
	cv=none; b=ka8+pLjudEWxWCkNbXB/sKZH3xaP7XJ6hVvzv9C2yv4k57KncbzFwEV1DBw+JolZLbtK3nNBbaPi5B7xXjoUnfFIeOfFQdEk/y6pzJyL75rWcxU3OhJckycZEhceC5xwh6gj4WMPewp1IDg+J3UtUftSXbpNlaaZC7xFyoYgnT1cPLsobe+EOzHXAoOfW9pPfUb+ZhxSznaSWBe19cKJPS3ro+KHXUWcJxXu1SYf7hSV8ugm+9I+iJCNRSN+H9IwLP5WgQ1ABMB8AUfQ868gtUG2SqqkNZRpKIPhRJO5VohctCxx6ynTp0ELK/TdU0bHpjMLvU8Xc+i0vrl/66zJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793853663; c=relaxed/relaxed;
	bh=Exl/nSC6acB8HvMYJnlgNTEkwcSS+m2uyCj1ldHYO3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpuET7mO4p+1YOgNwOPUvbYs+3hPQ0tcYAVV44zcybZiGrlLAmbsGMg4FXtB4IIhp2B9iuoWMYfRkZK0LqBnNDPLz6CfR1yOte1KQVQAJOqgo6awOHJ+FeTSdlXOETbjha6sh5ieAHL+YwCXBmsLZGRjYS5ORNHnBJ6q25L6ZvNuQSClgVApTB38RaaA86H1ORqLK31mJlrGinJKR7gHJSlVR5HA282jU4K4OJORYtzBt2y04ZZ+NM3lFTgqcW947Jb0IPzFQcP/npGCBsA/opy5j9ATvfJ1ExkSI45Z+LX9+Hv29XMci0A7ommQ2Bx3GeWEakxv5HFOyaXpTrIuIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkxlDIKP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::a; helo=mail-dy2-x0a.google.com; envelope-from=dennylin0707@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkxlDIKP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::a; helo=mail-dy2-x0a.google.com; envelope-from=dennylin0707@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com [IPv6:2607:f8b0:4864:36::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKqPm4Tc7z2xHG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 15:40:59 +1100 (AEDT)
Received: by mail-dy2-x0a.google.com with SMTP id 5a478bee46e88-36d73027aedso554192eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 20:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793853657; x=1794458457; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Exl/nSC6acB8HvMYJnlgNTEkwcSS+m2uyCj1ldHYO3s=;
        b=VkxlDIKP3iJg3BoEmGmWIJl/G7JsNSc/mPrkSGnk0ca73+HdO+4NL4Ca4ZgliJbt9g
         w0sAjO04702GgXjwF+4wY8hoC6xaMu0VEpL7sEO9OpIptJf7z5OWH4h1r9uUXLBlXE2r
         DU8cNCfqjkoMDhoFFR1ArZsI+TlgXAOly+fPhMSuwuJTfX1iakVH31CNeMGyFqXgWBMW
         MeJOofoM+L8zXzjmdNAdc6jCAZvBv3bCFNtIflrm4DtTtkVQYxLyy92HhDj3l8hKXywZ
         JkWtlpikjLyl26oEefP4IchaCn7mplUcyPUGeEh568fLD9STLpcE/u2pXcUo7EYCPJ5Z
         2jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793853657; x=1794458457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Exl/nSC6acB8HvMYJnlgNTEkwcSS+m2uyCj1ldHYO3s=;
        b=ZX77VeVbmNImseONAWZ+4DzP29RDUDHycE3q5pDVNdbtIiUfvYK114rcC8w8JSe1Dk
         4moWxJrLeYvIaKaArHCZ5/7LAdYE40uyyIYyw1mRoMS8mt0hlCjysxuzwcBhwMRqxjCd
         N9wvmgJRcr4GEYIh/xhfezlGIDYklu0PpIp7TaKmS2wv20AlLOEzIs9yd3/F56XAyL/3
         oWjUbbX8wAZjDZKcDxwLoCrjSWgqBX8ukIogwm9uHyXo9wZKl/q7ppoGZIFbHKjyAWYX
         IJ5tluwy+32hya+hGifijvFX62slYMxdzP86qBk9hNwjjdD5gf0Q8QD2TYMaieFu6k5j
         Faug==
X-Forwarded-Encrypted: i=1; AKwUvBwrtY6wT5EWchBs/22gfR4s4xh917awIGAXahpe60AN8T+K7H6btgdQ8JIQ5Trbzv2Nw6ovyttR2Y+75Vo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/1iZ469M4o45wrf5hN4+AOIxY9gMT/I6U5yNNTHJuzHFvT0/oO
	alyd0c0ZWyOU83rkO1Bcq8ILzOo4YMnwqj257Qxq8wefpHETo+JM9TOc
X-Gm-Gg: AYBFou0UCG+6lwtlvq/ge41uRfaBmQIrOPgreZglOF14gw6XdnT0UE2L3dR8XJBlYjD
	BEGB1DiQnpeHnQllsbn4W9C0vsPRPiKNMDFjPrTDL/9ckMhFptvHOTvEfbTA6wi9GDYrczls4YC
	jAqUE6nLaJ5yt4g0jlzRYCGsaDzsBiCshCwbAmxNvwxLJrjaL37tEhj6D7EVJJt/WMfCUmecBq5
	VlGBvzGRoGsr6Y8vt8F8qhzwDSRuBRpqZLFRFcYKpYiy92J9p1rKeSs5gkDDzxhbxFLow8sfaKw
	YdwJAVDnjmPFTJB5wVWhx9mDga8KtKCsMG2bolINj1BLCvXD1HY9VfMrDKseXEgZ/jMwLM6G3q4
	wTES/yn1e54eyURapGxBiopRY+yBz7r1R0INOaE6jsmyl9MzCTO/3PZkZsLanW79ZdgJzZuV8v8
	vACAbiFuOGdatD0FwGCnHHcvVhIBYvKNmxFRimBD1Wn3NYp1gBOY4aaIlav8e4q1VXCtNHH3+Rr
	i57eijikS1QT2gWwHdB9zEj28gz/3OGUhFNdd1lwd3S3LihoFmfsHCKiVOeePCm03mLedZfkhy6
	hvzuLNBM8C7WW+wrlz02QJjmCdPsfhW4Y48hSburC5P2l1K6Cbirb8XEVc5toOzxVUP8mBA8/A9
	0kgIJV7eaCgvPeCZnARaQr1T65+II6gLeNdtqqQ==
X-Received: by 2002:a05:7022:ef12:b0:14d:ef19:246f with SMTP id a92af1059eb24-1ac5f36d5cbmr28547733c88.45.1793853655771;
        Wed, 04 Nov 2026 20:40:55 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c290sm12725745c88.5.2026.11.04.20.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:40:55 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: me@bobcopeland.com
Cc: willy@infradead.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	geert@linux-m68k.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] omfs: remove the filesystem
Date: Thu,  5 Nov 2026 04:40:45 +0000
Message-ID: <20261105044046.52180-1-dennylin0707@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

OMFS supports the on-disk format used by the long-discontinued Rio Karma
music player and ReplayTV DVR. While reviewing a fix for incorrect block
mapping on writes starting beyond EOF, Matthew suggested removing the
filesystem instead of continuing to maintain it.

Existing OMFS media can still be accessed using an older kernel with OMFS
support.

Remove the driver, its documentation and build configuration, the
defconfig entries, and its name from the statmount selftest's filesystem
list.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 Documentation/filesystems/index.rst           |   1 -
 Documentation/filesystems/omfs.rst            | 112 ---
 MAINTAINERS                                   |   7 -
 arch/m68k/configs/amiga_defconfig             |   1 -
 arch/m68k/configs/apollo_defconfig            |   1 -
 arch/m68k/configs/atari_defconfig             |   1 -
 arch/m68k/configs/bvme6000_defconfig          |   1 -
 arch/m68k/configs/hp300_defconfig             |   1 -
 arch/m68k/configs/mac_defconfig               |   1 -
 arch/m68k/configs/multi_defconfig             |   1 -
 arch/m68k/configs/mvme147_defconfig           |   1 -
 arch/m68k/configs/mvme16x_defconfig           |   1 -
 arch/m68k/configs/q40_defconfig               |   1 -
 arch/m68k/configs/sun3_defconfig              |   1 -
 arch/m68k/configs/sun3x_defconfig             |   1 -
 arch/mips/configs/fuloong2e_defconfig         |   1 -
 arch/mips/configs/ip22_defconfig              |   1 -
 arch/mips/configs/ip27_defconfig              |   1 -
 arch/mips/configs/ip30_defconfig              |   1 -
 arch/powerpc/configs/ppc6xx_defconfig         |   1 -
 fs/Kconfig                                    |   1 -
 fs/Makefile                                   |   1 -
 fs/omfs/Kconfig                               |  15 -
 fs/omfs/Makefile                              |   5 -
 fs/omfs/bitmap.c                              | 194 -----
 fs/omfs/dir.c                                 | 461 ------------
 fs/omfs/file.c                                | 380 ----------
 fs/omfs/inode.c                               | 664 ------------------
 fs/omfs/omfs.h                                |  69 --
 fs/omfs/omfs_fs.h                             |  83 ---
 .../filesystems/statmount/statmount_test.c    |   2 +-
 31 files changed, 1 insertion(+), 2011 deletions(-)
 delete mode 100644 Documentation/filesystems/omfs.rst
 delete mode 100644 fs/omfs/Kconfig
 delete mode 100644 fs/omfs/Makefile
 delete mode 100644 fs/omfs/bitmap.c
 delete mode 100644 fs/omfs/dir.c
 delete mode 100644 fs/omfs/file.c
 delete mode 100644 fs/omfs/inode.c
 delete mode 100644 fs/omfs/omfs.h
 delete mode 100644 fs/omfs/omfs_fs.h

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1100130ccf0..a556084c885 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -105,7 +105,6 @@ Documentation for filesystem implementations.
    ntfs3
    ocfs2
    ocfs2-online-filecheck
-   omfs
    orangefs
    overlayfs
    proc
diff --git a/Documentation/filesystems/omfs.rst b/Documentation/filesystems/omfs.rst
deleted file mode 100644
index a104c25b7a2..00000000000
--- a/Documentation/filesystems/omfs.rst
+++ /dev/null
@@ -1,112 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-================================
-Optimized MPEG Filesystem (OMFS)
-================================
-
-Overview
-========
-
-OMFS is a filesystem created by SonicBlue for use in the ReplayTV DVR
-and Rio Karma MP3 player.  The filesystem is extent-based, utilizing
-block sizes from 2k to 8k, with hash-based directories.  This
-filesystem driver may be used to read and write disks from these
-devices.
-
-Note, it is not recommended that this FS be used in place of a general
-filesystem for your own streaming media device.  Native Linux filesystems
-will likely perform better.
-
-More information is available at:
-
-    http://linux-karma.sf.net/
-
-Various utilities, including mkomfs and omfsck, are included with
-omfsprogs, available at:
-
-    https://bobcopeland.com/karma/
-
-Instructions are included in its README.
-
-Options
-=======
-
-OMFS supports the following mount-time options:
-
-    ============   ========================================
-    uid=n          make all files owned by specified user
-    gid=n          make all files owned by specified group
-    umask=xxx      set permission umask to xxx
-    fmask=xxx      set umask to xxx for files
-    dmask=xxx      set umask to xxx for directories
-    ============   ========================================
-
-Disk format
-===========
-
-OMFS discriminates between "sysblocks" and normal data blocks.  The sysblock
-group consists of super block information, file metadata, directory structures,
-and extents.  Each sysblock has a header containing CRCs of the entire
-sysblock, and may be mirrored in successive blocks on the disk.  A sysblock may
-have a smaller size than a data block, but since they are both addressed by the
-same 64-bit block number, any remaining space in the smaller sysblock is
-unused.
-
-Sysblock header information::
-
-    struct omfs_header {
-	    __be64 h_self;                  /* FS block where this is located */
-	    __be32 h_body_size;             /* size of useful data after header */
-	    __be16 h_crc;                   /* crc-ccitt of body_size bytes */
-	    char h_fill1[2];
-	    u8 h_version;                   /* version, always 1 */
-	    char h_type;                    /* OMFS_INODE_X */
-	    u8 h_magic;                     /* OMFS_IMAGIC */
-	    u8 h_check_xor;                 /* XOR of header bytes before this */
-	    __be32 h_fill2;
-    };
-
-Files and directories are both represented by omfs_inode::
-
-    struct omfs_inode {
-	    struct omfs_header i_head;      /* header */
-	    __be64 i_parent;                /* parent containing this inode */
-	    __be64 i_sibling;               /* next inode in hash bucket */
-	    __be64 i_ctime;                 /* ctime, in milliseconds */
-	    char i_fill1[35];
-	    char i_type;                    /* OMFS_[DIR,FILE] */
-	    __be32 i_fill2;
-	    char i_fill3[64];
-	    char i_name[OMFS_NAMELEN];      /* filename */
-	    __be64 i_size;                  /* size of file, in bytes */
-    };
-
-Directories in OMFS are implemented as a large hash table.  Filenames are
-hashed then prepended into the bucket list beginning at OMFS_DIR_START.
-Lookup requires hashing the filename, then seeking across i_sibling pointers
-until a match is found on i_name.  Empty buckets are represented by block
-pointers with all-1s (~0).
-
-A file is an omfs_inode structure followed by an extent table beginning at
-OMFS_EXTENT_START::
-
-    struct omfs_extent_entry {
-	    __be64 e_cluster;               /* start location of a set of blocks */
-	    __be64 e_blocks;                /* number of blocks after e_cluster */
-    };
-
-    struct omfs_extent {
-	    __be64 e_next;                  /* next extent table location */
-	    __be32 e_extent_count;          /* total # extents in this table */
-	    __be32 e_fill;
-	    struct omfs_extent_entry e_entry;       /* start of extent entries */
-    };
-
-Each extent holds the block offset followed by number of blocks allocated to
-the extent.  The final extent in each table is a terminator with e_cluster
-being ~0 and e_blocks being ones'-complement of the total number of blocks
-in the table.
-
-If this table overflows, a continuation inode is written and pointed to by
-e_next.  These have a header but lack the rest of the inode structure.
-
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb31506..a3d87405995 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20573,13 +20573,6 @@ F:	drivers/regulator/twl6030-regulator.c
 F:	include/linux/platform_data/i2c-omap.h
 F:	include/linux/platform_data/ti-sysc.h
 
-OMFS FILESYSTEM
-M:	Bob Copeland <me@bobcopeland.com>
-L:	linux-karma-devel@lists.sourceforge.net
-S:	Maintained
-F:	Documentation/filesystems/omfs.rst
-F:	fs/omfs/
-
 OMNIVISION OG01A1B SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index e2d474e8cb8..9c303ee2a4d 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -437,7 +437,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 77669e31bb5..1783ae09ed5 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -391,7 +391,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 43ed1e317ae..5f8c1eab65e 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -416,7 +416,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 44c1a2228d5..43cf1f3ca84 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -383,7 +383,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 7ab25377bfe..b7be903e9ce 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -393,7 +393,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 13f642884a9..cda737fce9f 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -412,7 +412,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 1bbd2aa653c..c1febb79241 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -502,7 +502,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 3bfc36faf8d..7d536ff9d1c 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -383,7 +383,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 41ceed87c78..f36b502021b 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -384,7 +384,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index af4b5c6e465..c632c25c0af 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -402,7 +402,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 1140951fefe..cf28894400a 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -381,7 +381,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index bc9358e71ee..b3be0542a60 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -381,7 +381,6 @@ CONFIG_SQUASHFS=m
 CONFIG_SQUASHFS_LZ4=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_HPFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_QNX6FS_FS=m
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 8c80c690624..3969551be67 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -189,7 +189,6 @@ CONFIG_NTFS_FS=m
 CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
-CONFIG_OMFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 09a77e5b249..948a0244b73 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -252,7 +252,6 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_EFS_FS=m
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3_ACL=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index ac885ff5b71..46cfe409664 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -289,7 +289,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_SQUASHFS=m
-CONFIG_OMFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_CRYPTD=m
diff --git a/arch/mips/configs/ip30_defconfig b/arch/mips/configs/ip30_defconfig
index 93eb90efe06..bc6d1191116 100644
--- a/arch/mips/configs/ip30_defconfig
+++ b/arch/mips/configs/ip30_defconfig
@@ -157,7 +157,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_SQUASHFS=m
-CONFIG_OMFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_CRYPTD=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 8aab229fb90..5ca340f6b99 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -949,7 +949,6 @@ CONFIG_EFS_FS=m
 CONFIG_CRAMFS=m
 CONFIG_VXFS_FS=m
 CONFIG_MINIX_FS=m
-CONFIG_OMFS_FS=m
 CONFIG_QNX4FS_FS=m
 CONFIG_ROMFS_FS=m
 CONFIG_UFS_FS=m
diff --git a/fs/Kconfig b/fs/Kconfig
index 70a1d0760d2..54cab974f84 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -320,7 +320,6 @@ source "fs/ubifs/Kconfig"
 source "fs/cramfs/Kconfig"
 source "fs/squashfs/Kconfig"
 source "fs/minix/Kconfig"
-source "fs/omfs/Kconfig"
 source "fs/hpfs/Kconfig"
 source "fs/qnx4/Kconfig"
 source "fs/qnx6/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 16f1108b64e..ee7974b0572 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -104,7 +104,6 @@ obj-$(CONFIG_OVERLAY_FS)	+= overlayfs/
 obj-$(CONFIG_ORANGEFS_FS)       += orangefs/
 obj-$(CONFIG_UDF_FS)		+= udf/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
-obj-$(CONFIG_OMFS_FS)		+= omfs/
 obj-$(CONFIG_JFS_FS)		+= jfs/
 obj-$(CONFIG_XFS_FS)		+= xfs/
 obj-$(CONFIG_9P_FS)		+= 9p/
diff --git a/fs/omfs/Kconfig b/fs/omfs/Kconfig
deleted file mode 100644
index 8470f6c3e64..00000000000
--- a/fs/omfs/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config OMFS_FS
-	tristate "SonicBlue Optimized MPEG File System support"
-	depends on BLOCK
-	select BUFFER_HEAD
-	select CRC_ITU_T
-	help
-	  This is the proprietary file system used by the Rio Karma music
-	  player and ReplayTV DVR.  Despite the name, this filesystem is not
-	  more efficient than a standard FS for MPEG files, in fact likely
-	  the opposite is true.  Say Y if you have either of these devices
-	  and wish to mount its disk.
-
-	  To compile this file system support as a module, choose M here: the
-	  module will be called omfs.  If unsure, say N.
diff --git a/fs/omfs/Makefile b/fs/omfs/Makefile
deleted file mode 100644
index ae16fc3d34a..00000000000
--- a/fs/omfs/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-obj-$(CONFIG_OMFS_FS) += omfs.o
-
-omfs-y := bitmap.o dir.o file.o inode.o
diff --git a/fs/omfs/bitmap.c b/fs/omfs/bitmap.c
deleted file mode 100644
index 7147ba6a6af..00000000000
--- a/fs/omfs/bitmap.c
+++ /dev/null
@@ -1,194 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/buffer_head.h>
-#include <asm/div64.h>
-#include "omfs.h"
-
-unsigned long omfs_count_free(struct super_block *sb)
-{
-	unsigned int i;
-	unsigned long sum = 0;
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	int nbits = sb->s_blocksize * 8;
-
-	for (i = 0; i < sbi->s_imap_size; i++)
-		sum += nbits - bitmap_weight(sbi->s_imap[i], nbits);
-
-	return sum;
-}
-
-/*
- *  Counts the run of zero bits starting at bit up to max.
- *  It handles the case where a run might spill over a buffer.
- *  Called with bitmap lock.
- */
-static int count_run(unsigned long **addr, int nbits,
-		int addrlen, int bit, int max)
-{
-	int count = 0;
-	int x;
-
-	for (; addrlen > 0; addrlen--, addr++) {
-		x = find_next_bit(*addr, nbits, bit);
-		count += x - bit;
-
-		if (x < nbits || count > max)
-			return min(count, max);
-
-		bit = 0;
-	}
-	return min(count, max);
-}
-
-/*
- * Sets or clears the run of count bits starting with bit.
- * Called with bitmap lock.
- */
-static int set_run(struct super_block *sb, int map,
-		int nbits, int bit, int count, int set)
-{
-	int i;
-	int err;
-	struct buffer_head *bh;
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-
- 	err = -ENOMEM;
-	bh = sb_bread(sb, clus_to_blk(sbi, sbi->s_bitmap_ino) + map);
-	if (!bh)
-		goto out;
-
-	for (i = 0; i < count; i++, bit++) {
-		if (bit >= nbits) {
-			bit = 0;
-			map++;
-
-			mark_buffer_dirty(bh);
-			brelse(bh);
-			bh = sb_bread(sb,
-				clus_to_blk(sbi, sbi->s_bitmap_ino) + map);
-			if (!bh)
-				goto out;
-		}
-		if (set) {
-			set_bit(bit, sbi->s_imap[map]);
-			set_bit(bit, (unsigned long *)bh->b_data);
-		} else {
-			clear_bit(bit, sbi->s_imap[map]);
-			clear_bit(bit, (unsigned long *)bh->b_data);
-		}
-	}
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	err = 0;
-out:
-	return err;
-}
-
-/*
- * Tries to allocate exactly one block.  Returns true if successful.
- */
-int omfs_allocate_block(struct super_block *sb, u64 block)
-{
-	struct buffer_head *bh;
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	int bits_per_entry = 8 * sb->s_blocksize;
-	unsigned int map, bit;
-	int ret = 0;
-	u64 tmp;
-
-	tmp = block;
-	bit = do_div(tmp, bits_per_entry);
-	map = tmp;
-
-	mutex_lock(&sbi->s_bitmap_lock);
-	if (map >= sbi->s_imap_size || test_and_set_bit(bit, sbi->s_imap[map]))
-		goto out;
-
-	if (sbi->s_bitmap_ino > 0) {
-		bh = sb_bread(sb, clus_to_blk(sbi, sbi->s_bitmap_ino) + map);
-		if (!bh)
-			goto out;
-
-		set_bit(bit, (unsigned long *)bh->b_data);
-		mark_buffer_dirty(bh);
-		brelse(bh);
-	}
-	ret = 1;
-out:
-	mutex_unlock(&sbi->s_bitmap_lock);
-	return ret;
-}
-
-
-/*
- *  Tries to allocate a set of blocks.	The request size depends on the
- *  type: for inodes, we must allocate sbi->s_mirrors blocks, and for file
- *  blocks, we try to allocate sbi->s_clustersize, but can always get away
- *  with just one block.
- */
-int omfs_allocate_range(struct super_block *sb,
-			int min_request,
-			int max_request,
-			u64 *return_block,
-			int *return_size)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	int bits_per_entry = 8 * sb->s_blocksize;
-	int ret = 0;
-	int i, run, bit;
-
-	mutex_lock(&sbi->s_bitmap_lock);
-	for (i = 0; i < sbi->s_imap_size; i++) {
-		bit = 0;
-		while (bit < bits_per_entry) {
-			bit = find_next_zero_bit(sbi->s_imap[i], bits_per_entry,
-				bit);
-
-			if (bit == bits_per_entry)
-				break;
-
-			run = count_run(&sbi->s_imap[i], bits_per_entry,
-				sbi->s_imap_size-i, bit, max_request);
-
-			if (run >= min_request)
-				goto found;
-			bit += run;
-		}
-	}
-	ret = -ENOSPC;
-	goto out;
-
-found:
-	*return_block = (u64) i * bits_per_entry + bit;
-	*return_size = run;
-	ret = set_run(sb, i, bits_per_entry, bit, run, 1);
-
-out:
-	mutex_unlock(&sbi->s_bitmap_lock);
-	return ret;
-}
-
-/*
- * Clears count bits starting at a given block.
- */
-int omfs_clear_range(struct super_block *sb, u64 block, int count)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	int bits_per_entry = 8 * sb->s_blocksize;
-	u64 tmp;
-	unsigned int map, bit;
-	int ret;
-
-	tmp = block;
-	bit = do_div(tmp, bits_per_entry);
-	map = tmp;
-
-	if (map >= sbi->s_imap_size)
-		return 0;
-
-	mutex_lock(&sbi->s_bitmap_lock);
-	ret = set_run(sb, map, bits_per_entry, bit, count, 0);
-	mutex_unlock(&sbi->s_bitmap_lock);
-	return ret;
-}
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
deleted file mode 100644
index 18f4b4543cc..00000000000
--- a/fs/omfs/dir.c
+++ /dev/null
@@ -1,461 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * OMFS (as used by RIO Karma) directory operations.
- * Copyright (C) 2005 Bob Copeland <me@bobcopeland.com>
- */
-
-#include <linux/fs.h>
-#include <linux/ctype.h>
-#include <linux/buffer_head.h>
-#include "omfs.h"
-
-static int omfs_hash(const char *name, int namelen, int mod)
-{
-	int i, hash = 0;
-	for (i = 0; i < namelen; i++)
-		hash ^= tolower(name[i]) << (i % 24);
-	return hash % mod;
-}
-
-/*
- * Finds the bucket for a given name and reads the containing block;
- * *ofs is set to the offset of the first list entry.
- */
-static struct buffer_head *omfs_get_bucket(struct inode *dir,
-		const char *name, int namelen, int *ofs)
-{
-	int nbuckets = (dir->i_size - OMFS_DIR_START)/8;
-	int bucket = omfs_hash(name, namelen, nbuckets);
-
-	*ofs = OMFS_DIR_START + bucket * 8;
-	return omfs_bread(dir->i_sb, dir->i_ino);
-}
-
-static struct buffer_head *omfs_scan_list(struct inode *dir, u64 block,
-				const char *name, int namelen,
-				u64 *prev_block)
-{
-	struct buffer_head *bh;
-	struct omfs_inode *oi;
-	int err = -ENOENT;
-	*prev_block = ~0;
-
-	while (block != ~0) {
-		bh = omfs_bread(dir->i_sb, block);
-		if (!bh) {
-			err = -EIO;
-			goto err;
-		}
-
-		oi = (struct omfs_inode *) bh->b_data;
-		if (omfs_is_bad(OMFS_SB(dir->i_sb), &oi->i_head, block)) {
-			brelse(bh);
-			goto err;
-		}
-
-		if (strncmp(oi->i_name, name, namelen) == 0)
-			return bh;
-
-		*prev_block = block;
-		block = be64_to_cpu(oi->i_sibling);
-		brelse(bh);
-	}
-err:
-	return ERR_PTR(err);
-}
-
-static struct buffer_head *omfs_find_entry(struct inode *dir,
-					   const char *name, int namelen)
-{
-	struct buffer_head *bh;
-	int ofs;
-	u64 block, dummy;
-
-	bh = omfs_get_bucket(dir, name, namelen, &ofs);
-	if (!bh)
-		return ERR_PTR(-EIO);
-
-	block = be64_to_cpu(*((__be64 *) &bh->b_data[ofs]));
-	brelse(bh);
-
-	return omfs_scan_list(dir, block, name, namelen, &dummy);
-}
-
-int omfs_make_empty(struct inode *inode, struct super_block *sb)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	struct buffer_head *bh;
-	struct omfs_inode *oi;
-
-	bh = omfs_bread(sb, inode->i_ino);
-	if (!bh)
-		return -ENOMEM;
-
-	memset(bh->b_data, 0, sizeof(struct omfs_inode));
-
-	if (S_ISDIR(inode->i_mode)) {
-		memset(&bh->b_data[OMFS_DIR_START], 0xff,
-			sbi->s_sys_blocksize - OMFS_DIR_START);
-	} else
-		omfs_make_empty_table(bh, OMFS_EXTENT_START);
-
-	oi = (struct omfs_inode *) bh->b_data;
-	oi->i_head.h_self = cpu_to_be64(inode->i_ino);
-	oi->i_sibling = ~cpu_to_be64(0ULL);
-
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	return 0;
-}
-
-static int omfs_add_link(struct dentry *dentry, struct inode *inode)
-{
-	struct inode *dir = d_inode(dentry->d_parent);
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
-	struct omfs_inode *oi;
-	struct buffer_head *bh;
-	u64 block;
-	__be64 *entry;
-	int ofs;
-
-	/* just prepend to head of queue in proper bucket */
-	bh = omfs_get_bucket(dir, name, namelen, &ofs);
-	if (!bh)
-		goto out;
-
-	entry = (__be64 *) &bh->b_data[ofs];
-	block = be64_to_cpu(*entry);
-	*entry = cpu_to_be64(inode->i_ino);
-	mark_buffer_dirty(bh);
-	brelse(bh);
-
-	/* now set the sibling and parent pointers on the new inode */
-	bh = omfs_bread(dir->i_sb, inode->i_ino);
-	if (!bh)
-		goto out;
-
-	oi = (struct omfs_inode *) bh->b_data;
-	memcpy(oi->i_name, name, namelen);
-	memset(oi->i_name + namelen, 0, OMFS_NAMELEN - namelen);
-	oi->i_sibling = cpu_to_be64(block);
-	oi->i_parent = cpu_to_be64(dir->i_ino);
-	mark_buffer_dirty(bh);
-	brelse(bh);
-
-	inode_set_ctime_current(dir);
-
-	/* mark affected inodes dirty to rebuild checksums */
-	mark_inode_dirty(dir);
-	mark_inode_dirty(inode);
-	return 0;
-out:
-	return -ENOMEM;
-}
-
-static int omfs_delete_entry(struct dentry *dentry)
-{
-	struct inode *dir = d_inode(dentry->d_parent);
-	struct inode *dirty;
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
-	struct omfs_inode *oi;
-	struct buffer_head *bh, *bh2;
-	__be64 *entry, next;
-	u64 block, prev;
-	int ofs;
-	int err = -ENOMEM;
-
-	/* delete the proper node in the bucket's linked list */
-	bh = omfs_get_bucket(dir, name, namelen, &ofs);
-	if (!bh)
-		goto out;
-
-	entry = (__be64 *) &bh->b_data[ofs];
-	block = be64_to_cpu(*entry);
-
-	bh2 = omfs_scan_list(dir, block, name, namelen, &prev);
-	if (IS_ERR(bh2)) {
-		err = PTR_ERR(bh2);
-		goto out_free_bh;
-	}
-
-	oi = (struct omfs_inode *) bh2->b_data;
-	next = oi->i_sibling;
-	brelse(bh2);
-
-	if (prev != ~0) {
-		/* found in middle of list, get list ptr */
-		brelse(bh);
-		bh = omfs_bread(dir->i_sb, prev);
-		if (!bh)
-			goto out;
-
-		oi = (struct omfs_inode *) bh->b_data;
-		entry = &oi->i_sibling;
-	}
-
-	*entry = next;
-	mark_buffer_dirty(bh);
-
-	if (prev != ~0) {
-		dirty = omfs_iget(dir->i_sb, prev);
-		if (!IS_ERR(dirty)) {
-			mark_inode_dirty(dirty);
-			iput(dirty);
-		}
-	}
-
-	err = 0;
-out_free_bh:
-	brelse(bh);
-out:
-	return err;
-}
-
-static int omfs_dir_is_empty(struct inode *inode)
-{
-	int nbuckets = (inode->i_size - OMFS_DIR_START) / 8;
-	struct buffer_head *bh;
-	u64 *ptr;
-	int i;
-
-	bh = omfs_bread(inode->i_sb, inode->i_ino);
-
-	if (!bh)
-		return 0;
-
-	ptr = (u64 *) &bh->b_data[OMFS_DIR_START];
-
-	for (i = 0; i < nbuckets; i++, ptr++)
-		if (*ptr != ~0)
-			break;
-
-	brelse(bh);
-	return *ptr != ~0;
-}
-
-static int omfs_remove(struct inode *dir, struct dentry *dentry)
-{
-	struct inode *inode = d_inode(dentry);
-	int ret;
-
-
-	if (S_ISDIR(inode->i_mode) &&
-	    !omfs_dir_is_empty(inode))
-		return -ENOTEMPTY;
-
-	ret = omfs_delete_entry(dentry);
-	if (ret)
-		return ret;
-	
-	clear_nlink(inode);
-	mark_inode_dirty(inode);
-	mark_inode_dirty(dir);
-	return 0;
-}
-
-static int omfs_add_node(struct inode *dir, struct dentry *dentry, umode_t mode)
-{
-	int err;
-	struct inode *inode = omfs_new_inode(dir, mode);
-
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-
-	err = omfs_make_empty(inode, dir->i_sb);
-	if (err)
-		goto out_free_inode;
-
-	err = omfs_add_link(dentry, inode);
-	if (err)
-		goto out_free_inode;
-
-	d_instantiate(dentry, inode);
-	return 0;
-
-out_free_inode:
-	iput(inode);
-	return err;
-}
-
-static struct dentry *omfs_mkdir(const struct mnt_idmap *idmap, struct inode *dir,
-				 struct dentry *dentry, umode_t mode)
-{
-	return ERR_PTR(omfs_add_node(dir, dentry, mode));
-}
-
-static int omfs_create(const struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
-{
-	return omfs_add_node(dir, dentry, mode | S_IFREG);
-}
-
-static struct dentry *omfs_lookup(struct inode *dir, struct dentry *dentry,
-				  unsigned int flags)
-{
-	struct buffer_head *bh;
-	struct inode *inode = NULL;
-
-	if (dentry->d_name.len > OMFS_NAMELEN)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	bh = omfs_find_entry(dir, dentry->d_name.name, dentry->d_name.len);
-	if (!IS_ERR(bh)) {
-		struct omfs_inode *oi = (struct omfs_inode *)bh->b_data;
-		ino_t ino = be64_to_cpu(oi->i_head.h_self);
-		brelse(bh);
-		inode = omfs_iget(dir->i_sb, ino);
-	} else if (bh != ERR_PTR(-ENOENT)) {
-		inode = ERR_CAST(bh);
-	}
-	return d_splice_alias(inode, dentry);
-}
-
-/* sanity check block's self pointer */
-int omfs_is_bad(struct omfs_sb_info *sbi, struct omfs_header *header,
-	u64 fsblock)
-{
-	int is_bad;
-	u64 ino = be64_to_cpu(header->h_self);
-	is_bad = ((ino != fsblock) || (ino < sbi->s_root_ino) ||
-		(ino > sbi->s_num_blocks));
-
-	if (is_bad)
-		printk(KERN_WARNING "omfs: bad hash chain detected\n");
-
-	return is_bad;
-}
-
-static bool omfs_fill_chain(struct inode *dir, struct dir_context *ctx,
-		u64 fsblock, int hindex)
-{
-	/* follow chain in this bucket */
-	while (fsblock != ~0) {
-		struct buffer_head *bh = omfs_bread(dir->i_sb, fsblock);
-		struct omfs_inode *oi;
-		u64 self;
-		unsigned char d_type;
-
-		if (!bh)
-			return true;
-
-		oi = (struct omfs_inode *) bh->b_data;
-		if (omfs_is_bad(OMFS_SB(dir->i_sb), &oi->i_head, fsblock)) {
-			brelse(bh);
-			return true;
-		}
-
-		self = fsblock;
-		fsblock = be64_to_cpu(oi->i_sibling);
-
-		/* skip visited nodes */
-		if (hindex) {
-			hindex--;
-			brelse(bh);
-			continue;
-		}
-
-		d_type = (oi->i_type == OMFS_DIR) ? DT_DIR : DT_REG;
-
-		if (!dir_emit(ctx, oi->i_name,
-			      strnlen(oi->i_name, OMFS_NAMELEN),
-			      self, d_type)) {
-			brelse(bh);
-			return false;
-		}
-		brelse(bh);
-		ctx->pos++;
-	}
-	return true;
-}
-
-static int omfs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
-		       struct dentry *old_dentry, struct inode *new_dir,
-		       struct dentry *new_dentry, unsigned int flags)
-{
-	struct inode *new_inode = d_inode(new_dentry);
-	struct inode *old_inode = d_inode(old_dentry);
-	int err;
-
-	if (flags & ~RENAME_NOREPLACE)
-		return -EINVAL;
-
-	if (new_inode) {
-		/* overwriting existing file/dir */
-		err = omfs_remove(new_dir, new_dentry);
-		if (err)
-			goto out;
-	}
-
-	/* since omfs locates files by name, we need to unlink _before_
-	 * adding the new link or we won't find the old one */
-	err = omfs_delete_entry(old_dentry);
-	if (err)
-		goto out;
-
-	mark_inode_dirty(old_dir);
-	err = omfs_add_link(new_dentry, old_inode);
-	if (err)
-		goto out;
-
-	inode_set_ctime_current(old_inode);
-	mark_inode_dirty(old_inode);
-out:
-	return err;
-}
-
-static int omfs_readdir(struct file *file, struct dir_context *ctx)
-{
-	struct inode *dir = file_inode(file);
-	struct buffer_head *bh;
-	__be64 *p;
-	unsigned int hchain, hindex;
-	int nbuckets;
-
-	if (ctx->pos >> 32)
-		return -EINVAL;
-
-	if (ctx->pos < 1 << 20) {
-		if (!dir_emit_dots(file, ctx))
-			return 0;
-		ctx->pos = 1 << 20;
-	}
-
-	nbuckets = (dir->i_size - OMFS_DIR_START) / 8;
-
-	/* high 12 bits store bucket + 1 and low 20 bits store hash index */
-	hchain = (ctx->pos >> 20) - 1;
-	hindex = ctx->pos & 0xfffff;
-
-	bh = omfs_bread(dir->i_sb, dir->i_ino);
-	if (!bh)
-		return -EINVAL;
-
-	p = (__be64 *)(bh->b_data + OMFS_DIR_START) + hchain;
-
-	for (; hchain < nbuckets; hchain++) {
-		__u64 fsblock = be64_to_cpu(*p++);
-		if (!omfs_fill_chain(dir, ctx, fsblock, hindex))
-			break;
-		hindex = 0;
-		ctx->pos = (hchain+2) << 20;
-	}
-	brelse(bh);
-	return 0;
-}
-
-const struct inode_operations omfs_dir_inops = {
-	.lookup = omfs_lookup,
-	.mkdir = omfs_mkdir,
-	.rename = omfs_rename,
-	.create = omfs_create,
-	.unlink = omfs_remove,
-	.rmdir = omfs_remove,
-};
-
-const struct file_operations omfs_dir_operations = {
-	.read = generic_read_dir,
-	.iterate_shared = omfs_readdir,
-	.llseek = generic_file_llseek,
-};
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
deleted file mode 100644
index 79a413f1dc0..00000000000
--- a/fs/omfs/file.c
+++ /dev/null
@@ -1,380 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * OMFS (as used by RIO Karma) file operations.
- * Copyright (C) 2005 Bob Copeland <me@bobcopeland.com>
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/buffer_head.h>
-#include <linux/mpage.h>
-#include "omfs.h"
-
-static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
-{
-	return (sbi->s_sys_blocksize - offset -
-		sizeof(struct omfs_extent)) /
-		sizeof(struct omfs_extent_entry);
-}
-
-void omfs_make_empty_table(struct buffer_head *bh, int offset)
-{
-	struct omfs_extent *oe = (struct omfs_extent *) &bh->b_data[offset];
-
-	oe->e_next = ~cpu_to_be64(0ULL);
-	oe->e_extent_count = cpu_to_be32(1),
-	oe->e_fill = cpu_to_be32(0x22),
-	oe->e_entry[0].e_cluster = ~cpu_to_be64(0ULL);
-	oe->e_entry[0].e_blocks = ~cpu_to_be64(0ULL);
-}
-
-int omfs_shrink_inode(struct inode *inode)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
-	struct omfs_extent *oe;
-	struct omfs_extent_entry *entry;
-	struct buffer_head *bh;
-	u64 next, last;
-	u32 extent_count;
-	u32 max_extents;
-	int ret;
-
-	/* traverse extent table, freeing each entry that is greater
-	 * than inode->i_size;
-	 */
-	next = inode->i_ino;
-
-	/* only support truncate -> 0 for now */
-	ret = -EIO;
-	if (inode->i_size != 0)
-		goto out;
-
-	bh = omfs_bread(inode->i_sb, next);
-	if (!bh)
-		goto out;
-
-	oe = (struct omfs_extent *)(&bh->b_data[OMFS_EXTENT_START]);
-	max_extents = omfs_max_extents(sbi, OMFS_EXTENT_START);
-
-	for (;;) {
-
-		if (omfs_is_bad(sbi, (struct omfs_header *) bh->b_data, next))
-			goto out_brelse;
-
-		extent_count = be32_to_cpu(oe->e_extent_count);
-
-		if (extent_count > max_extents)
-			goto out_brelse;
-
-		last = next;
-		next = be64_to_cpu(oe->e_next);
-		entry = oe->e_entry;
-
-		/* ignore last entry as it is the terminator */
-		for (; extent_count > 1; extent_count--) {
-			u64 start, count;
-			start = be64_to_cpu(entry->e_cluster);
-			count = be64_to_cpu(entry->e_blocks);
-
-			omfs_clear_range(inode->i_sb, start, (int) count);
-			entry++;
-		}
-		omfs_make_empty_table(bh, (char *) oe - bh->b_data);
-		mark_buffer_dirty(bh);
-		brelse(bh);
-
-		if (last != inode->i_ino)
-			omfs_clear_range(inode->i_sb, last, sbi->s_mirrors);
-
-		if (next == ~0)
-			break;
-
-		bh = omfs_bread(inode->i_sb, next);
-		if (!bh)
-			goto out;
-		oe = (struct omfs_extent *) (&bh->b_data[OMFS_EXTENT_CONT]);
-		max_extents = omfs_max_extents(sbi, OMFS_EXTENT_CONT);
-	}
-	ret = 0;
-out:
-	return ret;
-out_brelse:
-	brelse(bh);
-	return ret;
-}
-
-static void omfs_truncate(struct inode *inode)
-{
-	omfs_shrink_inode(inode);
-	mark_inode_dirty(inode);
-}
-
-/*
- * Add new blocks to the current extent, or create new entries/continuations
- * as necessary.
- */
-static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
-			u64 *ret_block)
-{
-	struct omfs_extent_entry *terminator;
-	struct omfs_extent_entry *entry = oe->e_entry;
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
-	u32 extent_count = be32_to_cpu(oe->e_extent_count);
-	u64 new_block = 0;
-	u32 max_count;
-	int new_count;
-	int ret = 0;
-
-	/* reached the end of the extent table with no blocks mapped.
-	 * there are three possibilities for adding: grow last extent,
-	 * add a new extent to the current extent table, and add a
-	 * continuation inode.  in last two cases need an allocator for
-	 * sbi->s_cluster_size
-	 */
-
-	/* TODO: handle holes */
-
-	/* should always have a terminator */
-	if (extent_count < 1)
-		return -EIO;
-
-	/* trivially grow current extent, if next block is not taken */
-	terminator = entry + extent_count - 1;
-	if (extent_count > 1) {
-		entry = terminator-1;
-		new_block = be64_to_cpu(entry->e_cluster) +
-			be64_to_cpu(entry->e_blocks);
-
-		if (omfs_allocate_block(inode->i_sb, new_block)) {
-			be64_add_cpu(&entry->e_blocks, 1);
-			terminator->e_blocks = ~(cpu_to_be64(
-				be64_to_cpu(~terminator->e_blocks) + 1));
-			goto out;
-		}
-	}
-	max_count = omfs_max_extents(sbi, OMFS_EXTENT_START);
-
-	/* TODO: add a continuation block here */
-	if (be32_to_cpu(oe->e_extent_count) > max_count-1)
-		return -EIO;
-
-	/* try to allocate a new cluster */
-	ret = omfs_allocate_range(inode->i_sb, 1, sbi->s_clustersize,
-		&new_block, &new_count);
-	if (ret)
-		goto out_fail;
-
-	/* copy terminator down an entry */
-	entry = terminator;
-	terminator++;
-	memcpy(terminator, entry, sizeof(struct omfs_extent_entry));
-
-	entry->e_cluster = cpu_to_be64(new_block);
-	entry->e_blocks = cpu_to_be64((u64) new_count);
-
-	terminator->e_blocks = ~(cpu_to_be64(
-		be64_to_cpu(~terminator->e_blocks) + (u64) new_count));
-
-	/* write in new entry */
-	be32_add_cpu(&oe->e_extent_count, 1);
-
-out:
-	*ret_block = new_block;
-out_fail:
-	return ret;
-}
-
-/*
- * Scans across the directory table for a given file block number.
- * If block not found, return 0.
- */
-static sector_t find_block(struct inode *inode, struct omfs_extent_entry *ent,
-			sector_t block, int count, int *left)
-{
-	/* count > 1 because of terminator */
-	sector_t searched = 0;
-	for (; count > 1; count--) {
-		int numblocks = clus_to_blk(OMFS_SB(inode->i_sb),
-			be64_to_cpu(ent->e_blocks));
-
-		if (block >= searched  &&
-		    block < searched + numblocks) {
-			/*
-			 * found it at cluster + (block - searched)
-			 * numblocks - (block - searched) is remainder
-			 */
-			*left = numblocks - (block - searched);
-			return clus_to_blk(OMFS_SB(inode->i_sb),
-				be64_to_cpu(ent->e_cluster)) +
-				block - searched;
-		}
-		searched += numblocks;
-		ent++;
-	}
-	return 0;
-}
-
-static int omfs_get_block(struct inode *inode, sector_t block,
-			  struct buffer_head *bh_result, int create)
-{
-	struct buffer_head *bh;
-	sector_t next, offset;
-	int ret;
-	u64 new_block;
-	u32 max_extents;
-	int extent_count;
-	struct omfs_extent *oe;
-	struct omfs_extent_entry *entry;
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
-	int max_blocks = bh_result->b_size >> inode->i_blkbits;
-	int remain;
-
-	ret = -EIO;
-	bh = omfs_bread(inode->i_sb, inode->i_ino);
-	if (!bh)
-		goto out;
-
-	oe = (struct omfs_extent *)(&bh->b_data[OMFS_EXTENT_START]);
-	max_extents = omfs_max_extents(sbi, OMFS_EXTENT_START);
-	next = inode->i_ino;
-
-	for (;;) {
-
-		if (omfs_is_bad(sbi, (struct omfs_header *) bh->b_data, next))
-			goto out_brelse;
-
-		extent_count = be32_to_cpu(oe->e_extent_count);
-		next = be64_to_cpu(oe->e_next);
-		entry = oe->e_entry;
-
-		if (extent_count > max_extents)
-			goto out_brelse;
-
-		offset = find_block(inode, entry, block, extent_count, &remain);
-		if (offset > 0) {
-			ret = 0;
-			map_bh(bh_result, inode->i_sb, offset);
-			if (remain > max_blocks)
-				remain = max_blocks;
-			bh_result->b_size = (remain << inode->i_blkbits);
-			goto out_brelse;
-		}
-		if (next == ~0)
-			break;
-
-		brelse(bh);
-		bh = omfs_bread(inode->i_sb, next);
-		if (!bh)
-			goto out;
-		oe = (struct omfs_extent *) (&bh->b_data[OMFS_EXTENT_CONT]);
-		max_extents = omfs_max_extents(sbi, OMFS_EXTENT_CONT);
-	}
-	if (create) {
-		ret = omfs_grow_extent(inode, oe, &new_block);
-		if (ret == 0) {
-			mark_buffer_dirty(bh);
-			mark_inode_dirty(inode);
-			map_bh(bh_result, inode->i_sb,
-					clus_to_blk(sbi, new_block));
-		}
-	}
-out_brelse:
-	brelse(bh);
-out:
-	return ret;
-}
-
-static int omfs_read_folio(struct file *file, struct folio *folio)
-{
-	return block_read_full_folio(folio, omfs_get_block);
-}
-
-static void omfs_readahead(struct readahead_control *rac)
-{
-	mpage_readahead(rac, omfs_get_block);
-}
-
-static int
-omfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
-{
-	return mpage_writepages(mapping, wbc, omfs_get_block);
-}
-
-static void omfs_write_failed(struct address_space *mapping, loff_t to)
-{
-	struct inode *inode = mapping->host;
-
-	if (to > inode->i_size) {
-		truncate_pagecache(inode, inode->i_size);
-		omfs_truncate(inode);
-	}
-}
-
-static int omfs_write_begin(const struct kiocb *iocb,
-			    struct address_space *mapping,
-			    loff_t pos, unsigned len,
-			    struct folio **foliop, void **fsdata)
-{
-	int ret;
-
-	ret = block_write_begin(mapping, pos, len, foliop, omfs_get_block);
-	if (unlikely(ret))
-		omfs_write_failed(mapping, pos + len);
-
-	return ret;
-}
-
-static sector_t omfs_bmap(struct address_space *mapping, sector_t block)
-{
-	return generic_block_bmap(mapping, block, omfs_get_block);
-}
-
-const struct file_operations omfs_file_operations = {
-	.llseek = generic_file_llseek,
-	.read_iter = generic_file_read_iter,
-	.write_iter = generic_file_write_iter,
-	.mmap_prepare = generic_file_mmap_prepare,
-	.fsync = simple_fsync,
-	.splice_read = filemap_splice_read,
-};
-
-static int omfs_setattr(const struct mnt_idmap *idmap,
-			struct dentry *dentry, struct iattr *attr)
-{
-	struct inode *inode = d_inode(dentry);
-	int error;
-
-	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
-	if (error)
-		return error;
-
-	if ((attr->ia_valid & ATTR_SIZE) &&
-	    attr->ia_size != i_size_read(inode)) {
-		error = inode_newsize_ok(inode, attr->ia_size);
-		if (error)
-			return error;
-		truncate_setsize(inode, attr->ia_size);
-		omfs_truncate(inode);
-	}
-
-	setattr_copy(&nop_mnt_idmap, inode, attr);
-	mark_inode_dirty(inode);
-	return 0;
-}
-
-const struct inode_operations omfs_file_inops = {
-	.setattr = omfs_setattr,
-};
-
-const struct address_space_operations omfs_aops = {
-	.dirty_folio = block_dirty_folio,
-	.invalidate_folio = block_invalidate_folio,
-	.read_folio = omfs_read_folio,
-	.readahead = omfs_readahead,
-	.writepages = omfs_writepages,
-	.write_begin = omfs_write_begin,
-	.write_end = generic_write_end,
-	.bmap = omfs_bmap,
-	.migrate_folio = buffer_migrate_folio,
-};
-
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
deleted file mode 100644
index bc37029a4af..00000000000
--- a/fs/omfs/inode.c
+++ /dev/null
@@ -1,664 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Optimized MPEG FS - inode and super operations.
- * Copyright (C) 2006 Bob Copeland <me@bobcopeland.com>
- */
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/vfs.h>
-#include <linux/cred.h>
-#include <linux/buffer_head.h>
-#include <linux/vmalloc.h>
-#include <linux/writeback.h>
-#include <linux/seq_file.h>
-#include <linux/crc-itu-t.h>
-#include <linux/fs_struct.h>
-#include <linux/fs_context.h>
-#include <linux/fs_parser.h>
-#include "omfs.h"
-
-MODULE_AUTHOR("Bob Copeland <me@bobcopeland.com>");
-MODULE_DESCRIPTION("OMFS (ReplayTV/Karma) Filesystem for Linux");
-MODULE_LICENSE("GPL");
-
-struct buffer_head *omfs_bread(struct super_block *sb, sector_t block)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	if (block >= sbi->s_num_blocks)
-		return NULL;
-
-	return sb_bread(sb, clus_to_blk(sbi, block));
-}
-
-struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
-{
-	struct inode *inode;
-	u64 new_block;
-	int err;
-	int len;
-	struct omfs_sb_info *sbi = OMFS_SB(dir->i_sb);
-
-	inode = new_inode(dir->i_sb);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
-
-	err = omfs_allocate_range(dir->i_sb, sbi->s_mirrors, sbi->s_mirrors,
-			&new_block, &len);
-	if (err)
-		goto fail;
-
-	inode->i_ino = new_block;
-	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
-	inode->i_mapping->a_ops = &omfs_aops;
-
-	simple_inode_init_ts(inode);
-	switch (mode & S_IFMT) {
-	case S_IFDIR:
-		inode->i_op = &omfs_dir_inops;
-		inode->i_fop = &omfs_dir_operations;
-		inode->i_size = sbi->s_sys_blocksize;
-		inc_nlink(inode);
-		break;
-	case S_IFREG:
-		inode->i_op = &omfs_file_inops;
-		inode->i_fop = &omfs_file_operations;
-		inode->i_size = 0;
-		break;
-	}
-
-	insert_inode_hash(inode);
-	mark_inode_dirty(inode);
-	return inode;
-fail:
-	make_bad_inode(inode);
-	iput(inode);
-	return ERR_PTR(err);
-}
-
-/*
- * Update the header checksums for a dirty inode based on its contents.
- * Caller is expected to hold the buffer head underlying oi and mark it
- * dirty.
- */
-static void omfs_update_checksums(struct omfs_inode *oi)
-{
-	int xor, i, ofs = 0, count;
-	u16 crc = 0;
-	unsigned char *ptr = (unsigned char *) oi;
-
-	count = be32_to_cpu(oi->i_head.h_body_size);
-	ofs = sizeof(struct omfs_header);
-
-	crc = crc_itu_t(crc, ptr + ofs, count);
-	oi->i_head.h_crc = cpu_to_be16(crc);
-
-	xor = ptr[0];
-	for (i = 1; i < OMFS_XOR_COUNT; i++)
-		xor ^= ptr[i];
-
-	oi->i_head.h_check_xor = xor;
-}
-
-static int __omfs_write_inode(struct inode *inode, int wait)
-{
-	struct omfs_inode *oi;
-	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
-	struct buffer_head *bh, *bh2;
-	u64 ctime;
-	int i;
-	int ret = -EIO;
-	int sync_failed = 0;
-
-	/* get current inode since we may have written sibling ptrs etc. */
-	bh = omfs_bread(inode->i_sb, inode->i_ino);
-	if (!bh)
-		goto out;
-
-	oi = (struct omfs_inode *) bh->b_data;
-
-	oi->i_head.h_self = cpu_to_be64(inode->i_ino);
-	if (S_ISDIR(inode->i_mode))
-		oi->i_type = OMFS_DIR;
-	else if (S_ISREG(inode->i_mode))
-		oi->i_type = OMFS_FILE;
-	else {
-		printk(KERN_WARNING "omfs: unknown file type: %d\n",
-			inode->i_mode);
-		goto out_brelse;
-	}
-
-	oi->i_head.h_body_size = cpu_to_be32(sbi->s_sys_blocksize -
-		sizeof(struct omfs_header));
-	oi->i_head.h_version = 1;
-	oi->i_head.h_type = OMFS_INODE_NORMAL;
-	oi->i_head.h_magic = OMFS_IMAGIC;
-	oi->i_size = cpu_to_be64(inode->i_size);
-
-	ctime = inode_get_ctime_sec(inode) * 1000LL +
-		((inode_get_ctime_nsec(inode) + 999)/1000);
-	oi->i_ctime = cpu_to_be64(ctime);
-
-	omfs_update_checksums(oi);
-
-	mark_buffer_dirty(bh);
-	if (wait) {
-		sync_dirty_buffer(bh);
-		if (buffer_write_io_error(bh))
-			sync_failed = 1;
-	}
-
-	/* if mirroring writes, copy to next fsblock */
-	for (i = 1; i < sbi->s_mirrors; i++) {
-		bh2 = omfs_bread(inode->i_sb, inode->i_ino + i);
-		if (!bh2)
-			goto out_brelse;
-
-		memcpy(bh2->b_data, bh->b_data, bh->b_size);
-		mark_buffer_dirty(bh2);
-		if (wait) {
-			sync_dirty_buffer(bh2);
-			if (buffer_write_io_error(bh2))
-				sync_failed = 1;
-		}
-		brelse(bh2);
-	}
-	ret = (sync_failed) ? -EIO : 0;
-out_brelse:
-	brelse(bh);
-out:
-	return ret;
-}
-
-static int omfs_write_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	return __omfs_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
-}
-
-int omfs_sync_inode(struct inode *inode)
-{
-	return __omfs_write_inode(inode, 1);
-}
-
-/*
- * called when an entry is deleted, need to clear the bits in the
- * bitmaps.
- */
-static void omfs_evict_inode(struct inode *inode)
-{
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
-
-	if (inode->i_nlink)
-		return;
-
-	if (S_ISREG(inode->i_mode)) {
-		inode->i_size = 0;
-		omfs_shrink_inode(inode);
-	}
-
-	omfs_clear_range(inode->i_sb, inode->i_ino, 2);
-}
-
-struct inode *omfs_iget(struct super_block *sb, ino_t ino)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	struct omfs_inode *oi;
-	struct buffer_head *bh;
-	u64 ctime;
-	unsigned long nsecs;
-	struct inode *inode;
-
-	inode = iget_locked(sb, ino);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
-	if (!(inode_state_read_once(inode) & I_NEW))
-		return inode;
-
-	bh = omfs_bread(inode->i_sb, ino);
-	if (!bh)
-		goto iget_failed;
-
-	oi = (struct omfs_inode *)bh->b_data;
-
-	/* check self */
-	if (ino != be64_to_cpu(oi->i_head.h_self))
-		goto fail_bh;
-
-	inode->i_uid = sbi->s_uid;
-	inode->i_gid = sbi->s_gid;
-
-	ctime = be64_to_cpu(oi->i_ctime);
-	nsecs = do_div(ctime, 1000) * 1000L;
-
-	inode_set_atime(inode, ctime, nsecs);
-	inode_set_mtime(inode, ctime, nsecs);
-	inode_set_ctime(inode, ctime, nsecs);
-
-	inode->i_mapping->a_ops = &omfs_aops;
-
-	switch (oi->i_type) {
-	case OMFS_DIR:
-		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~sbi->s_dmask);
-		inode->i_op = &omfs_dir_inops;
-		inode->i_fop = &omfs_dir_operations;
-		inode->i_size = sbi->s_sys_blocksize;
-		inc_nlink(inode);
-		break;
-	case OMFS_FILE:
-		inode->i_mode = S_IFREG | (S_IRWXUGO & ~sbi->s_fmask);
-		inode->i_fop = &omfs_file_operations;
-		inode->i_size = be64_to_cpu(oi->i_size);
-		break;
-	}
-	brelse(bh);
-	unlock_new_inode(inode);
-	return inode;
-fail_bh:
-	brelse(bh);
-iget_failed:
-	iget_failed(inode);
-	return ERR_PTR(-EIO);
-}
-
-static void omfs_put_super(struct super_block *sb)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	kfree(sbi->s_imap);
-	kfree(sbi);
-	sb->s_fs_info = NULL;
-}
-
-static int omfs_statfs(struct dentry *dentry, struct kstatfs *buf)
-{
-	struct super_block *s = dentry->d_sb;
-	struct omfs_sb_info *sbi = OMFS_SB(s);
-	u64 id = huge_encode_dev(s->s_bdev->bd_dev);
-
-	buf->f_type = OMFS_MAGIC;
-	buf->f_bsize = sbi->s_blocksize;
-	buf->f_blocks = sbi->s_num_blocks;
-	buf->f_files = sbi->s_num_blocks;
-	buf->f_namelen = OMFS_NAMELEN;
-	buf->f_fsid = u64_to_fsid(id);
-
-	buf->f_bfree = buf->f_bavail = buf->f_ffree =
-		omfs_count_free(s);
-
-	return 0;
-}
-
-/*
- * Display the mount options in /proc/mounts.
- */
-static int omfs_show_options(struct seq_file *m, struct dentry *root)
-{
-	struct omfs_sb_info *sbi = OMFS_SB(root->d_sb);
-	umode_t cur_umask = current_umask();
-
-	if (!uid_eq(sbi->s_uid, current_uid()))
-		seq_printf(m, ",uid=%u",
-			   from_kuid_munged(&init_user_ns, sbi->s_uid));
-	if (!gid_eq(sbi->s_gid, current_gid()))
-		seq_printf(m, ",gid=%u",
-			   from_kgid_munged(&init_user_ns, sbi->s_gid));
-
-	if (sbi->s_dmask == sbi->s_fmask) {
-		if (sbi->s_fmask != cur_umask)
-			seq_printf(m, ",umask=%o", sbi->s_fmask);
-	} else {
-		if (sbi->s_dmask != cur_umask)
-			seq_printf(m, ",dmask=%o", sbi->s_dmask);
-		if (sbi->s_fmask != cur_umask)
-			seq_printf(m, ",fmask=%o", sbi->s_fmask);
-	}
-
-	return 0;
-}
-
-static const struct super_operations omfs_sops = {
-	.write_inode	= omfs_write_inode,
-	.evict_inode	= omfs_evict_inode,
-	.put_super	= omfs_put_super,
-	.statfs		= omfs_statfs,
-	.show_options	= omfs_show_options,
-};
-
-/*
- * For Rio Karma, there is an on-disk free bitmap whose location is
- * stored in the root block.  For ReplayTV, there is no such free bitmap
- * so we have to walk the tree.  Both inodes and file data are allocated
- * from the same map.  This array can be big (300k) so we allocate
- * in units of the blocksize.
- */
-static int omfs_get_imap(struct super_block *sb)
-{
-	unsigned int bitmap_size, array_size;
-	int count;
-	struct omfs_sb_info *sbi = OMFS_SB(sb);
-	struct buffer_head *bh;
-	unsigned long **ptr;
-	sector_t block;
-
-	bitmap_size = DIV_ROUND_UP(sbi->s_num_blocks, 8);
-	array_size = DIV_ROUND_UP(bitmap_size, sb->s_blocksize);
-
-	if (sbi->s_bitmap_ino == ~0ULL)
-		goto out;
-
-	sbi->s_imap_size = array_size;
-	sbi->s_imap = kcalloc(array_size, sizeof(unsigned long *), GFP_KERNEL);
-	if (!sbi->s_imap)
-		goto nomem;
-
-	block = clus_to_blk(sbi, sbi->s_bitmap_ino);
-	if (block >= sbi->s_num_blocks)
-		goto nomem;
-
-	ptr = sbi->s_imap;
-	for (count = bitmap_size; count > 0; count -= sb->s_blocksize) {
-		bh = sb_bread(sb, block++);
-		if (!bh)
-			goto nomem_free;
-		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
-		if (!*ptr) {
-			brelse(bh);
-			goto nomem_free;
-		}
-		if (count < sb->s_blocksize)
-			memset((void *)*ptr + count, 0xff,
-				sb->s_blocksize - count);
-		brelse(bh);
-		ptr++;
-	}
-out:
-	return 0;
-
-nomem_free:
-	for (count = 0; count < array_size; count++)
-		kfree(sbi->s_imap[count]);
-
-	kfree(sbi->s_imap);
-nomem:
-	sbi->s_imap = NULL;
-	sbi->s_imap_size = 0;
-	return -ENOMEM;
-}
-
-struct omfs_mount_options {
-	kuid_t s_uid;
-	kgid_t s_gid;
-	int s_dmask;
-	int s_fmask;
-};
-
-enum {
-	Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask,
-};
-
-static const struct fs_parameter_spec omfs_param_spec[] = {
-	fsparam_uid	("uid",		Opt_uid),
-	fsparam_gid	("gid",		Opt_gid),
-	fsparam_u32oct	("umask",	Opt_umask),
-	fsparam_u32oct	("dmask",	Opt_dmask),
-	fsparam_u32oct	("fmask",	Opt_fmask),
-	{}
-};
-
-static int
-omfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
-{
-	struct omfs_mount_options *opts = fc->fs_private;
-	int token;
-	struct fs_parse_result result;
-
-	/* All options are ignored on remount */
-	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
-		return 0;
-
-	token = fs_parse(fc, omfs_param_spec, param, &result);
-	if (token < 0)
-		return token;
-
-	switch (token) {
-	case Opt_uid:
-		opts->s_uid = result.uid;
-		break;
-	case Opt_gid:
-		opts->s_gid = result.gid;
-		break;
-	case Opt_umask:
-		opts->s_fmask = opts->s_dmask = result.uint_32;
-		break;
-	case Opt_dmask:
-		opts->s_dmask = result.uint_32;
-		break;
-	case Opt_fmask:
-		opts->s_fmask = result.uint_32;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void
-omfs_set_options(struct omfs_sb_info *sbi, struct omfs_mount_options *opts)
-{
-	sbi->s_uid = opts->s_uid;
-	sbi->s_gid = opts->s_gid;
-	sbi->s_dmask = opts->s_dmask;
-	sbi->s_fmask = opts->s_fmask;
-}
-
-static int omfs_fill_super(struct super_block *sb, struct fs_context *fc)
-{
-	struct buffer_head *bh, *bh2;
-	struct omfs_super_block *omfs_sb;
-	struct omfs_root_block *omfs_rb;
-	struct omfs_sb_info *sbi;
-	struct inode *root;
-	struct omfs_mount_options *parsed_opts = fc->fs_private;
-	int ret = -EINVAL;
-	int silent = fc->sb_flags & SB_SILENT;
-
-	sbi = kzalloc_obj(struct omfs_sb_info);
-	if (!sbi)
-		return -ENOMEM;
-
-	sb->s_fs_info = sbi;
-
-	omfs_set_options(sbi, parsed_opts);
-
-	sb->s_maxbytes = 0xffffffff;
-
-	sb->s_time_gran = NSEC_PER_MSEC;
-	sb->s_time_min = 0;
-	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
-
-	if (!sb_set_blocksize(sb, 0x200))
-		goto end;
-
-	bh = sb_bread(sb, 0);
-	if (!bh)
-		goto end;
-
-	omfs_sb = (struct omfs_super_block *)bh->b_data;
-
-	if (omfs_sb->s_magic != cpu_to_be32(OMFS_MAGIC)) {
-		if (!silent)
-			printk(KERN_ERR "omfs: Invalid superblock (%x)\n",
-				   omfs_sb->s_magic);
-		goto out_brelse_bh;
-	}
-	sb->s_magic = OMFS_MAGIC;
-
-	sbi->s_num_blocks = be64_to_cpu(omfs_sb->s_num_blocks);
-	sbi->s_blocksize = be32_to_cpu(omfs_sb->s_blocksize);
-	sbi->s_mirrors = be32_to_cpu(omfs_sb->s_mirrors);
-	sbi->s_root_ino = be64_to_cpu(omfs_sb->s_root_block);
-	sbi->s_sys_blocksize = be32_to_cpu(omfs_sb->s_sys_blocksize);
-	mutex_init(&sbi->s_bitmap_lock);
-
-	if (sbi->s_num_blocks > OMFS_MAX_BLOCKS) {
-		printk(KERN_ERR "omfs: sysblock number (%llx) is out of range\n",
-		       (unsigned long long)sbi->s_num_blocks);
-		goto out_brelse_bh;
-	}
-
-	if (sbi->s_sys_blocksize > PAGE_SIZE) {
-		printk(KERN_ERR "omfs: sysblock size (%d) is out of range\n",
-			sbi->s_sys_blocksize);
-		goto out_brelse_bh;
-	}
-
-	if (sbi->s_sys_blocksize < OMFS_DIR_START) {
-		printk(KERN_ERR "omfs: sysblock size (%d) is too small\n",
-			sbi->s_sys_blocksize);
-		goto out_brelse_bh;
-	}
-
-	if (sbi->s_blocksize < sbi->s_sys_blocksize ||
-	    sbi->s_blocksize > OMFS_MAX_BLOCK_SIZE) {
-		printk(KERN_ERR "omfs: block size (%d) is out of range\n",
-			sbi->s_blocksize);
-		goto out_brelse_bh;
-	}
-
-	/*
-	 * Use sys_blocksize as the fs block since it is smaller than a
-	 * page while the fs blocksize can be larger.
-	 */
-	if (!sb_set_blocksize(sb, sbi->s_sys_blocksize))
-		goto out_brelse_bh;
-
-	/*
-	 * ...and the difference goes into a shift.  sys_blocksize is always
-	 * a power of two factor of blocksize.
-	 */
-	sbi->s_block_shift = get_bitmask_order(sbi->s_blocksize) -
-		get_bitmask_order(sbi->s_sys_blocksize);
-
-	bh2 = omfs_bread(sb, be64_to_cpu(omfs_sb->s_root_block));
-	if (!bh2)
-		goto out_brelse_bh;
-
-	omfs_rb = (struct omfs_root_block *)bh2->b_data;
-
-	sbi->s_bitmap_ino = be64_to_cpu(omfs_rb->r_bitmap);
-	sbi->s_clustersize = be32_to_cpu(omfs_rb->r_clustersize);
-
-	if (sbi->s_num_blocks != be64_to_cpu(omfs_rb->r_num_blocks)) {
-		printk(KERN_ERR "omfs: block count discrepancy between "
-			"super and root blocks (%llx, %llx)\n",
-			(unsigned long long)sbi->s_num_blocks,
-			(unsigned long long)be64_to_cpu(omfs_rb->r_num_blocks));
-		goto out_brelse_bh2;
-	}
-
-	if (sbi->s_bitmap_ino != ~0ULL &&
-	    sbi->s_bitmap_ino > sbi->s_num_blocks) {
-		printk(KERN_ERR "omfs: free space bitmap location is corrupt "
-			"(%llx, total blocks %llx)\n",
-			(unsigned long long) sbi->s_bitmap_ino,
-			(unsigned long long) sbi->s_num_blocks);
-		goto out_brelse_bh2;
-	}
-	if (sbi->s_clustersize < 1 ||
-	    sbi->s_clustersize > OMFS_MAX_CLUSTER_SIZE) {
-		printk(KERN_ERR "omfs: cluster size out of range (%d)",
-			sbi->s_clustersize);
-		goto out_brelse_bh2;
-	}
-
-	ret = omfs_get_imap(sb);
-	if (ret)
-		goto out_brelse_bh2;
-
-	sb->s_op = &omfs_sops;
-
-	root = omfs_iget(sb, be64_to_cpu(omfs_rb->r_root_dir));
-	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out_brelse_bh2;
-	}
-
-	sb->s_root = d_make_root(root);
-	if (!sb->s_root) {
-		ret = -ENOMEM;
-		goto out_brelse_bh2;
-	}
-	printk(KERN_DEBUG "omfs: Mounted volume %s\n", omfs_rb->r_name);
-
-	ret = 0;
-out_brelse_bh2:
-	brelse(bh2);
-out_brelse_bh:
-	brelse(bh);
-end:
-	if (ret)
-		kfree(sbi);
-	return ret;
-}
-
-static int omfs_get_tree(struct fs_context *fc)
-{
-	return get_tree_bdev(fc, omfs_fill_super);
-}
-
-static void omfs_free_fc(struct fs_context *fc);
-
-static const struct fs_context_operations omfs_context_ops = {
-	.parse_param	= omfs_parse_param,
-	.get_tree	= omfs_get_tree,
-	.free		= omfs_free_fc,
-};
-
-static int omfs_init_fs_context(struct fs_context *fc)
-{
-	struct omfs_mount_options *opts;
-
-	opts = kzalloc_obj(*opts);
-	if (!opts)
-		return -ENOMEM;
-
-	/* Set mount options defaults */
-	opts->s_uid = current_uid();
-	opts->s_gid = current_gid();
-	opts->s_dmask = opts->s_fmask = current_umask();
-
-	fc->fs_private = opts;
-	fc->ops = &omfs_context_ops;
-
-	return 0;
-}
-
-static void omfs_free_fc(struct fs_context *fc)
-{
-	kfree(fc->fs_private);
-}
-
-static struct file_system_type omfs_fs_type = {
-	.owner		 = THIS_MODULE,
-	.name		 = "omfs",
-	.kill_sb	 = kill_block_super,
-	.fs_flags	 = FS_REQUIRES_DEV,
-	.init_fs_context = omfs_init_fs_context,
-	.parameters	 = omfs_param_spec,
-};
-MODULE_ALIAS_FS("omfs");
-
-static int __init init_omfs_fs(void)
-{
-	return register_filesystem(&omfs_fs_type);
-}
-
-static void __exit exit_omfs_fs(void)
-{
-	unregister_filesystem(&omfs_fs_type);
-}
-
-module_init(init_omfs_fs);
-module_exit(exit_omfs_fs);
diff --git a/fs/omfs/omfs.h b/fs/omfs/omfs.h
deleted file mode 100644
index 4008be73de5..00000000000
--- a/fs/omfs/omfs.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _OMFS_H
-#define _OMFS_H
-
-#include <linux/module.h>
-#include <linux/fs.h>
-
-#include "omfs_fs.h"
-
-/* In-memory structures */
-struct omfs_sb_info {
-	u64 s_num_blocks;
-	u64 s_bitmap_ino;
-	u64 s_root_ino;
-	u32 s_blocksize;
-	u32 s_mirrors;
-	u32 s_sys_blocksize;
-	u32 s_clustersize;
-	int s_block_shift;
-	unsigned long **s_imap;
-	int s_imap_size;
-	struct mutex s_bitmap_lock;
-	kuid_t s_uid;
-	kgid_t s_gid;
-	int s_dmask;
-	int s_fmask;
-};
-
-/* convert a cluster number to a scaled block number */
-static inline sector_t clus_to_blk(struct omfs_sb_info *sbi, sector_t block)
-{
-	return block << sbi->s_block_shift;
-}
-
-static inline struct omfs_sb_info *OMFS_SB(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
-/* bitmap.c */
-extern unsigned long omfs_count_free(struct super_block *sb);
-extern int omfs_allocate_block(struct super_block *sb, u64 block);
-extern int omfs_allocate_range(struct super_block *sb, int min_request,
-			int max_request, u64 *return_block, int *return_size);
-extern int omfs_clear_range(struct super_block *sb, u64 block, int count);
-
-/* dir.c */
-extern const struct file_operations omfs_dir_operations;
-extern const struct inode_operations omfs_dir_inops;
-extern int omfs_make_empty(struct inode *inode, struct super_block *sb);
-extern int omfs_is_bad(struct omfs_sb_info *sbi, struct omfs_header *header,
-			u64 fsblock);
-
-/* file.c */
-extern const struct file_operations omfs_file_operations;
-extern const struct inode_operations omfs_file_inops;
-extern const struct address_space_operations omfs_aops;
-extern void omfs_make_empty_table(struct buffer_head *bh, int offset);
-extern int omfs_shrink_inode(struct inode *inode);
-
-/* inode.c */
-extern struct buffer_head *omfs_bread(struct super_block *sb, sector_t block);
-extern struct inode *omfs_iget(struct super_block *sb, ino_t inode);
-extern struct inode *omfs_new_inode(struct inode *dir, umode_t mode);
-extern int omfs_reserve_block(struct super_block *sb, sector_t block);
-extern int omfs_find_empty_block(struct super_block *sb, int mode, ino_t *ino);
-extern int omfs_sync_inode(struct inode *inode);
-
-#endif
diff --git a/fs/omfs/omfs_fs.h b/fs/omfs/omfs_fs.h
deleted file mode 100644
index 1ff6b9e4129..00000000000
--- a/fs/omfs/omfs_fs.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _OMFS_FS_H
-#define _OMFS_FS_H
-
-/* OMFS On-disk structures */
-
-#define OMFS_MAGIC 0xC2993D87
-#define OMFS_IMAGIC 0xD2
-
-#define OMFS_DIR 'D'
-#define OMFS_FILE 'F'
-#define OMFS_INODE_NORMAL 'e'
-#define OMFS_INODE_CONTINUATION 'c'
-#define OMFS_INODE_SYSTEM 's'
-#define OMFS_NAMELEN 256
-#define OMFS_DIR_START 0x1b8
-#define OMFS_EXTENT_START 0x1d0
-#define OMFS_EXTENT_CONT 0x40
-#define OMFS_XOR_COUNT 19
-#define OMFS_MAX_BLOCK_SIZE 8192
-#define OMFS_MAX_CLUSTER_SIZE 8
-#define OMFS_MAX_BLOCKS (1ul << 31)
-
-struct omfs_super_block {
-	char s_fill1[256];
-	__be64 s_root_block;		/* block number of omfs_root_block */
-	__be64 s_num_blocks;		/* total number of FS blocks */
-	__be32 s_magic;			/* OMFS_MAGIC */
-	__be32 s_blocksize;		/* size of a block */
-	__be32 s_mirrors;		/* # of mirrors of system blocks */
-	__be32 s_sys_blocksize;		/* size of non-data blocks */
-};
-
-struct omfs_header {
-	__be64 h_self;			/* FS block where this is located */
-	__be32 h_body_size;		/* size of useful data after header */
-	__be16 h_crc;			/* crc-ccitt of body_size bytes */
-	char h_fill1[2];
-	u8 h_version;			/* version, always 1 */
-	char h_type;			/* OMFS_INODE_X */
-	u8 h_magic;			/* OMFS_IMAGIC */
-	u8 h_check_xor;			/* XOR of header bytes before this */
-	__be32 h_fill2;
-};
-
-struct omfs_root_block {
-	struct omfs_header r_head;	/* header */
-	__be64 r_fill1;
-	__be64 r_num_blocks;		/* total number of FS blocks */
-	__be64 r_root_dir;		/* block # of root directory */
-	__be64 r_bitmap;		/* block # of free space bitmap */
-	__be32 r_blocksize;		/* size of a block */
-	__be32 r_clustersize;		/* size allocated for data blocks */
-	__be64 r_mirrors;		/* # of mirrors of system blocks */
-	char r_name[OMFS_NAMELEN];	/* partition label */
-};
-
-struct omfs_inode {
-	struct omfs_header i_head;	/* header */
-	__be64 i_parent;		/* parent containing this inode */
-	__be64 i_sibling;		/* next inode in hash bucket */
-	__be64 i_ctime;			/* ctime, in milliseconds */
-	char i_fill1[35];
-	char i_type;			/* OMFS_[DIR,FILE] */
-	__be32 i_fill2;
-	char i_fill3[64];
-	char i_name[OMFS_NAMELEN];	/* filename */
-	__be64 i_size;			/* size of file, in bytes */
-};
-
-struct omfs_extent_entry {
-	__be64 e_cluster;		/* start location of a set of blocks */
-	__be64 e_blocks;		/* number of blocks after e_cluster */
-};
-
-struct omfs_extent {
-	__be64 e_next;			/* next extent table location */
-	__be32 e_extent_count;		/* total # extents in this table */
-	__be32 e_fill;
-	struct omfs_extent_entry e_entry[];	/* start of extent entries */
-};
-
-#endif
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index b237a95ec9f..562adca8998 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -27,7 +27,7 @@ static const char *const known_fs[] = {
 	"hfsplus", "hostfs", "hpfs", "hugetlbfs", "ibmasmfs", "iomem",
 	"ipathfs", "iso9660", "jffs2", "jfs", "minix", "mqueue", "msdos",
 	"nfs", "nfs4", "nfsd", "nilfs2", "nsfs", "ntfs", "ntfs3", "ocfs2",
-	"ocfs2_dlmfs", "omfs", "openpromfs", "overlay", "pipefs", "proc",
+	"ocfs2_dlmfs", "openpromfs", "overlay", "pipefs", "proc",
 	"pstore", "pvfs2", "qnx4", "qnx6", "ramfs", "resctrl", "romfs",
 	"rootfs", "rpc_pipefs", "s390_hypfs", "secretmem", "securityfs",
 	"selinuxfs", "smackfs", "smb3", "sockfs", "spufs", "squashfs", "sysfs",

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)


