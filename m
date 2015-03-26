Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2621A0BE1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 20:45:09 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 26 Mar 2015 09:45:06 -0000
Message-ID: <5513D514.1000504@fr.ibm.com>
Date: Thu, 26 Mar 2015 10:44:52 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: handle OPAL_SUCCESS return in
 opal_sensor_read
References: <1427305834-6737-1-git-send-email-clg@fr.ibm.com>
 <m3fv8s7k2p.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3fv8s7k2p.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2015 12:07 AM, Stewart Smith wrote:
> Cédric Le Goater <clg@fr.ibm.com> writes:
>> Currently, when a sensor value is read, the kernel calls OPAL, which in
>> turn builds a message for the FSP, and waits for a message back. 
>>
>> The new device tree for OPAL sensors [1] adds new sensors that can be 
>> read synchronously (core temperatures for instance) and that don't need 
>> to wait for a response.
>>
>> This patch modifies the opal call to accept an OPAL_SUCCESS return value
>> and cover the case above.
>>
>> [1] https://lists.ozlabs.org/pipermail/skiboot/2015-March/000639.html
>>
>> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
>> ---
>>
>>  We still uselessly reserve a token (for the response) and take a
>>  lock, which might raise the need of a new 'opal_sensor_read_sync' 
>>  call.
> 
> Actually.... why do we take a lock around the OPAL calls at all?

The sensor service in OPAL only handles one FSP request at a time and 
returns OPAL_BUSY if one is already in progress. The lock covers this case 
but we could also remove it return EBUSY to the driver or even retry the 
call. That might be dangerous though. 

Changing OPAL to handle simultaneously multiple requests does not seem really 
necessary, it won't speed up the communication with the FSP and that is the
main bottleneck.

C.


 
