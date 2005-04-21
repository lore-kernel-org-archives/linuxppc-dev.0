Return-Path: <kishorekrd@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id 901FF67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 08:53:20 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 13so798085nzn
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 15:53:18 -0700 (PDT)
Message-ID: <2cf2641f0504211553384bd3c@mail.gmail.com>
Date: Thu, 21 Apr 2005 15:53:18 -0700
From: Kishore Devireddy <kishorekrd@gmail.com>
To: Atit_Shah <Atit_Shah@satyam.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED1027752@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D8595042F3765A4285B848A78A2C2ED1027752@bsdmsg002.corp.satyam.ad>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 custom board, Linux 2.4 kernel hangs after uncompressing
Reply-To: Kishore Devireddy <kishorekrd@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

As you mentioned I checked my System.map file and found

c0199614  b  log_buf

and checked the location 0x00199614 using BDI2000

BDI>md 0x000199600
00199600 : 00000000 00000000 00000000 00000000  ................
00199610 : 00000000 3c363e4d 656d6f72 79204241  ....<6>Memory BA
00199620 : 54206d61 7070696e 673a2042 4154323d  T mapping: BAT2=3D
00199630 : 31364d62 2c204241 54333d30 4d622c20  16Mb, BAT3=3D0Mb,
00199640 : 72657369 6475616c 3a20304d 620a3c34  residual: 0Mb.<4
00199650 : 3e4c696e 75782076 65727369 6f6e2032  >Linux version 2
00199660 : 2e342e32 35202872 6f6f7440 4d616e64  .4.25 (root@Mand
00199670 : 72616b65 29202867 63632076 65727369  rake) (gcc versi
00199680 : 6f6e2033 2e332e33 20284445 4e582045  on 3.3.3 (DENX E
00199690 : 4c444b20 332e3120 332e332e 332d3829  LDK 3.1 3.3.3-8)
001996a0 : 29202337 20576564 20417072 20323020  ) #7 Wed Apr 20
001996b0 : 30313a33 393a3437 20504454 20323030  01:39:47 PDT 200
001996c0 : 350a3c36 3e4d6f74 6f726f6c 61205350  5.<6>Motorola SP
001996d0 : 53205361 6e64706f 696e7420 54657374  S Sandpoint Test
001996e0 : 20506c61 74666f72 6d0a3c36 3e506f72   Platform.<6>Por
001996f0 : 74206279 204d6f6e 74615669 73746120  t by MontaVista
BDI>md
00199700 : 536f6674 77617265 2c20496e 632e2028  Software, Inc. (
00199710 : 736f7572 6365406d 76697374 612e636f  source@mvista.co
00199720 : 6d290a3c 343e4f6e 206e6f64 65203020  m).<4>On node 0
00199730 : 746f7461 6c706167 65733a20 34303936  totalpages: 4096
00199740 : 0a3c343e 7a6f6e65 2830293a 20343039  .<4>zone(0): 409
00199750 : 36207061 6765732e 0a000000 00000000  6 pages.........
00199760 : 00000000 00000000 00000000 00000000  ................
00199770 : 00000000 00000000 00000000 00000000  ................
00199780 : 00000000 00000000 00000000 00000000  ................
00199790 : 00000000 00000000 00000000 00000000  ................
001997a0 : 70656e50 49432056 65727369 6f6e2031  penPIC Version 1
001997b0 : 2e322028 31204350 55732061 6e642031  .2 (1 CPUs and 1
001997c0 : 31204952 5120736f 75726365 73292061  1 IRQ sources) a
001997d0 : 74206664 66643030 30300a00 00000000  t fdfd0000......
001997e0 : 00000000 00000000 00000000 00000000  ................
001997f0 : 00000000 00000000 00000000 00000000  ................

But it does not say much here. Any help on this???????????

I also enabled CONFIG_SERIAL_TEXT_DEBUG, but I did not see any text
after uncompressing the linux.

As mentioned in your 3rd point "some flag in the U-Boot code for RAM
in burst mode.". What is that flag actually? Coulnd you let me know?

Thanks
Kishore


