Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 705C7DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 22:30:59 +1100 (EST)
Date: Sat, 23 Feb 2008 12:23:30 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 0/2] firewire: endinaness warnings (was Re: sparse - make
	__CHECK_ENDIAN__ default enabled?)
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1203545913.25307.47.camel@brick>
Message-ID: <tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<1203545913.25307.47.camel@brick>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Jarod Wilson <jwilson@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 20 Feb, Harvey Harrison wrote on LKML:
> On Wed, 2008-02-20 at 23:03 +0100, Sam Ravnborg wrote:
>> Hi Harvey.
>> 
>> Can I ask you to look into the worst offenders so we
>> can make -D__CHECK_ENDIAN__ enabled per default
>> in the kernel.
>> Or maybe we should do it anyway?
> 
> Well, I've got the worst of fs and drivers/ata done so far, still
> weeping over the 5500 warnings in drivers. (X86_32 allyesconfig).
> People ignore the existing warnings anyway, why not toss a few more
> on the pile?
> 
> I'll look them over tonight and see how bad it would be.

I looked into drivers/firewire and drivers/ieee1394.  As expected, there
are quite a lot endianess related warnings in the latter because this is
code from way before sparse was regularly used.

There are also a few warnings in the former, even though sparse checks
were run before submission of the whole drivers/firewire stack.  I will
follow up with two patches:
	1/2 firewire: endianess fix
	2/2 firewire: endianess annotations
Whether the "fix" is really a fix remains to be seen; I don't have a big
endian Linux box myself.
-- 
Stefan Richter
-=====-==--- --=- =-===
http://arcgraph.de/sr/
