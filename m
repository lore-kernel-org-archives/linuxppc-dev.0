Date: Fri, 8 Sep 2000 13:55:07 +0200 (CEST)
From: Tilmann Bitterberg <tibit-ibm@bitterberg.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Linuxppc Development Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: CONFIG_HIGHMEM problems
Message-ID: <Pine.LNX.4.21.0009081006530.1436-200000@ford>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-469140276-1387275527-968413832=:1436"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---469140276-1387275527-968413832=:1436
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0009081352061.1436@ford>

Hi,

I tried your experimental CONFIG_HIGHMEM support. My machine is
an RS/6K 44P-170 (POWER3-II) with 2Gig of RAM. Kernel is a recent
BK snapshot.

After looking at arch/ppc/mm/init.c:pmac_find_end_of_memory, I
realized that there is no chance to return a total of more than
ram_limit (which is in 512MB in my case).

I do not have discontinous memory so phys_mem.n_regions == 1

Problem: After freeing all init stuff I get a
Machine check in kernel mode
Caused by (from: SRR1=81032) Machine check.
TRAP 0200
TASK = co1a5ff0[0] 'swapper'
Last syscall: 120

My bootlog with the attached patch is: (long lines are wrapped)

I have found 2048MB RAM
set_phys_avail: klimit (-1071201084), kstart (0), ksize (2543616)
 Total memory = 640MB; using 2048kB for hash table (at c0800000)
Linux version 2.4.0-test8 (root@karl.de.ibm.com) (gcc version 2.95.2)
Boot arguments: root=/dev/sda2 mem=2048M console=ttyS0,9600
OpenPIC addrs: ffc00000 feff7c00 feef7c00
RTAS Event Scan Rate: 1 (2999 jiffies)
On node 0 totalpages: 524288
zone(0): 163840 pages.
zone(1): 0 pages.
zone(2): 360448 pages.
Kernel command line: root=/dev/sda2 mem=2048M console=ttyS0,9600
OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at ffc00000
OpenPIC timer frequency is not set
time_init: decrementer frequency = 100.004166 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 799.54 BogoMIPS
Memory: 1927816k available (1376k kernel code, 864k data, 244k init, \
                                                     1441792k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX

[...]

Freeing unused kernel memory: 244k init 32k prep 16k pmac
Mem-info:
Free pages:      1919936kB (1441792kB HighMem)
( Free: 479984, lru_cache: 4 (256 512 768) )
   00 DMA: 2*4kB 3*8kB 2*16kB 0*32kB 2*64kB 2*128kB 0*256kB \
1*512kB 0*1024kB 233*2048kB = 478144k)
  L00 Normal: = 0kB)
   00 HighMem: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB \
0*512kB 0*1024kB 704*2048kB = 144)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
524288 pages of RAM
360448 pages of HIGHMEM
481835 free pages
42261 reserved pages
0 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:       16kB
Process  Pid      Ctx   Ctx<<4 Last Sys        pc     task
swapper    1        0        0      120 ?00000000 c2a1c000 current
kswapd     2        0        0       -1 ?00000000 c067c000
kflushd    3        0        0       -1 ?00000000 c067a000
kupdate    4        0        0       -1 ?00000000 c0678000

Thanks in advance

Tilmann
--
/usr/games/fortune: No such file or directory



---469140276-1387275527-968413832=:1436
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="high.patch"
Content-ID: <Pine.LNX.4.21.0009081350320.1436@ford>
Content-Description: Highmem stuff
Content-Disposition: ATTACHMENT; FILENAME="high.patch"
Content-Transfer-Encoding: BASE64

