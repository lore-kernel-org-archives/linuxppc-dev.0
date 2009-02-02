Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 54AF4DDF25
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:37:42 +1100 (EST)
Message-ID: <49872152.1050902@harris.com>
Date: Mon, 02 Feb 2009 11:37:38 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Lixin Yao <Lixin.Yao@HSTX.com>
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28 kernel
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
	<49870A66.8030302@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
In-Reply-To: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Lixin Yao wrote:
> Hello, Steven,
> 
> I realized that and made change, I use reg-shift of 1 which u-boot uses
> and works for the CF.
> 
> localbus@f0010100 {
>       #address-cells = <2>;                   
>       #size-cells = <1>;
>       compatible = "fsl,mpc8248-localbus",    
>                    "fsl,pq2-localbus",
>                    "simple-bus"; 
>       reg = <0xf0010100 0x40>;                
>       ranges = <0x3 0x0 0x30000000 0x10000    
>                 0x4 0x0 0x40000000 0x10000>;  
> 
>       pata@3,0 {
>          compatible = "fsl,tr5000v2-pata", "ata-generic";
>          reg = <0x3 0x0 0x10 0x4 0xC 0x2>;   
>          reg-shift = <1>;                    
>          pio-mode = <6>;                     
>          // interrupts = <0x19 0x8>;         
>          // interrupt-parent = <&PIC>;       
>       };
> 
> 
> U-Boot (1.3.4) shows this:
> 
> bus 0: OK
>   Device 0: Model: SanDisk SDCFJ-128 Firm: HDX 2.27 Ser#:
> 116904C2505X4026
>             Type: Removable Hard Disk
>             Capacity: 122.5 MB = 0.1 GB (250880 x 512)
> 
> 
> This is the console output after setting reg = <0x3 0x0 0x10 0x4 0xC
> 0x2>:
> 
> ata_host_alloc: ENTER
> ata_port_alloc: ENTER
> __ata_port_freeze: ata4294967295 port frozen
> scsi0 : pata_platform
> ata1: PATA max PIO6 no IRQ, using PIO polling mmio cmd 0x30000000 ctl
> 0x4000000c

On my board, I get the following:

ata1: PATA max PIO6 mmio cmd 0x1c1000000 ctl 0x1c1000098 irq 32

Note that the addresses I provided got turned into 36-bit addresses
because I am using a PPC440EPx chip.

I am suspicious of the addresses you got, but I don't know enough
about how the mpc8248 sets up its memory map.  Perhaps someone with
knowledge of that chip can comment.

Have you hooked a logic analyzer to the device?  You should be sure
that the chip selects are really responding at the reported addresses.

Since the CF works with Uboot, at least we know the hardware is good.

	Steve


> ata_host_register: probe begin
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_link_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata1 port frozen
> ata_sff_softreset: ENTER
> ata_sff_softreset: about to softreset, devmask=0
> ata_bus_softreset: ata1: bus reset via SRST
> ata_sff_softreset: EXIT, classes[0]=9 [1]=9
> ata_eh_thaw_port: ata1 port thawed
> ata_std_postreset: ENTER
> ata_std_postreset: EXIT
> ata_sff_postreset: EXIT, no device
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=0
> ata_scsi_error: EXIT
> ata_host_register: host probe begin
> TCP cubic registered
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> ics1893_config_init() successful
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> ics1893_config_init() successful
> IP-Config: Complete:
>      device=eth0, addr=172.20.16.150, mask=255.255.255.0,
> gw=172.20.16.1,
>      host=tr5000v2, domain=, nis-domain=(none),
>      bootserver=10.15.34.196, rootserver=10.15.34.196, rootpath=
> Looking up port of RPC 100003/2 on 10.15.34.196
> ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> Looking up port of RPC 100005/1 on 10.15.34.196
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 164k init
> ### Application running ...
> 
>  
> The San Disk CF is still not found.
> 
> Any more insights/ideas?
> 
> Thank you and I appreciate your help!
> 
> Lixin
