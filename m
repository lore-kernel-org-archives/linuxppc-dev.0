Return-Path: <tosettofabio83@libero.it>
Received: from polito.it (unknown [130.192.3.45])
	by ozlabs.org (Postfix) with ESMTP id ACD75DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 18:52:15 +1000 (EST)
Message-ID: <48280504.1010602@libero.it>
Date: Mon, 12 May 2008 10:51:16 +0200
From: Fabio Tosetto <tosettofabio83@libero.it>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: MPC5200b MMC over SPI into PSC6
References: <481F4DFD.1000702@libero.it>	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>	<4821A551.3060205@libero.it>	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>	<482317E2.7000308@libero.it>	<fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>	<ed84ed090805090640w11dcfc57r1303ac4fceb482cb@mail.gmail.com>	<ed84ed090805090651g65ab474fk13d549e7166c3f1c@mail.gmail.com>	<fa686aa40805090706q572b44e9n2b39a6808562b2ad@mail.gmail.com>	<ed84ed090805090802s177f9d47r4be59b5a47138d2a@mail.gmail.com>
	<fa686aa40805090820s66801309j161adfcbc360fc42@mail.gmail.com>
In-Reply-To: <fa686aa40805090820s66801309j161adfcbc360fc42@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------050406010801050008060106"
Cc: linuxppc-dev@ozlabs.org, Fabri <rider4ever@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050406010801050008060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

in uboot i have setting the bootargs variable:

=> bootargs debug console=ttyPSC0,115200 root=/dev/ram
=> saveenv

If I'm not wrong, the right sequence of commands should be the following:

$ make ARCH=powerpc mpc5200_defconfig
$ make ARCH=powerpc menuconfig
.. [customizations]...
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- cuImage.lite5200b

and this is the output:
..
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  WRAP    arch/powerpc/boot/cuImage.lite5200b
DTC: dts->dtb  on file
"/home/ftosetto/linux-2.6.25.2-lite5200/arch/powerpc/boot/dts/lite5200b.dts"
Image Name:   Linux-2.6.25.2
Created:      Mon May  12 10:29:40 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1518744 Bytes = 1483.15 kB = 1.45 MB
Load Address: 0x00400000
Entry Point:  0x00400550


At this point I've loaded the cuImage and rootfs.uimage on the board:

=> usb start
=> usb scan
=> fatload usb 0 0x03000000 cuImage.lite5200b
=> fatload usb 0 0x04000000 rootfs.uimage
=> bootm 0x03000000 0x04000000

but it still hangs after this:

## Booting image at 03000000 
...                                               
   Image Name:   
Linux-2.6.25.2                                                
   Created:      2008-05-12   7:39:07 
UTC                                      
   Image Type:   PowerPC Linux Kernel Image (gzip 
compressed)                  
   Data Size:    1589091 Bytes =  1.5 
MB                                       
   Load Address: 
00400000                                                      
   Entry Point:  
00400550                                                      
   Verifying Checksum ... 
OK                                                   
   Uncompressing Kernel Image ... 
OK                                           
## Loading RAMDisk Image at 04000000 
...                                       
   Image Name:   RamDisk Image 
RadioNav                                        
   Created:      2007-10-24  15:48:39 
UTC                                      
   Image Type:   PowerPC Linux RAMDisk Image (gzip 
compressed)                 
   Data Size:    1839123 Bytes =  1.8 
MB                                       
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Loading Ramdisk to 0fd89000, end 0ff4a013 ... 
OK                            
Memory <- <0x0 0x10000000> 
(256MB)                                             
CPU clock-frequency <- 0xbcd3d80 
(198MHz)                                      
CPU timebase-frequency <- 0x1f78a40 
(33MHz)                                    
CPU bus-frequency <- 0x7de2900 
(132MHz)                                        
                                                                                

zImage starting: loaded at 0x00400000 (sp: 
0x0ff4a958)                         
Allocating 0x34d42c bytes for kernel 
...                                       
gunzipping (0x00000000 <- 0x0040d000:0x007510f0)...done 0x32d150 
bytes         
Using loader supplied ramdisk at 
0xfd89000-0xff4a013                           
initrd head: 
0x1f8b0808                                                        
                                                                                

Linux/PowerPC load: debug console=ttyPSC0,115200 root=/dev/ram
Finalizing device tree... flat tree at 0x75e300

Where is the problem? The problem is the my rootfs.uimage?

Do you have any idea?
Best regards,
Fabio

Grant Likely ha scritto:
> On Fri, May 9, 2008 at 9:02 AM, Fabri <rider4ever@gmail.com> wrote:
>   
>> Thanks for the patches, now some more rows are printed after RamDisk loading:
>>
>>   Verifying Checksum ... OK
>>   Loading Ramdisk to 0fe68000, end 0ff49bf2 ... OK
>> Memory <- <0x0 0x10000000> (256MB)
>> CPU clock-frequency <- 0xbcd3d80 (198MHz)
>> CPU timebase-frequency <- 0x1f78a40 (33MHz)
>> CPU bus-frequency <- 0x7de2900 (132MHz)
>>
>> zImage starting: loaded at 0x00400000 (sp: 0x0ff4a958)
>> Allocating 0x32d410 bytes for kernel ...
>> gunzipping (0x00000000 <- 0x0040d000:0x00730fd4)...done 0x30d150 bytes
>> Using loader supplied ramdisk at 0xfe68000-0xff49bf2
>> initrd head: 0x1f8b0808
>>
>> Linux/PowerPC load:
>>     
>                       ^^^^^^^^^^^^^^^^^^
>
> Doesn't look like you are passing a kernel parameters line.  The
> kernel probably is booting, but doesn't know where to output the
> console.  Try adding "console=ttyPSC0,115200".
>
> Cheers,
> g.
>
>   
>
>   


