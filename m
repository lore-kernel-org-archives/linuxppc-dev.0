Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 941BB2C00F7
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Mar 2013 05:02:30 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 19 Mar 2013 14:02:28 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9E58A6E805F
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:02:22 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2JI2O8L076786
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 14:02:24 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2JI1JY6012684
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 12:01:19 -0600
Message-ID: <5148A7EC.70301@linux.vnet.ibm.com>
Date: Tue, 19 Mar 2013 13:01:16 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH2/11] Add PRRN Event Handler
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB3C9.6010302@linux.vnet.ibm.com>
 <20130314085155.GB9841@iris.ozlabs.ibm.com>
In-Reply-To: <20130314085155.GB9841@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2013 03:51 AM, Paul Mackerras wrote:
> On Fri, Mar 08, 2013 at 10:00:09PM -0600, Nathan Fontenot wrote:
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
>> to allow rtasd to continue processing events.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> [snip]
> 
>> +static s32 update_scope;
> 
> Do we have a guarantee that there can only be one of these events
> outstanding at a time?  If so it would be nice to document that in a
> comment next to this declaration, so we know in future that this is
> why this is safe.
> 

We only allow for one event to be outstanding. When a PRRN Event is
received we flush any work currently queued up and add the new event
event to the workqueue (see prrn_schedule_work() from the patch).

As I understand flush_work(), this would wait for any work in flight
to complete, then remove all work before returning. I'll add a comment
and update the patch description.

-Nathan
