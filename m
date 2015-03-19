Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBFC1A012C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 13:53:28 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 19 Mar 2015 20:53:25 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D5E8B19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 20:44:29 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K2rVVu49479720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 19:53:31 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K2rLHb026818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 20:53:22 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds/powernv: Add driver for PowerNV platform
In-Reply-To: <20150308111435.3759.75840.stgit@localhost.localdomain>
References: <20150308110558.3759.72635.stgit@localhost.localdomain>
 <20150308111435.3759.75840.stgit@localhost.localdomain>
Date: Thu, 19 Mar 2015 14:35:32 -0700
Message-ID: <m34mpgpt5n.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cooloney@gmail.com, rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:

> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> This patch implements LED driver for PowerNV platform using the existing
> generic LED class framework. It registers classdev structures for all
> individual LEDs detected on the system through LED specific device tree
> nodes. Device tree nodes specify what all kind of LEDs present on the
> same location code. It registers LED classdev structure for each of them.
>
> The platform level implementation of LED get and set state has been
> achieved through OPAL calls. These calls are made available for the
> driver by exporting from architecture specific codes.
>
> As per the LED class framework, the 'brightness_set' function should not
> sleep. Hence these functions have been implemented through global work
> queue tasks which might sleep on OPAL async call completion.
>
> All the system LEDs can be found in the same regular path /sys/class/leds/.
> There are two different kind of LEDs present for the same location code,
> one being the identify indicator and other one being the fault indicator.
> We don't use LED colors. Hence our LEDs have names in this format.
>
>         <location_code>:<IDENTIFY|FAULT>
>
> Any positive brightness value would turn on the LED and a zero value
> would turn off the LED. The driver will return LED_FULL (255) for any
> turned on LED and LED_OFF for any turned off LED.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>


(well, it boots, interacts with firmware. I didn't go and look at the
LEDs themselves).
