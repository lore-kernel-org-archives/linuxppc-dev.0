Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2A0E1A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 19:00:25 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 75B89140783
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 19:00:25 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 8 Mar 2016 18:00:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4C6142CE805C
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 19:00:17 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28809T331129810
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 19:00:17 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u287xiWk013199
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 18:59:45 +1100
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56DE8656.3040208@au1.ibm.com>
Date: Tue, 8 Mar 2016 18:59:18 +1100
MIME-Version: 1.0
In-Reply-To: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/16 12:48, Ian Munsie wrote:
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

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
