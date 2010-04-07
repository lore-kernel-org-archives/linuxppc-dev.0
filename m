Return-Path: <wzgllc@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id EF5C5B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Apr 2010 08:33:59 +1000 (EST)
Received: by qyk27 with SMTP id 27so2059900qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 07 Apr 2010 15:33:57 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 7 Apr 2010 17:33:57 -0500
Message-ID: <u2vb97b35b01004071533oe3916294t5515da6bd31d7346@mail.gmail.com>
Subject: udev failed to automount USB memory stick on mpc8313
From: Zhigang Wang <wzgllc@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am using the latest LTIB BSP (2.6.23) for mpc8313 and want to use
udev to automatically mount and umount USB flash storage.

But it appears udev never executes the rule and the script file even
though it is called when a stick is attached. I can manually mount the
USB stick with no problem.
Here is the rule file and the script.

File: 10-local.rules
ACTION=="add", KERNEL=="sd[a-z][0-9]", SUBSYSTEM=="block",
RUN+="/root/usbmount.sh"

File: usbmount.sh

#!/bin/sh

if [ $ACTION == "add" ]
then
        mount -t vfat     /dev/sda1 /root/files
  elif [ $ACTION == "remove" ]

then
        umount -l /root/files
fi

Can someone tell me how to make it work?

Thanks.
