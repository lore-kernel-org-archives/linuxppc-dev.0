Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 6864067BAD
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:10:20 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAG8AIsa028398
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 17:10:18 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAG8AIdI028349
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 17:10:18 +0900 (JST)
Message-ID: <455C1CE4.2060203@am.sony.com>
Date: Thu, 16 Nov 2006 00:10:12 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/16] powerpc: add ps3 platform OS params support
References: <4554DB20.9020200@am.sony.com> <20061115180948.GD18856@lst.de>
In-Reply-To: <20061115180948.GD18856@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Fri, Nov 10, 2006 at 12:03:44PM -0800, Geoff Levand wrote:
>> Add support to access the parameter data from the ps3pf other OS area of flash
>> memory.  The parameter data mainly holds user preferences like static ip
>> address, etc.
> 
> So what's this code doing it?  You'd need some kind of sysfs or similar
> interface to actually export it to the user.

This gets things that are needed early in the boot, like what type of monitor
is connected to the system so the early kernel startup messages will go to
the correct place, etc.  This is not to be exported to the user.  It is only
used for kernel startup before the storage driver comes becomes ready, or
if the system is configured without the storage driver.  Once the storage
driver is up, this info can be read and written as a normal block device
from flash memory.

-Geoff
