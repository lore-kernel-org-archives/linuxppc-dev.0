Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:03:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D14D2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D14D2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LD3q59FPzDqR6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:03:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Kttw6tY2zDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 03:09:07 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B28B30894FB;
 Thu, 14 Mar 2019 16:09:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com
 [10.10.121.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF1385C21F;
 Thu, 14 Mar 2019 16:08:45 +0000 (UTC)
Subject: [PATCH 00/38] VFS: Convert trivial filesystems and more
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Date: Thu, 14 Mar 2019 16:08:44 +0000
Message-ID: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 14 Mar 2019 16:09:05 +0000 (UTC)
X-Mailman-Approved-At: Fri, 15 Mar 2019 16:01:23 +1100
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
Cc: Uma Krishnan <ukrishn@linux.ibm.com>, linux-aio@kvack.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Jason Wang <jasowang@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Keith Busch <keith.busch@intel.com>,
 Chris Mason <clm@fb.com>, Joel Fernandes <joel@joelfernandes.org>,
 Todd Kjos <tkjos@android.com>, "Manoj N. Kumar" <manoj@linux.ibm.com>,
 Christoph Hellwig <hch@lst.de>, devel@driverdev.osuosl.org,
 Matthew Garrett <matthew.garrett@nebula.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Paul Moore <paul@paul-moore.com>, linux-scsi@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Hugh Dickins <hughd@google.com>,
 Arve =?utf-8?b?SGrDuG5uZXbDpWc=?= <arve@android.com>,
 oprofile-list@lists.sf.net, "J. Bruce Fields" <bfields@fieldses.org>,
 xen-devel@lists.xenproject.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-usb@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 linux-mm@kvack.org, Nitin Gupta <ngupta@vflare.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Robert Richter <rric@kernel.org>, Juergen Gross <jgross@suse.com>,
 Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, apparmor@lists.ubuntu.com,
 Josef Bacik <josef@toxicpanda.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 John Johansen <john.johansen@canonical.com>, Joel Becker <jlbec@evilplan.org>,
 dhowells@redhat.com, David Sterba <dsterba@suse.com>,
 Eric Paris <eparis@parisplace.org>, Dan Williams <dan.j.williams@intel.com>,
 Martijn Coenen <maco@android.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Christian Brauner <christian@brauner.io>,
 "Matthew R. Ochs" <mrochs@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Felipe Balbi <balbi@kernel.org>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Tony Luck <tony.luck@intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, Anna Schumaker <anna.schumaker@netapp.com>,
 Minchan Kim <minchan@kernel.org>, linux-security-module@vger.kernel.org,
 Benjamin LaHaise <bcrl@kvack.org>, Jeremy Kerr <jk@ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, netdev@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi Al,

Here's a set of patches that:

 (1) Provides a convenience member in struct fs_context that is OR'd into
     sb->s_iflags by sget_fc().

 (2) Provides a convenience vfs_init_pseudo_fs_context() helper function
     for doing most of the work in mounting a pseudo filesystem.

 (3) Converts all the trivial filesystems that have no arguments to
     fs_context.

 (4) Converts binderfs (which was trivial before January).

 (5) Converts ramfs, tmpfs, rootfs and devtmpfs.

 (6) Kills off mount_pseudo(), mount_pseudo_xattr(), mount_ns(),
     sget_userns().

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

on branch:

	mount-api-viro

David
---
David Howells (38):
      vfs: Provide sb->s_iflags settings in fs_context struct
      vfs: Provide a mount_pseudo-replacement for fs_context
      vfs: Convert aio to fs_context
      vfs: Convert anon_inodes to fs_context
      vfs: Convert bdev to fs_context
      vfs: Convert nsfs to fs_context
      vfs: Convert pipe to fs_context
      vfs: Convert zsmalloc to fs_context
      vfs: Convert sockfs to fs_context
      vfs: Convert dax to fs_context
      vfs: Convert drm to fs_context
      vfs: Convert ia64 perfmon to fs_context
      vfs: Convert cxl to fs_context
      vfs: Convert ocxlflash to fs_context
      vfs: Convert virtio_balloon to fs_context
      vfs: Convert btrfs_test to fs_context
      vfs: Kill off mount_pseudo() and mount_pseudo_xattr()
      vfs: Use sget_fc() for pseudo-filesystems
      vfs: Convert binderfs to fs_context
      vfs: Convert nfsctl to fs_context
      vfs: Convert rpc_pipefs to fs_context
      vfs: Kill off mount_ns()
      vfs: Kill sget_userns()
      vfs: Convert binfmt_misc to fs_context
      vfs: Convert configfs to fs_context
      vfs: Convert efivarfs to fs_context
      vfs: Convert fusectl to fs_context
      vfs: Convert qib_fs/ipathfs to fs_context
      vfs: Convert ibmasmfs to fs_context
      vfs: Convert oprofilefs to fs_context
      vfs: Convert gadgetfs to fs_context
      vfs: Convert xenfs to fs_context
      vfs: Convert openpromfs to fs_context
      vfs: Convert apparmorfs to fs_context
      vfs: Convert securityfs to fs_context
      vfs: Convert selinuxfs to fs_context
      vfs: Convert smackfs to fs_context
      tmpfs, devtmpfs, ramfs, rootfs: Convert to fs_context


 arch/ia64/kernel/perfmon.c         |   14 +
 drivers/android/binderfs.c         |  173 +++++++++-------
 drivers/base/devtmpfs.c            |   16 +
 drivers/dax/super.c                |   13 +
 drivers/gpu/drm/drm_drv.c          |   14 +
 drivers/infiniband/hw/qib/qib_fs.c |   26 ++
 drivers/misc/cxl/api.c             |   10 -
 drivers/misc/ibmasm/ibmasmfs.c     |   21 +-
 drivers/oprofile/oprofilefs.c      |   20 +-
 drivers/scsi/cxlflash/ocxl_hw.c    |   21 +-
 drivers/usb/gadget/legacy/inode.c  |   21 +-
 drivers/virtio/virtio_balloon.c    |   19 +-
 drivers/xen/xenfs/super.c          |   21 +-
 fs/aio.c                           |   15 +
 fs/anon_inodes.c                   |   12 +
 fs/binfmt_misc.c                   |   20 +-
 fs/block_dev.c                     |   14 +
 fs/btrfs/tests/btrfs-tests.c       |   13 +
 fs/configfs/mount.c                |   20 +-
 fs/efivarfs/super.c                |   20 +-
 fs/fuse/control.c                  |   20 +-
 fs/libfs.c                         |   91 ++++++--
 fs/nfsd/nfsctl.c                   |   33 ++-
 fs/nsfs.c                          |   13 +
 fs/openpromfs/inode.c              |   20 +-
 fs/pipe.c                          |   12 +
 fs/ramfs/inode.c                   |  104 ++++++---
 fs/super.c                         |  106 ++--------
 include/linux/fs.h                 |   21 --
 include/linux/fs_context.h         |    8 +
 include/linux/ramfs.h              |    6 -
 include/linux/shmem_fs.h           |    4 
 init/do_mounts.c                   |   12 -
 mm/shmem.c                         |  396 ++++++++++++++++++++++++------------
 mm/zsmalloc.c                      |   19 +-
 net/socket.c                       |   14 +
 net/sunrpc/rpc_pipe.c              |   34 ++-
 security/apparmor/apparmorfs.c     |   20 +-
 security/inode.c                   |   21 +-
 security/selinux/selinuxfs.c       |   20 +-
 security/smack/smackfs.c           |   34 ++-
 41 files changed, 902 insertions(+), 609 deletions(-)

