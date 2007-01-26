Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B0DB6DE304
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 10:28:03 +1100 (EST)
Message-ID: <45BA8E7B.6010503@am.sony.com>
Date: Fri, 26 Jan 2007 15:27:55 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 10/14] ps3: get firmware version
References: <45B81891.1010309@am.sony.com> <20070126025955.GE18537@lst.de>
	<45BA4DD5.2030106@am.sony.com>
	<1169843138.24996.114.camel@localhost.localdomain>
	<20070126203758.GC17317@localdomain> <45BA8ADA.8000108@am.sony.com>
In-Reply-To: <45BA8ADA.8000108@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Nathan Lynch wrote:
>> Benjamin Herrenschmidt wrote:
>> 
>>> > Anyway, that is the need, the question is where to make it
>>> > available.  I thought /proc/cpuinfo already has the platform type
>>> > (coming from the generic powerpc code), so it would be convenient
>>> > for utilities to have the firmware version there too.  I don't
>>> > think parsing the dmsg is an option for minimal configs like
>>> > bootloaders and distro installers, as they may not keep the boot
>>> > messages around, and in general doesn't seem a reliable way.  If
>>> > you can make a suggestion, I'd like to hear it.
>>>
>>> Yeah, /proc/cpuinfo is actually a fairly convenient place for that...
>> 
>> Other firmwares provide a property in the device tree with version
>> information, for example on Power5:
> 
> But this firmware does not.  The kernel must do it sometime after
> startup.  I don't see any reason why the kernel should try to
> emulate the behavior of firmware on some other platform.

Actually, now that I think about it, your suggestion seems like the best
way to do it :-) 

Since /proc/device-tree/model gives the model, and I can arrange for
/proc/device-tree/firmware to give a firmware version.  I'll just need to
add a property to the tree after bootup.

-Geoff
