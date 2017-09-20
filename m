Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxnK90vJ1zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 14:47:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh: Disable EEH stack dump by default
In-Reply-To: <1505831139-6053-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1505831139-6053-1-git-send-email-joserz@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 14:47:08 +1000
Message-ID: <87r2v2kmcz.fsf@concordia.ellerman.id.au>
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

Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:

> Today, each EEH causes a stack dump to be printed in the logs. In
> production environment it's not quite necessary. Thus, this patch

I'm unconvinced. A production environment is exactly where you don't
want to be getting an EEH, and so if you *do* then every bit of
information is helpful.

> For example, instead of the following:
>
> [  131.778661] EEH: Frozen PHB#2-PE#fd detected
> [  131.778672] EEH: PE location: N/A, PHB location: N/A
> [  131.778677] CPU: 21 PID: 10098 Comm: lspci Not tainted ...
> [  131.778680] Call Trace:
> [  131.778686] [c0000003a140bab0] [c000000000beb58c] dump_stack+...
> <snip ~10 lines>
> [  131.778770] EEH: Detected PCI bus error on PHB#2-PE#fd
> [  131.778775] EEH: This PCI device has failed 1 times in the last hour
> ...
>
> we will have this by default:
>
> [12777.175880] EEH: Frozen PHB#2-PE#fd detected
> [12777.175893] EEH: PE location: N/A, PHB location: N/A
> [12777.175922] EEH: Detected PCI bus error on PHB#2-PE#fd
> [12777.175931] EEH: This PCI device has failed 2 times in the last hour

*What* PCI device?

How am I supposed to know what device/driver just failed? If I had the
stack trace I could probably at least work it out based on the driver
involved.

cheers
