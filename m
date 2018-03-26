Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0121.hostedemail.com
 [216.40.44.121])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4095Mj1DnDzF25m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 07:29:03 +1100 (AEDT)
Message-ID: <1522096136.12357.21.camel@perches.com>
Subject: [PATCH script] hwmon: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 patches@opensource.cirrus.com
Date: Mon, 26 Mar 2018 13:28:56 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drivers/hwmon is the most frequent user of symbolic permissions
like S_IRUGO in the kernel tree.

$ git grep -w -P "S_[A-Z]{5,5}" | \
  cut -f1 -d: | cut -f1-2 -d"/" | sed -r 's/[A-Za-z0-9_-]+\.[ch]$//' | \
  sort | uniq -c | sort -rn | head
   3862 drivers/hwmon
    814 drivers/scsi
    763 drivers/net
    242 drivers/infiniband
    184 drivers/staging
    181 drivers/usb
    158 fs/proc
    150 fs/xfs
    148 fs/
    142 drivers/misc

But using octal and not symbolic permissions is preferred by many
as it can be more readable.

https://lkml.org/lkml/2016/8/2/1945

Rather than converting these piecemeal, perhaps just do them all
at once via a trivial script like the below:

$ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
  xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace
$ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
  xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace

It's run twice because checkpatch only does 1 conversion per line
and there are some multiple instance lines.

This currently results in a 669 KB patch which is too large
to post but can be easily generated when appropriate.
