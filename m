Message-ID: <014101c24a16$e8f6cea0$db00000a@dejanj>
From: "Dejan Jovanovic" <dejanj@jaspur.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting Linux Kernel on a EST8260
Date: Thu, 22 Aug 2002 15:02:57 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to boot the Linux kernel on the EST8260 board.
Board has ppcboot-1.1.6 running.
The procedure I try to do is attached and is here as well.

Several questions.
1) what does message
"Warning: real time clock seems stuck!"
mean?

2) I was hoping that I have configured the bootargs corectly. But it seems that
something is wrong because of the messages
"
Looking up port of RPC 100003/2 on 10.0.0.245
portmap: server 10.0.0.245 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/2 on 10.0.0.245
portmap: server 10.0.0.245 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 10.0.0.245 not responding, timed out
"

I configured my nfs (/etc/exports file) like
"
/usr/src/ELDK/ppc_82xx    10.0.0.0/255.255.255.0(rw,no_root_squash,
no_all_squash)
"

nfs and portmap are running and DHCP is also running (I think)
"
/root>rpcinfo -p
  program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100011    1   udp    883  rquotad
    100011    2   udp    883  rquotad
    100005    1   udp   1039  mountd
    100005    1   tcp   1153  mountd
    100005    2   udp   1039  mountd
    100005    2   tcp   1153  mountd
    100005    3   udp   1039  mountd
    100005    3   tcp   1153  mountd
    100003    2   udp   2049  nfs

/root>ps -A |grep nfs
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd
    10892   pts/2 00:00:00 nfsd

/root>ps -A |grep dhcp
10566 ?  00:00:00 dhcpd
"

DHCP configuration file is as follows
subnet 10.0.0.0 netmask 255.255.255.0 {
 option routers  10.0.0.1;
   option subnet-mask 255.255.255.0;
 option domain-name "internal.jaspur.com";
 host trgt { hardware ethernet 00:A0:1E:A8:7B:CB;
   fixed-address   10.0.0.161;
   option root-path  "/usr/src/ELDK/ppc_82xx";
   option host-name  "trgt";
   next-server   10.0.0.245;
   filename   "/tftpboot/pImage";
 }
}

However what worries me is that there are no messages on my host machine when I
do the 'tcpdump'
Image I am trying to boot on the board is the image I compiled with the
following procedure:
'make mrproper'
'make est8260_config'
'make oldconfig'
'make dep'
'make pImage'

and I donwloaded this image as described bellow, as to say I did not change
anything in the configuration. This means that the NFS is configured in my
kernel and also BOOTP protocol for 'IP level autocofiguration'


Thanks in advance,
Cheers
Dejan


==========================================
PPCBoot 1.1.6 (Jul 24 2002 - 14:56:02)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 3x, VCO Div 2, 60x Bus Freq  33-100, Core Freq 100-300
 - dfbrg 0, corecnf 0x08, busdf 3, cpmdf 1, plldf 0, pllmf 1
 - vco_out  264000000, scc_clk   66000000, brg_clk   66000000
 - cpu_clk  198000000, cpm_clk  132000000, bus_clk   66000000

CPU:   MPC8260 (Rev 01, Mask A.1 1K22A-XC) at 198 MHz
Board: EST SBC8260
I2C:   ready
DRAM:  16 MB
FLASH:  4 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
=> tftpboot 200000 pImage
ARP broadcast 1
TFTP from server 10.0.0.245; our IP address is 10.0.0.161
Filename 'pImage'.
Load address: 0x200000
Loading: #################################################################
         #########################
done
Bytes transferred = 457136 (6f9b0 hex)
=> setenv bootargs root=/dev/nfs rw nfsroot=10.0.0.245:/usr/src/ELDK/ppc_82xx
ip=10.0.0.161:10.0.0.245:::trgt::off
=> bootm 200000
## Booting image at 00200000 ...
   Image Name:   Linux-2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    457072 Bytes = 446 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Total memory = 16MB; using 0kB for hash table (at 00000000)
