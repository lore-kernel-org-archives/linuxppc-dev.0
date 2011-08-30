Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39C50B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 16:17:20 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id p7U6HHH8005817
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 11:47:17 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7U6HHSR4223142
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 11:47:17 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7U6HGLx020610
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2011 16:17:17 +1000
Message-ID: <4E5C806C.1070809@in.ibm.com>
Date: Tue, 30 Aug 2011 11:47:16 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PSeries: Cancel RTAS event scan before firmware flash
References: <20110727120801.10429.7276.stgit@localhost6.localdomain6>
	<1314684237.2488.77.camel@pasglop>
In-Reply-To: <1314684237.2488.77.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mikey@neuling.org, "Ravi K. Nittala" <ravi.nittala@in.ibm.com>,
	sbest@us.ibm.com, antonb@au1.ibm.com, subrata.modak@in.ibm.com,
	ranittal@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	divya.vikas@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/11 11:33, Benjamin Herrenschmidt wrote:
> On Wed, 2011-07-27 at 17:39 +0530, Ravi K. Nittala wrote:
>> The firmware flash update is conducted using an RTAS call, that is serialized
>> by lock_rtas() which uses spin_lock. rtasd keeps scanning for the RTAS events
>> generated on the machine. This is performed via a delayed workqueue, invoking
>> an RTAS call to scan the events.
>>
>> The flash update takes a while to complete and during this time, any other
>> RTAS call has to wait. In this case, rtas_event_scan() waits for a long time
>> on the spin_lock resulting in a soft lockup.
>>
>> Approaches to fix the issue :
>>
>> Approach 1: Stop all the other CPUs before we start flashing the firmware.
>>
>> Before the rtas firmware update starts, all other CPUs should be stopped.
>> Which means no other CPU should be in lock_rtas(). We do not want other CPUs
>> execute while FW update is in progress and the system will be rebooted anyway
>> after the update.
>
> Shouldn't we resume the event scan after the flash ?
>

The flash operation is performed in the reboot path at the very end.
So, even if we restart the event scan, the thread may not be able to process
the events. Hence we thought we would leave it stopped.

Again, we do not have much expertise in deciding which is the best thing to do.
We could resume the event scan, if you think that is needed.

Thanks for the review.

Suzuki
