Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 616871A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 05:58:52 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 15 Jul 2015 15:58:48 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E14DBC90045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 15:49:51 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6FJwjEb32768242
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 19:58:45 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6FJwiUN016067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 15:58:45 -0400
Message-ID: <55A6BB73.7050402@linux.vnet.ibm.com>
Date: Wed, 15 Jul 2015 14:58:43 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: BUG: sleeping function called from ras_epow_interrupt context
References: <55A55846.5080904@redhat.com>
 <1436908977.3948.266.camel@kernel.crashing.org> <55A66F96.6030808@redhat.com>
In-Reply-To: <55A66F96.6030808@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2015 09:35 AM, Thomas Huth wrote:
> On 07/14/2015 11:22 PM, Benjamin Herrenschmidt wrote:
>> On Tue, 2015-07-14 at 20:43 +0200, Thomas Huth wrote:
>>> Any suggestions how to fix this? Simply revert 587f83e8dd50d? Use
>>> mdelay() instead of msleep() in rtas_busy_delay()? Something more
>>> fancy?
>>
>> A proper fix would be more fancy, the get_sensor should happen in a
>> kernel thread instead.
> 
> I'm not very familiar with this stuff, but isn't the EPOW interrupt
> something that is very time-critical? Moving parts of the handler into a
> kernel thread then does not sound like a very good idea to me...
> 
> Another question: Can it happen at all that this get-sensor call results
> in a sleep condition? Looking at commit ID
> 81b73dd92b97423b8f5324a59044da478c04f4c4 ("Fix might-sleep warning on
> removing cpus"), which apparently fixed a similar issue for CPU
> hot-plugging, indicates that at least some of the rtas calls are never
> returning the busy code? In that case we could fix this by introducing a
> similar rtas_get_sensor_fast() function? (or simply revert 587f83e8dd50d
> which would be quite similar, I think)
> 

Looking at the PAPR, the get-sensor-state rtas call for the EPOW sensor
is listed as a fast call and should not return a busy indication.

I'm curious as to why we're getting a busy return indication when
making this call.

-Nathan
