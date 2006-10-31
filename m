Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC22F67B9F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 04:34:46 +1100 (EST)
Message-ID: <4547872C.1080406@dlasys.net>
Date: Tue, 31 Oct 2006 12:26:04 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
	<609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
	<87lknadbbl.fsf@sleipner.barco.com>
	<877iylreca.fsf@sleipner.barco.com> <4542CE8A.9030904@dlasys.net>
	<87pscap5zq.fsf@sleipner.barco.com>
In-Reply-To: <87pscap5zq.fsf@sleipner.barco.com>
Content-Type: multipart/alternative;
	boundary="------------030704080004050704050001"
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
--------------030704080004050704050001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> David>     There is a substantial time/code difference between the
> David> time ulite_console_setup() is called and the time the platform
> David> device is initiallized.
>
> Huh?
>
> (gdb) br ulite_probe
> Breakpoint 2 at 0xc00f7530: file drivers/serial/uartlite.c, line 397.
> (gdb) br ulite_console_setup
> Breakpoint 3 at 0xc00f7454: file drivers/serial/uartlite.c, line 342.
> (gdb) c
> Continuing.
>
> Breakpoint 2, ulite_probe (pdev=0xc00ddb50) at drivers/serial/uartlite.c:397
> 397                     return -EINVAL;
> (gdb) c
> Continuing.
>
> Breakpoint 3, ulite_console_setup (co=0xc00e2f14, options=0xc00fe00f "115200")
>     at drivers/serial/uartlite.c:342
> 342             if (co->index < 0 || co->index >= ULITE_NR_UARTS)
>
> _probe get's called before console_setup, so we have all the
> information to output console data right away.
    I am not nearly as familiar with your driver and David B. Early 
serial patches as I am with my own.
    But I can assure you that the early serial init code occurs well 
before the call to probe.

    If that is not the case then there is no reason for the early serial 
code to even exist.
   
    Does David B.'s patch include support for early_serial_init(struct 
uart_port *) ?

    Look at other BSP's, most have early serial support.

    One of the reasons I modeled my driver off the 8250 was because it 
had boot to bash support.
    If the 8250 did something in a particular way I did the same for the 
uartlite - unless I really deeply understood why
    I needed not to.  I implimented every relevant 8250 feature every 
step of the way.
    I actually started with the early serial code long before I started 
with the driver. It was fairly trivial. It gets you fairly far into the 
boot process,
    and you can call it directly for debugging.
    

        
> David>     But for now, if you are not going to bother making
> David> console_settup() work you might as well not put the rest of the
> David> early serial code in at all.
>
> Not going to make it work? What doesn't work?
>   
     If you impliment early_serial_setup(struct uart_port *) then you 
must initialize the driver at the time of that call using a uart_port 
struct.
    Unless you are going to redefine early_serial_setup() specifically 
for the uartlite - maybe that is possible, I don't know, but it sounds 
like a bad idea.

    I have attached the boot text from a Pico E14 - this one using my 
Keyhole port serial driver not the uartlite drive - but since I 
patterned them both after the 8250
    the sequence is the same.
    The serial_init() call initializes the mini_driver in 
arch/ppc/boot/simple - in the case of uartlite that would be uartlite_tty.c
    keyhole_init() or uartlite_init() is in arch/ppc/syslib - in the 
case of uartlite uartlite_dbg.c
    that is followed immediately by early_serial_init() - basically 
meaning unless you make heavy use of progress() calls - and with 
early_serial_init() you can call printk and receive output immediately,
     uartlite_dbg.c is probably  unneeded but it is trivial and damn 
near identical to uartlite_tty.c
    early_serial_init() is  followed nearly immediately with 
keyhole_console_setup() or uartlite_console_setup()
    Much late Linux starts initializing the serial drivers and calls probe.

    If you do not impliment early_serial_setup, then you will be blind 
from that point until the probe call occurs. If anything goes wrong you 
will have to try to dump the printk buffer in memory to find out what 
went wrong.

    I do not know what hardware you are using or how your BSP is 
constructed.
   The whole early serial text system has little use for a system that 
is working perfectly.
    But it could be a life saver for somebody doing board bringup.



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
 
    
.
Loading zImage.elf.
[keyhole] serial_init()

loaded at:     00800000 00ABC13C
board data at: 0FFFFF60 0FFFFF7C
relocated to:  00804030 0080404C
zimage at:     00804E01 00AB9C2E
avail ram:     00ABD000 0FFFFFFF

Linux/PPC load: root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
keyhole_init()
keyhole:early_serial_setup()
arch: exit

keyhole_console_setup()
Linux version 2.6.19-rc2 (root@pico.dlasys.net) (gcc version 3.4.1) #2 
Tue Oct 31 11:24:48 EST 2006
Pico Virtex-4 port
Port by DLA Systems (info@dlasys.net)
Zone PFN ranges:
  DMA             0 ->    65535
  Normal      65535 ->    65535
