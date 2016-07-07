Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlLKd4qwdzDr0f
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 11:55:01 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id uj8so1539409pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 18:55:01 -0700 (PDT)
Date: Thu, 7 Jul 2016 11:00:25 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 geoff@infradead.org, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Message-ID: <20160707020025.GY20774@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
 <6483018.WWW2TSJB10@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
In-Reply-To: <6483018.WWW2TSJB10@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 06, 2016 at 04:29:18PM -0300, Thiago Jung Bauermann wrote:
> Hi,
> 
> Am Mittwoch, 06 Juli 2016, 16:52:26 schrieb AKASHI Takahiro:
> > +linux,usable-memory
> > +-------------------
> > +
> > +This property is set on PowerPC and arm64 by kexec-tools during kdump
> > +to tell the crash kernel the base address of its reserved area of memory,
> > and +the size. e.g.
> > +
> > +/ {
> > +	chosen {
> > +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> > +	};
> > +};
> 
> Again, this description is wrong for PowerPC. See messages from myself and 
> Michael Ellerman:
> 
> https://lists.infradead.org/pipermail/kexec/2016-June/016250.html
> 
> https://lists.infradead.org/pipermail/kexec/2016-June/016253.html

Oops, I must have missed your previous comments. Apologies.

Yes, I know that, and I used to implement the same functionality before.
It did work for dtb-based systems, but not for UEFI(ACPI)-based systems
because UEFI doesn't export memory regions information via a device tree,
but rather via ACPI table. So "/memory" node won't appear.
So I went back with "mem=" command line approach, and later this "/chosen/"
approach.

> IMHO, it would be simpler if ARM used linux,usable-memory in the same way 
> that PowerPC does, for consistency.

Well, this property won't conflict with per-"/memory" ones
if we take it that the former, if present, supersedes the latter.
Sophistic?
What about changing the name to usable-memory-limit?
(I know that you have another one, "memory-limit" though.)

Again, I would like to defer to arm64 maintainers.

Thanks,
-Takahiro AKASHI

> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
