Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 133481A1A2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:24:52 +1000 (AEST)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E9FE1402B3
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:24:50 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 01:24:49 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A90BC1FF0045
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 01:15:55 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7NrvE40829010
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 00:23:53 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7Ojhe028099
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 01:24:45 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, sam.mj@au1.ibm.com
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] powerpc/kexec: Wait 1s for secondaries to enter OPAL
In-Reply-To: <1438077498.7562.130.camel@kernel.crashing.org>
References: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
 <m3r3nukut9.fsf@oc8180480414.ibm.com> <55B71D89.7000308@au1.ibm.com>
 <1438077498.7562.130.camel@kernel.crashing.org>
Date: Wed, 29 Jul 2015 17:24:33 +1000
Message-ID: <m3io93ifym.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Tue, 2015-07-28 at 16:13 +1000, Samuel Mendoza-Jonas wrote:
>
>> "It sounds reasonable" was more or less the inspiration :)
>> While I was going over some of the code relating to the previous kexec
>> fix with Ben he pointed this out and suggested there wasn't
>> much of a reason to differentiate between a crashing/non-crashing
>> cpu as far as the timeout goes - if we're not 'crashing' we still
>> don't want to spin forever.
>> 
>> I'll let Ben comment on whether 1s per cpu is enough.
>
> Well, if the scheduler doesn't give us the CPU at the point of kexec
> within a second, I think we are in pretty bad shape already, don't you
> think ?

Quite likely, I think my dislike of magic timeouts just kicked in :)
