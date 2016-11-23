Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNncj15PmzDvHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 14:19:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com
Subject: Re: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
In-Reply-To: <1f4e106c-3ad6-e81f-184c-56bf61336453@au1.ibm.com>
References: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
 <87twazvmfx.fsf@concordia.ellerman.id.au>
 <f9cb1ce3-f636-4b41-4621-47ad742b66ad@au1.ibm.com>
 <1f4e106c-3ad6-e81f-184c-56bf61336453@au1.ibm.com>
Date: Wed, 23 Nov 2016 14:19:14 +1100
Message-ID: <8737iivq6l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> On 23/11/16 12:37, Andrew Donnellan wrote:
>>> There's existing logic in kernel/reboot.c to handle a reboot= command
>>> line parameter, which can set the reboot_mode, so my preference would be
>>> that we use that.
>>>
>>> Currently we completely ignore the reboot_mode, so there's no backward
>>> compatibility issue.
>>>
>>> It looks like the default is REBOOT_COLD, whatever that means. So I
>>> think we could define that on powernv REBOOT_HARD means "do a full IPL".
>>
>> Sounds good.
>
> Thinking about this more - you can't change that at runtime. :(

Yeah. Is that a problem? From my POV this is basically a "my firmware is
broken" workaround, so you're going to want to set it permanently until
you update your firmware.

>>> Or we could use "force", which already exists, though I can't quite see
>>> what that actually means on x86.
>>
>> Hmm.
>
> It looks like that on x86, if reboot_force = 1, we don't call 
> machine_shutdown() and go straight to __machine_emergency_restart()?

I think so. But I don't know what that actually means from a user's
point of view.

cheers