LS0tIGxpbnV4LTIuNC4wLXRlc3Q4LXByZTQvYXJjaC9wcGMvbW0vaW5pdC5j
Lm9yaWcgICAgICBNb24gRmViICAyIDA5OjMyOjM2IDE5NzANCisrKyBsaW51
eC0yLjQuMC10ZXN0OC1wcmU0L2FyY2gvcHBjL21tL2luaXQuYyAgIE1vbiBG
ZWIgIDIgMDk6MzE6MjkgMTk3MA0KQEAgLTEyODQsNiArMTI5MSw4IEBADQog
ew0KICAgICAgICB1bnNpZ25lZCBsb25nIGEsIHRvdGFsOw0KICAgICAgICB1
bnNpZ25lZCBsb25nIHJhbV9saW1pdCA9IDB4ZTAwMDAwMDAgLSBLRVJORUxC
QVNFOw0KKyAgICAgICB1bnNpZ25lZCBsb25nIHJlYWxfcmFtOw0KDQogICAg
ICAgIG1lbW9yeV9ub2RlID0gZmluZF9kZXZpY2VzKCJtZW1vcnkiKTsNCiAg
ICAgICAgaWYgKG1lbW9yeV9ub2RlID09IE5VTEwpIHsNCkBAIC0xMzAzLDE4
ICsxMzEyLDI4IEBADQogICAgICAgICAqIGluIG1lbV9tYXApLg0KICAgICAg
ICAgKi8NCiAgICAgICAgZ2V0X21lbV9wcm9wKCJyZWciLCAmcGh5c19tZW0p
Ow0KKyAgICAgICBwcmludGsoIkkgaGF2ZSBmb3VuZCAlbGRNQiBSQU1cbiIs
ICh1bnNpZ25lZCBsb25nKSBwaHlzX21lbS5yZWdpb25zWzBdLnNpemU+PjIw
KTsNCiAgICAgICAgaWYgKHBoeXNfbWVtLm5fcmVnaW9ucyA9PSAwKQ0KICAg
ICAgICAgICAgICAgIHBhbmljKCJObyBSQU0/PyIpOw0KICAgICAgICBhID0g
cGh5c19tZW0ucmVnaW9uc1swXS5hZGRyZXNzOyANCiAgICAgICAgaWYgKGEg
IT0gMCkNCiAgICAgICAgICAgICAgICBwYW5pYygiUkFNIGRvZXNuJ3Qgc3Rh
cnQgYXQgcGh5c2ljYWwgYWRkcmVzcyAwIik7DQogICAgICAgIGlmIChfX21h
eF9tZW1vcnkgPT0gMCB8fCBfX21heF9tZW1vcnkgPiByYW1fbGltaXQpDQog
ICAgICAgICAgICAgICAgX19tYXhfbWVtb3J5ID0gcmFtX2xpbWl0Ow0KKyAg
ICAgICANCisgICAgICAgcmVhbF9yYW0gPSBwaHlzX21lbS5yZWdpb25zWzBd
LnNpemU7DQorICAgICAgIA0KICAgICAgICBpZiAocGh5c19tZW0ucmVnaW9u
c1swXS5zaXplID49IF9fbWF4X21lbW9yeSkgew0KICAgICAgICAgICAgICAg
IHBoeXNfbWVtLnJlZ2lvbnNbMF0uc2l6ZSA9IF9fbWF4X21lbW9yeTsNCiAg
ICAgICAgICAgICAgICBwaHlzX21lbS5uX3JlZ2lvbnMgPSAxOyANCiAgICAg
ICAgfQ0KKyNpZmRlZiBDT05GSUdfSElHSE1FTSAvKiB0aWJpdCAqLw0KKyAg
ICAgICB0b3RhbCA9IHJlYWxfcmFtOw0KKyNlbHNlICAgICAgICAgICAgICAg
ICANCiAgICAgICAgdG90YWwgPSBwaHlzX21lbS5yZWdpb25zWzBdLnNpemU7
DQorI2VuZGlmIC8qIENPTkZJR19ISUdITUVNICovDQogICAgICAgIA0KICAg
ICAgICBpZiAocGh5c19tZW0ubl9yZWdpb25zID4gMSkgew0KICAgICAgICAg
ICAgICAgIHByaW50aygiUkFNIHN0YXJ0aW5nIGF0IDB4JXggaXMgbm90IGNv
bnRpZ3VvdXNcbiIsDQoNCg0K
---469140276-1387275527-968413832=:1436--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
