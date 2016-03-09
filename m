Return-Path: <mrochs@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C26901A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 03:42:34 +1100 (AEDT)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A20F140187
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 03:42:33 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mrochs@us.ibm.com>;
 Wed, 9 Mar 2016 09:41:14 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5E47419D8061
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 09:29:02 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29Gf6Re21364796
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 16:41:06 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29Gf5fa028447
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 11:41:06 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
From: Matt Ochs <mrochs@us.ibm.com>
In-Reply-To: <87a8m7iunv.fsf@vajain21.in.ibm.com>
Date: Wed, 9 Mar 2016 10:41:04 -0600
Cc: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Manoj Kumar <kumarmn@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Message-Id: <87CD53E9-4F45-476F-9DA3-A3CEF974D357@us.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 9, 2016, at 8:37 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> =
wrote:
>> +/*
>> + * AFU driver ops allows an AFU driver to create their own events to =
pass to
>> + * userspace through the file descriptor as a simpler alternative to =
overriding
>> + * the read() and poll() calls that works with the generic cxl =
events. These
>> + * events are given priority over the generic cxl events, so they =
will be
>> + * delivered first if multiple types of events are pending.
>> + *
>> + * event_pending() will be called by the cxl driver to check if an =
event is
>> + * pending (e.g. in select/poll/read calls).
>> + *
>> + * deliver_event() will be called to fill out a cxl_event structure =
with the
>> + * driver specific event. The header will already have the type and
>> + * process_element fields filled in, and header.size will be set to
>> + * sizeof(struct cxl_event_header). The AFU driver can extend that =
size up to
>> + * max_size (if an afu driver requires more space, they should =
submit a patch
>> + * increasing the size in the struct cxl_event_afu_driver_reserved =
definition).
>> + *
>> + * Both of these calls are made with a spin lock held, so they must =
not sleep.
>> + */
>> +struct cxl_afu_driver_ops {
>> +	bool (*event_pending) (struct cxl_context *ctx);
>> +	void (*deliver_event) (struct cxl_context *ctx,
>> +			struct cxl_event *event, size_t max_size);
>> +};
>> +
>=20
> I would propose these two apis.
>=20
> /*
> *  fetches an event from the driver event queue. NULL means that queue
> *  is empty. Can sleep if needed. The memory for cxl_event is =
allocated
> *  by module being called. Hence it can be potentially be larger then
> *  sizeof(struct cxl_event). Multiple calls to this should return same
> *  pointer untill ack_event is called.
> */
> struct cxl_event * fetch_event(struct cxl_context * ctx);
>=20
> /*
> * Returns and acknowledge the struct cxl_event * back to the driver
> * which can then free it or maybe put it back in a kmem_cache. This
> * should be called once we have completely returned the current
> * struct cxl_event from the readcall
> */
> void ack_event(struct cxl_context * ctx, struct cxl_event *);
>=20
> I think above apis would give us more flexbility in the future when
> drivers would want to send larger events without breaking the abi.

=46rom a cxlflash perspective, I think we'd be fine with this model as
long as the driver events are still prioritized. I do like the removal =
of
the no-sleep requirement and this would allow us to simply hand off
an already populated event reference.
