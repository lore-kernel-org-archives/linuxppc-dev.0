Message-ID: <3FCF0252.7070202@dgt-lab.com.pl>
Date: Thu, 04 Dec 2003 10:45:54 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
References: <3FCD956B.8030604@gazeta.pl> <3FCEF441.2030808@dgt-lab.com.pl> <20031204091536.GA1050@gate.ebshome.net>
In-Reply-To: <20031204091536.GA1050@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik Eugene Surovegin napisa³:

>On Thu, Dec 04, 2003 at 09:45:53AM +0100, Wojciech Kromer wrote:
>
>
>>>i have some problems with using fec device on my custom 8250 board
>>>while sending a lot of data (at least 300MB) through this device causes
>>>lack of memory
>>>sending same amount of data through loopback works fine
>>>
>>>i'm using 2.4.19 kernel
>>>any idea?
>>>
>>>
>>cached memory keeps growing slowly, and free is going down same way,
>>after putting ~300MB ftp data (from 8250 board to another host), VM
>>starts killing some applications
>>
>>same situation is with latest linuxppc_2_4_devel kernel from denx.de,
>>but there is additional information from kernel
>>
>><5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>><5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>><5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>><5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>><5>__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>><4>VM: killing process sshd
>>
>>what's wrong ???
>>
>>
>
>It means that this box is really out of memory.
>
>
sure, but _why_? thre are no memory consuption processes,
i've just run ftp-put from this box to another machine

>Could you provide output from utility called 'free' and from file
>/proc/slabinfo at two points of time: 1) when you just booted your
>boax and 2) just before it starts failing.
>
>
>
thx for quick answer

huh, a lot of info:

==== at begining =========================================
bash-2.05# free
             total       used       free     shared    buffers     cached
Mem:        127888      22488     105400          0          0      15272
-/+ buffers/cache:       7216     120672
Swap:            0          0          0
bash-2.05# cat /proc/slabinfo
slabinfo - version: 1.1
kmem_cache            62     68    112    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        3    113     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        2     59     64    1    1    1
ip_fib_hash           10    113     32    1    1    1
ip_dst_cache          27     48    160    2    2    1
arp_cache              4     30    128    1    1    1
blkdev_requests        0      0     96    0    0    1
nfs_write_data         0     10    384    0    1    1
nfs_read_data          0     40    384    0    4    1
nfs_page               0     40     96    0    1    1
devfsd_event           0      0     20    0    0    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        2     40     96    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache    131    192    160    8    8    1
sock                  21     25    800    5    5    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            10     59     64    1    1    1
bdev_cache             0      0     64    0    0    1
mnt_cache             11     59     64    1    1    1
inode_cache          419    424    480   53   53    1
dentry_cache         601    630    128   21   21    1
filp                 175    180    128    6    6    1
names_cache            0      3   4096    0    3    1
buffer_head            0      0     96    0    0    1
mm_struct             14     24    160    1    1    1
vm_area_struct       462    560     96   12   14    1
fs_cache              13    113     32    1    1    1
files_cache           14     18    416    2    2    1
signal_act            16     21   1312    6    7    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             10     10   4096   10   10    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              5    178   2048    3   89    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             17     24   1024    5    6    1
size-512(DMA)          0      0    512    0    0    1
size-512               6      8    512    1    1    1
size-256(DMA)          0      0    256    0    0    1
size-256              14     30    256    1    2    1
size-128(DMA)          0      0    128    0    0    1
size-128             829    930    128   31   31    1
size-64(DMA)           0      0     64    0    0    1
size-64               41     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32              201    226     32    2    2    1

===after some time (ftp put ~75MB) ================================

bash-2.05# free;cat /proc/slabinfo
             total       used       free     shared    buffers     cached
Mem:        127888     125688       2200          0          0      81772
-/+ buffers/cache:      43916      83972
Swap:            0          0          0
slabinfo - version: 1.1
kmem_cache            62     68    112    2    2    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        5    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        1     59     64    1    1    1
ip_fib_hash           10    113     32    1    1    1
ip_dst_cache          51     72    160    3    3    1
arp_cache              3     30    128    1    1    1
blkdev_requests        0      0     96    0    0    1
nfs_write_data         0      0    384    0    0    1
nfs_read_data          7     70    384    4    7    1
nfs_page               7     80     96    2    2    1
devfsd_event           0      0     20    0    0    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        2     40     96    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache              0      0     32    0    0    1
skbuff_head_cache  16857  16872    160  703  703    1
sock                  23     25    800    5    5    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            10     59     64    1    1    1
bdev_cache             0      0     64    0    0    1
mnt_cache             11     59     64    1    1    1
inode_cache          435    440    480   55   55    1
dentry_cache         625    630    128   21   21    1
filp                 179    180    128    6    6    1
names_cache            0      2   4096    0    2    1
buffer_head            0      0     96    0    0    1
mm_struct             15     24    160    1    1    1
vm_area_struct       485    520     96   13   13    1
fs_cache              14    113     32    1    1    1
files_cache           15     18    416    2    2    1
signal_act            17     18   1312    6    6    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              0      0   8192    0    0    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             10     10   4096   10   10    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048          16749  16798   2048 8382 8399    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             18     20   1024    5    5    1
size-512(DMA)          0      0    512    0    0    1
size-512              24     32    512    4    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              51     75    256    4    5    1
size-128(DMA)          0      0    128    0    0    1
size-128             910    930    128   31   31    1
size-64(DMA)           0      0     64    0    0    1
size-64               42     59     64    1    1    1
size-32(DMA)           0      0     32    0    0    1
size-32             8513   8588     32   76   76    1

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
