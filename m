Return-Path: <ppc@mindchasers.com>
Received: from resqmta-ch2-07v.sys.comcast.net
 (resqmta-ch2-07v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:39])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48B641A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 02:56:42 +1100 (AEDT)
Message-ID: <54D390BD.4060300@mindchasers.com>
Date: Thu, 05 Feb 2015 10:48:13 -0500
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@Freescale.com>, devel@driverdev.osuosl.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/10] Freescale DPAA B/QMan drivers
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/04/2015 09:48 AM, Emil Medve wrote:
>
> Hello,
>
>
> This is the first attempt to publish the Freescale DPAA B/QMan drivers. They are
> not to be applied yet.  At this stage, this is more or less the drivers from the
> Freescale PowerPC SDK roughly squashed and split in a sequence of component
> patches. They still needs some work and cleanup before we expect to have them
> applied, but we appreciate early feedback


Hi Emil,

I had thought to try to apply these patches and build it, but I won't 
get very far using it without FMAN (on my t1040).   I searched through 
the mail archives and didn't find FMAN patches other than for the device 
tree.   I also don't see it in the mainline tree.

If FMAN patches have already been submitted, please point me to it.

If not, then please let me know when we will see code to support FMAN.

Also, is it your intention for the same QMAN/BMAN drivers to be used 
with both FMAN and the LS AIOP?

Thank you,

Bob





>
>
> Cheers,
>
>
> Geoff Thorpe (8):
>    fsl_bman: Add drivers for the Freescale DPAA BMan
>    fsl_qman: Add drivers for the Freescale DPAA QMan
>    powerpc/mpc85xx: Add platform support for the Freescale DPAA BMan
>    powerpc/mpc85xx: Add platform support for the Freescale DPAA QMan
>    fsl_bman: Add self-tester
>    fsl_qman: Add self-tester
>    fsl_bman: Add debugfs support
>    fsl_qman: Add debugfs support
>
> Hai-Ying Wang (2):
>    fsl_bman: Add HOTPLUG_CPU support
>    fsl_qman: Add HOTPLUG_CPU support
>
>   arch/powerpc/Kconfig                            |   33 +-
>   arch/powerpc/platforms/85xx/Kconfig             |   11 +-
>   arch/powerpc/platforms/85xx/corenet_generic.c   |   26 +-
>   arch/powerpc/platforms/85xx/p1023_rdb.c         |   26 +-
>   drivers/staging/Kconfig                         |    4 +-
>   drivers/staging/Makefile                        |    1 +
>   drivers/staging/fsl_qbman/Kconfig               |  188 ++
>   drivers/staging/fsl_qbman/Makefile              |   23 +
>   drivers/staging/fsl_qbman/bman_config.c         |  611 ++++++
>   drivers/staging/fsl_qbman/bman_debugfs.c        |  119 +
>   drivers/staging/fsl_qbman/bman_driver.c         |  373 ++++
>   drivers/staging/fsl_qbman/bman_high.c           | 1055 +++++++++
>   drivers/staging/fsl_qbman/bman_low.h            |  524 +++++
>   drivers/staging/fsl_qbman/bman_private.h        |  149 ++
>   drivers/staging/fsl_qbman/bman_test.c           |   56 +
>   drivers/staging/fsl_qbman/bman_test.h           |   44 +
>   drivers/staging/fsl_qbman/bman_test_high.c      |  181 ++
>   drivers/staging/fsl_qbman/bman_test_thresh.c    |  196 ++
>   drivers/staging/fsl_qbman/dpa_alloc.c           |  573 +++++
>   drivers/staging/fsl_qbman/dpa_sys.h             |  294 +++
>   drivers/staging/fsl_qbman/qbman_driver.c        |   85 +
>   drivers/staging/fsl_qbman/qman_config.c         |  991 +++++++++
>   drivers/staging/fsl_qbman/qman_debugfs.c        | 1326 ++++++++++++
>   drivers/staging/fsl_qbman/qman_driver.c         |  548 +++++
>   drivers/staging/fsl_qbman/qman_high.c           | 2624 +++++++++++++++++++++++
>   drivers/staging/fsl_qbman/qman_low.h            | 1302 +++++++++++
>   drivers/staging/fsl_qbman/qman_private.h        |  283 +++
>   drivers/staging/fsl_qbman/qman_test.c           |   57 +
>   drivers/staging/fsl_qbman/qman_test.h           |   43 +
>   drivers/staging/fsl_qbman/qman_test_high.c      |  213 ++
>   drivers/staging/fsl_qbman/qman_test_hotpotato.c |  497 +++++
>   drivers/staging/fsl_qbman/qman_utility.c        |  129 ++
>   include/linux/fsl_bman.h                        |  517 +++++
>   include/linux/fsl_qman.h                        | 1955 +++++++++++++++++
>   34 files changed, 15032 insertions(+), 25 deletions(-)
>   create mode 100644 drivers/staging/fsl_qbman/Kconfig
>   create mode 100644 drivers/staging/fsl_qbman/Makefile
>   create mode 100644 drivers/staging/fsl_qbman/bman_config.c
>   create mode 100644 drivers/staging/fsl_qbman/bman_debugfs.c
>   create mode 100644 drivers/staging/fsl_qbman/bman_driver.c
>   create mode 100644 drivers/staging/fsl_qbman/bman_high.c
>   create mode 100644 drivers/staging/fsl_qbman/bman_low.h
>   create mode 100644 drivers/staging/fsl_qbman/bman_private.h
>   create mode 100644 drivers/staging/fsl_qbman/bman_test.c
>   create mode 100644 drivers/staging/fsl_qbman/bman_test.h
>   create mode 100644 drivers/staging/fsl_qbman/bman_test_high.c
>   create mode 100644 drivers/staging/fsl_qbman/bman_test_thresh.c
>   create mode 100644 drivers/staging/fsl_qbman/dpa_alloc.c
>   create mode 100644 drivers/staging/fsl_qbman/dpa_sys.h
>   create mode 100644 drivers/staging/fsl_qbman/qbman_driver.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_config.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_debugfs.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_driver.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_high.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_low.h
>   create mode 100644 drivers/staging/fsl_qbman/qman_private.h
>   create mode 100644 drivers/staging/fsl_qbman/qman_test.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_test.h
>   create mode 100644 drivers/staging/fsl_qbman/qman_test_high.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_test_hotpotato.c
>   create mode 100644 drivers/staging/fsl_qbman/qman_utility.c
>   create mode 100644 include/linux/fsl_bman.h
>   create mode 100644 include/linux/fsl_qman.h
>
