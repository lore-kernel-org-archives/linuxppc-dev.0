Return-Path: <jonsmirl@gmail.com>
Received: from vms048pub.verizon.net (vms048pub.verizon.net [206.46.252.48])
	by ozlabs.org (Postfix) with ESMTP id 60404DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 15:41:50 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JTB00IPRZPE2N68@vms048.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Wed, 19 Dec 2007 22:41:38 -0600 (CST)
Date: Wed, 19 Dec 2007 23:41:36 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 0/5] Version 17, series to add device tree naming to i2c
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Message-id: <20071220044136.20091.70984.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since copying i2c-mpc.c to maintain support for the ppc architecture seems to be an issue; instead rework i2c-mpc.c to use CONFIG_PPC_MERGE #ifdefs to support both the ppc and powerpc architecture. When ppc is deleted in six months these #ifdefs will need to be removed.

Another rework of the i2c for powerpc device tree patch. This version implements standard alias naming only on the powerpc platform and only for the device tree names. The old naming mechanism of i2c_client.name,driver_name is left in place and not changed for non-powerpc platforms. This patch is fully capable of dynamically loading the i2c modules. You can modprobe in the i2c-mpc driver and the i2c modules described in the device tree will be automatically loaded. Modules also work if compiled in.

The follow on patch to module-init-tools is also needed since the i2c subsystem has never implemented dynamic loading.

The following series implements standard linux module aliasing for i2c modules on arch=powerpc. It then converts the mpc i2c driver from being a platform driver to an open firmware one. I2C device names are picked up from the device tree. Module aliasing is used to translate from device tree names into to linux kernel names. Several i2c drivers are updated to use the new aliasing. 

--
Jon Smirl
jonsmirl@gmail.com 
