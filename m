Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlmn12MBdzDr4b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 04:46:45 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67Ii66I114977
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 14:46:43 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xn7hf6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 14:46:42 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 15:46:40 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 1DF2D1DC006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:46:30 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u67IkbSt12911102
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 15:46:37 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u67Ikboe032410
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 15:46:37 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: kexec@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
 geoff@infradead.org, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Date: Thu, 07 Jul 2016 15:46:35 -0300
In-Reply-To: <20160707020025.GY20774@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <6483018.WWW2TSJB10@hactar> <20160707020025.GY20774@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1629887.9vk1SlhCGj@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 07 Juli 2016, 11:00:25 schrieb AKASHI Takahiro:
> On Wed, Jul 06, 2016 at 04:29:18PM -0300, Thiago Jung Bauermann wrote:
> > Hi,
> > 
> > Am Mittwoch, 06 Juli 2016, 16:52:26 schrieb AKASHI Takahiro:
> > > +linux,usable-memory
> > > +-------------------
> > > +
> > > +This property is set on PowerPC and arm64 by kexec-tools during kdump
> > > +to tell the crash kernel the base address of its reserved area of
> > > memory, and +the size. e.g.
> > > +
> > > +/ {
> > > +	chosen {
> > > +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> > > +	};
> > > +};
> > 
> > Again, this description is wrong for PowerPC. See messages from myself
> > and Michael Ellerman:
> > 
> > https://lists.infradead.org/pipermail/kexec/2016-June/016250.html
> > 
> > https://lists.infradead.org/pipermail/kexec/2016-June/016253.html
> 
> Oops, I must have missed your previous comments. Apologies.

No problem.

> Yes, I know that, and I used to implement the same functionality before.
> It did work for dtb-based systems, but not for UEFI(ACPI)-based systems
> because UEFI doesn't export memory regions information via a device tree,
> but rather via ACPI table. So "/memory" node won't appear.
> So I went back with "mem=" command line approach, and later this
> "/chosen/" approach.

Ah, I didn't realize there could be dtb and UEFI systems.

> > IMHO, it would be simpler if ARM used linux,usable-memory in the same
> > way
> > that PowerPC does, for consistency.
> 
> Well, this property won't conflict with per-"/memory" ones
> if we take it that the former, if present, supersedes the latter.
> Sophistic?
> What about changing the name to usable-memory-limit?
> (I know that you have another one, "memory-limit" though.)
> 
> Again, I would like to defer to arm64 maintainers.

My personal opinion is that having a property with a different name would be 
less confusing, but it's not a strong opinion.

I would suggest calling it usable-memory-range, but I'm fine with whatever 
is decided by the maintainers.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
