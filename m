Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7D3DB1007D4
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Dec 2011 10:44:46 +1100 (EST)
Received: from mail27-db3 (localhost [127.0.0.1])	by mail27-db3-R.bigfish.com
 (Postfix) with ESMTP id 3B3AD20068	for <linuxppc-dev@ozlabs.org>;
 Mon,  5 Dec 2011 23:44:41 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.241])	by
 mail27-db3.bigfish.com (Postfix) with ESMTP id C81302C013B	for
 <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2011 23:44:40 +0000 (UTC)
Message-ID: <4EDD575F.6010006@freescale.com>
Date: Mon, 5 Dec 2011 17:44:31 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: add a 32-bit P1022DS device tree
References: <1322863714-6818-1-git-send-email-timur@freescale.com>
 <1322863714-6818-2-git-send-email-timur@freescale.com>
 <D5BD2D7D-4549-42A7-8BA6-9B3C84DB5E85@freescale.com>
In-Reply-To: <D5BD2D7D-4549-42A7-8BA6-9B3C84DB5E85@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> look at how mpc8572ds handles 36b.dts we put common definitions in a shared file.

Ok, I've made those changes, but when I boot the kernel, I'm seeing this.  Can you give me a clue as to what's wrong?

PCI: Probing PCI hardware                                                       
pci 0000:00:00.0: [1957:0110] type 1 class 0x000b20                             
pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)             
pci 0000:00:00.0: supports D1 D2                                                
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold                     
pci 0000:00:00.0: PME# disabled                                                 
pci 0000:00:00.0: PCI bridge to [bus 01-ff]                                     
pci 0001:02:00.0: [1957:0110] type 1 class 0x000b20                             
pci 0001:02:00.0: ignoring class b20 (doesn't match header type 01)             
pci 0001:02:00.0: supports D1 D2                                                
pci 0001:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold                     
pci 0001:02:00.0: PME# disabled                                                 
pci 0001:02:00.0: PCI bridge to [bus 03-ff]                                     
pci 0002:04:00.0: [1957:0110] type 1 class 0x000b20                             
pci 0002:04:00.0: ignoring class b20 (doesn't match header type 01)             
pci 0002:04:00.0: supports D1 D2                                                
pci 0002:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold                     
pci 0002:04:00.0: PME# disabled                                                 
pci 0002:05:00.0: [8086:10d3] type 0 class 0x000200                             
pci 0002:05:00.0: reg 10: [mem 0x80000000-0x8001ffff]                           
pci 0002:05:00.0: reg 14: [mem 0x80080000-0x800fffff]                           
pci 0002:05:00.0: reg 18: [io  0x1000-0x101f]                                   
pci 0002:05:00.0: reg 1c: [mem 0x80100000-0x80103fff]                           
pci 0002:05:00.0: reg 30: [mem 0x00000000-0x0003ffff pref]                      
pci 0002:05:00.0: PME# supported from D0 D3hot D3cold                           
pci 0002:05:00.0: PME# disabled                                                 
pci 0002:04:00.0: PCI bridge to [bus 05-ff]                                     
pci 0002:04:00.0:   bridge window [mem 0x80000000-0x801fffff]                   
PCI: Cannot allocate resource region 0 of device 0002:05:00.0, will remap       
PCI: Cannot allocate resource region 1 of device 0002:05:00.0, will remap       
PCI: Cannot allocate resource region 3 of device 0002:05:00.0, will remap       
PCI 0000:00 Cannot reserve Legacy IO [io  0xffbed000-0xffbedfff]                
PCI 0001:02 Cannot reserve Legacy IO [io  0xffbdb000-0xffbdbfff]                
PCI 0002:04 Cannot reserve Legacy IO [io  0xffbc9000-0xffbc9fff]                
PCI: max bus depth: 1 pci_try_num: 2                                            
pci 0000:00:00.0: PCI bridge to [bus 01-01]                                     
pci 0000:00:00.0:   bridge window [io  0xffbed000-0xffbfcfff]                   
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xbfffffff]                   
pci 0001:02:00.0: PCI bridge to [bus 03-03]                                     
pci 0001:02:00.0:   bridge window [io  0xffbdb000-0xffbeafff]                   
pci 0001:02:00.0:   bridge window [mem 0xc0000000-0xdfffffff]                   
pci 0002:04:00.0: BAR 9: can't assign mem pref (size 0x100000)                  
pci 0002:05:00.0: BAR 1: assigned [mem 0x80000000-0x8007ffff]                   
pci 0002:05:00.0: BAR 1: set to [mem 0x80000000-0x8007ffff] (PCI address [0xe000
0000-0xe007ffff])                                                               
pci 0002:05:00.0: BAR 6: assigned [mem 0x80080000-0x800bffff pref]              
pci 0002:05:00.0: BAR 0: assigned [mem 0x800c0000-0x800dffff]                   
pci 0002:05:00.0: BAR 0: set to [mem 0x800c0000-0x800dffff] (PCI address [0xe00c
0000-0xe00dffff])                                                               
pci 0002:05:00.0: BAR 3: assigned [mem 0x800e0000-0x800e3fff]                   
pci 0002:05:00.0: BAR 3: set to [mem 0x800e0000-0x800e3fff] (PCI address [0xe00e
0000-0xe00e3fff])                                                               
pci 0002:04:00.0: PCI bridge to [bus 05-05]                                     
pci 0002:04:00.0:   bridge window [io  0xffbc9000-0xffbd8fff]                   
pci 0002:04:00.0:   bridge window [mem 0x80000000-0x9fffffff]                   
pci 0000:00:00.0: enabling device (0106 -> 0107)                                
pci 0001:02:00.0: enabling device (0106 -> 0107)                                
pci 0002:04:00.0: enabling device (0106 -> 0107)                                
pci_bus 0000:00: resource 0 [io  0xffbed000-0xffbfcfff]                         
pci_bus 0000:00: resource 1 [mem 0xa0000000-0xbfffffff]                         
pci_bus 0000:01: resource 0 [io  0xffbed000-0xffbfcfff]                         
pci_bus 0000:01: resource 1 [mem 0xa0000000-0xbfffffff]                         
pci_bus 0001:02: resource 0 [io  0xffbdb000-0xffbeafff]                         
pci_bus 0001:02: resource 1 [mem 0xc0000000-0xdfffffff]                         
pci_bus 0001:03: resource 0 [io  0xffbdb000-0xffbeafff]                         
pci_bus 0001:03: resource 1 [mem 0xc0000000-0xdfffffff]                         
pci_bus 0002:04: resource 0 [io  0xffbc9000-0xffbd8fff]                         
pci_bus 0002:04: resource 1 [mem 0x80000000-0x9fffffff]                         
pci_bus 0002:05: resource 0 [io  0xffbc9000-0xffbd8fff]                         
pci_bus 0002:05: resource 1 [mem 0x80000000-0x9fffffff]        

-- 
Timur Tabi
Linux kernel developer at Freescale
