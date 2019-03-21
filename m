Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E885DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3276321915
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3276321915
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Q4pl52jQzDqSQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 22:50:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Q4lx0PWgzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 22:47:41 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 559B988AB5;
 Thu, 21 Mar 2019 11:47:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com
 [10.10.121.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0F605D9C5;
 Thu, 21 Mar 2019 11:47:32 +0000 (UTC)
Subject: [RFC PATCH 0/8] Convert mount_single-using filesystems to fs_context
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Date: Thu, 21 Mar 2019 11:47:32 +0000
Message-ID: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 21 Mar 2019 11:47:39 +0000 (UTC)
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
Cc: linux-s390@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Vorontsov <anton@enomsg.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 Jeremy Kerr <jk@ozlabs.org>, Colin Cross <ccross@android.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi Al,

Here's a set of patches that converts the mount_single()-using filesystems
to use the new fs_context struct.  There may be prerequisite commits in the
branch detailed below.

 (1) Add a new keying to vfs_get_super() that indicates that
     ->reconfigure() should be called instead of (*fill_super)() if the
     superblock already exists.

 (2) Convert debugfs.

 (3) Convert tracefs.

 (4) Convert pstore.

 (5) Fix a bug in hypfs.

 (6) Convert hypfs.

 (7) Convert spufs.

 (8) Kill off mount_single().

These can be found in the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (8):
      vfs: Add a single-or-reconfig keying to vfs_get_super()
      vfs: Convert debugfs to fs_context
      vfs: Convert tracefs to fs_context
      vfs: Convert pstore to fs_context
      hypfs: Fix error number left in struct pointer member
      vfs: Convert hypfs to fs_context
      vfs: Convert spufs to fs_context
      vfs: Kill off mount_single()


 Documentation/filesystems/vfs.txt         |    4 -
 arch/powerpc/platforms/cell/spufs/inode.c |  207 ++++++++++++++++-------------
 arch/s390/hypfs/inode.c                   |  137 +++++++++++--------
 fs/debugfs/inode.c                        |  186 ++++++++++++--------------
 fs/pstore/inode.c                         |  110 ++++++++++-----
 fs/super.c                                |   73 ++--------
 fs/tracefs/inode.c                        |  180 ++++++++++++-------------
 include/linux/fs.h                        |    3 
 include/linux/fs_context.h                |    1 
 9 files changed, 446 insertions(+), 455 deletions(-)

