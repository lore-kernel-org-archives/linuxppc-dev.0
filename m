Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 9EC1D67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 15:56:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 21 Apr 2005 11:22:15 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED1027752@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <kishorekrd@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linuxppc-embedded Digest, Vol 8, Issue 56
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Kishore,

	There are various things you can try.

1. Check your log buffer...your console may not be initialized yet so
all your printk are logged at a particular memory location. Checkout the
System.map file in the Linux folder for "log_buf". The address that you
have there subtract it with the kernel base address. Then in view your
memory at that location. We used U-Boot so we gave the command
=09
	md <log_buff address>

2. We used a tool called Code Warrior which helped us single step debug
the code, it didn't help us much though.

3. We had a problem with the RAM in burst mode. WolfGang would suggest
you check out if your RAM is operational. In our case we had to set some
flag in the U-Boot code for RAM in burst mode. We changed this flag and
it boots fine. Well almost.

Atit


Message: 5
Date: Wed, 20 Apr 2005 18:00:46 -0700
From: Kishore Devireddy <kishorekrd@gmail.com>
Subject: MPC8245 custom board, Linux 2.4 kernel hangs after
	uncompressing
To: linuxppc-embedded@ozlabs.org
Message-ID: <2cf2641f0504201800556805d2@mail.gmail.com>
Content-Type: text/plain; charset=3DISO-8859-1

Hi

I am trying to run Embedded linux (ELDK) (2.4 kerenl) on a custom
powerpc board,
which is similar to Artis A3000 board. This board has
mpc8245(XPC8245LZY266B), natsemi 83815 ethernet, 4MB intel e28f320
flash, 16MB winbond w986432DH-6 SDRAM. So I configured and compiled
U-boot for A3000 borad. U-boot worked on my board also. Next I
compiled ELDK 3.0 for Sandpoint 8245 board and copied to flash. But
linux hangs after uncompressing

U-Boot 1.1.2 (Apr 14 2005 - 00:02:29)

CPU:   MPC8245 Revision 1.2 at 249.999 MHz: 16 kB I-Cache 16 kB D-Cache
Board: A3000 Local Bus at 99.999 MHz
I2C:   ready
DRAM:  16 MB
FLASH: Get flash bank 0 @ 0xffc00000
Manuf. ID @ 0xff800000: 0x00000089
Device ID @ 0xff800001: 0x00000016
## Flash bank 0 at 0xffc00000 sizes: 0x00400000
protect monitor fff00000 @ 40000
protect environtment fffc0000 @ 20000
## Final Flash bank sizes: 00400000
4 MB
      00  13  100b  0020  0200  ff
In:    serial
Out:   serial
Err:   serial
Net:   natsemi: EEPROM contents:
ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff
dp83815#0
Warning: dp83815#0 MAC addresses don't match:
Address in SROM is         FF:FF:FF:FF:FF:FF
Address in environment is  00:40:05:B0:F1:BA

A3000> tftpboot 400000 uImage.eldk
Using dp83815#0 device
TFTP from server 192.168.1.124; our IP address is 192.168.1.54
Filename 'uImage.eldk'.
Load address: 0x400000
Loading:
#################################################################
       #################################################################
       ###################
done
Bytes transferred =3D 757926 (b90a6 hex)
A3000> bootm
## Booting image at 00400000 ...
 Image Name:   Linux-2.4.25
 Image Type:   PowerPC Linux Kernel Image (gzip compressed)
 Data Size:    757862 Bytes =3D 740.1 kB
 Load Address: 00000000
 Entry Point:  00000000
 Verifying Checksum ... OK
 Uncompressing Kernel Image ... OK

nothing happens after this until I reboot the board. I read u-boot FAQ
and configured bd_info structure same for both u-boot and Linux. I
found that CFG_IMMR is not applicable to MPC8245. I also used
clocks_in_mhz variable also before loading Linux. I am stuck here.
Could you please let me know what should I do next?

Thanks
Kishore


------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 8, Issue 56
************************************************


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
