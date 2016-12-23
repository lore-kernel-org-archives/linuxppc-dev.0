Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tlFX61S5CzDwKm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2016 15:19:17 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBN4DVvk044780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 23:19:15 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27gmxupq33-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 23:19:15 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 22 Dec 2016 23:19:14 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
In-Reply-To: <8737iivq6l.fsf@concordia.ellerman.id.au>
References: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
 <87twazvmfx.fsf@concordia.ellerman.id.au>
 <f9cb1ce3-f636-4b41-4621-47ad742b66ad@au1.ibm.com>
 <1f4e106c-3ad6-e81f-184c-56bf61336453@au1.ibm.com>
 <8737iivq6l.fsf@concordia.ellerman.id.au>
Date: Fri, 23 Dec 2016 15:19:04 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87pokj2s7b.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>
>> On 23/11/16 12:37, Andrew Donnellan wrote:
>>>> There's existing logic in kernel/reboot.c to handle a reboot= command
>>>> line parameter, which can set the reboot_mode, so my preference would be
>>>> that we use that.
>>>>
>>>> Currently we completely ignore the reboot_mode, so there's no backward
>>>> compatibility issue.
>>>>
>>>> It looks like the default is REBOOT_COLD, whatever that means. So I
>>>> think we could define that on powernv REBOOT_HARD means "do a full IPL".
>>>
>>> Sounds good.
>>
>> Thinking about this more - you can't change that at runtime. :(
>
> Yeah. Is that a problem? From my POV this is basically a "my firmware is
> broken" workaround, so you're going to want to set it permanently until
> you update your firmware.

The only real world application I can see wanting to do that is perhaps
HTX - where it chooses what kind of bootme run it wants. So, well, for
certain definitions of "real world".

-- 
Stewart Smith
OPAL Architect, IBM.
