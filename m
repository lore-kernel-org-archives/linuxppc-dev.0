Return-Path: <mrochs@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BF7D1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 15:06:35 +1100 (AEDT)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E42B1409C4
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 15:06:34 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mrochs@us.ibm.com>;
 Mon, 7 Mar 2016 21:06:32 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D88011FF0023
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2016 20:54:39 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2846Usl35193004
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Mar 2016 21:06:30 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2846T0k014606
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Mar 2016 21:06:30 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
From: Matt Ochs <mrochs@us.ibm.com>
In-Reply-To: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
Date: Mon, 7 Mar 2016 22:06:28 -0600
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Manoj Kumar <kumarmn@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Message-Id: <11B46653-99D3-4BF5-8F09-B14A9C0E06ED@us.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 7, 2016, at 7:48 PM, Ian Munsie <imunsie@au1.ibm.com> wrote:
> 
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds an afu_driver_ops structure with event_pending and
> deliver_event callbacks. An AFU driver such as cxlflash can fill these
> out and associate it with a context to enable passing custom AFU
> specific events to userspace.
> 
> The cxl driver will call event_pending() during poll, select, read, etc.
> calls to check if an AFU driver specific event is pending, and will call
> deliver_event() to deliver that event. This way, the cxl driver takes
> care of all the usual locking semantics around these calls and handles
> all the generic cxl events, so that the AFU driver only needs to worry
> about it's own events.
> 
> The deliver_event() call is passed a struct cxl_event buffer to fill in.
> The header will already be filled in for an AFU driver event, and the
> AFU driver is expected to expand the header.size as necessary (up to
> max_size, defined by struct cxl_event_afu_driver_reserved) and fill out
> it's own information.
> 
> Since AFU drivers provide their own means for userspace to obtain the
> AFU file descriptor (i.e. cxlflash uses an ioctl on their scsi file
> descriptor to obtain the AFU file descriptor) and the generic cxl driver
> will never use this event, the ABI of the event is up to each individual
> AFU driver.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
