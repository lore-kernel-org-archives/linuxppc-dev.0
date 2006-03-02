Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 591B667A01
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 05:55:15 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 972631D776
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 19:55:09 +0100 (CET)
Date: Thu, 2 Mar 2006 19:55:09 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: incorrect rmo_top handling in prom_init
Message-ID: <20060302185509.GA14235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My iBook1 has 2 memory regions in reg. Depending on how I boot it
(vmlinux+initrd) or zImage.initrd, it will not boot with current Linus
tree.
rmo_top should be 160MB instead of 32MB.


0 > dev /memory .properties
name                    memory
device_type             memory
reg                     00000000  02000000
                        02000000  08000000
slot-names              00000003
                        DIMM0/BUILT-IN
                        DIMM1/J12
available               00003000 09bfd000
dimm-info               8000040c 08040000 00000000 00000000 0000bc00 00000000 000000be 00bdbf00
                        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
                        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
                        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
                        8008040c 0a014000 01a08000 80080001 8f040601 01000fa0 60000014 14143220
                        20102010 00000000 00000000 00000000 00000000 00000000 00000000 00001237
                        7fd50000 00000000 01373634 56313641 33445434 44444700 00000001 00519900
                        00000001 01020105 09030701 02020000 00000000 00000000 00000000 000064c7
dimm-types              SDRAM
                        SDRAM
dimm-speeds
                        PC100-222S

 ok
0 > boot enet:1.1.1.3,yaboot
CLIENT: 000a27aa0f20 1.1.1.1
SERVER: 0003938574cc 1.1.1.3
Transfer FILE: yaboot \
TFTP-actual=406ff TFTP-adler32=e64fd05f load-size=406ff adler32=e64fd05f

Loading ELF

yaboot starting: loaded at 0x00200000-0x00235ed8 (0x0/0x200000/0xff80a290;sp: 0x0023eb14)
CLIENT: 000a27aa0f20 1.1.1.1
SERVER: 0003938574cc 1.1.1.3
Transfer FILE: yaboot.conf
TFTP-actual=333 TFTP-adler32=1af6149c Config file 'yaboot.conf' read, 819 bytes

 fooo xxx yaboot.conf
Welcome to yaboot version 1.3.13.SuSE
booted from '/pci@f4000000/ethernet:1.1.1.3,yaboot'
Enter "help" to get some basic usage information
boot: i
Please wait, loading kernel...

CLIENT: 000a27aa0f20 1.1.1.1
SERVER: 0003938574cc 1.1.1.3
Transfer FILE: inst32
TFTP-actual=798ffb TFTP-adler32=aaf3b8f5 Allocated 0x00900000 bytes for executable @ 0x00400000
   Elf32 kernel loaded...


SuSE Linux zImage starting: loaded at 0x00400000-0x00b93cbc (0x1000000/0x0/0xff80a290; sp: 0x0023e9a4)
uncompressing ELF header done. (0x00000100 bytes)
Allocated 0x0078dfb0 bytes for kernel @ 0x02000000
Allocated 0x005aacd6 bytes for initrd @ 0x0278e000
uncompressing kernel done. (0x00431788 bytes)
entering kernel at 0x02010000(278e000/5aacd6/ff80a290)
OF stdout device is: /packages/telnet
initrd_start=0x0278e000
initrd_end=0x02d38cd6
command line:
root_addr_cells: 00000001
root_size_cells: 00000001
scanning memory:
  node /memory@0 :
    00000000 02000000
    02000000 08000000
memory layout at init:
  memory_limit : 00000000 (16 MB aligned)
  alloc_bottom : 02d39000
  alloc_top    : 02000000
  alloc_top_hi : 0a000000
  rmo_top      : 02000000
  ram_top      : 0a000000
Booting CPU hw index = 0x00000000
copying OF device tree ...
foo
starting device tree allocs at 02d39000
alloc_up(00100000, 00001000)
Can't allocate initial device-tree chunk

DEFAULT CATCH!, code=900 at   %SRR0: 024017a4   %SRR1: 00083030
 ok 
0 > 