early_node_map[1] active PFN ranges
    0:        0 ->    65535
Built 1 zonelists.  Total pages: 65024
Kernel command line: root=/dev/ram
Xilinx INTC #0 at 0x41200000 mapped to 0xF5FFD000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255488k available (1272k kernel code, 724k data, 2052k init, 0k 
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16  
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered (default)
Serial: Xilinx uartlite driver $Revision: 0.10 $ 1 ports
Serial: Pico keyhole driver $Revision: 0.20 $*
keyhole_device_probe()
ttyS0 at MMIO 0x70000000 (irq = -1) is a keyhole
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
TCP cubic registered
NET: Registered protocol family 17
Freeing unused kernel memory: 2052k init
command='/bin/sh' action='2' terminal='/dev/ttyS0'
command='/etc/init.d/rcS' action='1' terminal='/dev/ttyS0'
command='/sbin/init' action='128' terminal='/dev/ttyS0'
command='/sbin/reboot' action='32' terminal='/dev/ttyS0'
command='/sbin/swapoff -a 2>/dev/null' action='64' terminal='/dev/ttyS0'
command='/bin/umount -a -r' action='64' terminal='/dev/ttyS0'
Starting DHCP client: udhcpc a
BusyBox v1.2.0 (2006.07.21-07:20+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.
/ $


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------030704080004050704050001
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Peter Korsgaard wrote:
<blockquote cite="mid:87pscap5zq.fsf@sleipner.barco.com" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">"David" == David H Lynch <a
 class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a> writes:
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
David&gt;     There is a substantial time/code difference between the
David&gt; time ulite_console_setup() is called and the time the platform
David&gt; device is initiallized.

Huh?

(gdb) br ulite_probe
Breakpoint 2 at 0xc00f7530: file drivers/serial/uartlite.c, line 397.
(gdb) br ulite_console_setup
Breakpoint 3 at 0xc00f7454: file drivers/serial/uartlite.c, line 342.
(gdb) c
Continuing.

Breakpoint 2, ulite_probe (pdev=0xc00ddb50) at drivers/serial/uartlite.c:397
397                     return -EINVAL;
(gdb) c
Continuing.

Breakpoint 3, ulite_console_setup (co=0xc00e2f14, options=0xc00fe00f "115200")
    at drivers/serial/uartlite.c:342
342             if (co-&gt;index &lt; 0 || co-&gt;index &gt;= ULITE_NR_UARTS)

_probe get's called before console_setup, so we have all the
information to output console data right away.</pre>
</blockquote>
&nbsp;&nbsp;&nbsp; I am not nearly as familiar with your driver and David B. Early
serial patches as I am with my own.<br>
&nbsp;&nbsp;&nbsp; But I can assure you that the early serial init code occurs well
before the call to probe.<br>
<br>
&nbsp;&nbsp;&nbsp; If that is not the case then there is no reason for the early
serial code to even exist.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Does David B.'s patch include support for early_serial_init(struct
uart_port *) ?<br>
<br>
&nbsp;&nbsp;&nbsp; Look at other BSP's, most have early serial support.<br>
<br>
&nbsp;&nbsp;&nbsp; One of the reasons I modeled my driver off the 8250 was because it
had boot to bash support.<br>
&nbsp;&nbsp;&nbsp; If the 8250 did something in a particular way I did the same for
the uartlite - unless I really deeply understood why <br>
&nbsp;&nbsp;&nbsp; I needed not to.&nbsp; I implimented every relevant 8250 feature every
step of the way.<br>
&nbsp;&nbsp;&nbsp; I actually started with the early serial code long before I started
with the driver. It was fairly trivial. It gets you fairly far into the
boot process, <br>
&nbsp;&nbsp;&nbsp; and you can call it directly for debugging.<br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
<blockquote cite="mid:87pscap5zq.fsf@sleipner.barco.com" type="cite">
  <pre wrap="">
David&gt;     But for now, if you are not going to bother making
David&gt; console_settup() work you might as well not put the rest of the
David&gt; early serial code in at all.

