Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63FBDDDDA2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 03:15:21 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id D782B8C05E
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 17:06:18 +0100 (CET)
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: ucc_geth broken w.r.t fixed_link PHY
Message-ID: <OF118046F1.CE4E43CC-ONC125757F.0057EA5C-C125757F.005877E9@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 20 Mar 2009 17:06:19 +0100
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trying to upgrade to latest linus latest just to see if it still works I 
get this:

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0151270
Oops: Kernel access of bad area, sig: 11 [#1]
TMCUTU
NIP: c0151270 LR: c0151270 CTR: c0017760
REGS: cf81fa60 TRAP: 0300   Not tainted  (2.6.29-rc8)
MSR: 00009032 <EE,ME,IR,DR>  CR: 24024042  XER: 20000000
DAR: 00000000, DSISR: 20000000
TASK = cf81cba0[1] 'swapper' THREAD: cf81e000
GPR00: c0151270 cf81fb10 cf81cba0 00000000 c0272e20 c025f354 00001e80 
cf86b08c 
GPR08: d1068200 cffffb74 06000000 d106c200 42024042 10085148 0fffd000 
0ffc81a0 
GPR16: 00000001 00000001 00000000 007ffeb0 00000000 0000c000 cf83f36c 
cf83f000 
GPR24: 00000030 cf83f360 cf81fb20 00000000 d106c200 20000000 00001e80 
cf83f360 
NIP [c0151270] ucc_geth_open+0x330/0x1efc
LR [c0151270] ucc_geth_open+0x330/0x1efc
Call Trace:
[cf81fb10] [c0151270] ucc_geth_open+0x330/0x1efc (unreliable)
[cf81fba0] [c0187638] dev_open+0xbc/0x12c
[cf81fbc0] [c0187e38] dev_change_flags+0x8c/0x1b0
[cf81fbe0] [c02a5e94] tm_icn_address+0x5f0/0x1038
[cf81fd70] [c00038b0] do_one_initcall+0x34/0x1dc
[cf81ffd0] [c02887dc] kernel_init+0x90/0x10c
[cf81fff0] [c00106a4] kernel_thread+0x4c/0x68
Instruction dump:
7c0004ac 914b0144 3800ffff 807f02b4 3c80c027 901f02ac 38842e20 38a00000 
937f02a8 3b410010 937f02b0 48022ef9 <80630000> 4bebc8c9 7c7d1b78 48023155 
---[ end trace 5e5a8c89939b0ba3 ]---
gdb vmlinux shows:
(gdb) list *0xc0151270
0xc0151270 is in ucc_geth_open (drivers/net/ucc_geth.c:1552).
1547            priv->oldlink = 0;
1548            priv->oldspeed = 0;
1549            priv->oldduplex = -1;
1550 
1551            ph = of_get_property(np, "phy-handle", NULL);
1552            phy = of_find_node_by_phandle(*ph);
1553            mdio = of_get_parent(phy);
1554 
1555            id = of_get_property(phy, "reg", NULL);
1556 

Tunrsn out that my fixed_link PHY doesn't work anymore. I don't have a 
phy-handle in
in my of tree. Instead I got fixed-link:
               enet2: ucc@3200 { //UCC4
                        device_type = "network";
                        compatible = "ucc_geth";
                        model = "UCC";
                        device-id = <4>;
                        cell-index = <4>;
                        reg = <3200 200>;
                        interrupts = <23>;
                        interrupt-parent = <&qeic>;
                        mac-address = [ 00 11 22 33 44 99 ];
                        rx-clock = <17>; //CLK7, 23
                        tx-clock = <18>; //CLK8, 24
                        fixed-link = <19 1 1 100 0 0>;
                        phy-connection-type = "mii";
                        pio-handle = <&pio4>;
                };

So what is broken, ucc_geth or my OF tree?

      Jocke
