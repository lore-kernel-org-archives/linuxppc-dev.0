Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B81DE1A1942
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 20:29:03 +1000 (EST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85A7414018B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 20:29:03 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 2 Oct 2014 20:29:03 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 15/17] cxl: Userspace header file.
In-reply-to: <20141002060237.E9963140180@ozlabs.org>
References: <20141002060237.E9963140180@ozlabs.org>
Date: Thu, 02 Oct 2014 20:28:55 +1000
Message-Id: <1412243942-sup-5336@delenn.ozlabs.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, arnd <arnd@arndb.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg <greg@kroah.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, anton <anton@samba.org>,
 jk <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Michael,

Excerpts from Michael Ellerman's message of 2014-10-02 16:02:37 +1000:
> > +/* ioctls */
> > +struct cxl_ioctl_start_work {
> > +    __u64 wed;
> > +    __u64 amr;
> > +    __u64 reserved1;
> > +    __u32 reserved2;
> > +    __s16 num_interrupts; /* -1 = use value from afu descriptor */
> > +    __u16 process_element; /* returned from kernel */
> > +    __u64 reserved3;
> > +    __u64 reserved4;
> > +    __u64 reserved5;
> > +    __u64 reserved6;
> 
> Why so many reserved fields?

The first two are reserved for the context save area (reserved1) and
size (reserved2) of the "shared" (AKA time sliced) virtualisation model,
which we don't yet support. That only leaves us with four reserved
fields for anything that we haven't thought of or that the hardware team
hasn't come up with yet ;-)

> What mechanism is there that will allow you to ever unreserve them?
>
> ie. how does a new userspace detect that the kernel it's running on supports
> new fields?

The ioctl will return -EINVAL if any of them are set to non-zero values,
so userspace can easily tell if it's running on an old kernel.

> Or conversely how does a new kernel detect that userspace has passed it a
> meaningful value in one of the previously reserved fields?

They would have to be non-zero (certainly true of the context save
area's size), or one could turn into a flags field or api version.

> > +#define CXL_MAGIC 0xCA
> > +#define CXL_IOCTL_START_WORK      _IOWR(CXL_MAGIC, 0x00, struct cxl_ioctl_start_work)
> 
> What happened to 0x1 ?

That was used to dynamically program the FPGA with a new AFU image, but
we don't have anything to test it on yet and I'm not convinced that the
procedure won't change by the time we do, so we pulled the code.

We can repack the ioctl numbers easily enough... Will do :)

> > +enum cxl_event_type {
> > +    CXL_EVENT_READ_FAIL     = -1,
> 
> I don't see this used?

That was used in the userspace library to mark it's buffer as bad if the
read() call failed for whatever reason... but you're right - it isn't
used by the kernel and doesn't belong in this header. Will remove.

> > +struct cxl_event_header {
> > +    __u32 type;
> > +    __u16 size;
> > +    __u16 process_element;
> > +    __u64 reserved1;
> > +    __u64 reserved2;
> > +    __u64 reserved3;
> > +};
> 
> Again lots of reserved fields?

Figured it was better to have a bit more than we expect we might need
just in case... We can reduce this if you feel it is excessive?

In an earlier version of the code the kernel would fill out the header
and not clear an event if a buffer was passed in that was too small, so
userspace could realloc a larger buffer and try again. This made the API
a bit more complex and our internal users weren't too keen on it, so we
decided to use a fixed-size buffer and make it larger than we strictly
needed so we have plenty of room for further expansion.

> Rather than having the header included in every event, would it be clearer if
> the cxl_event was:
> 
> struct cxl_event {
>     struct cxl_event_header header;
>     union {
>         struct cxl_event_afu_interrupt irq;
>         struct cxl_event_data_storage fault;
>         struct cxl_event_afu_error afu_err;
>     };
> };

Sounds like a good idea to me :)

Cheers,
-Ian
