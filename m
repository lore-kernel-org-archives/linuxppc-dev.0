Return-Path: <woodys@xandros.com>
Received: from ottmail.xandros.com (ottmail.xandros.com [142.46.212.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47576DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 07:58:33 +1100 (EST)
Date: Wed, 20 Feb 2008 15:37:28 -0500
From: woodys <woodys@xandros.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Message-ID: <47BC8F88.80502@xandros.com>
In-Reply-To: <20080220180325.46446675@i1501.lan.towertech.it>
References: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
References: <20080220180325.46446675@i1501.lan.towertech.it>
Subject: Re: [rtc-linux] state of GEN_RTC vs rtc subsystem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, rz@linux-m68k.org,
	rtc-linux@googlegroups.com, LKML Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alessandro Zummo wrote:
> On Wed, 20 Feb 2008 10:11:23 -0600
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>   
>> Is the functionality provided by drivers/char/gen_rtc.c completely  
>> handled by the rtc subsystem in drivers/rtc?
>>
>> I ask for two reasons:
>> 1. should we make it mutually exclusive in Kconfig
>> 2. I've enabled both and get (we'll my defconfig did):
>>     
>
>  They shouldn't be enabled at once. I think a patch 
>  for Kconfig has been recently submitted to give a warning
>  in such a case.
>
>  rtc-cmos should be able to handle the vast majority of x86
>  rtcs out there. 
>
>  The only real open issue is related to the ntp synchronization
>  mode and will be solved only when we can get rid of it :)
>
>   
On ARM genrtc has been arbitrary disabled in Kconfig circa 2.6.19 and 
the change to rtc_cmos it is not 100% transparent (ARM Netwinder, Debian).
If I want to use a current (Etch) hwclock binary - I need genrtc with 
/dev/rtc at 10,135, however new rtc_cmos creates /dev/rtc0 at 254,0.
As a result on new kernels hwclock claims that it is not able to access 
hardware.

However upgrading the util-linux package will (sometime in the 
"unstable" future) solve it, so it is not completely broken... Still, at 
the moment - genrtc seems to be a better solution...

Just my $.02...

Woody Suwalski
