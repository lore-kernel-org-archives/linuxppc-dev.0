Return-Path: <swarren@nvidia.com>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F141B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 05:47:02 +1100 (EST)
From: Stephen Warren <swarren@nvidia.com>
To: Michal Marek <mmarek@suse.cz>, Jon Loeliger <jdl@jdl.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/2] dtc: Implement -d option to write out a dependency file
Date: Mon,  9 Jan 2012 11:38:14 -0700
Message-Id: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
Cc: Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <a-jacquiot@ti.com>,
 Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>,
 microblaze-uclinux@itee.uq.edu.au, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, Mark Salter <msalter@redhat.com>,
 Stephen Warren <swarren@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
 linux@lists.openrisc.net, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will allow callers to rebuild .dtb files when any of the /include/d
.dtsi files are modified, not just the top-level .dts file.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is against the Linux kernel's copy of dtc, but it applies to
upstream dtc with a couple of trivial conflicts. I can post a version for
upstream dtc as well if desired.

I have only tested this series for ARM.

 scripts/dtc/dtc.c    |   22 +++++++++++++++++++++-
 scripts/dtc/srcpos.c |    6 ++++++
 scripts/dtc/srcpos.h |    1 +
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
index cbc0193..27ecf06 100644
--- a/scripts/dtc/dtc.c
+++ b/scripts/dtc/dtc.c
@@ -71,6 +71,7 @@ static void  __attribute__ ((noreturn)) usage(void)
 	fprintf(stderr, "\t\t\tasm - assembler source\n");
 	fprintf(stderr, "\t-V <output version>\n");
 	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", DEFAULT_FDT_VERSION);
+	fprintf(stderr, "\t-d <output dependency file>\n");
 	fprintf(stderr, "\t-R <number>\n");
 	fprintf(stderr, "\t\tMake space for <number> reserve map entries (relevant for \n\t\tdtb and asm output only)\n");
 	fprintf(stderr, "\t-S <bytes>\n");
@@ -99,6 +100,7 @@ int main(int argc, char *argv[])
 	const char *inform = "dts";
 	const char *outform = "dts";
 	const char *outname = "-";
+	const char *depname = NULL;
 	int force = 0, check = 0, sort = 0;
 	const char *arg;
 	int opt;
@@ -111,7 +113,8 @@ int main(int argc, char *argv[])
 	minsize    = 0;
 	padsize    = 0;
 
-	while ((opt = getopt(argc, argv, "hI:O:o:V:R:S:p:fcqb:vH:s")) != EOF) {
+	while ((opt = getopt(argc, argv, "hI:O:o:V:d:R:S:p:fcqb:vH:s"))
+			!= EOF) {
 		switch (opt) {
 		case 'I':
 			inform = optarg;
@@ -125,6 +128,9 @@ int main(int argc, char *argv[])
 		case 'V':
 			outversion = strtol(optarg, NULL, 0);
 			break;
+		case 'd':
+			depname = optarg;
+			break;
 		case 'R':
 			reservenum = strtol(optarg, NULL, 0);
 			break;
@@ -188,6 +194,15 @@ int main(int argc, char *argv[])
 	fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
 		inform, outform, arg);
 
+	if (depname) {
+		depfile = fopen(depname, "w");
+		if (!depfile)
+			die("Couldn't open dependency file %s: %s\n", depname,
+			    strerror(errno));
+		fputs(outname, depfile);
+		fputc(':', depfile);
+	}
+
 	if (streq(inform, "dts"))
 		bi = dt_from_source(arg);
 	else if (streq(inform, "fs"))
@@ -197,6 +212,11 @@ int main(int argc, char *argv[])
 	else
 		die("Unknown input format \"%s\"\n", inform);
 
+	if (depfile) {
+		fputc('\n', depfile);
+		fclose(depfile);
+	}
+
 	if (cmdline_boot_cpuid != -1)
 		bi->boot_cpuid_phys = cmdline_boot_cpuid;
 
diff --git a/scripts/dtc/srcpos.c b/scripts/dtc/srcpos.c
index 2dbc874..93b3533 100644
--- a/scripts/dtc/srcpos.c
+++ b/scripts/dtc/srcpos.c
@@ -40,6 +40,7 @@ static char *dirname(const char *path)
 	return NULL;
 }
 
+FILE *depfile; /* = NULL */
 struct srcfile_state *current_srcfile; /* = NULL */
 
 /* Detect infinite include recursion. */
@@ -67,6 +68,11 @@ FILE *srcfile_relative_open(const char *fname, char **fullnamep)
 			    strerror(errno));
 	}
 
+	if (depfile) {
+		fputc(' ', depfile);
+		fputs(fullname, depfile);
+	}
+
 	if (fullnamep)
 		*fullnamep = fullname;
 	else
diff --git a/scripts/dtc/srcpos.h b/scripts/dtc/srcpos.h
index bd7966e..ce980ca 100644
--- a/scripts/dtc/srcpos.h
+++ b/scripts/dtc/srcpos.h
@@ -30,6 +30,7 @@ struct srcfile_state {
 	struct srcfile_state *prev;
 };
 
+extern FILE *depfile; /* = NULL */
 extern struct srcfile_state *current_srcfile; /* = NULL */
 
 FILE *srcfile_relative_open(const char *fname, char **fullnamep);
-- 
1.7.0.4
