Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 5BDE3DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 21:34:37 +1100 (EST)
Message-ID: <47DF9ABB.2020607@matrix-vision.de>
Date: Tue, 18 Mar 2008 11:34:35 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: simple MPC5200B system
References: <47DD71D0.2010203@matrix-vision.de>	<fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com>
	<47DF821B.6090600@matrix-vision.de>
In-Reply-To: <47DF821B.6090600@matrix-vision.de>
Content-Type: multipart/alternative;
	boundary="------------010304040707030205030005"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010304040707030205030005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Grant,

sorry for having troubled you. Looks like the build system has been in=20
an invalid state...

After doing a git-pull and "make distclean" + "make mpc5200_defconfig"=20
the system is finally up and running.




Using mpc5200-simple-platform machine description
Linux version 2.6.25-rc6-00978-g275c005-dirty (root@nova) (gcc version=20
4.0.0 (DENX ELDK 4.1 4.0.0)) #9 Tue Mar 18 11:25:07 CET 2008
Found initrd at 0xc397a000:0xc3c00000
arch/powerpc/platforms/52xx/mpc52xx_common.c: Error mapping XLB in=20
mpc52xx_setup_cpu().  Expect some abnormal behavior
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1625=
6
Kernel command line: root=3D/dev/ram ro rootfstype=3Dsquashfs=20
ip=3D192.168.65.57::192.168.65.15:255.255.255.0 console=3DttyPSC0,115200N=
8=20
e1000.TxDescriptors=3D1500 e1000.SmartPowerDownEnable=3D1
MPC52xx PIC is up and running!
PID hash table entries: 256 (order: 8, 1024 bytes)
clocksource: timebase mult[79364d9] shift[22] registered
console [ttyPSC0] enabled
....



regards,
Andre


Andre Schwarz schrieb:
> Grant,
>
> I've pulled the latest git and built a mpc5200_simple system with a=20
> minimal dts.
> There's not a single char put on the console ....
>
>
>
> Grant Likely schrieb:
>> On Sun, Mar 16, 2008 at 1:15 PM, Andr=E9 Schwarz
>> <Andre.Schwarz@matrix-vision.de> wrote:
>>  =20
>>> All,
>>>
>>>  I'm quite stuck in getting our MPC5200B based systems work on 2.6.24=
+
>>>  ... maybe someone could give me some hints.
>>>  Up to now the systems have been running on 2.6.19 without any proble=
ms.
>>>
>>>  This is what I've done so far :
>>>
>>>  - get a recent system with 2.6.19 running and keep the toolchain (gc=
c
>>>  4.0) including RFS uImage.
>>>  - latest bootloader (u-boot 1.3.2) is running fine with dtb support.
>>>  - Kernel and RFS images are available via bootp/tftp
>>>  - device tree blob seems ok, i.e. u-boot can display the blob and fi=
ll
>>>  in all clocks correctly.
>>>  - Kernel gets called with Kernel, RFS and dtb on suitable adresses
>>>  (0x100000, 0x600000, 0x5F0000).
>>>  - nothing more happens. It looks like the console isn't working prop=
erly
>>>  - maybe worse ...
>>>    =20
>>
>> Can you either halt the processor or reset the board and access memory
>> after this point?  You should see if you can access __log_buf (Look in
>> System.map for the address and subtract 0xc0000000 to get the physical
>> address).   __log_buf should give you clues about how far booting
>> progresses.
>>
>>  =20
> (c033d4b4 b __log_buf) yields all zeroes - nothing logged at all.
>
> Examining the CPU state with the bdi shows :
>
>     Target CPU        : MPC8280/8220/5200 (Zeppo)
>     Target state      : debug mode
>     Debug entry cause : COP halt
>     Current PC        : 0xc000552c
>     Current CR        : 0x48000042
>     Current MSR       : 0x00009032
>     Current LR        : 0xc00166c0
>
> The program counter shows the adress of "irq_set_virq_count" which has=20
> a BUG() macro. Looks like this one evaluates to true.
>
> What do you think ?
>
>>>  The kernel has been build using the "MPC5200 simple" setup. I've add=
ed
>>>  our board identifier "mv,mvbluecougar" to the list of supported boar=
ds
>>>  in the "mpc52xx_simple.c" file. This identifier is used in the dtb a=
s
>>>  well of course. This should be enough along with a valid device tree
>>>  blob, isn't it ? Did I miss anything already ?
>>>    =20
>>
>> Yes, this should be enough (on a side note; it should probably be
>> "matrix-vision,bluecougar" unless of''mv' is your company's stock
>> ticker symbol).
>>
>>  =20
>>>  As far as I did understand by reading the docs it should be possible
>>>  running a general MPC52xx kernel with a custom dtb ? Is this correct=
 ?
