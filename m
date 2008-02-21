Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id D7D3DDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 11:17:38 +1100 (EST)
Date: Thu, 21 Feb 2008 01:14:25 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: state of GEN_RTC vs rtc subsystem
Message-ID: <20080221011425.2f8ad363@i1501.lan.towertech.it>
In-Reply-To: <47BC8F88.80502@xandros.com>
References: <47B18612-66A3-476C-B81C-F2FD11CE9A64@kernel.crashing.org>
	<47BC8F88.80502@xandros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	LKML Kernel <linux-kernel@vger.kernel.org>, rz@linux-m68k.org,
	woodys@xandros.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Feb 2008 15:37:28 -0500
woodys <woodys@xandros.com> wrote:

> On ARM genrtc has been arbitrary disabled in Kconfig circa 2.6.19 and 
> the change to rtc_cmos it is not 100% transparent (ARM Netwinder, Debian).
> If I want to use a current (Etch) hwclock binary - I need genrtc with 
> /dev/rtc at 10,135, however new rtc_cmos creates /dev/rtc0 at 254,0.
> As a result on new kernels hwclock claims that it is not able to access 
> hardware.
> 
> However upgrading the util-linux package will (sometime in the 
> "unstable" future) solve it, so it is not completely broken... Still, at 
> the moment - genrtc seems to be a better solution...

 Strange that it has been disabled, I used to keep an eye to avoid touching
 anything outside of drivers/rtc .

 the rtc subsystem creates the device dynamically, you shouldn't count
 on having 254,0. I would eventually ack a patch that adds
 /dev/rtc at 10,135 as an alias for /dev/rtc0.

 however the best solution would be to upgrade hwclock.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
