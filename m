Message-ID: <791B3205DB661A42B4BFE5464A7D1D0204B36C6E@chzugexch01.abatos.com>
From: Graf Alex <alex.graf@siemens.com>
To: "'somshekar chandrashekar kadam'" <som_kadam1@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: AW: AW: AW: AW: compact flash
Date: Wed, 1 Oct 2003 13:32:10 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here are the definitions of the IDE ports.
With the 0x320 I am not sure, if these are good too for u!
This definitions presuppose, that you use 3 windows for the slot!

// Definitions for IDE0 Interface
#define IDE0_BASE_OFFSET		0
#define IDE0_DATA_REG_OFFSET		(PCMCIA_MEM_SIZE + 0x320)
#define IDE0_ERROR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 1)
#define IDE0_NSECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 2)
#define IDE0_SECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 3)
#define IDE0_LCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 4)
#define IDE0_HCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 5)
#define IDE0_SELECT_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 6)
#define IDE0_STATUS_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 7)
#define IDE0_CONTROL_REG_OFFSET		0x0106
#define IDE0_IRQ_REG_OFFSET		0x000A	// not used

cheers

Alex

-----Ursprüngliche Nachricht-----
Von: somshekar chandrashekar kadam [mailto:som_kadam1@rediffmail.com]
Gesendet: Mittwoch, 1. Oktober 2003 12:15
An: Graf Alex
Cc: linuxppc-embedded@lists.linuxppc.org
Betreff: Re: AW: AW: AW: compact flash



Hi Alex ,

    I got Compact flash work on PPCBOOT , Thanks a lot for ur
info

IN linux when I confiure linux I see detect the card but doent get
attached to any of the hda or other devices , I am totally lost
i have not attached pcmcia cs package to the kernel , do i need to
attch it ?

here are the messages of PPPCBOOT and LINUX bootup i have enabled
debug in Linux
can any say what is that I am doing wrong here , he gives message
up to
----------------------------------------------------------------

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
m8xx_ide_init_hwif_ports
PCMCIA slot A: phys mem 04000000...10000000 (size 0c000000)
PCMCIA virt base: c1000000
PCMCIA virt base: c1000000
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]


after this i dont whats goes wrong i lost here ,please  tell me
what i need to check

Thanks And Regards
Somshekar
-----------------------------------------------







-----------------------------------------------------------------

ppcboot messages

Tuple code 22  length 3
         Data: 02 0c 0f
Tuple code 1a  length 5
         Data: 01 03 00 02 0f
Tuple code 1b  length 8
         Data: c0 c0 a1 01 55 08 00 20
Tuple code 1b  length 6
         Data: 00 01 21 b5 1e 4d
Tuple code 1b  length 10
         Data: c1 41 99 01 55 64 f0 ff ff 20
Tuple code 1b  length 6
         Data: 01 01 21 b5 1e 4d
Tuple code 1b  length 15
         Data: c2 41 99 01 55 ea 61 f0 01 07 f6 03 01 ee 20
Tuple code 1b  length 6
         Data: 02 01 21 b5 1e 4d
Tuple code 1b  length 15
         Data: c3 41 99 01 55 ea 61 70 01 07 76 03 01 ee 20
Tuple code 1b  length 6
         Data: 03 01 21 b5 1e 4d
Tuple code 14  length 0
         Data:CF 128MB
             Fixed Disk Card
             IDE interface
             [silicon] [unique] [single] [sleep] [standby] [idle]
[low power]
Bus 0: OK
   Device 0: Model:  Firm: verB.65 Ser#: 035726530
             Type: Removable Hard Disk
             Capacity: 123.7 MB = 0.1 GB (253440 x 512)
============================================================

=> tftpboot 0x500000 pMulti

SCC ETHERNET configured
ARP broadcast 1
Got ARP REPLY

Server Ethernet Address : 00:50:ba:d7:23:f6
TFTP server Address     : 10.1.1.10
Our IP Address          : 10.1.1.2
Filename                : pMulti
Load address            : 0x500000

Loading:
#################################################################


#################################################################


#################################################################


#################################################################


#################################################################


#################################################################


#################################################################

          ##################################
done
Bytes transferred = 2498926 (26216e hex)

=> bootm 0x500000
## Booting image at 00500000 ...
    Image Name:   MyImage
    Image Type:   PowerPC Linux Multi-File Image (gzip
compressed)
    Data Size:    2498862 Bytes =  2.4 MB
    Load Address: 00000000
    Entry Point:  00000000
    Contents:
    Image 0:   527064 Bytes = 514.7 kB
    Image 1:  1971786 Bytes =  1.9 MB
    Verifying Checksum ... OK
    Uncompressing Multi-File Image ... OK
    Loading Ramdisk to 005bc000, end 0079d64a ... OK
    Transferring control to Linux (at address 00000000) ...
