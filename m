Date: Fri, 15 Mar 2002 14:25:42 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org, Armin <akuster@pacbell.net>
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
Message-ID: <20020315142542.A27043@ecam.san.rr.com>
References: <20020315114137.A26609@ecam.san.rr.com> <20020315200558.GG691@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <20020315200558.GG691@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii

On Fri, Mar 15, 2002 at 01:05:58PM -0700, Tom Rini wrote:
> On Fri, Mar 15, 2002 at 11:41:37AM -0800, andrew may wrote:
>
> > 3. added mal.sh to generate a new ibm_ocp_mal.c
>
> This looks very cool.  Can you add in some comments to the shell script,
> and I didn't see any bashisms in there, can you verify it works with
> pdksh or one of the other script shells which can be /bin/sh ?

I am not sure how I can check against other shells since I don't
have them on my machine. Is sh --posix good enough?

Here is a patch to mal.sh with some more comments, taking an
arg of the Mal count, and some spacing fixups.

Am taking a day off my work, work so I am not around the code
to do a patch for the Config.help, but I will include the text
I would like there. It may be a bit verbose.

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mal.sh.diff"

--- mal.sh.old	Fri Mar 15 14:10:53 2002
+++ mal.sh	Fri Mar 15 14:16:17 2002
@@ -1,25 +1,70 @@
 #!/bin/sh
+#
+# We want one arg with the number of MALs to support.
+# The first is just MAL_BASE and the second is called
+# MAL1_BASE and so on. If we don't get just one arg
+# we default to 1 MAL.
+#
+# It would be nice to grep these out of a header, but
+# I don't think we can tell which header we need to
+# grep without going through the defines with a pre-compile.
+
+# The c-comments below describe why we need to generate
+# this code.
+
+BASES="DCRN_MAL_BASE"
+if [ $# -ne 1 ] ; then
+    END=1
+else
+    END=$1
+fi
+
+I=1
+while [ $I -lt $END ] ; do
+    BASES="$BASES DCRN_MAL${I}_BASE"
+    I=$((I+1))
+done
+
+DCRNS="DCRN_MALCR \
+       DCRN_MALDBR \
+       DCRN_MALESR \
+       DCRN_MALIER \
+       DCRN_MALTXCARR \
+       DCRN_MALTXCASR \
+       DCRN_MALTXDEIR \
+       DCRN_MALTXEOBISR \
+       DCRN_MALRXCARR \
+       DCRN_MALRXCASR \
+       DCRN_MALRXDEIR \
+       DCRN_MALRXEOBISR \
+       DCRN_MALRXCTP0R \
+       DCRN_MALTXCTP0R \
+       DCRN_MALTXCTP1R \
+       DCRN_MALRCBS0 "

-DCRNS=" DCRN_MALCR \
-        DCRN_MALDBR \
-        DCRN_MALESR \
-        DCRN_MALIER \
-        DCRN_MALTXCARR \
-        DCRN_MALTXCASR \
-        DCRN_MALTXDEIR \
-        DCRN_MALTXEOBISR \
-        DCRN_MALRXCARR \
-        DCRN_MALRXCASR \
-        DCRN_MALRXDEIR \
-        DCRN_MALRXEOBISR \
-        DCRN_MALRXCTP0R \
-        DCRN_MALTXCTP0R \
-        DCRN_MALTXCTP1R \
-        DCRN_MALRCBS0 "
 echo '#include <linux/config.h>'
 echo '#include <asm/ibm4xx.h>'
 echo
-echo '/* Dynamically generated code-DONNOT EDIT*/'
+echo '/* Dynamically generated code-DONNOT EDIT */'
+
+echo '/*                                        */'
+
+echo '/* This stuff needs to be done since the  */'
+echo '/* DCRN number is actually in the opcode  */'
+echo '/* itself. So there is no simple way for  */'
+echo '/* the driver to store off the base value */'
+echo '/* and do the math at run time. Take a    */'
+echo '/* look at the PPCBoot code to see the    */'
+echo '/* self modifying code needed to do this  */'
+echo '/* at run time.                           */'
+echo '/*                                        */'
+echo '/* This could be expanded to cover more   */'
+echo '/* than just the ethernet driver. So it   */'
+echo '/* may be valuable to move this into arch */'
+echo '/* and export the 2 functions. At that    */'
+echo '/* point it may be just as well to dump   */'
+echo '/* the names/macros here and just expand  */'
+echo '/* it with just the numbers.              */'

 echo
 echo
@@ -28,12 +73,14 @@
 echo '{'
 echo '    switch(dcrn) {'
 for DCRN in $DCRNS; do
-    for BASE in $@; do
-        echo '    case' $DCRN '(' $BASE ') :'
-        echo '        return mfdcr( ' $DCRN '(' $BASE '));'
+    for BASE in $BASES; do
+        echo "    case ${DCRN}(${BASE}):"
+        echo "        return mfdcr( ${DCRN}(${BASE}) );"
     done
 done
 echo '    }'
+echo '    /*Should we do some sort of error?*/'
+echo '    /*Extra return keeps the compiler happy*/'
 echo '    return 0;'
 echo '}'

@@ -44,11 +91,14 @@
 echo '{'
 echo '    switch(dcrn) {'
 for DCRN in $DCRNS; do
-    for BASE in $@; do
-        echo '    case' $DCRN '(' $BASE ') :'
-        echo '      mtdcr( ' $DCRN '(' $BASE '), val);'
+    for BASE in $BASES; do
+        echo "    case ${DCRN}(${BASE}) :"
+        echo "      mtdcr( ${DCRN}(${BASE}), val);"
         echo '      break;'
     done
 done
+echo '    default:'
+echo '        /*Should we do some sort of error?*/'
+echo '        break;'
 echo '    }'
 echo '}'

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ocp_help

Amount of bytes to Reserve on a skb for the IBM OCP Enet Driver
CONFIG_IBM_OCP_ENET_SKB_RES
  Many standard ethernet drivers need to reserve 2 bytes of data
  on the skb before giving the data ptr to the hardware. This is
  so the IP data will be 16-byte aligned when it goes up the stack.
  This is a requirement for some processors and it can cause major
  slow downs on others. The 405GP dose not have problems with the
  misaligned data so the default is 0. If you need to route the
  incoming ethernet packets to another device that has alignment
  requirements this can help remove a data copy. A value of 2 can
  help at getting 16-byte aligned IP data for another device. A
  larger value can be used when routing to a IP tunnel device.
  Make sure XXX_DESC_SIZE - XXX_SKB_RES >= 1514, or larger if VLANS
  are used.
--opJtzjQTFsWo+cga--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
