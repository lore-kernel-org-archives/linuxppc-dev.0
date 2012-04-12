Return-Path: <anton@samba.org>
Date: Fri, 13 Apr 2012 07:39:31 +1000
From: Anton Blanchard <anton@samba.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/21] EEH reorganization
Message-ID: <20120413073931.0c36169b@kryten>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Gavin,

> This series of patches is going to reorganize EEH so that it could
> support multiple platforms in future. The requirements were raised
> from the aspects.

I just hit this on mainline from today (3.4.0-rc2-00065-gf549e08).
Haven't had a chance to narrow it down yet.

Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=1024 NUMA pSeries
Modules linked in:
NIP: c000000000055af8 LR: c000000000033204 CTR: 0000000000000000
REGS: c000001f42fb7990 TRAP: 0300   Tainted: G        W     (3.4.0-rc2-00065-gf549e08-dirty)
MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24008084  XER: 00000000
SOFTE: 1
CFAR: 00000000000049b8
DAR: 0000000000000070, DSISR: 40000000
TASK = c000001f6c7dfc40[19010] 'eehd' THREAD: c000001f42fb4000 CPU: 6
GPR00: 0000000000000001 c000001f42fb7c10 c000000000bd3a28 c000001f80ab0800 
GPR04: c000001f7c57d418 0000000000000380 c000001f7c57e070 c000000000ed5360 
GPR08: 0000000000000000 c000000000c77088 0000000000000000 0000000000000001 
GPR12: 0000000044008088 c00000000eda1500 00000000019ffa78 0000000000a70000 
GPR16: 00000000000000bb c000000000a9f754 c000000000963230 000000000000005e 
GPR20: 0000000001b37e80 00000000000000bb 0000000000000000 c000000000b0ad90 
GPR24: 0000000000000000 c000000000b10588 0000000000000001 c000001f80ab0800 
GPR28: 0000000000000000 c000001f80ab0828 0000000000000000 c000001f7ee10000 
NIP [c000000000055af8] .eeh_add_device_tree_late+0x58/0xf0
LR [c000000000033204] .pcibios_finish_adding_to_bus+0x34/0x50
Call Trace:
[c000001f42fb7c10] [00000000fdffffff] 0xfdffffff (unreliable)
[c000001f42fb7ca0] [c000000000033204] .pcibios_finish_adding_to_bus+0x34/0x50
[c000001f42fb7d20] [c000000000059a5c] .pcibios_add_pci_devices+0x7c/0x190
[c000001f42fb7db0] [c000000000057a6c] .eeh_reset_device+0xfc/0x1a0
[c000001f42fb7e50] [c000000000057e18] .handle_eeh_events+0x308/0x480
[c000001f42fb7f00] [c0000000000584dc] .eeh_event_handler+0x13c/0x1d0
[c000001f42fb7f90] [c00000000002099c] .kernel_thread+0x54/0x70
Instruction dump:
480000a8 60000000 ebff0000 7fbfe800 419e0098 2fbf0000 419e005c e9229eb0 
80090008 2f800000 419e004c ebdf01d0 <e81e0070> 7fbf0000 3160ffff
7d2b0110 

Anton
