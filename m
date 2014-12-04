Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CCB61A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 03:42:20 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FF371400EA
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 03:42:18 +1100 (AEDT)
From: Wolfram Sang <wsa@the-dreams.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 0/2] get rid of remaining users of attach_adapter
Date: Thu,  4 Dec 2014 17:41:51 +0100
Message-Id: <1417711313-7257-1-git-send-email-wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The attach_adapter mechanism of the I2C framework is deprecated for years.
There are two users left, drivers for old Macintosh computers. I recently got
the idea of replacing this mechanism with a custom one with the help of
deferred probing. Because I don't have the hardware, I worked on a seperate
branch where I modified the windtunnel driver to be runnable on my Renesas
Lager board (ARM). I first verified that the attach_adapter method was used,
then the driver rightfully failed on detecting the i2c clients. Using my custom
mechanism, the same happens: all busses get scanned, then the clients cannot be
detected. Since I didn't change the actual detection code, I assume that it
should be working on those Macintosh devices as well. The keywest driver is
only compile-tested. That being said, I'd be more than happy, if we could find
someone willing to test these patches. If they could be applied, we can
_finally_ get rid of this legacy mechanism and clean up the i2c core.

The branch I used for ARM compilation is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/attach_adapter_removal_with_arm_compile-experimental

Thanks,

   Wolfram

Wolfram Sang (2):
  macintosh: therm_windtunnel: drop using attach adapter
  sound: ppc: keywest: drop using attach adapter

 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 sound/ppc/keywest.c                  | 21 ++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.1.3
