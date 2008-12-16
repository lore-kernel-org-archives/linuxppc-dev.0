Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 16 Dec 2008 15:34:43 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Manish Ahuja <mahuja@us.ibm.com>
Subject: [PATCH] [RFC] Pass a valid token to rats_call() in phyp-dump code.
Message-ID: <20081216043429.GC14890@ozlabs.org>
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

ibm_configure_kernel_dump, is passed as the token to rtas_call() but I
cannot see where it is initialised.  Set it to something sane?

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/pseries/phyp_dump.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/phyp_dump.c b/arch/powerpc/platforms/pseries/phyp_dump.c
index 16e659a..6cf35cd 100644
--- a/arch/powerpc/platforms/pseries/phyp_dump.c
+++ b/arch/powerpc/platforms/pseries/phyp_dump.c
@@ -414,6 +414,8 @@ static int __init phyp_dump_setup(void)
 		of_node_put(rtas);
 	}
 
+	ibm_configure_kernel_dump = rtas_token("ibm,configure-kernel-dump");
+
 	print_dump_header(dump_header);
 	dump_area_length = init_dump_header(&phdr);
 	/* align down */
-- 
1.6.0.4


Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
