Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfGr260FyzDqnP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 06:00:18 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SJxuxL035071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 16:00:16 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt6mr4e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 16:00:16 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 14:00:15 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [v7,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1466687034-15350-1-git-send-email-felix@linux.vnet.ibm.com>
Date: Tue, 28 Jun 2016 15:00:02 -0500
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1466687034-15350-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Message-Id: <2DC430E0-BC39-4635-95E7-844E44203BA2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jun 23, 2016, at 8:03 AM, Philippe Bergheaud =
<felix@linux.vnet.ibm.com> wrote:
>=20
> This adds an afu_driver_ops structure with fetch_event() and
> event_delivered() callbacks. An AFU driver such as cxlflash can fill
> this out and associate it with a context to enable passing custom AFU
> specific events to userspace.
>=20
> This also adds a new kernel API function cxl_context_pending_events(),
> that the AFU driver can use to notify the cxl driver that new specific
> events are ready to be delivered, and wake up anyone waiting on the
> context wait queue.
>=20
> The current count of AFU driver specific events is stored in the field
> afu_driver_events of the context structure.
>=20
> The cxl driver checks the afu_driver_events count during poll, select,
> read, etc. calls to check if an AFU driver specific event is pending,
> and calls fetch_event() to obtain and deliver that event. This way, =
the
> cxl driver takes care of all the usual locking semantics around these
> calls and handles all the generic cxl events, so that the AFU driver
> only needs to worry about it's own events.
>=20
> fetch_event() return a struct cxl_event_afu_driver_reserved, allocated
> by the AFU driver, and filled in with the specific event information =
and
> size. Total event size (header + data) should not be greater than
> CXL_READ_MIN_SIZE (4K).
>=20
> Th cxl driver prepends an appropriate cxl event header, copies the =
event
> to userspace, and finally calls event_delivered() to return the status =
of
> the operation to the AFU driver. The event is identified by the =
context
> and cxl_event_afu_driver_reserved pointers.
>=20
> Since AFU drivers provide their own means for userspace to obtain the
> AFU file descriptor (i.e. cxlflash uses an ioctl on their scsi file
> descriptor to obtain the AFU file descriptor) and the generic cxl =
driver
> will never use this event, the ABI of the event is up to each =
individual
> AFU driver.
>=20
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
