Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav17.bay1.hotmail.com [65.54.244.121])
	by ozlabs.org (Postfix) with ESMTP id 9BC0467A2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 21:56:02 +1100 (EST)
Message-ID: <BAY1-DAV179F29DC2682774C4B16488B7E0@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Embedded TUX" <etux@embeddedtux.org>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>,
	"BusyBox Support" <busybox@mail.busybox.net>
Date: Wed, 2 Feb 2005 16:25:54 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Getty prob solved, problem with Telnetd persists
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

With reference to my mail to this list yesterday, the Getty problem has been
solved. It was due to a mistake we made in writing /etc/inittab. Our
original inittab was:

ttyCPM::once:/bin/sh
..
ttyCPM::once:/sbin/getty -L 57600 ttyCPM

This was causing the problem described earlier. It didn't strike us that we
don't need to call the shell when we're calling getty, as it'll call the
appropriate shell on its own after user authentication. We commented out the
first ttyCPM line and now all is fine.

However, the Telnetd problem still persists. When I do a ls -l on a
directory with several contents, the remote telnet terminal gets _stuck_ and
there's no way to recover except to either close the telnet terminal window
or kill the shell application on the target running telnetd.

What could the problem be? Please advise.

I would also like to point out a problem with BusyBox 1.00. I have enabled
the DEVPTS file system in Linux and have enabled support for it in BusyBox.
This means that CONFIG_FEATURE_DEVPTS is enabled and defined in config.h in
the include subfolder inside the BusyBox source directory. However, the
following code still doesn't get compiled:

#ifdef CONFIG_FEATURE_DEVPTS
        p = open("/dev/ptmx", 2);
        if (p > 0) {
                grantpt(p);
                unlockpt(p);
                strcpy(line, ptsname(p));
                return(p);
        }
#else
..

I had to resolve the issue by explicitly including the config.h file from
telnetd.c, by adding the following line:

#include <config.h>

I don't know if there are similar problems with other headers that don't
take effect.

However, the problem of the terminal getting stuck still persists. Please
guide me as to what I need to change.

Regards

Vijay Padiyar
