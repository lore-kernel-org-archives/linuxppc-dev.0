Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17504.23893.242671.413735@cargo.ozlabs.ibm.com>
Date: Tue, 9 May 2006 19:13:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch
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

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

There are two commits there, both small bug-fixes for ARCH=ppc.

Thanks,
Paul.

 arch/ppc/kernel/head_8xx.S |    4 ----
 include/asm-ppc/page.h     |    1 +
 2 files changed, 1 insertions(+), 4 deletions(-)

commit c51e078f82096a7d35ac8ec2416272e843a0e1c4
Author: Marcelo Tosatti <marcelo@kvack.org>
Date:   Fri May 5 17:09:29 2006 -0300

    [PATCH] ppc32/8xx: Fix r3 trashing due to 8MB TLB page instantiation
    
    Instantiation of 8MB pages on the TLB cache for the kernel static
    mapping trashes r3 register on !CONFIG_8xx_CPU6 configurations.
    This ensures r3 gets saved and restored.
    
    Signed-off-by: Marcelo Tosatti <marcelo@kvack.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e4de00215c3af02116db3d486bf53700dfe10619
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue May 9 16:00:59 2006 +1000

    powerpc/32: Define an is_kernel_addr() to fix ARCH=ppc compilation
    
    My commit 6bfd93c32a5065d0e858780b3beb0b667081601c broke the ARCH=ppc
    compilation by using the is_kernel_addr() macro in asm/uaccess.h.
    This fixes it by defining a suitable is_kernel_addr() for ARCH=ppc.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>
