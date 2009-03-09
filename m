Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 9772DDE119
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 05:51:11 +1100 (EST)
Message-ID: <49B5618E.9050501@am.sony.com>
Date: Mon, 9 Mar 2009 11:35:58 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 7/7] powerpc/ps3: Add rtc-ps3
References: <1236605183-22718-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1236605183-22718-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-m68k@vger.kernel.org,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Dann Frazier <dannf@dannf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 03/09/2009 06:26 AM, Geert Uytterhoeven wrote:
> Create a real RTC driver for PS3, and unhook the deprecated
> ppc_md.[gs]et_rtc_time.

>  8 files changed, 132 insertions(+), 18 deletions(-)

Sorry, I hadn't been following the discussion closely, but
could you explain why we are going from a generic framework
where we hook in our platform specific part to a totally
independent driver that has such an increase in code size.

Why couldn't you fix the generic part so that udev could
load it automatically?

I much prefer to have this code in the platform support
code as it was.  It is much more effort (a pain) to maintain
a separate driver were I have to cater to a subsystem's
maintainer, and with this rtc it seems everyone who was
using the generic PPC driver will need to do the same.

-Geoff
