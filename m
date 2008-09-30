Return-Path: <rlefevre@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 39C46DE283
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Oct 2008 02:44:39 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so117984wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Sep 2008 09:44:38 -0700 (PDT)
Message-ID: <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>
Date: Tue, 30 Sep 2008 18:44:37 +0200
From: "Remi Lefevre" <rlefevre@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup (100005/1)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I use static IP config to boot Linux-2.6.27-rc7 denx from NFS on a MPC8270
custom board. The first NFS RPC port lookup completes successfully:

[    2.892607] Looking up port of RPC 100003/2 on 192.168.0.1
...
[    5.308767] Root-NFS: Portmapper on server returned 2049 as nfsd port

No fs_enet error is reported.
But the second RPC port lookup fails with a fs_net error:

[    5.315243] Looking up port of RPC 100005/1 on 192.168.0.1
...
[    5.528022] RPC:     2 call_bind (status 0)
[    5.532280] RPC:     2 call_connect xprt c7853400 is connected
[    5.538185] RPC:     2 call_transmit (status 0)
[    5.542767] RPC:     2 xprt_prepare_transmit
[    5.547091] RPC:     2 rpc_xdr_encode (status 0)
[    5.551757] RPC:     2 marshaling UNIX cred c78ed800
[    5.556776] RPC:     2 using AUTH_UNIX cred c78ed800 to wrap rpc data
[    5.563292] RPC:       rpcb_encode_mapping(100005, 1, 17, 0)
[    5.569024] RPC:     2 xprt_transmit(80)
[    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12
[    5.577958] RPC:       xs_udp_send_request(80) =3D 80
[    5.582809] RPC:     2 xmit complete

On a side note, the upper layer does not seem to notice the error as it
returns a "rpcbind: server not responding, timed out" error after a while,
but the port lookup is never received by the server.

At this moment (before the reboot after 180 seconds), ping requests also le=
ad
to "FS_ENET ERROR(s) 0x12" but ARP requests are still answered correctly.

I get the same behavior if I use FCC2 instead of FCC1.

Any idea would be greatly appreciated.

Best regards,
R=E9mi


Tcpdump:
1 0.000000    da:b0:4e:0f:0a:26     Broadcast             ARP      Who
has 192.168.0.1?  Tell 192.168.0.42
2 0.000032    Giga-Byt_72:7c:b6     da:b0:4e:0f:0a:26     ARP
192.168.0.1 is at 00:20:ed:72:7c:b6
3 0.000209    192.168.0.42          192.168.0.1           Portmap  V2
GETPORT Call (Reply In 4) NFS(100003) V:2 UDP
4 0.000467    192.168.0.1           192.168.0.42          Portmap  V2
GETPORT Reply (Call In 3) Port:2049

5 4.996926    Giga-Byt_72:7c:b6     da:b0:4e:0f:0a:26     ARP      Who
has 192.168.0.42?  Tell 192.168.0.1
6 4.997151    da:b0:4e:0f:0a:26     Giga-Byt_72:7c:b6     ARP
192.168.0.42 is at da:b0:4e:0f:0a:26

7 9.293063    192.168.0.1           192.168.0.42          ICMP
Echo (ping) request
8 10.292965   192.168.0.1           192.168.0.42          ICMP
Echo (ping) request
9 11.292976   192.168.0.1           192.168.0.42          ICMP
Echo (ping) request
[...other ping...]
12 20.394112   Giga-Byt_72:7c:b6     Broadcast             ARP
Who has 192.168.0.42?  Tell 192.168.0.1
13 20.394337   da:b0:4e:0f:0a:26     Giga-Byt_72:7c:b6     ARP
192.168.0.42 is at da:b0:4e:0f:0a:26

Boot:
[    0.000000] Linux version 2.6.27-rc7 (gcc version 4.2.2) #3 Tue Sep
30 17:30:39 CEST 2008
...
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00008000
[    0.000000]   Normal   0x00008000 -> 0x00008000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00008000
[    0.000000] paging_init done
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32512
[    0.000000] Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.0.1:/opt/eldk-4.2/ppc_6xx
ip=3D192.168.0.42:192.168.0.1:192.168.0.1:255.255.255.0:dmyx:eth0:off
console=3DttyCPM0,115200n8
[    0.000000] IP-Config: Parameter #0: `192.168.0.42'
[    0.000000] IP-Config: Parameter #1: `192.168.0.1'
[    0.000000] IP-Config: Parameter #2: `192.168.0.1'
[    0.000000] IP-Config: Parameter #3: `255.255.255.0'
[    0.000000] IP-Config: Parameter #4: `dmyx'
[    0.000000] IP-Config: Parameter #5: `eth0'
[    0.000000] IP-Config: Parameter #6: `off'
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000000] clocksource: timebase mult[c0e6b75] shift[22] registered
[    0.000392] console [ttyCPM0] enabled
[    0.189357] Dentry cache hash table entries: 16384 (order: 4, 65536 byte=
s)
[    0.197491] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.232601] Memory: 127044k/131072k available (2508k kernel code,
3884k reserved, 92k data, 119k bss, 144k init)
[    0.243001] SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0,
CPUs=3D1, Nodes=3D1
[    0.250648] Calibrating delay loop... 41.34 BogoMIPS (lpj=3D82688)
[    0.333226] Mount-cache hash table entries: 512
[    0.342369] net_namespace: 288 bytes
[    0.346805] NET: Registered protocol family 16
[    0.382394] NET: Registered protocol family 2
[    0.419811] IP route cache hash table entries: 1024 (order: 0, 4096 byte=
s)
[    0.428192] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)
[    0.435713] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.442368] TCP: Hash tables configured (established 4096 bind 4096)
[    0.448703] TCP reno registered
[    0.463908] NET: Registered protocol family 1
[    0.522188] RPC:       creating workqueue nfsiod
[    0.530731] RPC:       registering /proc/net/rpc
[    0.535382] RPC:       registering /proc/net/rpc/nfs
[    0.540622] JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
[    0.550555] msgmni has been set to 248
[    0.554665] io scheduler noop registered
[    0.558480] io scheduler anticipatory registered (default)
[    0.564036] io scheduler deadline registered
[    0.568701] io scheduler cfq registered
[    1.199635] ttyCPM0 at MMIO 0xc905ca90 (irq =3D 16) is a CPM UART
[    1.231991] brd: module loaded
[    1.247199] loop: module loaded
[    1.254228] eth0: fs_enet: da:b0:4e:0f:0a:26
[    1.261053] eth1: fs_enet: b6:e1:11:b2:0b:22
[    1.269971] CPM2 Bitbanged MII: probed
[    1.276396] i2c /dev entries driver
[    1.285576] TCP cubic registered
[    1.288787] NET: Registered protocol family 17
[    1.294319] RPC:       creating workqueue rpciod
[    1.299932] RPC:       registering /proc/net/rpc
[    1.304679] svc: Adding svc transport class 'tcp'
[    1.309280] svc: Adding svc transport class 'udp'
[    1.314193] RPC: Registered udp transport module.
[    1.318798] RPC: Registered tcp transport module.
[    1.327533] IP-Config: Entered.
[    1.832825] IP-Config: eth0 UP (able=3D1, xid=3Dde9a95b6)
[    2.839908] IP-Config: Complete:
[    2.842777]      device=3Deth0, addr=3D192.168.0.42,
mask=3D255.255.255.0, gw=3D192.168.0.1,
[    2.850513]      host=3Ddmyx, domain=3D, nis-domain=3D(none),
[    2.855885]      bootserver=3D192.168.0.1, rootserver=3D192.168.0.1, roo=
tpath=3D
[    2.863596] Root-NFS: Mounting /opt/eldk-4.2/ppc_6xx on server
192.168.0.1 as root
[    2.871169] Root-NFS:     rsize =3D 4096, wsize =3D 4096, timeo =3D 0, r=
etrans =3D 0
[    2.878320] Root-NFS:     acreg (min,max) =3D (3,60), acdir (min,max) =
=3D (30,60)
[    2.885552] Root-NFS:     nfsd port =3D -1, mountd port =3D 0, flags =3D=
 00000200
