Message-ID: <01C1525A.ED6F1960.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Get "put_dirty_page" error msg
Date: Thu, 11 Oct 2001 13:45:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone.

I am porting a version of Redhat's embedded linux kernel to
a new custom designed bd with the mpc860. I previously
successfully used this kernel with the MBX dev bd, using
NFS to access the remote RAM disk, thus booting the kernel
and executing my app.  Now I am using a local RAM disk on
this new bd.

The zImage (boot loader + zipped KERNEL + zipped RAM disk)
is downloaded into the onboard RAM, starts its BOOT loader,
unzips the kernel, unzips the RAM disk, starts booting the
kernel code up to calling execve(/sbin/init).  The sequence
is shown below. I don't understand what is happening here with the
"put_dirty_pages".  /sbin/init is getting executed and /app is then
attempted.


There is 32M of RAM.	0x0000.0000 - 0x01ff.ffff
zImage is downloaded into 0x0018.0000 and execution
begins there:

Executing Boot Loader...
                             Start               End
                            -----------          -----------
kernel (zipped)  =  0x001a2254   0x001f1dbe
initrd (zipped)  =    0x001f1dbe   0x0021f357
initrd relocated =   0x01fc2000   0x01fef599
available RAM    = 0x001f2000   0x01fc2000
Unzipping Kernel()...

Booting Kernel...
Calibrating delay loop...49.05 BogoMIPS
start_kernel(3): mem_start=c0129d80,mem_end=c1ff0000
Memory: 31328k available (616k kernel code, 576k data, 0k init)
[c0000000,c1ff0000]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Linux NET4.0 for Linux 2.2
<6>Based upon Swansea University Computer Society NET3.039
<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Starting kswapd v1.5
RAM disk driver initialized:  16 RAM disks of 4096K size

Loading RAM DISK image...
<5>RAMDISK: Compressed image found at block 0
Unzipping RAM DISK...
VFS: Mounted root (romfs filesystem).
Freeing unused kernel memory: 0k init

sys_execve(): Executing /sbin/init...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists

sys_execve(): Executing /app...
put_dirty_page: pte 01fc49c1 already exists
find_vma_prev: tree inconsistent with list
Executing /app...



Thanks,

Steven Vacca
Valcom, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
