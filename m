Return-Path: <aleck@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 677FE67B66
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 11:40:54 +1000 (EST)
Received: from spamcheck.gdatech.com (localhost.localdomain [127.0.0.1])
	by spamcheck.gdatech.com (Postfix-out) with ESMTP id 829C16AC0A1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 18:40:53 -0700 (PDT)
Received: from sierra.gdatech.com (sierra.gdatech.com [192.168.200.112])
	by spamcheck.gdatech.com (Postfix-out) with ESMTP id 439FF6AC075
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 18:40:53 -0700 (PDT)
Received: from monstertop (wireless.gdatech.com [192.168.200.122])
	(authenticated)
	by sierra.gdatech.com (8.11.6/8.11.6) with ESMTP id k8E1fJn31127
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Sep 2006 18:41:19 -0700
From: "Aleck Lin" <aleck@gdatech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Ethernet driver for Linux kernel 2.6 running on ML403
Date: Wed, 13 Sep 2006 18:40:40 -0700
Message-ID: <002501c6d79e$cca7ee40$800101df@monstertop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm able to boot Linux 2.6 on ML403 board (with a ramdisk file system).

However, during the kernel booting, it complains that "No network devices
available," So I figured I probably didn't enable the ethernet driver in the
kernel. 

>From doing "make menuconfig", under "Device Drivers" --> "Network device
support" --> "Ethernet(10 or 100Mbit)", I checked the box of both "Ethernet
(10 or 100Mbit)" and "PowerPC 4xx on-chip Ethernet support." I then
save/exit the menuconfig to compile the kernel again. I've attached the
error output at the bottom.

The problem is that I don't have any define in my .config file that matches
"CONFIG_405GP", "CONFIG_405GPR" or "CONFIG_405EP" in the
/drivers/net/ibm_emac/ibm_emac.h file, so it complains that I might not have
correct defines. 

1st question: Which one of the CONFIG_405xxx should I use? I was searching
around but couldn't find an answer, but my intuition tells me that it should
probably be CONFIG_405GP.

2nd question: So I decided to try with CONFIG_405GP just to see what
happens. However, some compilation errors were still there. And it complains
about "dereferencing pointer to incomplete type". Does anyone have any
experience working with this driver and perhaps found that there's an error
in the kernel for this driver?

Thanks,

Aleck


------------------------------------------------------------------------
In file included from drivers/net/ibm_emac/ibm_emac_core.h:28,
                 from drivers/net/ibm_emac/ibm_emac_mal.c:33:
drivers/net/ibm_emac/ibm_emac.h:31:2: error: #error "Unknown SoC. Please,
check chip user manual and make sure EMAC defines are OK"
In file included from drivers/net/ibm_emac/ibm_emac_core.h:32,
                 from drivers/net/ibm_emac/ibm_emac_mal.c:33:
drivers/net/ibm_emac/ibm_emac_mal.h:42:2: error: #error "Unknown SoC, please
check chip manual and choose MAL 'version'"
drivers/net/ibm_emac/ibm_emac_mal.h:53:5: warning: "MAL_VERSION" is not
defined
drivers/net/ibm_emac/ibm_emac_mal.h:61:7: warning: "MAL_VERSION" is not
defined
drivers/net/ibm_emac/ibm_emac_mal.h:72:2: error: #error "Unknown MAL
version"
drivers/net/ibm_emac/ibm_emac_mal.h:88:5: warning: "MAL_VERSION" is not
defined
drivers/net/ibm_emac/ibm_emac_mal.h:91:7: warning: "MAL_VERSION" is not
defined
drivers/net/ibm_emac/ibm_emac_mal.h:99:2: error: #error "Unknown MAL
version"
drivers/net/ibm_emac/ibm_emac_mal.h:107:5: warning: "MAL_VERSION" is not
defined
drivers/net/ibm_emac/ibm_emac_mal.h:110:7: warning: "MAL_VERSION" is not
defined
drivers/net/ibm_emac/ibm_emac_mal.h:116:2: error: #error "Unknown MAL
version"
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_register_commac':
drivers/net/ibm_emac/ibm_emac_mal.c:50: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_set_rcbs':
drivers/net/ibm_emac/ibm_emac_mal.c:80: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:81: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:81: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:81: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:89: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_tx_bd_offset':
drivers/net/ibm_emac/ibm_emac_mal.c:99: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:100: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:100: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:100: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_rx_bd_offset':
drivers/net/ibm_emac/ibm_emac_mal.c:106: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:107: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:107: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:107: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:108: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_serr':
drivers/net/ibm_emac/ibm_emac_mal.c:196: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:204: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_txde':
drivers/net/ibm_emac/ibm_emac_mal.c:250: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_reset':
drivers/net/ibm_emac/ibm_emac_mal.c:359: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_dump_regs':
drivers/net/ibm_emac/ibm_emac_mal.c:372: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:375: error: 'MAL_VERSION' undeclared
(first use in this function)
drivers/net/ibm_emac/ibm_emac_mal.c:375: error: (Each undeclared identifier
is reported only once
drivers/net/ibm_emac/ibm_emac_mal.c:375: error: for each function it appears
in.)
drivers/net/ibm_emac/ibm_emac_mal.c:376: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:378: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:379: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_probe':
drivers/net/ibm_emac/ibm_emac_mal.c:411: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:414: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:422: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:425: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:426: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:441: error: 'MAL_CFG_DEFAULT' undeclared
(first use in this function)
drivers/net/ibm_emac/ibm_emac_mal.c:447: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:447: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:447: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:447: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:447: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:447: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:448: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:448: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:448: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:448: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:448: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:448: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:450: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:451: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:453: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:458: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:464: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:469: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:474: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:477: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:480: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:483: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:486: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:491: error: 'MAL_IER_SOC_EVENTS'
undeclared (first use in this function)
drivers/net/ibm_emac/ibm_emac_mal.c:494: warning: implicit declaration of
function 'ocp_set_drvdata'
drivers/net/ibm_emac/ibm_emac_mal.c:499: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:499: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:499: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:503: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:505: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:507: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:509: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:511: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_remove':
drivers/net/ibm_emac/ibm_emac_mal.c:519: warning: implicit declaration of
function 'ocp_get_drvdata'
drivers/net/ibm_emac/ibm_emac_mal.c:519: warning: initialization makes
pointer from integer without a cast
drivers/net/ibm_emac/ibm_emac_mal.c:520: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:534: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:539: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:540: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:541: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:542: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:543: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:549: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:551: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:552: error: dereferencing pointer to
incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c: At top level:
drivers/net/ibm_emac/ibm_emac_mal.c:559: error: array type has incomplete
element type
drivers/net/ibm_emac/ibm_emac_mal.c:560: error: field name not in record or
union initializer
drivers/net/ibm_emac/ibm_emac_mal.c:560: error: (near initialization for
'mal_ids')
drivers/net/ibm_emac/ibm_emac_mal.c:560: error: field name not in record or
union initializer
drivers/net/ibm_emac/ibm_emac_mal.c:560: error: (near initialization for
'mal_ids')
drivers/net/ibm_emac/ibm_emac_mal.c:561: error: field name not in record or
union initializer
drivers/net/ibm_emac/ibm_emac_mal.c:561: error: (near initialization for
'mal_ids')
drivers/net/ibm_emac/ibm_emac_mal.c:564: error: variable 'mal_driver' has
initializer but incomplete type
drivers/net/ibm_emac/ibm_emac_mal.c:565: error: unknown field 'name'
specified in initializer
drivers/net/ibm_emac/ibm_emac_mal.c:565: warning: excess elements in struct
initializer
drivers/net/ibm_emac/ibm_emac_mal.c:565: warning: (near initialization for
'mal_driver')
drivers/net/ibm_emac/ibm_emac_mal.c:566: error: unknown field 'id_table'
specified in initializer
drivers/net/ibm_emac/ibm_emac_mal.c:566: warning: excess elements in struct
initializer
drivers/net/ibm_emac/ibm_emac_mal.c:566: warning: (near initialization for
'mal_driver')
drivers/net/ibm_emac/ibm_emac_mal.c:568: error: unknown field 'probe'
specified in initializer
drivers/net/ibm_emac/ibm_emac_mal.c:568: warning: excess elements in struct
initializer
drivers/net/ibm_emac/ibm_emac_mal.c:568: warning: (near initialization for
'mal_driver')
drivers/net/ibm_emac/ibm_emac_mal.c:569: error: unknown field 'remove'
specified in initializer
drivers/net/ibm_emac/ibm_emac_mal.c:569: warning: excess elements in struct
initializer
drivers/net/ibm_emac/ibm_emac_mal.c:569: warning: (near initialization for
'mal_driver')
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_init':
drivers/net/ibm_emac/ibm_emac_mal.c:575: warning: implicit declaration of
function 'ocp_register_driver'
drivers/net/ibm_emac/ibm_emac_mal.c: In function 'mal_exit':
drivers/net/ibm_emac/ibm_emac_mal.c:581: warning: implicit declaration of
function 'ocp_unregister_driver'
make[3]: *** [drivers/net/ibm_emac/ibm_emac_mal.o] Error 1
make[2]: *** [drivers/net/ibm_emac] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
---------------------------------------------------------------------------