Linux version 2.4.4 (root@jebac.internal.jaspur.com) (gcc version 2.95.3
20010111 (prerelease/franzo/20010111)) #1 Wed Au
g 14 17:17:49 CDT 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.245:/usr/src/ELDK/ppc_82xx
ip=10.0.0.161:10.0.0.245:::trgt::off
Warning: real time clock seems stuck!
Calibrating delay loop... 131.89 BogoMIPS
Memory: 14796k available (868k kernel code, 364k data, 48k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.02
ttyS0 on SMC1 at 0x0000, BRG7
ttyS1 on SMC2 at 0x0040, BRG8
ttyS2 on SCC1 at 0x8100, BRG1
ttyS3 on SCC2 at 0x8200, BRG2
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9744kB/3248kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: SCC ENET Version 0.1, 00:a0:1e:a8:7b:cb
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.0.0.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.245
portmap: server 10.0.0.245 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/2 on 10.0.0.245
portmap: server 10.0.0.245 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 10.0.0.245 not responding, timed out
Root-NFS: Server returned error -5 while mounting /usr/src/ELDK/ppc_82xx
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..
======================================================



begin 666 log.txt
M4%!#0F]O=" Q+C$N-B H2G5L(#(T(#(P,#(@+2 Q-#HU-CHP,BD-"@T*35!#
M.#(V,"!297-E="!3=&%T=7,Z($5X=&5R;F%L(%-O9G0L($5X=&5R;F%L($AA
M<F0-"@T*35!#.#(V,"!#;&]C:R!#;VYF:6=U<F%T:6]N#0H@+2!"=7,M=&\M
M0V]R92!-=6QT(#-X+"!60T\@1&EV(#(L(#8P>"!"=7,@1G)E<2 @,S,M,3 P
M+"!#;W)E($9R97$@,3 P+3,P, T*("T@9&9B<F<@,"P@8V]R96-N9B P># X
M+"!B=7-D9B S+"!C<&UD9B Q+"!P;&QD9B P+"!P;&QM9B Q#0H@+2!V8V]?
M;W5T(" R-C0P,# P,# L('-C8U]C;&L@(" V-C P,# P,"P@8G)G7V-L:R @
M(#8V,# P,# P#0H@+2!C<'5?8VQK(" Q.3@P,# P,# L(&-P;5]C;&L@(#$S
M,C P,# P,"P@8G5S7V-L:R @(#8V,# P,# P#0H-"D-053H@("!-4$,X,C8P
M("A2978@,#$L($UA<VL@02XQ(#%+,C)!+5A#*2!A=" Q.3@@34AZ#0I";V%R
M9#H@15-4(%-"0S@R-C -"DDR0SH@("!R96%D>0T*1%)!33H@(#$V($U"#0I&
M3$%32#H@(#0@34(-"DEN.B @("!S97)I86P-"D]U=#H@("!S97)I86P-"D5R
M<CH@("!S97)I86P-"DAI="!A;GD@:V5Y('1O('-T;W @875T;V)O;W0Z(" P
M#0H]/B!T9G1P8F]O=" R,# P,# @<$EM86=E#0I!4E @8G)O861C87-T(#$-
M"E1&5% @9G)O;2!S97)V97(@,3 N,"XP+C(T-3L@;W5R($E0(&%D9')E<W,@
M:7,@,3 N,"XP+C$V,0T*1FEL96YA;64@)W!);6%G92<N#0I,;V%D(&%D9')E
M<W,Z(#!X,C P,# P#0I,;V%D:6YG.B C(R,C(R,C(R,C(R,C(R,C(R,C(R,C
M(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(PT*
M(" @(" @(" @(R,C(R,C(R,C(R,C(R,C(R,C(R,C(R,C(PT*9&]N90T*0GET
M97,@=')A;G-F97)R960@/2 T-3<Q,S8@*#9F.6(P(&AE>"D-"CT^('-E=&5N
M=B!B;V]T87)G<R!R;V]T/2]D978O;F9S(')W(&YF<W)O;W0],3 N,"XP+C(T
M-3HO=7-R+W-R8R]%3$1++W!P8U\X,GAX(&EP/3$P+C N,"XQ-C$Z,3 N,"XP
M+C(T-3HZ.G1R9W0Z.F]F9@T*/3X@8F]O=&T@,C P,# P#0HC(R!";V]T:6YG
M(&EM86=E(&%T(# P,C P,# P("XN+@T*(" @26UA9V4@3F%M93H@("!,:6YU
M>"TR+C0N- T*(" @26UA9V4@5'EP93H@("!0;W=E<E!#($QI;G5X($ME<FYE
M;"!);6%G92 H9WII<"!C;VUP<F5S<V5D*0T*(" @1&%T82!3:7IE.B @(" T
M-3<P-S(@0GET97,@/2 T-#8@:T(@/2 P($U"#0H@("!,;V%D($%D9')E<W,Z
M(# P,# P,# P#0H@("!%;G1R>2!0;VEN=#H@(# P,# P,# P#0H@("!697)I
M9GEI;F<@0VAE8VMS=6T@+BXN($]+#0H@("!5;F-O;7!R97-S:6YG($ME<FYE
M;"!);6%G92 N+BX@3TL-"E1O=&%L(&UE;6]R>2 ](#$V34([('5S:6YG(#!K
M0B!F;W(@:&%S:"!T86)L92 H870@,# P,# P,# I#0I,:6YU>"!V97)S:6]N
M(#(N-"XT("AR;V]T0&IE8F%C+FEN=&5R;F%L+FIA<W!U<BYC;VTI("AG8V,@
M=F5R<VEO;B R+CDU+C,@,C P,3 Q,3$@*'!R97)E;&5A<V4O9G)A;GIO+S(P
M,#$P,3$Q*2D@(S$@5V5D($%U#0IG(#$T(#$W.C$W.C0Y($-$5" R,# R#0I/
M;B!N;V1E(# @=&]T86QP86=E<SH@-# Y-@T*>F]N92@P*3H@-# Y-B!P86=E
M<RX-"GIO;F4H,2DZ(# @<&%G97,N#0IZ;VYE*#(I.B P('!A9V5S+@T*2V5R
M;F5L(&-O;6UA;F0@;&EN93H@<F]O=#TO9&5V+VYF<R!R=R!N9G-R;V]T/3$P
M+C N,"XR-#4Z+W5S<B]S<F,O14Q$2R]P<&-?.#)X>"!I<#TQ,"XP+C N,38Q
M.C$P+C N,"XR-#4Z.CIT<F=T.CIO9F8-"E=A<FYI;F<Z(')E86P@=&EM92!C
M;&]C:R!S965M<R!S='5C:R$-"D-A;&EB<F%T:6YG(&1E;&%Y(&QO;W N+BX@
M,3,Q+C@Y($)O9V]-25!3#0I-96UO<GDZ(#$T-SDV:R!A=F%I;&%B;&4@*#@V
M.&L@:V5R;F5L(&-O9&4L(#,V-&L@9&%T82P@-#AK(&EN:70L(#!K(&AI9VAM
M96TI#0I$96YT<GDM8V%C:&4@:&%S:"!T86)L92!E;G1R:65S.B R,#0X("AO
M<F1E<CH@,BP@,38S.#0@8GET97,I#0I"=69F97(M8V%C:&4@:&%S:"!T86)L
M92!E;G1R:65S.B Q,#(T("AO<F1E<CH@,"P@-# Y-B!B>71E<RD-"E!A9V4M
M8V%C:&4@:&%S:"!T86)L92!E;G1R:65S.B T,#DV("AO<F1E<CH@,BP@,38S
M.#0@8GET97,I#0I);F]D92UC86-H92!H87-H('1A8FQE(&5N=')I97,Z(#$P
M,C0@*&]R9&5R.B Q+" X,3DR(&)Y=&5S*0T*4$]325@@8V]N9F]R;6%N8V4@
M=&5S=&EN9R!B>2!53DE&25@-"DQI;G5X($Y%5#0N,"!F;W(@3&EN=7@@,BXT
M#0I"87-E9"!U<&]N(%-W86YS96$@56YI=F5R<VET>2!#;VUP=71E<B!3;V-I
M971Y($Y%5#,N,#,Y#0I3=&%R=&EN9R!K<W=A<&0@=C$N. T*0U!-(%5!4E0@
M9')I=F5R('9E<G-I;VX@,"XP,@T*='1Y4S @;VX@4TU#,2!A=" P># P,# L
M($)21S<-"G1T>5,Q(&]N(%--0S(@870@,'@P,#0P+"!"4D<X#0IT='E3,B!O
M;B!30T,Q(&%T(#!X.#$P,"P@0E)',0T*='1Y4S,@;VX@4T-#,B!A=" P>#@R
M,# L($)21S(-"G!T>3H@,C4V(%5N:7@Y."!P='ES(&-O;F9I9W5R960-"F)L
M;V-K.B!Q=65U960@<V5C=&]R<R!M87@O;&]W(#DW-#1K0B\S,C0X:T(L(#8T
M('-L;W1S('!E<B!Q=65U90T*4D%-1$E32R!D<FEV97(@:6YI=&EA;&EZ960Z
M(#$V(%)!32!D:7-K<R!O9B T,#DV2R!S:7IE(#$P,C0@8FQO8VMS:7IE#0IE
M=&@P.B!30T,@14Y%5"!697)S:6]N(# N,2P@,# Z83 Z,64Z83@Z-V(Z8V(-
M"FQO;W Z(&QO861E9" H;6%X(#@@9&5V:6-E<RD-"DY%5#0Z($QI;G5X(%1#
M4"])4" Q+C @9F]R($Y%5#0N, T*25 @4')O=&]C;VQS.B!)0TU0+"!51% L
M(%1#4"P@24=-4 T*25 Z(')O=71I;F<@8V%C:&4@:&%S:"!T86)L92!O9B U
M,3(@8G5C:V5T<RP@-$MB>71E<PT*5$-0.B!(87-H('1A8FQE<R!C;VYF:6=U
M<F5D("AE<W1A8FQI<VAE9" Q,#(T(&)I;F0@,3 R-"D-"DE0+4-O;F9I9SH@
M1W5E<W-I;F<@;F5T;6%S:R R-34N,"XP+C -"DY%5#0Z(%5N:7@@9&]M86EN
M('-O8VME=',@,2XP+U--4"!F;W(@3&EN=7@@3D54-"XP+@T*3&]O:VEN9R!U
M<"!P;W)T(&]F(%)00R Q,# P,#,O,B!O;B Q,"XP+C N,C0U#0IP;W)T;6%P
M.B!S97)V97(@,3 N,"XP+C(T-2!N;W0@<F5S<&]N9&EN9RP@=&EM960@;W5T
M#0I2;V]T+4Y&4SH@56YA8FQE('1O(&=E="!N9G-D('!O<G0@;G5M8F5R(&9R
M;VT@<V5R=F5R+"!U<VEN9R!D969A=6QT#0I,;V]K:6YG('5P('!O<G0@;V8@
M4E!#(#$P,# P-2\R(&]N(#$P+C N,"XR-#4-"G!O<G1M87 Z('-E<G9E<B Q
M,"XP+C N,C0U(&YO="!R97-P;VYD:6YG+"!T:6UE9"!O=70-"E)O;W0M3D93
M.B!5;F%B;&4@=&\@9V5T(&UO=6YT9"!P;W)T(&YU;6)E<B!F<F]M('-E<G9E
M<BP@=7-I;F<@9&5F875L= T*;6]U;G0Z('-E<G9E<B Q,"XP+C N,C0U(&YO
M="!R97-P;VYD:6YG+"!T:6UE9"!O=70-"E)O;W0M3D93.B!397)V97(@<F5T
M=7)N960@97)R;W(@+34@=VAI;&4@;6]U;G1I;F<@+W5S<B]S<F,O14Q$2R]P
M<&-?.#)X> T*5D93.B!5;F%B;&4@=&\@;6]U;G0@<F]O="!F<R!V:6$@3D93
M+"!T<GEI;F<@9FQO<'!Y+@T*5D93.B!#86YN;W0@;W!E;B!R;V]T(&1E=FEC
M92 B;F9S(B!O<B P,CHP, T*4&QE87-E(&%P<&5N9"!A(&-O<G)E8W0@(G)O
M;W0](B!B;V]T(&]P=&EO;@T*2V5R;F5L('!A;FEC.B!61E,Z(%5N86)L92!T
M;R!M;W5N="!R;V]T(&9S(&]N(# R.C P#0I296)O;W1I;F<@:6X@,3@P('-E
'8V]N9',N+@``
`
end


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
