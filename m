Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A589C10F00
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 02:17:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350652075C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 02:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350652075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44V7mW6998zDqFM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 13:17:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44V4Hz2rfCzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 10:40:44 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DC9081F2F;
 Wed, 27 Mar 2019 23:40:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com
 [10.10.121.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B92419C5A;
 Wed, 27 Mar 2019 23:40:01 +0000 (UTC)
Subject: [RFC PATCH 00/68] VFS: Convert a bunch of filesystems to the new
 mount API
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Date: Wed, 27 Mar 2019 23:40:00 +0000
Message-ID: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 27 Mar 2019 23:40:41 +0000 (UTC)
X-Mailman-Approved-At: Thu, 28 Mar 2019 13:15:36 +1100
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, dri-devel@lists.freedesktop.org,
 "J. Bruce Fields" <bfields@fieldses.org>, ceph-devel@vger.kernel.org,
 Mike Marshall <hubcap@omnibond.com>, xen-devel@lists.xenproject.org,
 devel@lists.orangefs.org, Felipe Balbi <balbi@kernel.org>,
 Uma Krishnan <ukrishn@linux.ibm.com>, "Manoj N. Kumar" <manoj@linux.ibm.com>,
 Joel Becker <jlbec@evilplan.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Arve =?utf-8?b?SGrDuG5uZXbDpWc=?= <arve@android.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Martin Brandenburg <martin@omnibond.com>, linux-ia64@vger.kernel.org,
 David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org,
 Keith Busch <keith.busch@intel.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Matthew Garrett <matthew.garrett@nebula.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Andreas Schwab <schwab@suse.de>, Anton Vorontsov <anton@enomsg.org>,
 Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
 Yonghong Song <yhs@fb.com>, Todd Kjos <tkjos@android.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, selinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Casey Schaufler <casey@schaufler-ca.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Nitin Gupta <ngupta@vflare.org>,
 Martijn Coenen <maco@android.com>, Tony Luck <tony.luck@intel.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>, linux-nvdimm@lists.01.org,
 "Yan, Zheng" <zyan@redhat.com>, Minchan Kim <minchan@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, linux-efi@vger.kernel.org,
 linux-aio@kvack.org, Jason Wang <jasowang@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Chris Mason <clm@fb.com>,
 linux-mtd@lists.infradead.org, Joel Fernandes <joel@joelfernandes.org>,
 Dave Jiang <dave.jiang@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org,
 coda@cs.cmu.edu, Andrew Price <anprice@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Fenghua Yu <fenghua.yu@intel.com>, Robert Richter <rric@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Eric Paris <eparis@parisplace.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian Brauner <christian@brauner.io>, Jan Harkes <jaharkes@cs.cmu.edu>,
 linux-nfs@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-s390@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Colin Cross <ccross@android.com>, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 Anna Schumaker <anna.schumaker@netapp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, dhowells@redhat.com, linux-mm@kvack.org,
 devel@driverdev.osuosl.org, Sage Weil <sage@redhat.com>,
 Nicolas Pitre <nico@linaro.org>, Richard Weinberger <richard@nod.at>,
 cluster-devel@redhat.com, Marek Vasut <marek.vasut@gmail.com>,
 oprofile-list@lists.sf.net, squashfs-devel@lists.sourceforge.net,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, apparmor@lists.ubuntu.com,
 Josef Bacik <josef@toxicpanda.com>,
 =?utf-8?q?Micha=C5=82?= Nazarewicz <mina86@mina86.com>,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Juergen Gross <jgross@suse.com>, John Johansen <john.johansen@canonical.com>,
 linux-scsi@vger.kernel.org, Artem Bityutskiy <dedekind1@gmail.com>,
 netdev@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 linux-security-module@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
 Daniel Vetter <daniel@ffwll.ch>, Vishal Verma <vishal.l.verma@intel.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 David Woodhouse <dwmw2@infradead.org>, linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi Al,

Here's a set of patches that converts a bunch (but not yet all!) to the new
mount API.  To this end, it makes the following changes:

 (1) Provides a convenience member in struct fs_context that is OR'd into
     sb->s_iflags by sget_fc().

 (2) Provides a convenience helper function, vfs_init_pseudo_fs_context(),
     for doing most of the work in mounting a pseudo filesystem.

 (3) Provides a convenience helper function, vfs_get_block_super(), for
     doing the work in setting up a block-based superblock.

 (4) Improves the handling of fd-type parameters.

 (5) Moves some of the subtype handling int fuse.

 (6) Provides a convenience helper function, vfs_get_mtd_super(), for
     doing the work in setting up an MTD device-based superblock.

 (7) Kills off mount_pseudo(), mount_pseudo_xattr(), mount_ns(),
     sget_userns(), mount_mtd(), mount_single().

 (8) Converts a slew of filesystems to use the mount API.

 (9) Fixes a bug in hypfs.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	mount-api-viro

David
---
Andrew Price (1):
      gfs2: Convert gfs2 to fs_context

David Howells (66):
      vfs: Update mount API docs
      vfs: Fix refcounting of filenames in fs_parser
      vfs: Provide sb->s_iflags settings in fs_context struct
      vfs: Provide a mount_pseudo-replacement for the new mount API
      vfs: Convert aio to use the new mount API
      vfs: Convert anon_inodes to use the new mount API
      vfs: Convert bdev to use the new mount API
      vfs: Convert nsfs to use the new mount API
      vfs: Convert pipe to use the new mount API
      vfs: Convert zsmalloc to use the new mount API
      vfs: Convert sockfs to use the new mount API
      vfs: Convert dax to use the new mount API
      vfs: Convert drm to use the new mount API
      vfs: Convert ia64 perfmon to use the new mount API
      vfs: Convert cxl to use the new mount API
      vfs: Convert ocxlflash to use the new mount API
      vfs: Convert virtio_balloon to use the new mount API
      vfs: Convert btrfs_test to use the new mount API
      vfs: Kill off mount_pseudo() and mount_pseudo_xattr()
      vfs: Use sget_fc() for pseudo-filesystems
      vfs: Convert binderfs to use the new mount API
      vfs: Convert nfsctl to use the new mount API
      vfs: Convert rpc_pipefs to use the new mount API
      vfs: Kill mount_ns()
      vfs: Kill sget_userns()
      vfs: Convert binfmt_misc to use the new mount API
      vfs: Convert configfs to use the new mount API
      vfs: Convert efivarfs to use the new mount API
      vfs: Convert fusectl to use the new mount API
      vfs: Convert qib_fs/ipathfs to use the new mount API
      vfs: Convert ibmasmfs to use the new mount API
      vfs: Convert oprofilefs to use the new mount API
      vfs: Convert gadgetfs to use the new mount API
      vfs: Convert xenfs to use the new mount API
      vfs: Convert openpromfs to use the new mount API
      vfs: Convert apparmorfs to use the new mount API
      vfs: Convert securityfs to use the new mount API
      vfs: Convert selinuxfs to use the new mount API
      vfs: Convert smackfs to use the new mount API
      vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API
      vfs: Create fs_context-aware mount_bdev() replacement
      vfs: Make fs_parse() handle fs_param_is_fd-type params better
      vfs: Convert fuse to use the new mount API
      vfs: Move the subtype parameter into fuse
      mtd: Provide fs_context-aware mount_mtd() replacement
      vfs: Convert romfs to use the new mount API
      vfs: Convert cramfs to use the new mount API
      vfs: Convert jffs2 to use the new mount API
      mtd: Kill mount_mtd()
      vfs: Convert squashfs to use the new mount API
      vfs: Convert ceph to use the new mount API
      vfs: Convert functionfs to use the new mount API
      vfs: Add a single-or-reconfig keying to vfs_get_super()
      vfs: Convert debugfs to use the new mount API
      vfs: Convert tracefs to use the new mount API
      vfs: Convert pstore to use the new mount API
      hypfs: Fix error number left in struct pointer member
      vfs: Convert hypfs to use the new mount API
      vfs: Convert spufs to use the new mount API
      vfs: Kill mount_single()
      vfs: Convert coda to use the new mount API
      vfs: Convert autofs to use the new mount API
      vfs: Convert devpts to use the new mount API
      vfs: Convert bpf to use the new mount API
      vfs: Convert ubifs to use the new mount API
      vfs: Convert orangefs to use the new mount API

Masahiro Yamada (1):
      kbuild: skip sub-make for in-tree build with GNU Make 4.x


 Documentation/filesystems/mount_api.txt   |  367 ++++++++-------
 Documentation/filesystems/vfs.txt         |    4 
 Makefile                                  |   31 +
 arch/ia64/kernel/perfmon.c                |   14 -
 arch/powerpc/platforms/cell/spufs/inode.c |  207 +++++----
 arch/s390/hypfs/inode.c                   |  137 +++---
 drivers/android/binderfs.c                |  173 ++++---
 drivers/base/devtmpfs.c                   |   16 -
 drivers/block/rbd.c                       |  363 ++++++++-------
 drivers/dax/super.c                       |   13 -
 drivers/gpu/drm/drm_drv.c                 |   14 -
 drivers/infiniband/hw/qib/qib_fs.c        |   26 +
 drivers/misc/cxl/api.c                    |   10 
 drivers/misc/ibmasm/ibmasmfs.c            |   21 +
 drivers/mtd/mtdcore.h                     |    1 
 drivers/mtd/mtdsuper.c                    |  181 ++++----
 drivers/oprofile/oprofilefs.c             |   20 +
 drivers/scsi/cxlflash/ocxl_hw.c           |   21 -
 drivers/usb/gadget/function/f_fs.c        |  233 +++++-----
 drivers/usb/gadget/legacy/inode.c         |   21 +
 drivers/virtio/virtio_balloon.c           |   19 -
 drivers/xen/xenfs/super.c                 |   21 +
 fs/aio.c                                  |   15 -
 fs/anon_inodes.c                          |   12 
 fs/autofs/autofs_i.h                      |   13 -
 fs/autofs/init.c                          |    9 
 fs/autofs/inode.c                         |  429 ++++++++++--------
 fs/binfmt_misc.c                          |   20 +
 fs/block_dev.c                            |   14 -
 fs/btrfs/tests/btrfs-tests.c              |   13 -
 fs/ceph/cache.c                           |    9 
 fs/ceph/cache.h                           |    5 
 fs/ceph/super.c                           |  697 ++++++++++++++---------------
 fs/ceph/super.h                           |    1 
 fs/coda/inode.c                           |  171 +++++--
 fs/configfs/mount.c                       |   20 +
 fs/cramfs/inode.c                         |   69 ++-
 fs/debugfs/inode.c                        |  186 ++++----
 fs/devpts/inode.c                         |  265 +++++------
 fs/efivarfs/super.c                       |   20 +
 fs/fs_context.c                           |   16 -
 fs/fs_parser.c                            |   18 +
 fs/fuse/control.c                         |   20 +
 fs/fuse/inode.c                           |  291 +++++++-----
 fs/gfs2/incore.h                          |    8 
 fs/gfs2/ops_fstype.c                      |  495 ++++++++++++++++-----
 fs/gfs2/super.c                           |  335 --------------
 fs/gfs2/super.h                           |    3 
 fs/jffs2/fs.c                             |   21 -
 fs/jffs2/os-linux.h                       |    4 
 fs/jffs2/super.c                          |  172 +++----
 fs/libfs.c                                |   91 +++-
 fs/nfsd/nfsctl.c                          |   33 +
 fs/nsfs.c                                 |   13 -
 fs/openpromfs/inode.c                     |   20 +
 fs/orangefs/orangefs-kernel.h             |    8 
 fs/orangefs/orangefs-mod.c                |    3 
 fs/orangefs/super.c                       |  186 ++++----
 fs/pipe.c                                 |   12 
 fs/pstore/inode.c                         |  109 +++--
 fs/ramfs/inode.c                          |  104 +++-
 fs/romfs/super.c                          |   46 +-
 fs/squashfs/super.c                       |  100 ++--
 fs/super.c                                |  301 ++++++-------
 fs/tracefs/inode.c                        |  180 +++----
 fs/ubifs/super.c                          |  447 ++++++++-----------
 include/linux/ceph/ceph_debug.h           |    1 
 include/linux/ceph/libceph.h              |   17 +
 include/linux/fs.h                        |   24 -
 include/linux/fs_context.h                |   20 +
 include/linux/mtd/super.h                 |    6 
 include/linux/ramfs.h                     |    6 
 include/linux/shmem_fs.h                  |    4 
 init/do_mounts.c                          |   12 
 kernel/bpf/inode.c                        |   92 ++--
 mm/shmem.c                                |  396 +++++++++++-----
 mm/zsmalloc.c                             |   19 -
 net/ceph/ceph_common.c                    |  410 +++++++----------
 net/socket.c                              |   14 -
 net/sunrpc/rpc_pipe.c                     |   34 +
 security/apparmor/apparmorfs.c            |   20 +
 security/inode.c                          |   21 +
 security/selinux/selinuxfs.c              |   20 +
 security/smack/smackfs.c                  |   34 +
 84 files changed, 4257 insertions(+), 3810 deletions(-)

