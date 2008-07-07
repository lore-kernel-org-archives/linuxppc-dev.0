Return-Path: <maynardj@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E17A8DDECF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:04:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67LxVw2025643
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 17:59:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67M4hkn125382
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 16:04:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67M4hSB012864
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 16:04:43 -0600
Message-ID: <48729311.1040206@us.ibm.com>
Date: Mon, 07 Jul 2008 17:05:05 -0500
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Add PPC_FEATURE_PMU_COMPAT
References: <20080703232001.GB9594@localdomain>
	<A2A80C78-AF10-4FC0-A7E7-CDCACA9AD7E3@kernel.crashing.org>
	<20080707172921.GH9594@localdomain>
In-Reply-To: <20080707172921.GH9594@localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Kumar Gala wrote:
>   
>> On Jul 3, 2008, at 6:20 PM, Nathan Lynch wrote:
>>
>>     
>>> Beginning with Power6, there is a set of 32 PMU events which is
>>> compatible across POWER processor lines.  PPC_FEATURE_PMU_COMPAT
>>> indicates support for this subset.
>>>
>>> Signed-off-by: Nathan Lynch <ntl@pobox.com>
>>> ---
>>> arch/powerpc/kernel/cputable.c |    4 ++--
>>> include/asm-powerpc/cputable.h |    1 +
>>> 2 files changed, 3 insertions(+), 2 deletions(-)
>>>       
>> Can you explain what these PMU events are a bit further?
>>     
>
> Maynard, can you help out here...?  :)
>   
As of POWER6, a set of 32 common events were defined that must be
supported on all future POWER processors -- aka "PMU compat set".  The
main impetus for this compat set is the need to support partition
migration, especially from processor P(n) to processor P(n+1), where
performance software that's running in the new partition may not be
knowledgeable about processor P(n+1).  If a performance tool determines
it does not support the physical processor, but is told (via the
PPC_FEATURE_PMU_COMPAT bit) that the processor supports the notion of
the PMU compat set, then the performance tool can surface just those
events to the user of the tool.

Hope that helps.

-Maynard
