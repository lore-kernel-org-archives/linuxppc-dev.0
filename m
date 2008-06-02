Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 3DC41DE224
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 08:27:56 +1000 (EST)
Message-ID: <484473E6.5060400@am.sony.com>
Date: Mon, 2 Jun 2008 15:27:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] state of GEN_RTC vs rtc subsystem
References: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
	<20080220180325.46446675@i1501.lan.towertech.it>
	<48408394.8000406@am.sony.com>
In-Reply-To: <48408394.8000406@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, rz@linux-m68k.org,
	LKML Kernel <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Alessandro Zummo wrote:
>> On Wed, 20 Feb 2008 10:11:23 -0600
>> Kumar Gala <galak@kernel.crashing.org> wrote:
>> 
>>> 
>>> Is the functionality provided by drivers/char/gen_rtc.c completely  
>>> handled by the rtc subsystem in drivers/rtc?
>>> 
>>> I ask for two reasons:
>>> 1. should we make it mutually exclusive in Kconfig
>>> 2. I've enabled both and get (we'll my defconfig did):
>> 
>>  They shouldn't be enabled at once. I think a patch 
>>  for Kconfig has been recently submitted to give a warning
>>  in such a case.
>> 
>>  rtc-cmos should be able to handle the vast majority of x86
>>  rtcs out there. 
> 
> gen_rtc was hooked up to the powerpc platform
> ppc_md.set_rtc_time and ppc_md.get_rtc_time via the arch
> specific get_rtc_time() and  set_rtc_time() routines.
> 
>>From what I can tell, those generic rtc routines the powerpc
> arch provides are not properly hooked into the new rtc subsystem.
> This causes problems for multi-platform builds where some platforms
> must use gen_rtc, and some must the new rtc subsytem.

Just to follow up, I found that David Woodhouse has submitted
a patch which does this:

   http://patchwork.ozlabs.org/linuxppc/patch?id=18139

-Geoff
