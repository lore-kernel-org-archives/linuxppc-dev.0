Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.207])
	by ozlabs.org (Postfix) with ESMTP id 58588679FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 09:26:33 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so940512nzh
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 16:26:30 -0700 (PDT)
Message-ID: <198592450608281626h6b3ced67i8a3d993053e75669@mail.gmail.com>
Date: Mon, 28 Aug 2006 23:26:30 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: "Howard, Marc" <Marc.Howard@kla-tencor.com>
Subject: Re: Help with booting with very large initrd
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE02F33401@CA1EXCLV02.adcorp.kla-tencor.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_134602_2794066.1156807590115"
References: <91B22F93A880FA48879475E134D6F0BE02F33401@CA1EXCLV02.adcorp.kla-tencor.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_134602_2794066.1156807590115
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I had a similiar problem long time ago. I remember it was related to the
size of ramdisk. Double check if your ramdisk size big enough.

On 8/25/06, Howard, Marc <Marc.Howard@kla-tencor.com> wrote:
>
> Hi,
>
> I'm developing a PPC440GX based board that uses U-Boot to boot a
> multi-file boot image composed of the kernel and a very large (> 96MB
> uncompressed) initrd file.  The board has 512MB of RAM of which the
> upper 16MB is reserved for dedicated hardware.  The 16MB block is
> reserved via "mem=496M" and U-Boot is told to stay out of that area by
> setting "initrd_high=1f000000".
>
> Before anyone asks there are several reasons for doing things this way.
> NFS is not an option in the target environment.
>
> I can tftp the combined boot image to my board.  I checked the crc with
> the crc32 command and it agrees exactly with the result obtained on the
> host machine using the boot file.  Therefore there is not a "TFTP >32MB"
> problem here.
>
> If I boot I get the following:
>
> => boot
> Waiting for PHY auto negotiation to complete... done
> ENET Speed is 1000 Mbps - FULL duplex connection
> Using ppc_4xx_eth2 device
> TFTP from server 192.168.168.108; our IP address is 192.168.168.111
> Filename 'pMulti-ramdisk'.
> Load address: 0x400000
> Loading: *
> done
> Bytes transferred = 38825407 (2506dbf hex)
> Automatic boot of image at addr 0x00400000 ...
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.10_mvl401-440gx_eval-I
>    Created:      2006-08-25   1:01:29 UTC
>    Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
>    Data Size:    38825343 Bytes = 37 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Contents:
>    Image 0:  1137986 Bytes =  1.1 MB
>    Image 1: 37687343 Bytes = 35.9 MB
>    Verifying Checksum ... OK
>    Uncompressing Multi-File Image ... OK
>    Loading Ramdisk to 1cc0e000, end 1efff02f ... OK
> Linux version 2.6.10_mvl401-440gx_eval (cram@toaster.kla-tencor.com)
> (gcc version 3.4.3 (MontaVista 3.4.3-25.0.107.0601076 2006-07-21)) #46
> Thu Aug 24 17:28:09 PDT 2006
> IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)
> Built 1 zonelists
> Kernel command line: ramdisk_size=262144 root=/dev/ram rw
> console=ttyS0,115200
> ip=192.168.168.111:192.168.168.108::255.255.255.0:scpu2:eth0: off
> mem=496M
> PID hash table entries: 2048 (order: 11, 32768 bytes)
>
> ......stuff deleted......
>
> RAMDISK driver initialized: 8 RAM disks of 262144K size 1024 blocksize
> loop: loaded (max 8 devices)
>
> ......more stuff deleted......
>
> eth0: link is down
> eth0: link is up, 1000 FDX, pause enabled
> IP-Config: Complete:
>       device=eth0, addr=192.168.168.111, mask=255.255.255.0,
> gw=255.255.255.255,     host=scpu2, domain=, nis-domain=(none),
>      bootserver=192.168.168.108, rootserver=192.168.168.108, rootpath=
> RAMDISK: Compressed image found at block 0
> crc error (orig 0x9a278d64, CRC_VALUE 0xa7bcd2e3 -- ignoring!
> length error (orig = 0x0c000000, bytes_out = 0x0c000015 -- ignored
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 120k init
> Warning: unable to open an initial console.
> Kernel panic - not syncing: No init found.  Try passing init= option to
> kernel.
> <0>Rebooting in 180 seconds..
>
> (I modified lib/inflate.c so that the crc and length checks would
> provide more info).
>
> Since the overall file CRC is good and U-Boot checksums are also okay
> this looks like some sort of size limitation with the inflate routine.
> BTW, The kerenel was made assuming a 256MB ramdisk; likewise the command
> line specs one as well.  The initrd image would fit easily in that
> space.
>
> Have any of you worked on this problem before and come up with a
> solution?
>
> Thanks,
>
> Marc Howard
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_134602_2794066.1156807590115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I had a similiar problem long time ago. I remember it was related to
the size of ramdisk. Double check if your ramdisk size big enough.<br><br><div><span class="gmail_quote">On 8/25/06, <b class="gmail_sendername">Howard, Marc</b> &lt;<a href="mailto:Marc.Howard@kla-tencor.com">Marc.Howard@kla-tencor.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br><br>I'm developing a PPC440GX based board that uses U-Boot to boot a
<br>multi-file boot image composed of the kernel and a very large (&gt; 96MB<br>uncompressed) initrd file.&nbsp;&nbsp;The board has 512MB of RAM of which the<br>upper 16MB is reserved for dedicated hardware.&nbsp;&nbsp;The 16MB block is<br>reserved via &quot;mem=496M&quot; and U-Boot is told to stay out of that area by
<br>setting &quot;initrd_high=1f000000&quot;.<br><br>Before anyone asks there are several reasons for doing things this way.<br>NFS is not an option in the target environment.<br><br>I can tftp the combined boot image to my board.&nbsp;&nbsp;I checked the crc with
<br>the crc32 command and it agrees exactly with the result obtained on the<br>host machine using the boot file.&nbsp;&nbsp;Therefore there is not a &quot;TFTP &gt;32MB&quot;<br>problem here.<br><br>If I boot I get the following:<br>
<br>=&gt; boot<br>Waiting for PHY auto negotiation to complete... done<br>ENET Speed is 1000 Mbps - FULL duplex connection<br>Using ppc_4xx_eth2 device<br>TFTP from server <a href="http://192.168.168.108">192.168.168.108</a>
; our IP address is <a href="http://192.168.168.111">192.168.168.111</a><br>Filename 'pMulti-ramdisk'.<br>Load address: 0x400000<br>Loading: *<br>done<br>Bytes transferred = 38825407 (2506dbf hex)<br>Automatic boot of image at addr 0x00400000 ...
<br>## Booting image at 00400000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.10_mvl401-440gx_eval-I<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2006-08-25&nbsp;&nbsp; 1:01:29 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Multi-File Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp;&nbsp;38825343 Bytes = 37 MB
<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp;&nbsp;00000000<br>&nbsp;&nbsp; Contents:<br>&nbsp;&nbsp; Image 0:&nbsp;&nbsp;1137986 Bytes =&nbsp;&nbsp;1.1 MB<br>&nbsp;&nbsp; Image 1: 37687343 Bytes = 35.9 MB<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Multi-File Image ... OK
<br>&nbsp;&nbsp; Loading Ramdisk to 1cc0e000, end 1efff02f ... OK<br>Linux version 2.6.10_mvl401-440gx_eval (<a href="mailto:cram@toaster.kla-tencor.com">cram@toaster.kla-tencor.com</a>)<br>(gcc version 3.4.3 (MontaVista 3.4.3-25.0.107.0601076
 2006-07-21)) #46<br>Thu Aug 24 17:28:09 PDT 2006<br>IBM Ocotea port (MontaVista Software, Inc. &lt;<a href="mailto:source@mvista.com">source@mvista.com</a>&gt;)<br>Built 1 zonelists<br>Kernel command line: ramdisk_size=262144 root=/dev/ram rw
<br>console=ttyS0,115200<br>ip=<a href="http://192.168.168.111:192">192.168.168.111:192</a>.168.168.108::255.255.255.0:scpu2:eth0: off<br>mem=496M<br>PID hash table entries: 2048 (order: 11, 32768 bytes)<br><br>......stuff deleted......
<br><br>RAMDISK driver initialized: 8 RAM disks of 262144K size 1024 blocksize<br>loop: loaded (max 8 devices)<br><br>......more stuff deleted......<br><br>eth0: link is down<br>eth0: link is up, 1000 FDX, pause enabled<br>
IP-Config: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=eth0, addr=<a href="http://192.168.168.111">192.168.168.111</a>, mask=<a href="http://255.255.255.0">255.255.255.0</a>,<br>gw=<a href="http://255.255.255.255">255.255.255.255</a>,&nbsp;&nbsp;&nbsp;&nbsp; host=scpu2, domain=, nis-domain=(none),
<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://192.168.168.108">192.168.168.108</a>, rootserver=<a href="http://192.168.168.108">192.168.168.108</a>, rootpath=<br>RAMDISK: Compressed image found at block 0<br>crc error (orig 0x9a278d64, CRC_VALUE 0xa7bcd2e3 -- ignoring!
<br>length error (orig = 0x0c000000, bytes_out = 0x0c000015 -- ignored<br>VFS: Mounted root (ext2 filesystem).<br>Freeing unused kernel memory: 120k init<br>Warning: unable to open an initial console.<br>Kernel panic - not syncing: No init found.&nbsp;&nbsp;Try passing init= option to
<br>kernel.<br> &lt;0&gt;Rebooting in 180 seconds..<br><br>(I modified lib/inflate.c so that the crc and length checks would<br>provide more info).<br><br>Since the overall file CRC is good and U-Boot checksums are also okay
<br>this looks like some sort of size limitation with the inflate routine.<br>BTW, The kerenel was made assuming a 256MB ramdisk; likewise the command<br>line specs one as well.&nbsp;&nbsp;The initrd image would fit easily in that<br>
space.<br><br>Have any of you worked on this problem before and come up with a<br>solution?<br><br>Thanks,<br><br>Marc Howard<br><br><br><br>_______________________________________________<br>Linuxppc-embedded mailing list
<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote>
</div><br>

------=_Part_134602_2794066.1156807590115--
