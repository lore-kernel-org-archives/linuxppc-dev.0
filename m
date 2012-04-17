Return-Path: <benh@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72371B7072
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 11:58:36 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 17 Apr 2012 01:53:29 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3H1pJsu618748
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 11:51:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3H1vqb4019159
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 11:57:53 +1000
Message-ID: <1334627871.25353.26.camel@pasglop>
Subject: Re: [PATCH v5 00/21] EEH reorganization
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2012 11:57:51 +1000
In-Reply-To: <20120417113738.0f091da4@kryten>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <20120413073931.0c36169b@kryten> <20120413120346.42e01402@kryten>
 <20120417012915.GA3806@shangw> <20120417113738.0f091da4@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-17 at 11:37 +1000, Anton Blanchard wrote:
> 
> No. I replaced that backtrace in eeh_dn_check_failure with a WARN_ON()
> because the backtrace doesn't give us enough info. I'm submitting a
> patch for that today.
> 
> Bottom line is mstmread has been causing an EEH error since at least
> 3.0, but in 3.4 we now oops instead of recovering. The signs all point
> to the EEH rework in 3.4.

More precisely, the original oops reported by Anton decodes as such:

>Oops: Kernel access of bad area, sig: 11 [#1]

This is typically a bad memory access..

>SMP NR_CPUS=1024 NUMA pSeries
>Modules linked in:
>NIP: c000000000055af8 LR: c000000000033204 CTR: 0000000000000000
>REGS: c000001f42fb7990 TRAP: 0300   Tainted: G        W     (3.4.0-rc2-00065-gf549e08-dirty)

TRAP: 300 means that it's the result of a data access interrupts, ie,
load or store to a bad address

>MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24008084  XER: 00000000
>SOFTE: 1
>CFAR: 00000000000049b8
>DAR: 0000000000000070, DSISR: 40000000

Here the DAR tells us what address was accessed. 0x70 is a strong indication
that this was an access to a NULL pointer (at offset 0x70 from that pointer).

It -might- be something else (such as a NULL passed to a list head or such)
but the idea that there's a NULL floating around is a good hint.

>TASK = c000001f6c7dfc40[19010] 'eehd' THREAD: c000001f42fb4000 CPU: 6
>GPR00: 0000000000000001 c000001f42fb7c10 c000000000bd3a28 c000001f80ab0800 
>GPR04: c000001f7c57d418 0000000000000380 c000001f7c57e070 c000000000ed5360 
>GPR08: 0000000000000000 c000000000c77088 0000000000000000 0000000000000001 
>GPR12: 0000000044008088 c00000000eda1500 00000000019ffa78 0000000000a70000 
>GPR16: 00000000000000bb c000000000a9f754 c000000000963230 000000000000005e 
>GPR20: 0000000001b37e80 00000000000000bb 0000000000000000 c000000000b0ad90 
>GPR24: 0000000000000000 c000000000b10588 0000000000000001 c000001f80ab0800 
>GPR28: 0000000000000000 c000001f80ab0828 0000000000000000 c000001f7ee10000 
>NIP [c000000000055af8] .eeh_add_device_tree_late+0x58/0xf0

This is the function where it happened (eeh_add_device_tree_late)

>LR [c000000000033204] .pcibios_finish_adding_to_bus+0x34/0x50
>Call Trace:
>[c000001f42fb7c10] [00000000fdffffff] 0xfdffffff (unreliable)
>[c000001f42fb7ca0] [c000000000033204] .pcibios_finish_adding_to_bus+0x34/0x50
>[c000001f42fb7d20] [c000000000059a5c] .pcibios_add_pci_devices+0x7c/0x190
>[c000001f42fb7db0] [c000000000057a6c] .eeh_reset_device+0xfc/0x1a0
>[c000001f42fb7e50] [c000000000057e18] .handle_eeh_events+0x308/0x480
>[c000001f42fb7f00] [c0000000000584dc] .eeh_event_handler+0x13c/0x1d0
>[c000001f42fb7f90] [c00000000002099c] .kernel_thread+0x54/0x70

And your backtrace. You can see that you got an eeh event, which triggered an
eeh reset, which triggered a pcibios_add_pci_devices() etc...

>Instruction dump:
>480000a8 60000000 ebff0000 7fbfe800 419e0098 2fbf0000 419e005c e9229eb0 
>80090008 2f800000 419e004c ebdf01d0 <e81e0070> 7fbf0000 3160ffff
>7d2b0110 

Cheers,
Ben.