Not going to make it work? What doesn't work?
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp;&nbsp; If you impliment early_serial_setup(struct uart_port *) then you
must initialize the driver at the time of that call using a uart_port
struct.<br>
&nbsp;&nbsp;&nbsp; Unless you are going to redefine early_serial_setup() specifically
for the uartlite - maybe that is possible, I don't know, but it sounds
like a bad idea.<br>
<br>
&nbsp;&nbsp;&nbsp; I have attached the boot text from a Pico E14 - this one using my
Keyhole port serial driver not the uartlite drive - but since I
patterned them both after the 8250<br>
&nbsp;&nbsp;&nbsp; the sequence is the same.<br>
&nbsp;&nbsp;&nbsp; The serial_init() call initializes the mini_driver in
arch/ppc/boot/simple - in the case of uartlite that would be
uartlite_tty.c<br>
&nbsp;&nbsp;&nbsp; keyhole_init() or uartlite_init() is in arch/ppc/syslib - in the
case of uartlite uartlite_dbg.c<br>
&nbsp;&nbsp;&nbsp; that is followed immediately by early_serial_init() - basically
meaning unless you make heavy use of progress() calls - and with
early_serial_init() you can call printk and receive output immediately,
<br>
&nbsp;&nbsp;&nbsp;&nbsp; uartlite_dbg.c is probably&nbsp; unneeded but it is trivial and damn
near identical to uartlite_tty.c<br>
&nbsp;&nbsp;&nbsp; early_serial_init() is&nbsp; followed nearly immediately with
keyhole_console_setup() or uartlite_console_setup()<br>
&nbsp;&nbsp;&nbsp; Much late Linux starts initializing the serial drivers and calls
probe.<br>
<br>
&nbsp;&nbsp;&nbsp; If you do not impliment early_serial_setup, then you will be blind
from that point until the probe call occurs. If anything goes wrong you
will have to try to dump the printk buffer in memory to find out what
went wrong.<br>
<br>
&nbsp;&nbsp;&nbsp; I do not know what hardware you are using or how your BSP is
constructed.<br>
&nbsp;&nbsp; The whole early serial text system has little use for a system that
is working perfectly.<br>
&nbsp;&nbsp;&nbsp; But it could be a life saver for somebody doing board bringup.<br>
<br>
<br>
<br>
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;<br>
.<br>
Loading zImage.elf.<br>
[keyhole] serial_init()<br>
<br>
loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00800000 00ABC13C<br>
board data at: 0FFFFF60 0FFFFF7C<br>
relocated to:&nbsp; 00804030 0080404C<br>
zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00804E01 00AB9C2E<br>
avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00ABD000 0FFFFFFF<br>
<br>
Linux/PPC load: root=/dev/ram<br>
Uncompressing Linux...done.<br>
Now booting the kernel<br>
id mach(): done<br>
MMU:enter<br>
MMU:hw init<br>
MMU:mapin<br>
MMU:setio<br>
MMU:exit<br>
setup_arch: enter<br>
setup_arch: bootmem<br>
keyhole_init()<br>
keyhole:early_serial_setup()<br>
arch: exit<br>
<br>
keyhole_console_setup()<br>
Linux version 2.6.19-rc2 (<a class="moz-txt-link-abbreviated" href="mailto:root@pico.dlasys.net">root@pico.dlasys.net</a>) (gcc version 3.4.1) #2
Tue Oct 31 11:24:48 EST 2006<br>
Pico Virtex-4 port<br>
Port by DLA Systems (<a class="moz-txt-link-abbreviated" href="mailto:info@dlasys.net">info@dlasys.net</a>)<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 65535<br>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 65535 -&gt;&nbsp;&nbsp;&nbsp; 65535<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 65535<br>
Built 1 zonelists.&nbsp; Total pages: 65024<br>
Kernel command line: root=/dev/ram<br>
Xilinx INTC #0 at 0x41200000 mapped to 0xF5FFD000<br>
PID hash table entries: 1024 (order: 10, 4096 bytes)<br>
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
Memory: 255488k available (1272k kernel code, 724k data, 2052k init, 0k
highmem)<br>
Mount-cache hash table entries: 512<br>
NET: Registered protocol family 16&nbsp;&nbsp; <br>
NET: Registered protocol family 2<br>
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
TCP established hash table entries: 8192 (order: 3, 32768 bytes)<br>
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<br>
TCP: Hash tables configured (established 8192 bind 4096)<br>
TCP reno registered<br>
io scheduler noop registered (default)<br>
Serial: Xilinx uartlite driver $Revision: 0.10 $ 1 ports<br>
Serial: Pico keyhole driver $Revision: 0.20 $*<br>
keyhole_device_probe()<br>
ttyS0 at MMIO 0x70000000 (irq = -1) is a keyhole<br>
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize<br>
TCP cubic registered<br>
NET: Registered protocol family 17<br>
Freeing unused kernel memory: 2052k init<br>
command='/bin/sh' action='2' terminal='/dev/ttyS0'<br>
command='/etc/init.d/rcS' action='1' terminal='/dev/ttyS0'<br>
command='/sbin/init' action='128' terminal='/dev/ttyS0'<br>
command='/sbin/reboot' action='32' terminal='/dev/ttyS0'<br>
command='/sbin/swapoff -a 2&gt;/dev/null' action='64'
terminal='/dev/ttyS0'<br>
command='/bin/umount -a -r' action='64' terminal='/dev/ttyS0'<br>
Starting DHCP client: udhcpc a<br>
BusyBox v1.2.0 (2006.07.21-07:20+0000) Built-in shell (ash)<br>
Enter 'help' for a list of built-in commands.<br>
/ $ <br>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a
 class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a
 class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------030704080004050704050001--
