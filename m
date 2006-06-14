Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A47A767B9C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 18:51:50 +1000 (EST)
Message-ID: <448FCE21.5030005@cambridgebroadband.com>
Date: Wed, 14 Jun 2006 09:51:45 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: No ttyS device at I/O port 0xfe004500 for console
References: <001001c68f2f$42f6e730$0e67a8c0@Jocke>
In-Reply-To: <001001c68f2f$42f6e730$0e67a8c0@Jocke>
Content-Type: multipart/mixed; boundary="------------040908020507020709020803"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040908020507020709020803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Joakim Tjernlund wrote:
>  
> 
>> -----Original Message-----
>> From: 
>> linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se@ozlabs.
>> org 
>> [mailto:linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se
>> @ozlabs.org] On Behalf Of Alex Zeffertt
>> Sent: den 13 juni 2006 18:48
>> To: linuxppc-embedded@ozlabs.org
>> Subject: No ttyS device at I/O port 0xfe004500 for console
>>
>> Hi list,
>>
>> I'm trying to boot a linux-2.6.11 kernel on a MPC83xx based 
>> board.  Through some experimentation I have found I need 
>> "console=uart,io,0xfe004500"
>> in the kernel command line in order to get any output over 
>> the serial port.
> 
> Alex, can you post your complete u-boot env(printenv). I am trying to do
> the same as you but I havn't gotten any output yet. I managed to wipe my
> u-boot & u-boot env and the docs arent that great :(
> 
>  Jocke
> 

No problem.

I just had to try absolutely *every* possible option for the console parameter.
Eventually this worked (for the early serial output only, not for /dev/console
output.)

See attached for my u-boot environment

Alex



--------------040908020507020709020803
Content-Type: text/plain;
 name="u-boot.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="u-boot.log"

U-Boot 1.1.3 (FSL Development) (Jun 13 2006 - 14:01:25) MPC83XX
 
Clock configuration:
  Coherent System Bus:  132 MHz
  Core:                 264 MHz
  QE:                   198 MHz
  Local Bus Controller: 132 MHz
  Local Bus:             66 MHz
  DDR:                  264 MHz
  SEC:                  132 MHz
  I2C1:                 132 MHz
CPU: MPC8323E, Rev: 10 at 264 MHz
Board: Freescale MPC832XEPB
I2C:   ready
DRAM:
   DDR RAM: 128 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   FSL GETH0
Hit any key to stop autoboot:  0
=> printenv
ramboot=setenv bootargs root=/dev/ram rw console=$consoledev,$baudrate $othbootargs;tftp $ramdiskaddr $ramdiskfile;tftp $loadaddr $bootfile;bootm $loadaddr $ramdiskaddr
bootdelay=6
loads_echo=1
loadaddr=200000
netdev=eth0
ramdiskaddr=400000
ramdiskfile=ramfs.83xx
ethact=FSL GETH0
ethaddr=00:04:9f:00:00:00
ipaddr=10.0.6.65
netmask=255.255.0.0
serverip=10.0.0.107
gatewayip=10.0.0.1
rootpath=/opt/eldk/ppc_6xx
bootfile=uImage
baudrate=9600
consoledev=uart,io,0xfe004500
bootargs=root=/dev/nfs rw nfsroot=10.0.0.107:/opt/eldk/ppc_6xx ip=10.0.6.65:10.0.0.107:10.0.0.1:255.255.0.0:eth0:off console=uart,io,0xfe004500
nfsboot=setenv bootargs root=/dev/nfs rw nfsroot=$serverip:$rootpath ip=$ipaddr:$serverip:$gatewayip:$netmask:$netdev:off console=$consoledev $othbootargs;tftp $loadaddr $bootfile;bootm $loadaddr
bootcmd=run nfsboot
stdin=serial
stdout=serial
stderr=serial
 
Environment size: 871/8188 bytes
=>


--------------040908020507020709020803--
