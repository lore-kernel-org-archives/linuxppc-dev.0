Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFC7A1A092A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 16:47:44 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 12 Feb 2015 11:17:41 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1CF0BE004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 11:19:14 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C5lUJS61669452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 11:17:30 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C5lcsQ003977
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 11:17:38 +0530
Message-ID: <54DC3E7A.3090404@linux.vnet.ibm.com>
Date: Thu, 12 Feb 2015 11:17:38 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4] powerpc, powernv: Add OPAL platform event driver
References: <1423206522-18084-1-git-send-email-vipin@linux.vnet.ibm.com>
 <m31tlxniqp.fsf@oc8180480414.ibm.com>
In-Reply-To: <m31tlxniqp.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Joel Stanley <joel@jms.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02/11/2015 10:32 AM, Stewart Smith wrote:
> Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
>> 	(1) Environmental and Power Warning (EPOW)
>> 	(2) Delayed Power Off (DPO)
>> The user interface for this driver is /dev/opal_event character
>> device file where the user space clients can poll and read for
>> new opal platform events. The expected sequence of events driven
>> from user space should be like the following.
>>
>> 	(1) Open the character device file
>> 	(2) Poll on the file for POLLIN event
>> 	(3) When unblocked, must attempt to read OPAL_PLAT_EVENT_MAX_SIZE size
>> 	(4) Kernel driver will pass at most one opal_plat_event structure
>> 	(5) Poll again for more new events
> A few thoughts from discussing with Michael and Joel:
> - not convinced that a chardev is the most ideal way to notify
>    userspace. It seems like yet-another powerpc specific notification
>    mechanism, which isn't ideal.
> - netlink probably isn't right either (although maybe *sligthtly*
>    better?)
> - it seems that the "standard" way is ACPI, so I wonder if we could emit
>    an ACPI event and essentially fake having ACPI... that would make all
>    existing userspace "just work", right?
>    Looking at acpi_bus_generate_netlink_event call in
>    drivers/acpi/button.c it looks possible that we may be able to
>    (relatively simply) do that?
Thanks Stewart, i will explore more about ACPI and will also try to see 
if we could use it to throw
events to guests.
> - What do UPSs do? It would seem that some common "this is what's about
>    to happen to your power" would almost *have* to exist somewhat
>    generically?
UPS class tells about UPS status with system. FSP sends mbox messages 
with UPS status along with
UPS status bit which tells exactly as to what change is there in UPS 
status like UPS installed, UPS battery low, UPS removed (By passed). We 
plan to add support for these UPS events in skiboot to provide more
UPS details.
> I strongly advocate for anything that doesn't require custom userspace
> that's OPAL/POWER specific (that we then have to get into distros etc etc
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
