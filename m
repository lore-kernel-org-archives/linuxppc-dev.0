Return-Path: <paulus@ozlabs.org>
Date: Tue, 27 Jul 2010 22:40:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Please pull my perf.git urgent branch
Message-ID: <20100727124019.GB14947@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus,

Please do a pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/perf.git urgent

to get one commit that fixes a problem where, on some Freescale
embedded PowerPC machines, unprivileged userspace could oops the
kernel using the perf_event subsystem.  I know it's late, but it is a
potential security hole (but only on Freescale embedded systems), the
fix is small (3 lines) and only affects Freescale embedded processors,
and I was on vacation for the past two weeks. :)

Thanks,
Paul.

Peter Zijlstra (1):
      perf, powerpc: Use perf_sample_data_init() for the FSL code

 arch/powerpc/kernel/perf_event_fsl_emb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

commit 6b95ed345b9faa4ab3598a82991968f2e9f851bb
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Fri Jul 9 10:21:21 2010 +0200

    perf, powerpc: Use perf_sample_data_init() for the FSL code
    
    We should use perf_sample_data_init() to initialize struct
    perf_sample_data.  As explained in the description of commit dc1d628a
    ("perf: Provide generic perf_sample_data initialization"), it is
    possible for userspace to get the kernel to dereference data.raw,
    so if it is not initialized, that means that unprivileged userspace
    can possibly oops the kernel.  Using perf_sample_data_init makes sure
    it gets initialized to NULL.
    
    This conversion should have been included in commit dc1d628a, but it
    got missed.
    
    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Acked-by: Kumar Gala <kumar.gala@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/perf_event_fsl_emb.c b/arch/powerpc/kernel/perf_event_fsl_emb.c
index 369872f..babccee 100644
--- a/arch/powerpc/kernel/perf_event_fsl_emb.c
+++ b/arch/powerpc/kernel/perf_event_fsl_emb.c
@@ -566,9 +566,9 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	 * Finally record data if requested.
 	 */
 	if (record) {
-		struct perf_sample_data data = {
-			.period	= event->hw.last_period,
-		};
+		struct perf_sample_data data;
+
+		perf_sample_data_init(&data, 0);
 
 		if (perf_event_overflow(event, nmi, &data, regs)) {
 			/*
