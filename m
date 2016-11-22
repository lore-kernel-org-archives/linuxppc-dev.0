Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNM9f0FhqzDvkR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:27:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com
Subject: Re: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
In-Reply-To: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
References: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
Date: Tue, 22 Nov 2016 21:27:46 +1100
Message-ID: <87twazvmfx.fsf@concordia.ellerman.id.au>
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

> skiboot now supports "fast reboot", a reboot procedure where skiboot
> reinitialises hardware and loads a new kernel without re-IPLing the
> machine. At present, fast reboot support is still experimental and is not
> enabled by default, however it is intended that it will be enabled by
> default in a near-future release.
>
> There may be some circumstances where the user wants to force a full IPL
> reboot rather than using fast reboot. Add support for the
> OPAL_REBOOT_FULL_IPL reboot type, enabled by writing 1 to
> /sys/firmware/opal/force_full_ipl_reboot. On versions of skiboot that
> implement the OPAL_REBOOT_FULL_IPL reboot type, this will force an IPL. On
> versions that do not, print an error message on reboot and proceed with a
> regular reboot (which could be a full IPL or a fast reboot).

Hi Andrew,

Can I suggest:
 - Fix OPAL
 - Fix OPAL
 - Fix OPAL

...

Oh OK, it's firmware :D

There's existing logic in kernel/reboot.c to handle a reboot= command
line parameter, which can set the reboot_mode, so my preference would be
that we use that.

Currently we completely ignore the reboot_mode, so there's no backward
compatibility issue.

It looks like the default is REBOOT_COLD, whatever that means. So I
think we could define that on powernv REBOOT_HARD means "do a full IPL".

Or we could use "force", which already exists, though I can't quite see
what that actually means on x86.

cheers
