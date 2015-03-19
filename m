Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96ED61A09D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 04:44:58 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 19 Mar 2015 17:44:53 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH v2 0/5] hwmon: (ibmpowernv) remove dependency on OPAL index
Date: Thu, 19 Mar 2015 18:44:40 +0100
Message-Id: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Jean Delvare <jdelvare@suse.de>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello !

The current implementation of the driver uses an index for the hwmon 
attribute which is extracted from the device node name. This index
is calculated by the OPAL firmware and its usage creates a dependency 
with the driver which makes changes a little more complex in OPAL.

This patchset changes the ibmpowernv code to use its own index. It 
starts with a few cleanups, mostly code shuffling around the creation 
of the hwmon sysfs attributes and completes by removing the dependency.

It also prepares ground for future OPAL changes :  

   https://lists.ozlabs.org/pipermail/skiboot/2015-March/000639.html

which will be addressed in a other small patchset.


The patches are based on Linux 4.0.0-rc4 and were tested on IBM Power 
and Open Power systems running Trusty. 

Cheers,

C.


Changes since v1:

 - fixed alignment
 - killed a couple of useless "return NULL"
 - changed returned value of parse_opal_node_name()
 - used *_PTR macros to check for errors

Cédric Le Goater (5):
  hwmon: (ibmpowernv) replace AMBIENT_TEMP by TEMP
  hwmon: (ibmpowernv) add a get_sensor_type() routine
  hwmon: (ibmpowernv) add a convert_opal_attr_name() routine
  hwmon: (ibmpowernv) change create_hwmon_attr_name() prototype
  hwmon: (ibmpowernv) do not use the OPAL index for hwmon attribute
    names

 drivers/hwmon/ibmpowernv.c |  122 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 41 deletions(-)

-- 
1.7.10.4
