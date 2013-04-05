Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EE8CE2C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 02:43:34 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 5 Apr 2013 11:43:32 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4BDB46E8066
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 11:43:26 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r35FhSn8296578
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 11:43:28 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r35FhPEv013355
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 11:43:25 -0400
Message-ID: <515EF11C.5060401@linux.vnet.ibm.com>
Date: Fri, 05 Apr 2013 10:43:24 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 2/11] Add PRRN Event Handler
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509CF0.10200@linux.vnet.ibm.com> <20130404033436.GC19443@drongo>
In-Reply-To: <20130404033436.GC19443@drongo>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2013 10:34 PM, Paul Mackerras wrote:
> On Mon, Mar 25, 2013 at 01:52:32PM -0500, Nathan Fontenot wrote:
>> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
>>
>> A PRRN event is signaled via the RTAS event-scan mechanism, which
>> returns a Hot Plug Event message "fixed part" indicating "Platform
>> Resource Reassignment". In response to the Hot Plug Event message,
>> we must call ibm,update-nodes to determine which resources were
>> reassigned and then ibm,update-properties to obtain the new affinity
>> information about those resources.
>>
>> The PRRN event-scan RTAS message contains only the "fixed part" with
>> the "Type" field set to the value 160 and no Extended Event Log. The
>> four-byte Extended Event Log Length field is repurposed (since no
>> Extended Event Log message is included) to pass the "scope" parameter
>> that causes the ibm,update-nodes to return the nodes affected by the
>> specific resource reassignment.
>>
>> This patch adds a handler in rtasd for PRRN RTAS events. The function
>> pseries_devicetree_update() (from mobility.c) is used to make the
>> ibm,update-nodes/ibm,update-properties RTAS calls. Updating the NUMA maps
>> (handled by a subsequent patch) will require significant processing,
>> so pseries_devicetree_update() is called from an asynchronous workqueue
>> to allow rtasd to continue processing events. Since we flush all work
>> on the queue before handling any new work there should only be one event
>> in flight of being handled at a time.
>             ^^ "of" is superfluous

will remove it.

> 
> In the worst case where PRRN events come close together in time, the
> flush_work will block for however long it takes to do this
> "significant processing", meaning that we're no better off using a
> workqueue.  Do we have any reason to think that these PRRN events will
> normally be widely spaced in time?  If so you should mention it in the
> patch description.

Yes. PRRN events can only be triggered from the HMC by an IBM tech who has
to actualy log into a customer system and initiate the PRRN event. There
is no method for a user to initiate a PRRN event. Given this is is safe
to assume that these events will be widely spaced in time.

> 
> Also, rtasd isn't actually a task, it's just a function that gets run
> via schedule_delayed_work_on() and re-schedules itself each time it
> runs.  Is there any deadlock possibility in calling flush_work from a
> work function?

I don't know of any but I will investigate.

Thanks for the feedback.
-Nathan
