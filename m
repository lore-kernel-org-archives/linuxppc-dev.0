Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA4D31A0550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:45:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 24 Feb 2015 19:45:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A581A2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:45:01 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1O9irSj25362636
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:45:01 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1O9iRts018350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:44:28 +1100
Message-ID: <54EC47E8.4090003@linux.vnet.ibm.com>
Date: Tue, 24 Feb 2015 15:14:08 +0530
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

Hi Stewart,
          I looked into ACPI and found details about it. But before we 
go into
discussing more details of it, would like to  share a brief about OPAL 
platform
events (EPOW/DPO) work and original design proposed.

As if now OPAL platform events work supports two events:
EPOW (Early Power Off Warning) and DPO (Delayed Power Off).

On FSP based systems FSP notifies OPAL about EPOW and DPO events via mbox
mechanism. Subsequently OPAL sends notifications for these events to 
pkvm kernel.
Original design is to have a kernel driver maintain a queue and add 
these events
to queue upon arrival. pkvm driver also provides a character device for 
host to consume
these events. A daemon is proposed for pkvm host to poll/read these 
events from
char device. This daemon would process these events and take action to log
and shutdown host. Apart from this it would also send these event info 
to VMs
which is handled by OSes running on VMs. Linux on VMs already has code 
in place
to handle these events as it expects this info to reach it in PAPR 
format under
EPOW (Environmental and Power Warnings) category.

EPOW mbox msgs are received for below events:
1. UPS events - UPS Battery Low, UPS Bypassed, UPS Utility Failure, UPS On
2. SPCN events - Configuration Change, Log SPCN Fault, Impending Power 
Failure, Power Incomplete
3. Temprature events - Over Ambient temperature, Over internal temperature.

Now ACPI:

Looked into ACPI and tried to figure out how ACPI userspace/kernel 
framework
can be helpful for our work.

ACPI user space consists of below components.
acpid - ACPI daemon to receive events from kernel
acpid provides events and actions files in /etc/acpi dir to configure 
actions
for various events.

acpi, acpi_listen, acpitool - Commands to query and set various ACPI 
supported parameters.
These tools work with various sysfs files to show/set various parameter 
values.

As if today acpid and other tools don't exist for POWER so would need to 
be ported.
acpid is useful for our work but other tools might not be helpful as 
they look into
various sysfs files created by various ACPI kernel drivers which we 
won't have.
Also we would need to map our EPOW/DPO events to acpid supported events
and few events link SPCN ones won't map straight away and might need to be
added in acpid as new events.

ACPI in kernel has various drivers for fan, battery, laptop buttons etc. 
They handle events
and uses netlink mechanism to sent out these events to userspace. Now 
looking into ACPI
code it seems that we would be reusing a small chunk of acpi code but 
instead end up adding
unnecessary complexity due to support a lot of stuff than needed by us. 
Here too mapping our
  EPOW/DPO events to ACPI defined structures in needed and we would need 
to add
new member varaibles in ACPI event structures for unmapped events like 
SPCN ones.

In nutshell it seems that by using ACPI we would end up adding lot more 
complexity with a little
gain of code reuse.

Netlink:

On technology side netlink seems to be a faster method compared to 
character driver. So that could be
a good alternative to use as a method of communication between our pkvm 
driver and userspace.
But EPOW/DPO events occur at very low rate unlike network subsystem 
which receive data packets
at a very high rate. So probably netlink could be a faster method but 
due to slow EPOW/DPO event
traffic a character driver might be sufficient.

We already have ppc64-diag package which is part of various distros so 
would be used for hosting
daemon code. Thus it takes off overhead of convincing distros for adding 
something extra.

This was my findings and opinions on alternatives. Apologies for a 
little lengthy text :-)

Let me know if i missed out anything and any suggestions that you would 
have.

Regards,
Vipin

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
> - What do UPSs do? It would seem that some common "this is what's about
>    to happen to your power" would almost *have* to exist somewhat
>    generically?
>
> I strongly advocate for anything that doesn't require custom userspace
> that's OPAL/POWER specific (that we then have to get into distros etc etc)
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
