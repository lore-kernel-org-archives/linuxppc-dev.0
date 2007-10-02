Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18177.47055.317473.681156@cargo.ozlabs.ibm.com>
Date: Tue, 2 Oct 2007 13:15:27 +1000
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

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a bug-fix from Anton Blanchard for 2.6.23.

Thanks,
Paul.

 arch/powerpc/platforms/pseries/xics.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit e48395f1753cab0fde6c03f1db833cece9ef2ba0
Author: Anton Blanchard <anton@samba.org>
Date:   Mon Oct 1 07:45:55 2007 +1000

    [POWERPC] Fix xics set_affinity code
    
    On a POWER6 machine running 2.6.23-rc8 I sometimes see the following error:
    
    xics_set_affinity: No online cpus in the mask 00000000,00000000,00000000,00000001 for irq 20
    
    In a desperate attempt to get a changelog entry in 2.6.23, I took a look
    into it.
    
    It turns out we are passing a real and not a virtual irq into
    get_irq_server.  This works for the case where hwirq < NR_IRQS and we
    set virq = hwirq.  In my case however hwirq = 590082 and we try and
    access irq_desc[590082], slightly past the end at 512 entries.
    
    Lucky we ship lots of memory with our machines.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
