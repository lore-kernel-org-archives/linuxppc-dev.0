Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7F5D1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 14:09:23 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 22:09:21 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 764581FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 22:00:28 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6F46jU744105738
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:06:46 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6F49GSM003731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 22:09:17 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Michael Neuling <mikey@neuling.org>, rtc-linux@googlegroups.com,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] rtc/rtc-opal: Enable alarms only when opal supports tpo
In-Reply-To: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Wed, 15 Jul 2015 14:09:15 +1000
Message-ID: <m3egkaukno.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
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

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

FWIW I'm updating OPAL docs with this. The TPO calls aren't actually
documented :(

In future, it'd be great if there was an accompanying skiboot patch
updating the documentation there too.
