Message-ID: <004601c13710$d26abee0$2000a8c0@private>
From: =?ks_c_5601-1987?B?wLG1v7yu?= <manulsan@daintelecom.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Can't run init... MPC8240 
Date: Fri, 7 Sep 2001 05:16:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear

I am working MPC8240 custom board with Sandpoint8240 BSP
from MVista CDK 2.0 .   I think that I made something wrong.
I tried to make run "init" ( init is located /bin/init,  sbin is symbolic link to bin),
but didn't run it so I printed error code  with printk function.  Error code is 2
Error code 2 says that file does not exist. I can't find debugging point.
Small advice gonna be big hands to me.


Following is What I did and partial souece and console output using printk

[ Work Sequence ]

1. Made ramdisk.image.gz and copy it to "/opt/hardhat/devkit/lsp/motorola-sandpoint/linux-
   2.4.2_hhl20/arch/ppc/boot/images"
2. compiled with command " make zImage.initrd"
3. Change to directory   "/opt/hardhat/devkit/lsp/motorola-sandpoint/linux- 2.4.2_hhl20/arch/ppc/boot/images"
4. Make it to srec format
    zsrec -s 900000 zImage.initrd.sandpoint  > image.hex
5. At vision prob I converted it to bdx file
    I got image.bdx
6. I downloaded "image.bdx" using vision prob
7. go 900000




=====================  source code  =====================

static int init(void * unused)
{
        lock_kernel();
        do_basic_setup();

        /*
         * Ok, we have completed the initial bootup, and
         * we're essentially up and running. Get rid of the
         * initmem segments and start the user-mode stuff..
         */
        free_initmem();
        unlock_kernel();
#if 0

        if (open("/dev/console", O_RDWR, 0) < 0)
                printk("Warning: unable to open an initial console.\n");

        (void) dup(0);
        (void) dup(0);
#endif
        /*
         * We try each of these until one succeeds.
         *
         * The Bourne shell can be used instead of init if we are
         * trying to recover a really broken machine.
         */

        if (execute_command)
                execve(execute_command,argv_init,envp_init);

if (execute_command)
printk("Suchen nach %s ", execute_command);    execve(execute_command,argv_init,envp_init);
printk("%d\n", errno);

printk(" /sbin/init ==> "); execve("/sbin/init",argv_init,envp_init);
printk("  %d\n", (errno));

printk(" /init ==> "); execve("/init",argv_init,envp_init);
printk("%d\n", (errno));

printk(" /etc/init  ==> "); execve("/etc/init",argv_init,envp_init);
printk("%d\n", (errno));

printk(" /bin/init  ==> "); execve("/bin/init",argv_init,envp_init);
printk("%d\n", (errno));

printk(" /bin/sh ==> "); execve("/bin/sh",argv_init,envp_init);
printk("%d\n", (errno));

panic("No init found. Try passing init= option to kernel.");
}


=======[  Printk output ]===================================

.
.   ( omitted )
.
.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
block: queued sectors max/low 40885kB/13628kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194301k freed
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ena
bled
ttyS00 at 0x1e08080 (irq = 4) is a ST16650
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
IP-Config: No network devices available.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init 4k openfirmware...
Suchen nach /init 2
 /sbin/init ==>   2
 /init ==> 2
 /etc/init  ==> 2
 /bin/init  ==> 2
 /bin/sh ==> 2
Kernel panic: No init found. Try passing init= option to kernel.
Rebooting in 180 seconds..
=========================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
