Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B8D41A0D89
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 10:41:17 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 18:41:15 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A8C2E6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 18:33:05 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FNfCch25624796
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 23:41:12 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FNfCnP029575
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 18:41:12 -0500
Message-ID: <54B85016.4080906@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 15:41:10 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] pseries/le: Fix another endiannes issue in RTAS call
 from xmon
References: <1421295950.11409.3.camel@ellerman.id.au>
 <1421342627-7214-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <54B8188D.1060907@linux.vnet.ibm.com>
 <1421360377.23332.1.camel@ellerman.id.au>
In-Reply-To: <1421360377.23332.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: paulus@samba.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/15/2015 02:19 PM, Michael Ellerman wrote:
> On Thu, 2015-01-15 at 11:44 -0800, Tyrel Datwyler wrote:
>> On 01/15/2015 09:23 AM, Laurent Dufour wrote:
>>> The commit 3b8a3c010969 ("powerpc/pseries: Fix endiannes issue in RTAS
>>> call from xmon") was fixing an endianness issue in the call made from
>>> xmon to RTAS.
>>>
>>> However, as Michael Ellerman noticed, this fix was not complete, the
>>> token value was not byte swapped. This lead to call an unexpected and
>>> most of the time unexisting RTAS function, which is silently ignored
>>> by RTAS.
>>
>> Nit. Not so much that is silently ignored by RTAS as much as
>> disable_surveillance silently doesn't check the return status of the
>> RTAS call. Maybe a check is warranted and reporting of non-success.
> 
> Yeah you're right, I added a printf of the result and got -3, which is also
> wrong as far as I can tell, but I didn't have the energy to chase it any
> further.

If this was on a powerkvm guest set-indicator should be present for
hotplug (DLPAR) support. However, the surveillance indicator would not
be implemented. I know sometimes I forget if I'm on a powervm or
powerkvm guest. Just a thought.

-Tyrel

> 
> Because this is in xmon we want to be extra careful about what we do, but an
> xmon_printf() should be safe. I'll do that as a cleanup after this.
> 
> cheers
> 
> 
