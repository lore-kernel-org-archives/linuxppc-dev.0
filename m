Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 05/20] powerpc/perf: Reject EBB events which specify a
 sample_type
Date: Fri, 14 Mar 2014 16:00:30 +1100
Message-Id: <1394773245-18328-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although we already block EBB events which request sampling using
sample_period, technically it's possible for an event to set sample_type
but not sample_period.

Nothing terrible will happen if an EBB event does specify sample_type,
but it signals a major confusion on the part of userspace, and so we do
them the favor of rejecting it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 53ac1b2..1e095fd 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -503,8 +503,11 @@ static int ebb_event_check(struct perf_event *event)
 		if (!leader->attr.pinned || !leader->attr.exclusive)
 			return -EINVAL;
 
-		if (event->attr.inherit || event->attr.sample_period ||
-		    event->attr.enable_on_exec || event->attr.freq)
+		if (event->attr.freq ||
+		    event->attr.inherit ||
+		    event->attr.sample_type ||
+		    event->attr.sample_period ||
+		    event->attr.enable_on_exec)
 			return -EINVAL;
 	}
 
-- 
1.8.3.2