>>>    =20
>>
>> That is correct.
>>
>>  =20
>>>  The dts file has already been reduced to a minimum, i.e. only the cp=
u,
>>>  pic, xlb and a few nodes like psc1 and psc2 are present. No bestcomm=
,
>>>  pci, ata or "advanced" features like mtd partitions. All I want to g=
et
>>>  working is the serial console on "/dev/ttyPSC0".
>>>    =20
>>
>> Cheers,
>> g.
>>
>>  =20
>
> regards,
> Andre
>
> MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler -=20
> Registergericht: Amtsgericht Stuttgart, HRB 271090 Gesch=E4ftsf=FChrer:=
=20
> Gerhard Thullner, Werner Armingeon, Uwe Furtner
> -----------------------------------------------------------------------=
-
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev



MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------010304040707030205030005
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Grant,<br>
<br>
sorry for having troubled you. Looks like the build system has been in
an invalid state...<br>
<br>
After doing a git-pull and "make distclean" + "make mpc5200_defconfig"
the system is finally up and running.<br>
<br>
<br>
<br>
<br>
Using mpc5200-simple-platform machine description<br>
Linux version 2.6.25-rc6-00978-g275c005-dirty (root@nova) (gcc version
4.0.0 (DENX ELDK 4.1 4.0.0)) #9 Tue Mar 18 11:25:07 CET 2008<br>
Found initrd at 0xc397a000:0xc3c00000<br>
arch/powerpc/platforms/52xx/mpc52xx_common.c: Error mapping XLB in
mpc52xx_setup_cpu().&nbsp; Expect some abnormal behavior<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16384 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 16384<br>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages:
16256<br>
Kernel command line: root=/dev/ram ro rootfstype=squashfs
ip=192.168.65.57::192.168.65.15:255.255.255.0 console=ttyPSC0,115200N8
e1000.TxDescriptors=1500 e1000.SmartPowerDownEnable=1<br>
MPC52xx PIC is up and running!<br>
PID hash table entries: 256 (order: 8, 1024 bytes)<br>
clocksource: timebase mult[79364d9] shift[22] registered<br>
console [ttyPSC0] enabled<br>
....<br>
<br>
<br>
<br>
regards,<br>
Andre<br>
<br>
<br>
Andre Schwarz schrieb:
<blockquote cite="mid:47DF821B.6090600@matrix-vision.de" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
Grant,<br>
  <br>
I've pulled the latest git and built a mpc5200_simple system with a
minimal dts.<br>
There's not a single char put on the console ....<br>
  <br>
  <br>
  <br>
Grant Likely schrieb:
  <blockquote
 cite="mid:fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com"
 type="cite">
    <pre wrap="">On Sun, Mar 16, 2008 at 1:15 PM, Andr&eacute; Schwarz
