Return-Path: <orutsch@sympatec.com>
Message-ID: <48C68763.6030606@sympatec.com>
Date: Tue, 09 Sep 2008 16:25:39 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: TQM8349 and ARCH = powerpc
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

currently I'm evaluating a TQM8349 (MPC8349E-based) module on a STK85xx. 
I wonder if anybody has already managed to get this module running under 
ARCH=powerpc.
As I did not found anything on the net I tried the following:

U-Boot (1.3.4):
Appended the file include/configs/TQM834x.h to support fdt:

#define CONFIG_OF_LIBFDT	1
#define CONFIG_OF_BOARD_SETUP	1
#define CONFIG_OF_STDOUT_VIA_ALIAS	1

Appended the file board/tqc/tqm834x/tqm834x.c:
#if defined(CONFIG_OF_BOARD_SETUP)
void ft_board_setup(void *blob, bd_t *bd)
{
	ft_cpu_setup(blob, bd);
#ifdef CONFIG_PCI
	ft_pci_setup(blob, bd);
#endif
}

U-Boot compiled fine and it looks good after flashing. In U-Boot 
everything seems to work.

Kernel (Linux-2.6.27-rc5):
I took arch/powerpc/boot/dts/mpc8349emitx.dts as a template
for a tqm8349.dts and stripped the IDE interface from it.
So for me the dts does not look board specific anymore and
the network/console should work.
I compiled a dtb with:
dtc -b 0 -S 0x3000 -R 4 -I dts -O dtb -f 
arch/powerpc/boot/dts/tqm8349.dts > tqm8349.dtb
Then I build the kernel with
make mpc83xx_defconfig
make menuconfig (I made some minor modifications)
make uImage
Unfortunately the kernel stops booting after decompressing.
I tried a lot of things, but without any success.
So any help to get this running is greatly appreciated.
Below there is the printout of my U-Boot session.

Thanks in advance and bye.


=> run nfsargs addip addtty
=> print bootargs
bootargs=root=/dev/nfs rw 
nfsroot=172.20.3.118:/home/rutsch/eldk4/ppc_6xx 
ip=172.20.3.250:172.20.3.118:192.168.1.1:255.255.192.0:tqm83xx:eth0:off 
panic=1 console=ttyS0,115200
=> print net_nfs
net_nfs=tftp 200000 ${bootfile};tftp 400000 ${dtbfile};run nfsargs addip 
addtty;bootm 200000 - 400000


=> run net_nfs
Speed: 1000, full duplex
Using TSEC0 device
TFTP from server 172.20.3.118; our IP address is 172.20.3.250
Filename 'uImage_tqm8349'.
Load address: 0x200000
Loading: #################################################################
############################################################
done
Bytes transferred = 1822793 (1bd049 hex)
Speed: 1000, full duplex
Using TSEC0 device
TFTP from server 172.20.3.118; our IP address is 172.20.3.250
Filename 'tqm8349.dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting kernel from Legacy Image at 00200000 ...
    Image Name:   Linux-2.6.27-rc5-01142-gc66bf97
    Created:      2008-09-09  13:42:42 UTC
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1822729 Bytes =  1.7 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 00400000
    Booting using the fdt blob at 0x400000
    Uncompressing Kernel Image ... OK




-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com