-------------------------------------------------------------------

Linux messages


m8xx_ide_init
Linux version 2.4.18 (root@localhost.localdomain) (gcc version
2.95.3 20010315 (release)) #528 Wed Oct 1 15:19:20 IST 2003
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
in time_init()
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 4768k available (944k kernel code, 352k data, 44k init, 0k
highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
Console port = 1
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
m8xx_ide_init_hwif_ports
PCMCIA slot A: phys mem 04000000...10000000 (size 0c000000)
PCMCIA virt base: c1000000
PCMCIA virt base: c1000000
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
m8xx_ide_init_hwif_ports
PIPR = 0x4700FF00  slot A ==> mask = 0x18000000
check_ide_device
PCMCIA MEM: C1000000
identify
Card ID: CF 128MB
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
base: c1000000 + 00000000 = c1000000
port[0]: c1000000 + 00000000 = 00000000
port[1]: c1000000 + 00000000 = 00000001
port[2]: c1000000 + 00000000 = 00000002
port[3]: c1000000 + 00000000 = 00000003
port[4]: c1000000 + 00000000 = 00000004
port[5]: c1000000 + 00000000 = 00000005
port[6]: c1000000 + 00000000 = 00000006
port[7]: c1000000 + 00000000 = 00000007
port[8]: c1000000 + 00000000 = 00000008
port[9]: c1000000 + 00000000 = 00000009
[125] m8xx_ide_default_irq 13
ideprobe_init
probe_hwif
hwif_check_regions
probe_for_driver
probing for hda: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hda: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdb: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdb: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hdc: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hdc: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdd: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdd: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hde: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hde: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdf: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdf: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hdg: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hdg: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdh: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdh: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hdi: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hdi: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdj: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdj: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hdk: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hdk: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdl: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdl: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hdm: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hdm: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdn: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdn: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
probe_hwif
hwif_check_regions
probe_for_driver
probing for hdo: present=0, media=32, probetype=ATA
1 a0  RETURNING 3
probing for hdo: present=0, media=32, probetype=ATAPI
1 a0  RETURNING 3
probe_for_driver
probing for hdp: present=0, media=32, probetype=ATA
1 b0  RETURNING 3
probing for hdp: present=0, media=32, probetype=ATAPI
1 b0  RETURNING 3
hwif_init
hwif_init
hwif_init
hwif_init
hwif_init
hwif_init
hwif_init
hwif_init
eth0: CPM ENET Version 0.2 on SCC1, d7:00:04:94:80:00
Linux Kernel Card Services 3.1.22
   options:  none
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 512 bind 512)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
good
ds: no socket drivers loaded!
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1925k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is
recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 44k init
init-2.00# in scc_enet_interrupt()
in scc_enet_interrupt()
in scc_enet_interrupt()
in scc_enet_interrupt()
in scc_enet_interrupt()
in scc_enet_interrupt()
in scc_enet_interrupt()
in scc_enet_interrupt()





















On Tue, 30 Sep 2003 Graf Alex wrote :
>The IO address depends on your memory map!
>Please have a look @ www.denx.de !
>@ denx u can download a kernel. The MPC860 is supported there.
>Read the
>manuals e.g the DULG document(they are very good!)
>
>cheers
>
>Alex
>
>-----Ursprüngliche Nachricht-----
>Von: somshekar chandrashekar kadam
>[mailto:som_kadam1@rediffmail.com]
>Gesendet: Dienstag, 30. September 2003 08:01
>An: Graf Alex
>Cc: linuxppc-embedded@lists.linuxppc.org
>Betreff: Re: AW: AW: compact flash
>
>
>
>Hi Alex ,
>
>     what do get this ATTRIBUTE address , IO address DMA
>ADDRESS
>with respect to CF , where do i get this info
>i know the MEM_ADDR in my memory map others i dont have any idea
>,
>where should i get it from
>
>Thanks In Advance
>SOm
>On Mon, 29 Sep 2003 Graf Alex wrote :
> >
> >do i need to first detect it on my PPCBOOT , or can I make it
> >DETECT directly from LINUX
> > >> it depends on what u want.
> >If u want only IDE support, no hotplug, u have to setup the
> >PCMCIA registers
> >in ppcboot. The driver/pcmcia/ide-m8xx.c reads out the PCMCIA
> >register and
> >remaps the io windows for IDE access. This is the simple way
>and
> >it works
> >with www.denx.de ELDK.
> >for hotplug, the register setup (for linux) is in
> >driver/pcmcia/m8xx_pcmcia.c. U can set up the PCMCIA
>registers
> >for ppcboot,
> >but it's not necesary. Then u need the pcmcia-cs package. This
>is
> >the tricky
> >way and, depends on ur kernel, is not supported on all kernel
> >versions!
> >
> >cheers
> >
> >Alex Graf
> >
> >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
