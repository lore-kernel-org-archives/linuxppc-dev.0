Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 16 Dec 2008 15:17:48 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Manish Ahuja <mahuja@us.ibm.com>
Subject: [PATCH] Protect against NULL pointer deref in phyp-dump code.
Message-ID: <20081216041748.GB14890@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

print_dump_header() will be called at least once with a NULL pointer in
a normal boot sequence.  if DEBUG is defined then we will get a deref,
add a quick fix to exit early in the NULL pointer case.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/pseries/phyp_dump.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/phyp_dump.c b/arch/powerpc/platforms/pseries/phyp_dump.c
index edbc012..16e659a 100644
--- a/arch/powerpc/platforms/pseries/phyp_dump.c
+++ b/arch/powerpc/platforms/pseries/phyp_dump.c
@@ -130,6 +130,9 @@ static unsigned long init_dump_header(struct phyp_dump_header *ph)
 static void print_dump_header(const struct phyp_dump_header *ph)
 {
 #ifdef DEBUG
+	if (ph == NULL)
+		return;
+
 	printk(KERN_INFO "dump header:\n");
 	/* setup some ph->sections required */
 	printk(KERN_INFO "version = %d\n", ph->version);
-- 
1.6.0.4


Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
