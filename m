Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18039.27686.176506.53055@cargo.ozlabs.ibm.com>
Date: Tue, 19 Jun 2007 15:39:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a fix from Ben H for some refcounting bugs in the snd-powermac
driver.

Thanks,
Paul.

 sound/ppc/pmac.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

commit 41e904dee22066ae7ac3a7f695b2c8bd43ce4e04
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jun 19 14:37:39 2007 +1000

    [POWERPC] Fix snd-powermac refcounting bugs
    
    The old snd-powermac driver has some serious refcounting issues when
    initialisation fails, which is the case on all new machines with
    a layout-id since those are handled by the new snd-aoa driver.
    
    Some of those bugs seem to have been under the radar for some time
    (like double pci_dev_put), but one was actually added in 2.6.22 with
    Stephen attempt at teaching refcounting to the driver which didn't
    do it at all.
    
    This patch fixes both, thus removing all sort of kref errors that
    would happen if that driver gets loaded on a G5 machine or a recent
    PowerBook due to OF nodes left around with a 0 refcount.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
