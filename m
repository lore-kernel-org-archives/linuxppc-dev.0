Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15407C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Nov 2021 20:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzG3j3rH1z3dl4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Nov 2021 07:30:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p4mf9rgo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mcgrof@infradead.org; receiver=<UNKNOWN>)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzFxQ1XDWz2ymv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Nov 2021 07:24:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=PX6DFmuLauFsaWJNNGOxexZiiMzG6E0BCx21ecGYmG8=; b=p4mf9rgotBvhOXxYctzEKxvkuw
 zrpJ9fPlUIXVJjH6FTSFS2v21dS1rJtBCGpWwgC+2YpOrxzIL9CRSvnh8wCIitMFaz2Tr3v74iCZp
 DwTogfRlUVv5pysKD/6AWlrVTu+2R2h9FNL/BFNf67UR/7tF+9a+49vgov0vRXz1xRC7sEEJIdbpK
 FduY1Wskwp/rVQKTpAVa9EUlLTDJar/pqmQsZRuiTc6uGjVRoX9rbM4XwSKe4G4vyfQU2JZarWXQD
 oHTenr2J3guLvmo+5BMr2z1ZEWwZ2CqI7k7bmkUMTMNRM/xXyTnzLqkL98/Ad3oYhfZgKJsQu3z5Y
 1bLwPwfQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mpcL1-003R5B-67; Tue, 23 Nov 2021 20:24:23 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org, keescook@chromium.org,
	yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
	clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
	airlied@linux.ie, "daniel@ffwll.chairlied"@linux.ie,
	benh@kernel.crashing.org, mark@fasheh.com, jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com, jack@suse.cz, amir73il@gmail.com,
	phil@philpotter.co.uk, viro@zeniv.linux.org.uk, julia.lawall@inria.fr
Subject: [PATCH v2 0/8] sysctl: second set of kernel/sysctl cleanups
Date: Tue, 23 Nov 2021 12:24:14 -0800
Message-Id: <20211123202422.819032-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Luis Chamberlain <mcgrof@kernel.org>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the 2nd set of kernel/sysctl.c cleanups. The diff stat should
reflect how this is a much better way to deal with theses. Fortunately
coccinelle can be used to ensure correctness for most of these and/or
future merge conflicts.

Note that since this is part of a larger effort to cleanup
kernel/sysctl.c I think we have no other option but to go with
merging these patches in either Andrew's tree or keep them staged
in a separate tree and send a merge request later. Otherwise
kernel/sysctl.c will end up becoming a sore spot for the next
merge window.

Changes in this v2:

 * As suggested by Eric W. Biederman I dropped the subdir new call
   and just used the register_sysctl() by specifying the parent
   directory.
 * 0-day cleanups, commit log enhancements
 * Updated the coccinelle patch with register_sysctl()

Luis Chamberlain (6):
  hpet: simplify subdirectory registration with register_sysctl()
  i915: simplify subdirectory registration with register_sysctl()
  macintosh/mac_hid.c: simplify subdirectory registration with
    register_sysctl()
  ocfs2: simplify subdirectory registration with register_sysctl()
  test_sysctl: simplify subdirectory registration with register_sysctl()
  cdrom: simplify subdirectory registration with register_sysctl()

Xiaoming Ni (2):
  inotify: simplify subdirectory registration with register_sysctl()
  eventpoll: simplify sysctl declaration with register_sysctl()

 drivers/cdrom/cdrom.c            | 23 +----------------------
 drivers/char/hpet.c              | 22 +---------------------
 drivers/gpu/drm/i915/i915_perf.c | 22 +---------------------
 drivers/macintosh/mac_hid.c      | 24 +-----------------------
 fs/eventpoll.c                   | 10 +++++++++-
 fs/notify/inotify/inotify_user.c | 11 ++++++++++-
 fs/ocfs2/stackglue.c             | 25 +------------------------
 include/linux/inotify.h          |  3 ---
 include/linux/poll.h             |  2 --
 include/linux/sysctl.h           |  1 -
 kernel/sysctl.c                  | 28 ----------------------------
 lib/test_sysctl.c                | 22 +---------------------
 12 files changed, 25 insertions(+), 168 deletions(-)

-- 
2.33.0

