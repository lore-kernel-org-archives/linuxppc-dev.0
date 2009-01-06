Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id D062547B42
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 08:38:51 +1100 (EST)
Message-ID: <4963CF68.3040808@harris.com>
Date: Tue, 06 Jan 2009 16:38:48 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
References: <496268E7.5090907@harris.com>	 <1231190318.14860.17.camel@pasglop>
	<49627D33.8030605@harris.com> <1231223634.14860.18.camel@pasglop>
	<4963C1DE.6020007@harris.com>
In-Reply-To: <4963C1DE.6020007@harris.com>
Content-Type: text/plain; charset=UTF-8
Cc: Wolfgang Denk <wd@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven A. Falco wrote:
> Benjamin Herrenschmidt wrote:
>>> Here is a complete startup log, with debug turned on as you requested.
>>> This is still against 2.6.27.9, as it will take me a little time to
>>> build 2.6.28.  Hopefully, this log will be useful in the meantime.
>> Can you add "debug" to your kernel command line option or send the
>> output of the "dmesg" command please ?
>>

Time to answer my own questions.  U-boot is missing a setting for
CFG_PCI_MEMSIZE in the sequoia.h file.  Four 256MB TLBs are reserved,
but since CFG_PCI_MEMSIZE is not set, the size defaults to 256MB,
rather than the 1GB that is allocated.

So, I added:

#define CFG_PCI_MEMSIZE 0x40000000 /* 1GB */

to sequoia.h.  Now U-boot uses all four TLBs, and that error message
goes away.

But this has no effect on Linux.  So, I also changed the sequoia.dts
to make the outbound range larger, and now Linux is happy too.  I now
have ranges for the device:

# cat 0000:01:00.0/resource
0x0000000190000000 0x000000019007ffff 0x0000000000020200
0x0000000180000000 0x000000018fffffff 0x0000000000020200

	Steve