On 4/20/05, Atit_Shah <Atit_Shah@satyam.com> wrote:
>=20
> Hi Kishore,
>=20
>        There are various things you can try.
>=20
> 1. Check your log buffer...your console may not be initialized yet so
> all your printk are logged at a particular memory location. Checkout the
> System.map file in the Linux folder for "log_buf". The address that you
> have there subtract it with the kernel base address. Then in view your
> memory at that location. We used U-Boot so we gave the command
>=20
>        md <log_buff address>
>=20
> 2. We used a tool called Code Warrior which helped us single step debug
> the code, it didn't help us much though.
>=20
> 3. We had a problem with the RAM in burst mode. WolfGang would suggest
> you check out if your RAM is operational. In our case we had to set some
> flag in the U-Boot code for RAM in burst mode. We changed this flag and
> it boots fine. Well almost.
>=20
> Atit
>=20
>=20
> Message: 5
> Date: Wed, 20 Apr 2005 18:00:46 -0700
> From: Kishore Devireddy <kishorekrd@gmail.com>
> Subject: MPC8245 custom board, Linux 2.4 kernel hangs after
>        uncompressing
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <2cf2641f0504201800556805d2@mail.gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
>=20
> Hi
>=20
> I am trying to run Embedded linux (ELDK) (2.4 kerenl) on a custom
> powerpc board,
> which is similar to Artis A3000 board. This board has
> mpc8245(XPC8245LZY266B), natsemi 83815 ethernet, 4MB intel e28f320
> flash, 16MB winbond w986432DH-6 SDRAM. So I configured and compiled
> U-boot for A3000 borad. U-boot worked on my board also. Next I
> compiled ELDK 3.0 for Sandpoint 8245 board and copied to flash. But
> linux hangs after uncompressing
>=20
> U-Boot 1.1.2 (Apr 14 2005 - 00:02:29)
>=20
> CPU:   MPC8245 Revision 1.2 at 249.999 MHz: 16 kB I-Cache 16 kB D-Cache
> Board: A3000 Local Bus at 99.999 MHz
> I2C:   ready
> DRAM:  16 MB
> FLASH: Get flash bank 0 @ 0xffc00000
> Manuf. ID @ 0xff800000: 0x00000089
> Device ID @ 0xff800001: 0x00000016
> ## Flash bank 0 at 0xffc00000 sizes: 0x00400000
> protect monitor fff00000 @ 40000
> protect environtment fffc0000 @ 20000
> ## Final Flash bank sizes: 00400000
> 4 MB
>      00  13  100b  0020  0200  ff
> In:    serial
> Out:   serial
> Err:   serial
> Net:   natsemi: EEPROM contents:
> ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff ffff
> dp83815#0
> Warning: dp83815#0 MAC addresses don't match:
> Address in SROM is         FF:FF:FF:FF:FF:FF
> Address in environment is  00:40:05:B0:F1:BA
>=20
> A3000> tftpboot 400000 uImage.eldk
> Using dp83815#0 device
> TFTP from server 192.168.1.124; our IP address is 192.168.1.54
> Filename 'uImage.eldk'.
> Load address: 0x400000
> Loading:
> #################################################################
>       #################################################################
>       ###################
> done
> Bytes transferred =3D 757926 (b90a6 hex)
> A3000> bootm
> ## Booting image at 00400000 ...
> Image Name:   Linux-2.4.25
> Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> Data Size:    757862 Bytes =3D 740.1 kB
> Load Address: 00000000
> Entry Point:  00000000
> Verifying Checksum ... OK
> Uncompressing Kernel Image ... OK
>=20
> nothing happens after this until I reboot the board. I read u-boot FAQ
> and configured bd_info structure same for both u-boot and Linux. I
> found that CFG_IMMR is not applicable to MPC8245. I also used
> clocks_in_mhz variable also before loading Linux. I am stuck here.
> Could you please let me know what should I do next?
>=20
> Thanks
> Kishore
>=20
> ------------------------------
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
> End of Linuxppc-embedded Digest, Vol 8, Issue 56
> ************************************************
>=20
> DISCLAIMER:
> This email (including any attachments) is intended for the sole use of th=
e intended recipient/s and may contain material that is CONFIDENTIAL AND PR=
IVATE COMPANY INFORMATION. Any review or reliance by others or copying or d=
istribution or forwarding of any or all of the contents in this message is =
STRICTLY PROHIBITED. If you are not the intended recipient, please contact =
the sender by email and delete all copies; your cooperation in this regard =
is appreciated.
>
