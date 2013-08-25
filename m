Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id B13DC2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 01:04:28 +1000 (EST)
Subject: Re: [PATCH 2/2] ppc: kvm: use anon_inode_getfd() with O_CLOEXEC flag
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <b7ae23be3a3d4a2f57eca6cfc7f9361da883ceca.1377372576.git.ydroneaud@opteya.com>
Date: Sun, 25 Aug 2013 16:04:21 +0100
Message-Id: <3557EF65-4327-4DAE-999A-B0EE13C433F5@suse.de>
References: <cover.1377372576.git.ydroneaud@opteya.com>
 <b7ae23be3a3d4a2f57eca6cfc7f9361da883ceca.1377372576.git.ydroneaud@opteya.com>
To: Yann Droneaud <ydroneaud@opteya.com>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 24.08.2013, at 21:14, Yann Droneaud wrote:

> KVM uses anon_inode_get() to allocate file descriptors as part
> of some of its ioctls. But those ioctls are lacking a flag argument
> allowing userspace to choose options for the newly opened file =
descriptor.
>=20
> In such case it's advised to use O_CLOEXEC by default so that
> userspace is allowed to choose, without race, if the file descriptor
> is going to be inherited across exec().
>=20
> This patch set O_CLOEXEC flag on all file descriptors created
> with anon_inode_getfd() to not leak file descriptors across exec().
>=20
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> Link: =
http://lkml.kernel.org/r/cover.1377372576.git.ydroneaud@opteya.com

Reviewed-by: Alexander Graf <agraf@suse.de>

Would it make sense to simply inherit the O_CLOEXEC flag from the parent =
kvm fd instead? That would give user space the power to keep fds across =
exec() if it wants to.


Alex
