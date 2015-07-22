Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id 05E471A1D40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 03:18:58 +1000 (AEST)
Date: Wed, 22 Jul 2015 19:11:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: Re: [PATCH] rtc/rtc-opal: Enable alarms only when opal supports tpo
Message-ID: <20150722171119.GJ2853@piout.net>
References: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/2015 at 13:28:28 +0530, Vaibhav Jain wrote :
> rtc-opal driver provides support for rtc alarms via
> timed-power-on(tpo). However some Power platforms like BML use a fake
> rtc clock and don't support tpo. Such platforms are indicated by the
> missing 'has-tpo' property in the device tree.
> 
> Current implementation however enables callback for
> rtc_class_ops.read/set alarm irrespective of the tpo support from the
> platform. This results in a failed opal call when kernel tries to read
> an existing alarms via opal_get_tpo_time during rtc device registration.
> 
> This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
> callback pointers only when tpo is supported.
> 
> Acked-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/rtc/rtc-opal.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
