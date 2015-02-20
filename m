Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B37A71A12FC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 02:11:03 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Feb 2015 15:10:59 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/3] hwmon: (ibmpowernv) add DTS support
Date: Fri, 20 Feb 2015 16:07:34 +0100
Message-Id: <1424444857-13805-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello !

These patches rework the ibmpowernv driver to support the new device 
tree as proposed by this patchset on the skiboot mailing list :

  https://lists.ozlabs.org/pipermail/skiboot/2015-February/000457.html

They are based on Linux 3.19 and were tested on IBM Power and Open Power 
systems running trusty.

The main issue is that the new device tree is incompatible with the 
previous ibmpowernv drivers. The consequence is no powernv sensors 
on systems with such a opal/linux configuration.

Cheers,

C.


Cédric Le Goater (3):
  powerpc/powernv: Check OPAL sensor calls exist
  powerpc/powernv: handle OPAL_SUCCESS return in opal_sensor_read
  hwmon: (ibmpowernv) add DTS support

 arch/powerpc/platforms/powernv/opal-sensor.c |   32 ++-
 drivers/hwmon/ibmpowernv.c                   |  336 ++++++++++++++------------
 2 files changed, 202 insertions(+), 166 deletions(-)

-- 
1.7.10.4
