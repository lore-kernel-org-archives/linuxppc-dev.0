Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F882DDFFA
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:13:50 +1100 (EST)
Message-ID: <45BE476A.3010407@am.sony.com>
Date: Mon, 29 Jan 2007 11:13:46 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/16] ps3: get firmware version
References: <45BAC225.7020209@am.sony.com> <200701271230.06534.arnd@arndb.de>
In-Reply-To: <200701271230.06534.arnd@arndb.de>
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
>> Changed from a struct to a union and got rid of the output to /proc/cpuinfo.
>> I'll look into arranging something in /proc/device-tree that userspace utils
>> can query.
> 
> What's the current plan for the creating the device tree anyway? I think
> this should be part of the boot wrapper for the kernel in the ps3 flash,
> which can write the version into the flattened device tree. The second
> kernel then gets a copy of that through kboot.

Yes, that's hopefully ppossible, start with the static tree from ps3.dts then
add some properties in the first stage (romboot) wrapper entry.  kboot then
passes that to the second stage wrapper entry, which passes it to the
second stage kernel.  I suppose the second stage wrapper could do some
processing on it if needed.  Backward compatibility with the 2.6.16 bootloader
will probably need that.

To make it work, I need to arrange to do 64 bit HV calls from the 32 bit
wrapper.  I'm not yet entirely sure how to set that up.  Any suggestions
would be welcome.

-Geoff 