[    2.892607] Looking up port of RPC 100003/2 on 192.168.0.1
[    2.898164] RPC:       rpcb_getport_sync(192.168.0.1, 100003, 2, 17)
[    2.904746] RPC:       set up transport to address addr=3D192.168.0.1
port=3D111 proto=3Dudp
[    2.912641] RPC:       created transport c7853400 with 16 slots
[    2.918616] RPC:       creating rpcbind client for 192.168.0.1
(xprt c7853400)
...
[    2.892607] Looking up port of RPC 100003/2 on 192.168.0.1
...
(exactly identical to next request except the port number and no fs_enet er=
ror)
...
[    5.308767] Root-NFS: Portmapper on server returned 2049 as nfsd port
[    5.315243] Looking up port of RPC 100005/1 on 192.168.0.1
[    5.320808] RPC:       rpcb_getport_sync(192.168.0.1, 100005, 1, 17)
[    5.327404] RPC:       set up transport to address addr=3D192.168.0.1
port=3D111 proto=3Dudp
[    5.335305] RPC:       created transport c7853400 with 16 slots
[    5.341283] RPC:       creating rpcbind client for 192.168.0.1
(xprt c7853400)
[    5.348608] RPC:       creating UNIX authenticator for client c7895200
[    5.355213] RPC:     0 looking up UNIX cred
[    5.359459] RPC:       looking up UNIX cred
[    5.363677] RPC:       allocating UNIX cred for uid 0 gid 0
[    5.369325] RPC:       new task initialized, procpid 1
[    5.374494] RPC:       allocated task c783c500
[    5.379020] RPC:     2 __rpc_execute flags=3D0x280
[    5.383684] RPC:     2 call_start rpcbind2 proc GETPORT (sync)
[    5.389608] RPC:     2 call_reserve (status 0)
[    5.394078] RPC:     2 reserved req c780b000 xid cc0a6feb
[    5.399573] RPC:     2 call_reserveresult (status 0)
[    5.404599] RPC:     2 call_allocate (status 0)
[    5.409186] RPC:     2 allocated buffer of size 412 at c7983000
[    5.415178] RPC:     2 call_bind (status 0)
[    5.419388] RPC:     2 call_connect xprt c7853400 is not connected
[    5.425679] RPC:     2 xprt_connect xprt c7853400 is not connected
[    5.431937] RPC:     2 xprt_cwnd_limited cong =3D 0 cwnd =3D 256
[    5.437670] RPC:     2 sleep_on(queue "xprt_pending" time 4294893603)
[    5.444190] RPC:     2 added to queue c7853588 "xprt_pending"
[    5.449939] RPC:     2 setting alarm for 5000 ms
[    5.454675] RPC:       xs_connect scheduled xprt c7853400
[    5.460155] RPC:     2 sync task going to sleep
[    5.464810] RPC:       disconnected transport c7853400
[    5.469949] RPC:     2 __rpc_wake_up_task (now 4294893611)
[    5.475485] RPC:     2 disabling timer
[    5.479202] RPC:     2 removed from queue c7853588 "xprt_pending"
[    5.485458] RPC:       __rpc_wake_up_task done
[    5.489926] RPC:       unx_free_cred c78edd00
[    5.494450] RPC:       xs_bind4 0.0.0.0:0: ok (0)
[    5.499138] RPC:       worker connecting xprt c7853400 to address:
addr=3D192.168.0.1 port=3D111 proto=3Dudp
[    5.508664] RPC:     2 sync task resuming
[    5.512595] RPC:     2 xprt_connect_status: connection broken
[    5.518409] RPC:     2 call_connect_status (status -107)
[    5.523794] RPC:     2 call_timeout (minor)
[    5.528022] RPC:     2 call_bind (status 0)
[    5.532280] RPC:     2 call_connect xprt c7853400 is connected
[    5.538185] RPC:     2 call_transmit (status 0)
[    5.542767] RPC:     2 xprt_prepare_transmit
[    5.547091] RPC:     2 rpc_xdr_encode (status 0)
[    5.551757] RPC:     2 marshaling UNIX cred c78ed800
[    5.556776] RPC:     2 using AUTH_UNIX cred c78ed800 to wrap rpc data
[    5.563292] RPC:       rpcb_encode_mapping(100005, 1, 17, 0)
[    5.569024] RPC:     2 xprt_transmit(80)
[    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12
[    5.577958] RPC:       xs_udp_send_request(80) =3D 80
[    5.582809] RPC:     2 xmit complete
[    5.586425] RPC:     2 sleep_on(queue "xprt_pending" time 4294893640)
[    5.592951] RPC:     2 added to queue c7853588 "xprt_pending"
[    5.598754] RPC:     2 setting alarm for 10000 ms
[    5.603537] RPC:     2 sync task going to sleep
... (other retries)
[   35.795325] rpcbind: server 192.168.0.1 not responding, timed out
[   35.881159] Root-NFS: Unable to get mountd port number from server,
using default
[   35.888727] Root-NFS: mountd port is 627
[   35.892664] NFS: sending MNT request for server:/opt/eldk-4.2/ppc_6xx
[   66.422513] NFS: failed to create RPC client, status=3D-5
[   66.427765] Root-NFS: Server returned error -5 while mounting
/opt/eldk-4.2/ppc_6xx
[   66.435693] VFS: Unable to mount root fs via NFS, trying floppy.
[   66.442262] VFS: Cannot open root device "nfs" or unknown-block(2,0)
[   66.448655] Please append a correct "root=3D" boot option; here are
the available partitions:
[   66.457179] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(2,0)
[   66.465454] Rebooting in 180 seconds..

DTS soc parts:
    soc@f0000000 {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        device_type =3D "soc";
        compatible =3D "fsl,mpc8280", "fsl,pq2-soc", "simple-bus";
        ranges =3D <0x00000000 0xf0000000 0x00053000>;

        // Temporary -- will go away once kernel uses ranges for get_immrba=
se().
        reg =3D <0xf0000000 0x00053000>;

        cpm@119c0 {
            #address-cells =3D <1>;
            #size-cells =3D <1>;
            #interrupt-cells =3D <2>;
            compatible =3D "fsl,mpc8280-cpm", "fsl,cpm2", "simple-bus";
            reg =3D <0x119c0 0x30>;
            ranges;
            clock-frequency =3D <290304000>;

            muram@0 {
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <0 0 0x10000>;

                data@0 {
                    compatible =3D "fsl,cpm-muram-data";
                    reg =3D <0x0 0x2000 0x9800 0x800>;
                };
            };

            brg@119f0 {
                compatible =3D "fsl,mpc8280-brg", "fsl,cpm2-brg";
                reg =3D <0x119f0 0x10 0x115f0 0x10>;
                /*clock-frequency =3D <36288000>;  Do I need this ? */
            };
...
            fcc1: ethernet@11300 {
                device_type =3D "network";
                compatible =3D "fsl,mpc8280-fcc-enet",
                             "fsl,cpm2-fcc-enet";
                reg =3D <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
                interrupts =3D <32 8>;
                interrupt-parent =3D <&PIC>;
                phy-handle =3D <&PHY1>;
                linux,network-index =3D <0>;
                fsl,cpm-command =3D <0x12000300>;
            };
...
