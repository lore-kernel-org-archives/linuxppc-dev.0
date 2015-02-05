Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEB281A0C91
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 02:53:44 +1100 (AEDT)
Message-ID: <54D391B2.9090909@Freescale.com>
Date: Thu, 5 Feb 2015 09:52:18 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Bob Cochran <ppc@mindchasers.com>, <devel@driverdev.osuosl.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 00/10] Freescale DPAA B/QMan drivers
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
 <54D390BD.4060300@mindchasers.com>
In-Reply-To: <54D390BD.4060300@mindchasers.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bob,


On 02/05/2015 09:48 AM, Bob Cochran wrote:
> On 02/04/2015 09:48 AM, Emil Medve wrote:
>>
>> Hello,
>>
>>
>> This is the first attempt to publish the Freescale DPAA B/QMan
>> drivers. They are
>> not to be applied yet.  At this stage, this is more or less the
>> drivers from the
>> Freescale PowerPC SDK roughly squashed and split in a sequence of
>> component
>> patches. They still needs some work and cleanup before we expect to
>> have them
>> applied, but we appreciate early feedback
> 
> 
> Hi Emil,
> 
> I had thought to try to apply these patches and build it, but I won't
> get very far using it without FMAN (on my t1040).   I searched through
> the mail archives and didn't find FMAN patches other than for the device
> tree.   I also don't see it in the mainline tree.
> 
> If FMAN patches have already been submitted, please point me to it.
> 
> If not, then please let me know when we will see code to support FMAN.

Let me inquire with the FMan guy here. I'll get back to you on this,
however, don't hold your breath. There might be some weeks before the
FMan driver will hit the e-mail lists

> Also, is it your intention for the same QMAN/BMAN drivers to be used
> with both FMAN and the LS AIOP?

These drivers (with some upcoming updates) are expected to be use on all
QorIQ and LS1 devices. The programming model for LS2 (which includes the
AIOP and friends) seems to have a different programming model and these
drivers will not be usable there


Cheers,


> Thank you,
> 
> Bob
> 
> 
> 
> 
> 
>>
>>
>> Cheers,
>>
>>
>> Geoff Thorpe (8):
>>    fsl_bman: Add drivers for the Freescale DPAA BMan
>>    fsl_qman: Add drivers for the Freescale DPAA QMan
>>    powerpc/mpc85xx: Add platform support for the Freescale DPAA BMan
>>    powerpc/mpc85xx: Add platform support for the Freescale DPAA QMan
>>    fsl_bman: Add self-tester
>>    fsl_qman: Add self-tester
>>    fsl_bman: Add debugfs support
>>    fsl_qman: Add debugfs support
>>
>> Hai-Ying Wang (2):
>>    fsl_bman: Add HOTPLUG_CPU support
>>    fsl_qman: Add HOTPLUG_CPU support
>>
>>   arch/powerpc/Kconfig                            |   33 +-
>>   arch/powerpc/platforms/85xx/Kconfig             |   11 +-
>>   arch/powerpc/platforms/85xx/corenet_generic.c   |   26 +-
>>   arch/powerpc/platforms/85xx/p1023_rdb.c         |   26 +-
>>   drivers/staging/Kconfig                         |    4 +-
>>   drivers/staging/Makefile                        |    1 +
>>   drivers/staging/fsl_qbman/Kconfig               |  188 ++
>>   drivers/staging/fsl_qbman/Makefile              |   23 +
>>   drivers/staging/fsl_qbman/bman_config.c         |  611 ++++++
>>   drivers/staging/fsl_qbman/bman_debugfs.c        |  119 +
>>   drivers/staging/fsl_qbman/bman_driver.c         |  373 ++++
>>   drivers/staging/fsl_qbman/bman_high.c           | 1055 +++++++++
>>   drivers/staging/fsl_qbman/bman_low.h            |  524 +++++
>>   drivers/staging/fsl_qbman/bman_private.h        |  149 ++
>>   drivers/staging/fsl_qbman/bman_test.c           |   56 +
>>   drivers/staging/fsl_qbman/bman_test.h           |   44 +
>>   drivers/staging/fsl_qbman/bman_test_high.c      |  181 ++
>>   drivers/staging/fsl_qbman/bman_test_thresh.c    |  196 ++
>>   drivers/staging/fsl_qbman/dpa_alloc.c           |  573 +++++
>>   drivers/staging/fsl_qbman/dpa_sys.h             |  294 +++
>>   drivers/staging/fsl_qbman/qbman_driver.c        |   85 +
>>   drivers/staging/fsl_qbman/qman_config.c         |  991 +++++++++
>>   drivers/staging/fsl_qbman/qman_debugfs.c        | 1326 ++++++++++++
>>   drivers/staging/fsl_qbman/qman_driver.c         |  548 +++++
>>   drivers/staging/fsl_qbman/qman_high.c           | 2624
>> +++++++++++++++++++++++
>>   drivers/staging/fsl_qbman/qman_low.h            | 1302 +++++++++++
>>   drivers/staging/fsl_qbman/qman_private.h        |  283 +++
>>   drivers/staging/fsl_qbman/qman_test.c           |   57 +
>>   drivers/staging/fsl_qbman/qman_test.h           |   43 +
>>   drivers/staging/fsl_qbman/qman_test_high.c      |  213 ++
>>   drivers/staging/fsl_qbman/qman_test_hotpotato.c |  497 +++++
>>   drivers/staging/fsl_qbman/qman_utility.c        |  129 ++
>>   include/linux/fsl_bman.h                        |  517 +++++
>>   include/linux/fsl_qman.h                        | 1955
>> +++++++++++++++++
>>   34 files changed, 15032 insertions(+), 25 deletions(-)
>>   create mode 100644 drivers/staging/fsl_qbman/Kconfig
>>   create mode 100644 drivers/staging/fsl_qbman/Makefile
>>   create mode 100644 drivers/staging/fsl_qbman/bman_config.c
>>   create mode 100644 drivers/staging/fsl_qbman/bman_debugfs.c
>>   create mode 100644 drivers/staging/fsl_qbman/bman_driver.c
>>   create mode 100644 drivers/staging/fsl_qbman/bman_high.c
>>   create mode 100644 drivers/staging/fsl_qbman/bman_low.h
>>   create mode 100644 drivers/staging/fsl_qbman/bman_private.h
>>   create mode 100644 drivers/staging/fsl_qbman/bman_test.c
>>   create mode 100644 drivers/staging/fsl_qbman/bman_test.h
>>   create mode 100644 drivers/staging/fsl_qbman/bman_test_high.c
>>   create mode 100644 drivers/staging/fsl_qbman/bman_test_thresh.c
>>   create mode 100644 drivers/staging/fsl_qbman/dpa_alloc.c
>>   create mode 100644 drivers/staging/fsl_qbman/dpa_sys.h
>>   create mode 100644 drivers/staging/fsl_qbman/qbman_driver.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_config.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_debugfs.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_driver.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_high.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_low.h
>>   create mode 100644 drivers/staging/fsl_qbman/qman_private.h
>>   create mode 100644 drivers/staging/fsl_qbman/qman_test.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_test.h
>>   create mode 100644 drivers/staging/fsl_qbman/qman_test_high.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_test_hotpotato.c
>>   create mode 100644 drivers/staging/fsl_qbman/qman_utility.c
>>   create mode 100644 include/linux/fsl_bman.h
>>   create mode 100644 include/linux/fsl_qman.h
