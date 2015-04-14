Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2203A1A0CC8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 16:41:34 +1000 (AEST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 14 Apr 2015 02:41:32 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 81F5F6E8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:33:19 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3E6fUN932112706
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:41:30 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E6fSks022465
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:41:28 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=20v9=2011/11=5D=20perf-download=3A=20Download=20the=20events=20json=20file?=
Date: Mon, 13 Apr 2015 23:41:04 -0700
Message-Id: <1428993665-2133-12-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a downloader to automatically download the right files from a
download site.

This is implemented as a script calling curl, similar to perf archive.
The perf driver automatically calls the right binary. The downloader is
extensible, but currently only implements an Intel and Powerpc event
download.  It would be straightforward to add support for other architectures.

For now, there could be slight variations in how individual architectures
organize the JSON files. Eg. Powerpc has a simple mapping from its PVR
to cpu family eg power8's events file, which x86 uses, CPU vendor, family
model to locate the specific file to download.

The downloaded event files are put into ~/.cache/pmu-events, where the
builtin event parser in util/* can find them automatically.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/n/1405123165-22666-8-git-send-email-andi@firstfloor.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Changelog[v9] (by Sukadev Bhattiprolu)
	Add the perf-download script back into patchset. Set default
	download location to the tools/perf/pmu-events/ directory in
	Linus's tree.
	Include code to parse/download powerpc JSON files.
	Remove Acked-by: Namhyung Kim since this patch has major changes
---
 tools/perf/Documentation/perf-download.txt |   31 +++++
 tools/perf/Documentation/perf-list.txt     |   12 +-
 tools/perf/Makefile.perf                   |    5 +-
 tools/perf/perf-download.sh                |  171 ++++++++++++++++++++++++++++
 4 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-download.txt
 create mode 100755 tools/perf/perf-download.sh

diff --git a/tools/perf/Documentation/perf-download.txt b/tools/perf/Documentation/perf-download.txt
new file mode 100644
index 0000000..9e5b28e
--- /dev/null
+++ b/tools/perf/Documentation/perf-download.txt
@@ -0,0 +1,31 @@
+perf-download(1)
+===============
+
+NAME
+----
+perf-download - Download event files for current CPU.
+
+SYNOPSIS
+--------
+[verse]
+'perf download' [vendor-family-model]
+
+DESCRIPTION
+-----------
+This command automatically downloads the event list for the current CPU and
+stores them in $XDG_CACHE_HOME/pmu-events (or $HOME/.cache/pmu-events).
+The other tools automatically look for them there. The CPU can be also
+specified at the command line.
+
+The downloading is done using http through wget, which needs
+to be installed. When behind a firewall the proxies
+may also need to be set up using "export https_proxy=...."
+
+The user should regularly call this to download updated event lists
+for the current CPU.
+
+Note the downloaded files are stored per user, so if perf is
+used as both normal user and with sudo the event files may
+also need to be moved to root's home directory with
+sudo mkdir /root/.cache ; sud cp -r ~/.cache/pmu-events /root/.cache
+after downloading.
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 7479efe..98637e8 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -66,6 +66,16 @@ Sampling). Examples to use IBS:
  perf record -a -e r076:p ...          # same as -e cpu-cycles:p
  perf record -a -e r0C1:p ...          # use ibs op counting micro-ops
 
+PER CPU EVENT LISTS
+-------------------
+
+For some CPUs (particularly modern Intel CPUs) "perf download" can
+download additional CPU specific event definitions, which then
+become visible in perf list and available in the other perf tools.
+
+This obsoletes the raw event description method described below
+for most cases.
+
 RAW HARDWARE EVENT DESCRIPTOR
 -----------------------------
 Even when an event is not available in a symbolic form within perf right now,
@@ -141,6 +151,6 @@ types specified.
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-top[1],
-linkperf:perf-record[1],
+linkperf:perf-record[1], linkperf:perf-download[1],
 http://www.intel.com/Assets/PDF/manual/253669.pdf[Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide],
 http://support.amd.com/us/Processor_TechDocs/24593_APM_v2.pdf[AMD64 Architecture Programmer’s Manual Volume 2: System Programming]
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d9c03c4..9f955b1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -136,6 +136,7 @@ SCRIPT_SH =
 
 SCRIPT_SH += perf-archive.sh
 SCRIPT_SH += perf-with-kcore.sh
+SCRIPT_SH += perf-download.sh
 
 grep-libs = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
@@ -946,6 +947,8 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-with-kcore) \
 		$(INSTALL) $(OUTPUT)perf-with-kcore -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
+	$(call QUIET_INSTALL, perf-download) \
+		$(INSTALL) $(OUTPUT)perf-download -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBPERL
 	$(call QUIET_INSTALL, perl-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
@@ -991,7 +994,7 @@ config-clean:
 	@$(MAKE) -C config/feature-checks clean >/dev/null
 
 clean: $(LIBTRACEEVENT)-clean $(LIBAPIKFS)-clean config-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_OBJS) $(BUILTIN_OBJS) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf.o $(LANG_BINDINGS) $(GTK_OBJS)
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_OBJS) $(BUILTIN_OBJS) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-download $(OUTPUT)perf.o $(LANG_BINDINGS) $(GTK_OBJS)
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)PERF-CFLAGS $(OUTPUT)PERF-FEATURES $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex*
 	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
diff --git a/tools/perf/perf-download.sh b/tools/perf/perf-download.sh
new file mode 100755
index 0000000..79922c5
--- /dev/null
+++ b/tools/perf/perf-download.sh
@@ -0,0 +1,171 @@
+#!/bin/bash
+#
+# Download event files for current cpu for perf
+#
+
+set -e
+
+CURLOPT=${CURLOPT:- --max-time 5 --progress-bar}
+MAPFILE=${MAPFILE:-mapfile.csv}
+GKO=https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/;
+CACHEDIR=${XDG_CACHE_HOME:-~/.cache}
+
+ARCH="";
+CPUREV="";
+VENDOR="";
+VFM="";
+
+init_arch()
+{
+	arch=`uname -m  | sed -r 's/(x86.*|i.*86)/x86/' \
+			| sed -r 's/ppc.*/powerpc/'`;
+
+	if [ "x$arch" == "xpowerpc" -o "x$arch" == "xx86" ]; then
+		ARCH=$arch;
+	else
+		echo "Unknown architecture/CPU $arch"
+		exit 1;
+	fi
+}
+
+init_cpu_revision()
+{
+	if [ "x$ARCH" == "xpowerpc" ]; then
+		CPUREV=`grep revision /proc/cpuinfo | tail -1 |
+			awk '{ gsub(/\)/, "", $6); printf("%s%s", $5, $6); }'`
+	fi
+}
+
+init_vendor_family_model()
+{
+	if [ "x$ARCH" != "xx86" ]; then
+		return;
+	fi
+
+	VFM=$(awk '
+		/^vendor/     		{ V=$3 }
+		/^model/ && $2 == ":" 	{ M=$3 }
+		/^cpu family/ 		{ F = $4 }
+		END	      		{ printf("%s-%s-%X", V, F, M) }' \
+			/proc/cpuinfo)
+
+	VENDOR=$(echo $VFM  | ( IFS=- read v f m ; echo $v) )
+}
+
+init_defaults()
+{
+	# Not all architectures need all these
+	init_arch;
+	init_cpu_revision;
+	init_vendor_family_model;
+}
+
+download_x86_files()
+{
+	case "$VENDOR" in
+
+	GenuineIntel)
+		echo "Downloading readme.txt"
+		curl $CURLOPT $URLBASE/readme.txt -o readme.txt
+		if [ ! -f "readme.txt" ]; then
+			echo "Couldn't download $URLBASE/readme.txt, continuing"
+		fi
+
+		;;
+
+	# Add more CPU vendors here
+
+	*)
+		echo "Unsupported CPU vendor $V"
+		exit 1
+		;;
+	esac
+
+	echo "Downloading models file"
+	curl $CURLOPT $URLBASE/$MAPFILE -o $MAPFILE
+
+	if [ ! -f $MAPFILE ]; then
+		echo "Could not download $URLBASE/$MAPFILE"
+		exit 1;
+	fi
+
+	events_file=`mktemp`;
+	echo "Downloading events file"
+	awk -v urlbase=$URLBASE -v cpu="$VFM" -F, 			\
+		'$1 == cpu && $4 == "core" { 			\
+			print "url = \"" urlbase $3 "\"";	\
+			exit 0 }' 				\
+		$MAPFILE > $events_file
+
+	if [ -s $events_file ] ; then
+		curl $CURLOPT -K $events_file -o $VFM-core.json
+	else
+		echo "CPU $VFM not found"
+	fi
+
+	#rm -f $events_file
+}
+
+download_powerpc_files()
+{
+	#
+	# Mapfile for Power looks like this:
+	#
+	# 	004d0100,core,power8.json
+	#
+	# where first column is the PVR, and last column is the
+	# name of the events file for the CPU family. Download
+	# the events file and create a symlink to it:
+	#
+	# 	004d0100-core.json -> power8.json
+	#
+	echo "Downloading models file, $MAPFILE"
+	curl $CURLOPT ${URLBASE}/$MAPFILE -o $MAPFILE
+
+	if [ ! -f $MAPFILE ]; then
+		echo "Could not download $URLBASE/$MAPFILE"
+		exit 1;
+	fi
+
+	target=`awk -v cpu="$CPUREV" -F, \
+		'$1 == cpu && $2 == "core" { print $3 }' $MAPFILE`
+
+	cpurev=${CPUREV}-core.json
+	rm -f $cpurev;
+
+	echo "Downloading events file for CPU/Rev '$cpurev'"
+	curl $CURLOPT ${URLBASE}/$target -o $target
+	ln -s $target $cpurev 
+}
+#
+# Main
+#
+if ! type curl > /dev/null ; then
+	echo "please install curl"
+	exit 1
+fi
+
+if [ "$1" == "" ] ; then
+	init_defaults;
+else
+	ARCH=$1;
+	CPUREV=$2;
+	VENDOR=$3;
+fi;
+
+URLBASE=${URLBASE:-${GKO}/tools/perf/pmu-events/arch/${ARCH}/};
+
+[ ! -d $CACHEDIR/pmu-events ] && mkdir -p $CACHEDIR/pmu-events
+cd $CACHEDIR/pmu-events
+
+case $ARCH in
+
+x86)
+	download_x86_files
+	;;
+
+powerpc)
+
+	download_powerpc_files
+	;;
+esac
-- 
1.7.9.5
