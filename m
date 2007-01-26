Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B4EE5DDFE6
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 05:56:32 +1100 (EST)
Message-ID: <45BA4DD5.2030106@am.sony.com>
Date: Fri, 26 Jan 2007 10:52:05 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/14] ps3: get firmware version
References: <45B81891.1010309@am.sony.com> <20070126025955.GE18537@lst.de>
In-Reply-To: <20070126025955.GE18537@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Wed, Jan 24, 2007 at 06:40:17PM -0800, Geoff Levand wrote:
>> Output the PS3 firmware version to dmesg and /proc/cpuinfo.
> 
> Do we really need to bloat /proc/cpuinfo with more information that's
> totally platform-specific?  The file is enough of a mess already..

I wanted to make the firmware version available to user space utilities, so
for example, I plan to make a utility to write the kernel to flash.  If the
utility can query the firmware version, it can prompt the user that a firmware
update would allow the kernel to take advantage of some new or updated feature.
Without this, the only way to notify the user is with a message to the system
log when the new kernel is running.

Anyway, that is the need, the question is where to make it available.  I thought
/proc/cpuinfo already has the platform type (coming from the generic powerpc
code), so it would be convenient for utilities to have the firmware version
there too.  I don't think parsing the dmsg is an option for minimal
configs like bootloaders and distro installers, as they may not keep the boot
messages around, and in general doesn't seem a reliable way.  If you can make
a suggestion, I'd like to hear it.

-Geoff
