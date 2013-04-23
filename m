Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67A432C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 04:58:13 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 14:58:10 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6D34F38C801C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:58:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NIw824322294
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:58:08 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NIw7xD022010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:58:08 -0300
Message-ID: <5176D9BE.3090402@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 13:58:06 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 7/12] Use stop machine to update cpu maps
References: <51757951.2080007@linux.vnet.ibm.com>
 <51758470.60402@linux.vnet.ibm.com> <1366676688.2886.5.camel@pasglop>
In-Reply-To: <1366676688.2886.5.camel@pasglop>
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

On 04/22/2013 07:24 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-04-22 at 13:41 -0500, Nathan Fontenot wrote:
>> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
>>
>> Platform events such as partition migration or the new PRRN firmware
>> feature can cause the NUMA characteristics of a CPU to change, and these
>> changes will be reflected in the device tree nodes for the affected
>> CPUs.
>>
>> This patch registers a handler for Open Firmware device tree updates
>> and reconfigures the CPU and node maps whenever the associativity
>> changes. Currently, this is accomplished by marking the affected CPUs in
>> the cpu_associativity_changes_mask and allowing
>> arch_update_cpu_topology() to retrieve the new associativity information
>> using hcall_vphn().
>>
>> Protecting the NUMA cpu maps from concurrent access during an update
>> operation will be addressed in a subsequent patch in this series.
> 
> I see no more mention of stop_machine() ... is the patch subject stale ?
> 

Nope, just me mistakenly putting the wrong subject for this patch. I'll
correct it in the next version.

-Nathan