<a moz-do-not-send="true" class="moz-txt-link-rfc2396E"
 href="mailto:Andre.Schwarz@matrix-vision.de">&lt;Andre.Schwarz@matrix-vision.de&gt;</a> wrote:
  </pre>
    <blockquote type="cite">
      <pre wrap="">All,

 I'm quite stuck in getting our MPC5200B based systems work on 2.6.24+
 ... maybe someone could give me some hints.
 Up to now the systems have been running on 2.6.19 without any problems.

 This is what I've done so far :

 - get a recent system with 2.6.19 running and keep the toolchain (gcc
 4.0) including RFS uImage.
 - latest bootloader (u-boot 1.3.2) is running fine with dtb support.
 - Kernel and RFS images are available via bootp/tftp
 - device tree blob seems ok, i.e. u-boot can display the blob and fill
 in all clocks correctly.
 - Kernel gets called with Kernel, RFS and dtb on suitable adresses
 (0x100000, 0x600000, 0x5F0000).
 - nothing more happens. It looks like the console isn't working properly
 - maybe worse ...
    </pre>
    </blockquote>
    <pre wrap=""><!---->
Can you either halt the processor or reset the board and access memory
after this point?  You should see if you can access __log_buf (Look in
System.map for the address and subtract 0xc0000000 to get the physical
address).   __log_buf should give you clues about how far booting
progresses.

  </pre>
  </blockquote>
(c033d4b4 b __log_buf) yields all zeroes - nothing logged at all.<br>
  <br>
Examining the CPU state with the bdi shows :<br>
  <br>
&nbsp;&nbsp;&nbsp; Target CPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MPC8280/8220/5200 (Zeppo)<br>
&nbsp;&nbsp;&nbsp; Target state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : debug mode<br>
&nbsp;&nbsp;&nbsp; Debug entry cause : COP halt<br>
&nbsp;&nbsp;&nbsp; Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc000552c<br>
&nbsp;&nbsp;&nbsp; Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x48000042<br>
&nbsp;&nbsp;&nbsp; Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x00009032<br>
&nbsp;&nbsp;&nbsp; Current LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xc00166c0<br>
  <br>
The program counter shows the adress of "irq_set_virq_count" which has
a BUG() macro. Looks like this one evaluates to true.<br>
  <br>
What do you think ?<br>
  <br>
  <blockquote
 cite="mid:fa686aa40803161301r1685f2cale75d67b8a203cca3@mail.gmail.com"
 type="cite">
    <blockquote type="cite">
      <pre wrap=""> The kernel has been build using the "MPC5200 simple" setup. I've added
 our board identifier "mv,mvbluecougar" to the list of supported boards
 in the "mpc52xx_simple.c" file. This identifier is used in the dtb as
 well of course. This should be enough along with a valid device tree
 blob, isn't it ? Did I miss anything already ?
    </pre>
    </blockquote>
    <pre wrap=""><!---->
Yes, this should be enough (on a side note; it should probably be
"matrix-vision,bluecougar" unless of''mv' is your company's stock
ticker symbol).

  </pre>
    <blockquote type="cite">
      <pre wrap=""> As far as I did understand by reading the docs it should be possible
 running a general MPC52xx kernel with a custom dtb ? Is this correct ?
    </pre>
    </blockquote>
    <pre wrap=""><!---->
That is correct.

  </pre>
    <blockquote type="cite">
      <pre wrap=""> The dts file has already been reduced to a minimum, i.e. only the cpu,
 pic, xlb and a few nodes like psc1 and psc2 are present. No bestcomm,
 pci, ata or "advanced" features like mtd partitions. All I want to get
 working is the serial console on "/dev/ttyPSC0".
    </pre>
    </blockquote>
    <pre wrap=""><!---->
Cheers,
g.

  </pre>
  </blockquote>
  <br>
regards,<br>
Andre<br>
  <br>
MATRIX VISION GmbH, Talstra&szlig;e 16, DE-71570 Oppenweiler -
Registergericht: Amtsgericht Stuttgart, HRB 271090
Gesch&auml;ftsf&uuml;hrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
  <br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a></pre>
</blockquote>
<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------010304040707030205030005--