--------------050406010801050008060106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Times New Roman, Times, serif"><big>Hello,<br>
<br>
in uboot i have setting the bootargs variable:</big><br>
<br>
=&gt; bootargs debug console=ttyPSC0,115200 root=/dev/ram<br>
=&gt; saveenv<br>
<br>
<big>If I'm not wrong, the right sequence of commands should be the
following:</big></font><br>
<pre wrap="">$ make ARCH=powerpc mpc5200_defconfig
$ make ARCH=powerpc menuconfig
.. [customizations]...
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- cuImage.lite5200b

<big><big><font face="Times New Roman, Times, serif">and this is the output:</font></big></big>
..
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  WRAP    arch/powerpc/boot/cuImage.lite5200b
DTC: dts-&gt;dtb  on file
"/home/ftosetto/linux-2.6.25.2-lite5200/arch/powerpc/boot/dts/lite5200b.dts"
Image Name:   Linux-2.6.25.2
Created:      Mon May  12 10:29:40 2008
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    1518744 Bytes = 1483.15 kB = 1.45 MB
Load Address: 0x00400000
Entry Point:  0x00400550


<big><big><font face="Times New Roman, Times, serif">At this point I've loaded the cuImage and rootfs.uimage on the board:</font></big></big>
</pre>
=&gt; usb start<br>
=&gt; usb scan<br>
=&gt; fatload usb 0 0x03000000 cuImage.lite5200b<br>
=&gt; fatload usb 0 0x04000000 rootfs.uimage<br>
=&gt; bootm 0x03000000 0x04000000<br>
<br>
<big>but it still hangs after this:<br>
<br>
</big>## Booting image at 03000000
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp;
Linux-2.6.25.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-05-12&nbsp;&nbsp; 7:39:07
UTC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip
compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1589091 Bytes =&nbsp; 1.5
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Load Address:
00400000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Entry Point:&nbsp;
00400550&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Verifying Checksum ...
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Uncompressing Kernel Image ...
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
## Loading RAMDisk Image at 04000000
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; RamDisk Image
RadioNav&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-10-24&nbsp; 15:48:39
UTC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip
compressed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1839123 Bytes =&nbsp; 1.8
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Load Address:
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Entry Point:&nbsp;
00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Verifying Checksum ...
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp; Loading Ramdisk to 0fd89000, end 0ff4a013 ...
OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Memory &lt;- &lt;0x0 0x10000000&gt;
(256MB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
CPU clock-frequency &lt;- 0xbcd3d80
(198MHz)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
CPU timebase-frequency &lt;- 0x1f78a40
(33MHz)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
CPU bus-frequency &lt;- 0x7de2900
(132MHz)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
zImage starting: loaded at 0x00400000 (sp:
0x0ff4a958)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Allocating 0x34d42c bytes for kernel
...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
gunzipping (0x00000000 &lt;- 0x0040d000:0x007510f0)...done 0x32d150
bytes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
Using loader supplied ramdisk at
0xfd89000-0xff4a013&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
initrd head:
0x1f8b0808&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
Linux/PowerPC load: debug console=ttyPSC0,115200 root=/dev/ram<br>
Finalizing device tree... flat tree at 0x75e300<br>
<br>
<big>Where is the problem? The problem is the my rootfs.uimage?</big><br>
<br>
<big>Do you have any idea?<br>
Best regards,
<br>
Fabio</big><br>
<br>
Grant Likely ha scritto:
<blockquote
 cite="mid:fa686aa40805090820s66801309j161adfcbc360fc42@mail.gmail.com"
 type="cite">
  <pre wrap="">On Fri, May 9, 2008 at 9:02 AM, Fabri <a class="moz-txt-link-rfc2396E" href="mailto:rider4ever@gmail.com">&lt;rider4ever@gmail.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks for the patches, now some more rows are printed after RamDisk loading:

  Verifying Checksum ... OK
  Loading Ramdisk to 0fe68000, end 0ff49bf2 ... OK
Memory &lt;- &lt;0x0 0x10000000&gt; (256MB)
CPU clock-frequency &lt;- 0xbcd3d80 (198MHz)
CPU timebase-frequency &lt;- 0x1f78a40 (33MHz)
CPU bus-frequency &lt;- 0x7de2900 (132MHz)

zImage starting: loaded at 0x00400000 (sp: 0x0ff4a958)
Allocating 0x32d410 bytes for kernel ...
gunzipping (0x00000000 &lt;- 0x0040d000:0x00730fd4)...done 0x30d150 bytes
Using loader supplied ramdisk at 0xfe68000-0xff49bf2
initrd head: 0x1f8b0808

Linux/PowerPC load:
    </pre>
  </blockquote>
  <pre wrap=""><!---->                      ^^^^^^^^^^^^^^^^^^

Doesn't look like you are passing a kernel parameters line.  The
kernel probably is booting, but doesn't know where to output the
console.  Try adding "console=ttyPSC0,115200".

Cheers,
g.

  </pre>
  <pre wrap=""><!---->
  </pre>
</blockquote>
<br>
</body>
</html>

--------------050406010801050008060106--
