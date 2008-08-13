Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id C2AD5DE040
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 22:06:38 +1000 (EST)
Received: from [192.168.1.37] (node156.73.251.72.1dial.com [72.251.73.156])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7DC5Koh095646
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 05:06:31 -0700 (PDT)
Message-ID: <48A2CD2A.5020107@hypersurf.com>
Date: Wed, 13 Aug 2008 05:01:46 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: details, details ...
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

In cpu exit function of a cpufreq driver:

         while (test_bit(cf750gxmChangingPllBit, &cf750gxvStateBits))
                 msleep(1);

This bit will get cleared by a notifier callback.

In module_exit function of a related module:

         while (test_bit(PLL_LOCK_BIT, (unsigned long *)&boot_ratio)) {
                 msleep(1);
         }

This bit will get cleared by a timer. It will also fire the notifiers 
needed above.

I don't think these are in interrupt context. The sleeps ok here?

Also, from checkpatch:

ERROR: do not initialise externals to 0 or NULL
#2483: FILE: arch/powerpc/kernel/cpu/pll_if.c:486:
+int rval = 0;

ERROR: do not initialise statics to 0 or NULL
#2058: FILE: arch/powerpc/kernel/cpu/pll_if.c:61:
+static unsigned int override_bus_clock = 0;

Huh? What? Anyone care to teach an old dog a new trick???

kevin
