Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FED11A04F2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 03:20:02 +1000 (AEST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 8 Apr 2015 18:19:59 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH v5 0/4] hwmon: (ibmpowernv) add DTS support
Date: Wed,  8 Apr 2015 19:19:46 +0200
Message-Id: <1428513590-5773-1-git-send-email-clg@fr.ibm.com>
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

These patches extend the ibmpowernv driver to support the new OPAL firmware 
which now exposes in its device tree the Digital Temperature Sensors of 
a P8 system.

They are based on Linux 4.0.0-rc7 + the initial cleanup serie :

     http://lists.lm-sensors.org/pipermail/lm-sensors/2015-March/043670.html

and were tested on IBM Power and Open Power systems running Trusty.

Cheers,

C.

 Changes since v4:

 - fixed comparison between signed and unsigned integer in 
   get_logical_cpu()

 Changes since v3:

 - removed error message in case of an unknown physical cpu number

 Changes since v2:

 - fix bogus logical cpu retrieval 
 - use 'threads_per_core' to print out cpu range

 Changes since v1:

 - check cpu validity before printing out the attribute label. 
   if invalid, use a "phy" prefix to distinguish a linux cpu 
   number from a physical cpu number. 
 - fixed alignment
 - fixed comparison between signed and unsigned integer on opal_index 


Cédric Le Goater (4):
  hwmon: (ibmpowernv) add a helper routine create_hwmon_attr
  hwmon: (ibmpowernv) add support for the new device tree
  hwmon: (ibmpowernv) add a label attribute
  hwmon: (ibmpowernv) pretty print labels

 drivers/hwmon/ibmpowernv.c |  166 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 148 insertions(+), 18 deletions(-)

-- 
1.7.10.4
