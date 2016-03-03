Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 070EF1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:53:37 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 3 Mar 2016 14:53:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C3DC32BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:53:34 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u234rQR967043390
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 15:53:34 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u234r1IJ029269
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 15:53:02 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 14/18] cxl: Support to flash a new image on the adapter
 from a guest
In-reply-to: <1456244519-18934-15-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-15-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Thu, 03 Mar 2016 15:52:37 +1100
Message-Id: <1456980059-sup-1506@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Dangit! My email client crashed and I lost the response I was typing!)

@mpe I'd still like it if you weighed in on this one. It's looking
pretty good to me now aside from one pointer used in structure passed to
the new ioctl (and once that is addressed you may consider this
Acked-By: me), but since you had some feedback on our original user API
I'd appreciate it if you could take a look at this one also.

Excerpts from Frederic Barrat's message of 2016-02-24 03:21:55 +1100:
> +    case VALIDATE_IMAGE:
...
> +            for (afu = 0; afu < adapter->slices; afu++)
> +                cxl_guest_remove_afu(adapter->afu[afu]);

Thanks for moving that here - that should remove one possible race :)

> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h

Thanks for moving these to the correct header :)

> +struct cxl_adapter_image {
> +    __u64 flags;
> +    __u64 *data;

This isn't quite what I had in mind - using a * still makes that a
pointer and will still have variable size depending on userspace,
regardless of what size data it is pointing too. You could potentially
handle the difference in the compat_ioctl, but that is more intended as
a last resort to fix up broken APIs, not to rely on when adding a new
one. I think it would be better to just declare that as a __u64 and have
userspace cast to it so that the struct will always be consistent
(similar to the WED for AFUs that define that as an address).

> +    __u64 len_data;
> +    __u64 len_image;
> +    __u64 reserved1;
> +    __u64 reserved2;
> +    __u64 reserved3;
> +    __u64 reserved4;

Thanks for changing the rest of this structure to be more consistent
with the other cxl user APIs & checking the flags+reserved fields in the
code :)

> +#define CXL_IOCTL_DOWNLOAD_IMAGE        _IOW(CXL_MAGIC, 0x0A, struct cxl_adapter_image)
> +#define CXL_IOCTL_VALIDATE_IMAGE        _IOW(CXL_MAGIC, 0x0B, struct cxl_adapter_image)

Thanks for splitting those operations into two separate ioctls.

Cheers,
-Ian
