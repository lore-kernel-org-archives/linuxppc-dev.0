From: bharat <bharat@coraltele.com>
Subject: Re: regarding ld.so.preloads,ld.so.cache
Date: Tue, 8 Jun 2004 10:52:11 +0530
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <30210059.1086672088796.JavaMail.administrator@RnDserver>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----------  Forwarded Message  ----------

Subject: Re: regarding ld.so.preloads,ld.so.cache
Date: Tuesday 08 June 2004 10:48 am
From: Bharat <bharat@coraltele.com>
To: Mark Hatle <mhatle@mvista.com>

hi mark and everyone in list
             thanks for answering  me i am still struggling with the same
problem i am sending the dump of my whole execution i put some comments
in the whole execution hope these will be helpful
starting dump :

starting kernel Boot arguments:

 m8xx_xpm_reset func commented
memory_start c010a000 memory_end c0800000
memory_start c0120410
 After Trap_init
 WARN: cpm_interrupt_init blocked here (anand)
 After init_irq
Func:time_init  IMAP_ADDR ff000000freq 32time_init: decrementer frequency =
187500000/60

 m8xx_get_rtc_time() ENABLE INT ftv_sec 75f803e6 stage 5stage 6
WARN: serial_console_setup func return here without serial init
 (anand)console flag 7
console init done MEM- c0120410 After prof_len
Kmem_cache_init Starts
Kmem_cache_init()Calibrating delay loop... 49.05 BogoMIPS
Memory: 7036k available (676k kernel code, 448k data, 32k init)
[c0000000,c0800000]
 kmem_cache_sizes_init kmem_cache_sizes_init exit Dentry hash table entries:
1024 (order 1, 8k)

 Kernel in process .. stage1Buffer cache hash table entries: 8192 (order 3,
32k)
Page cache hash table entries: 2048 (order 1, 8k)

 Kernel in process .. stage2POSIX conformance testing by UNIFIX

M_TWB-c00bd000
 WAITING IN INFINITE LOOP(cpu_idle func)

 INIT TASK ON .........

<6>Linux NET4.0 for Linux 2.2
<6>Based upon Swansea University Computer Society NET3.039
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 8192 bhash 8192)

M_TWB-c00bd000
M_TWB-c00bd000Starting kswapd v5. 1.5 $

M_TWB-c00bd000
M_TWB-c00bd000STAG1<6>Serial driver version 4.27 with no serial options
enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16450
<6>ttyS01 at 0x02f8 (irq = 3) is a 16450
<6>ttyS02 at 0x03e8 (irq = 4) is a 16450
<6>CPM UART driver version 0.03

 HARDCODED RETURN FROM rs_8xx_init func
<6>loop: registered device at major 7
Func net_dev_init()
INFO: Processor :MPC860T, So we call fec_enet_init here
fec_enet_init()fep->rx_bd_base c016f000fep->tx_bd_base
c016f040bdp->cbd_buffaddr 16e000bdp->cbdf
fec: link up,remote fault,auto complete
fec: 10 Mbps, Half-Duplex
eth0: FEC ENET Version 0.1, 00:00:21:27:c0:03
Finc:ip_auto_config()IP_AUTO_CONFIGIP_AUTO_CONFIGIP-Config: Guessing netmask
255.255.255.0

 local=c0a84114, server=c0a8415aIP-Config: host=192.168.65.20, domain=(none),
path=`'
STAG2STAG3STAG4<5>Root-NFS: Mounting /prjroot/rootfs on server 192.168.65.90
as root
<5>Root-NFS:     rsize = 4096, wsize = 4096, timeo = 7, retrans = 3
<5>Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
<5>Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
<5>Looking up port of RPC 100003/2 on 192.168.65.90
Root-NFS: Portmapper on server returned 2049 as nfsd port
<5>Looking up port of RPC 100005/1 on 192.168.65.90
Root-NFS: mountd port is 32771
NFS:      nfs_mount(c0a8415a:/prjroot/rootfs)

M_TWB-c00bd000<5>VFS: Mounted root (NFS filesystem) readonly.
STAG5Freeing unused kernel memory: 32k init
exit function
open_namei-/dev/consoleST7
Warning: unable to open an initial console.
File NAme  /sbin/init ,
open_namei-/sbin/init prepare_bin
FILE POINT c00388a4
,7f,45,4c,
bprm_shsh_bang
FILE POINT c00360fc
ELF  FILE DETECTMACHINE ARCH 14start, end,end_data initSTG23STG24file
/sbin/init,
c00cd000SlowNEW page tbl c00cd000NEW page tbl c00cd000
M_TWB-c00cd000file /sbin/init,file /sbin/init,(start_brk) 100d5a48
(end_code) 100cd1a8
(start_code) 10000000
(end_data) 100cd1a8
(start_stack) 7fffffc0
(brk) 100d5a48

 regs [c013de70]Elf_INTER[10000100], sp[7fffffc0]
 filename/sbin/initreturn search_binary
after this this goes hangs and gives me a lot of trouble which are on  and on
from last 7 days
if i reboot the NFS server and then starts the client again then the response
is again the same  and the execution does not halted
please reply as soon as possible
thanks in anticipation

On Monday 07 June 2004 08:07 pm, you wrote:
> Two things.  First ld.so.preloads and ld.so.cache (and ld.conf) are all
> optional, and usually won't exist on an embedded system.  (You might get
> some arguments by some about ld.so.cache.. but the point is it does NOT
> need to exist).
>
> Second I believe you NFS problems are probably unrelated.  Specifically
> on system without a proper RTC, the timestamps for NFS requests will
> reset to a previous time stamp.  NFS uses time stamps to make sure that
> requests are always moving "forward" in time.  If you reboot your
> embedded system, the time stamp goes back in time.. you can easily get
> lockups with the NFS server not responding.
>
> First thing to try, reboot the NFS server, and see if it works once..
> then stops working for subsequent boots.  If that is the case, then you
> will need to figure out how to seed the kernel (on your embedded system)
> with a reasonable "time/date" combo if you don't have an RTC.
>
> --Mark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
