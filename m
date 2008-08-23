Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id DE95EDF2A8
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 10:23:57 +1000 (EST)
Received: from [192.168.1.37] (node49.79.251.72.1dial.com [72.251.79.49])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7N0MXNG009415
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 17:23:49 -0700 (PDT)
Message-ID: <48AF5818.7010802@hypersurf.com>
Date: Fri, 22 Aug 2008 17:21:44 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: checkpatch nits ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Can I ignore these checkpatch errors:

ERROR: do not initialise statics to 0 or NULL
#829: FILE: powerpc/kernel/cpu/pll_if.c:61:
+static unsigned int override_bus_clock = 0;

ERROR: do not initialise externals to 0 or NULL
#1281: FILE: powerpc/kernel/cpu/pll_if.c:513:
+int rval = 0;

Someone (Arnd?) told me this was due to an older compiler putting these
in a strange section?

WARNING: externs should be avoided in .c files
#1137: FILE: powerpc/kernel/cpu/pll_if.c:369:
+       __asm__ __volatile__ (

??? I don't know what this is?

The entire block is:

	__asm__ __volatile__ (
		"addi %0,%3,-1\n"
		"andc %1,%3,%0\n"
		"cntlzw %1,%1\n"
		"subfic %1,%1,31\n"
		"cntlzw %0,%2\n":
		"=r"(cntlz), "=r"(cnttz):
		"r"(tmp), "b"(cnttz)
	);
