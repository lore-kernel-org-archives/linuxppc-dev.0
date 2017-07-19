Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCYW34vmvzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 09:43:11 +1000 (AEST)
Message-ID: <1500507770.3350.41.camel@kernel.crashing.org>
Subject: Re: KVM guests freeze under upstream kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: joserz@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au, oohall@gmail.com
Date: Thu, 20 Jul 2017 09:42:50 +1000
In-Reply-To: <20170719194634.GA1222@pacoca>
References: <20170719194634.GA1222@pacoca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-19 at 16:46 -0300, joserz@linux.vnet.ibm.com wrote:
> Hello!
> 
> We're not able to boot any KVM guest using upstream kernel (cb8c65ccff7f77d0285f1b126c72d37b2572c865 - 4.13.0-rc1+).
> After reaching the SLOF initial counting, the guest simply freezes:

Can you send our .config ?

> SLOF
> **********************************************************************
> QEMU Starting
>  Build Date = Mar  3 2017 13:29:19
>   FW Version = git-66d250ef0fd06bb8
>    Press "s" to enter Open Firmware.
> 
>    C0360
> 
> After bisecting I found the commit:
> 
> https://github.com/torvalds/linux/commit/ebd3119
> 
>     powerpc/mm: Add devmap support for ppc64
> 
>     Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S.  This
>     is used to differentiate device backed memory from transparent huge
>     pages since they are handled in more or less the same manner by the core
>     mm code.
> 
> Reverting the commit and rebuilding 4.13.0-rc1+ was enough to make a workaround.
> But I'll need some help from you guys in order to solve it.
> 
> Thanks!
> 
> Jose Ziviani
