Return-Path: <jbarnes@virtuousgeek.org>
Received: from cpoproxy1-pub.bluehost.com (cpoproxy1-pub.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id CBE92B7DED
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 07:03:35 +1000 (EST)
Date: Fri, 11 Jun 2010 14:02:19 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] PCI fixes
Message-ID: <20100611140219.6b853478@virtuousgeek.org>
In-Reply-To: <alpine.LFD.2.00.1006091611040.4506@i5.linux-foundation.org>
References: <20100609155321.299cadd9@virtuousgeek.org>
	<alpine.LFD.2.00.1006091611040.4506@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <monstr@monstr.eu>, linux-am33-list@redhat.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Jun 2010 16:14:10 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 9 Jun 2010, Jesse Barnes wrote:
> > 
> > Nothing too big here; I do have a couple of fixes in the queue that
> > aren't included here though.  I'll be pulling them together over the
> > next couple of days.
> 
> Hmm. None of these seem to really be relevant. The fact that one is from 
> me doesn't make me any more eager to pull. Are any of these real 
> regressions (the missing parenthesis one seems to be the only one that 
> could be serious, but I didn't grep for actual use).

Ok I've updated the tree to cover the regressions reported so far,
including the printk change so we get fewer spurious reports.  Note it
hasn't gone through linux-next yet, but the patches are all small and
have each been tested individually.

There's one change in particular I'd like you (along with the cc'd
arch maintainers) to review:

commit 837c4ef13c44296bb763a0ca0e84a076592474cf
Author: Yinghai Lu <yinghai.lu@oracle.com>
Date:   Thu Jun 3 13:43:03 2010 -0700

    PCI: clear bridge resource range if BIOS assigned bad one

This fixes a regression rather minimally, but may have side effects I'm
not seeing.  An alternative to that fix would be to revert

commit d65245c3297ac63abc51a976d92f45f2195d2854
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Fri Jan 22 01:02:23 2010 -0800

    PCI: don't shrink bridge resources

but it seems that's a bit more risky at this point, since it could
affect hotplug and rescan cases.  Really this code needs to be
reworked, especially in light of the revert of
977d17bb1749517b353874ccdc9b85abc7a58c2a which tried (and failed)
to perform aggressive reallocation when devices weren't configured.
I'll try to find some time next week to work on that.

The following changes since commit 9dda696f0de87a2e5cfabb147e28c76b7d3c6846:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci-2.6 for-linus

Bjorn Helgaas (1):
      PCI: change resource collision messages from KERN_ERR to KERN_INFO

Jesse Barnes (1):
      Revert "PCI: create function symlinks in /sys/bus/pci/slots/N/"

Jiri Slaby (1):
      PCI: hotplug/cpqphp, fix NULL dereference

Yinghai Lu (1):
      PCI: clear bridge resource range if BIOS assigned bad one

 Documentation/ABI/testing/sysfs-bus-pci |   40 -------------------------
 arch/microblaze/pci/pci-common.c        |    1 +
 arch/mn10300/unit-asb2305/pci-asb2305.c |    1 +
 arch/powerpc/kernel/pci-common.c        |    1 +
 arch/x86/pci/i386.c                     |    2 +
 drivers/pci/hotplug/cpqphp_core.c       |    7 ++++
 drivers/pci/pci-sysfs.c                 |   37 -----------------------
 drivers/pci/setup-res.c                 |   10 +++---
 drivers/pci/slot.c                      |   48 -------------------------------
 9 files changed, 17 insertions(+), 130 deletions(-)

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
