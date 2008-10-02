Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc2-s40.bay0.hotmail.com (bay0-omc2-s40.bay0.hotmail.com
	[65.54.246.176]) by ozlabs.org (Postfix) with ESMTP id 0169BDDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Oct 2008 08:08:51 +1000 (EST)
Message-ID: <BLU119-DAV7AAD14B29FCBD0AAF9C43BB3D0@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.2277.1222796203.3127.linuxppc-embedded@ozlabs.org>
Subject: Sharing SPI bus for SD card and other peripheral using MPC8313E
Date: Thu, 2 Oct 2008 15:03:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I found the the latest Linux BSP come with the latest eva board (CPU rev 
2.0) support SD card.
I try to use it to mount filesystem and it works fine.

I also have other 2 devices connected to SPI.

Normally I have a driver to access these 2 SPI devices as char device. But 
now using SD card as block device from the kernel, so I'm not sure how to 
access these 2 char devices. In addition, how to guarantte these no 
conflicts ?

Thanks,

Duy Kyng

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, September 30, 2008 10:36 AM
Subject: Linuxppc-embedded Digest, Vol 50, Issue 1


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. Re: FCC1 failing on large packet PINGS, while FCC2 is
>      successful (Scott Wood)
>   2. gpt frequency input/pwm driver for MPC512x (Matteo Fortini)
>   3. FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
>      (100005/1) (Remi Lefevre)
>   4. Re: FCC1 failing on large packet PINGS, while FCC2 is
>      successful (embedded)
>   5. Re: FCC1 failing on large packet PINGS, while FCC2 is
>      successful (Scott Wood)
>   6. Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
>      (100005/1) (Scott Wood)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 29 Sep 2008 09:43:13 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: FCC1 failing on large packet PINGS, while FCC2 is
> successful
> To: embedded <embedded@akb.net>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <48E0E981.60703@freescale.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> embedded wrote:
>> We've found a way to get ping to fail all of the time by increasing
>> the size of the ping messages.  When we use the max in Windows of
>> 65500, every ping to the first FCC1 Ethernet is dropped.  However,
>> when we ping with a size of 65500 to the second FCC2 Ethernet
>> everything is fine and all echos are successful.
>>
>> In windows:
>> ping -l 64000 172.24.100.11  -t
>>
>> It definitely seems to be a problem with the mpc, but I'm not sure
>> where to look.  Board? KErnel? boot loader?  The two Ethernet devices
>> should be configured identically, and looking through the kernel code,
>> it seems that there aren't any preferred treatment differences.  Could
>> the problem be in the bit-banging mdio control, or should I look
>> within fs_enet?  We've got this reproducing on all of our boards and
>> it could also reside in the board setup...
>>
>> Does anyone with experience on the ep8248 and/or mpc8272 family,
>> fs_enet-* code have any ideas where I should look next?
>
> It looks very similar to what I was seeing on ep8248 -- the first
> ethernet port would fail when attempting to receive back-to-back
> packets.  I didn't look into it too closely since I thought it was
> probably a board issue (I had only one, and the firmware never generated
> any traffic that resulted in back-to-back receives).
>
> I'd be very interested if you ever figure out what's wrong.
>
> -Scott
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 30 Sep 2008 13:12:54 +0200
> From: Matteo Fortini <m.fortini@selcomgroup.com>
> Subject: gpt frequency input/pwm driver for MPC512x
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <48E209B6.7070203@selcomgroup.com>
> Content-Type: text/plain; charset=ISO-8859-15; format=flowed
>
> We are developing a couple of gpt drivers (one for input capture and
> frequency measurement, one for pwm lcd backlight control) for an
> MPC512x, and we'd like to find the proper way of inserting it into the
> kernel.
>
> Currently, the frequency input driver is reserving a character device
> and registering as a platform device driver with the
> of_register_platform_driver() calls.
> The character device interface is given through the old-style cdev_t
> allocation and deallocation, but I see that maybe this kind of devices,
> which seems not to conform to any device type, should register as
> "miscdevice"s, is that correct? This would leave me with only 14 minor
> numbers free to be allocated. Moreover, there seems to be no way of
> getting to the device data when using miscdevice's file operations, so
> we would be on our own allocating more than one frequency input.
>
> Same for the backlight driver: I'd like to have a pmw driver, which I
> can register a new platform driver, but how do I "glue" it with the
> backlight driver? I'd prefer not to have direct pwm  register calls in
> the backlight driver, but I'd rather have the backlight driver call a
> generic pwm driver in order to do its job.
>
> Thanks,
> Matteo
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 30 Sep 2008 18:44:37 +0200
> From: "Remi Lefevre" <rlefevre@gmail.com>
> Subject: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
> (100005/1)
> To: linuxppc-embedded@ozlabs.org
> Message-ID:
> <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Hi,
>
> I use static IP config to boot Linux-2.6.27-rc7 denx from NFS on a MPC8270
> custom board. The first NFS RPC port lookup completes successfully:
>
> [    2.892607] Looking up port of RPC 100003/2 on 192.168.0.1
> ...
> [    5.308767] Root-NFS: Portmapper on server returned 2049 as nfsd port
>
> No fs_enet error is reported.
> But the second RPC port lookup fails with a fs_net error:
>
> [    5.315243] Looking up port of RPC 100005/1 on 192.168.0.1
> ...
> [    5.528022] RPC:     2 call_bind (status 0)
> [    5.532280] RPC:     2 call_connect xprt c7853400 is connected
> [    5.538185] RPC:     2 call_transmit (status 0)
> [    5.542767] RPC:     2 xprt_prepare_transmit
> [    5.547091] RPC:     2 rpc_xdr_encode (status 0)
> [    5.551757] RPC:     2 marshaling UNIX cred c78ed800
> [    5.556776] RPC:     2 using AUTH_UNIX cred c78ed800 to wrap rpc data
> [    5.563292] RPC:       rpcb_encode_mapping(100005, 1, 17, 0)
> [    5.569024] RPC:     2 xprt_transmit(80)
> [    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12
> [    5.577958] RPC:       xs_udp_send_request(80) = 80
> [    5.582809] RPC:     2 xmit complete
>
> On a side note, the upper layer does not seem to notice the error as it
> returns a "rpcbind: server not responding, timed out" error after a while,
> but the port lookup is never received by the server.
>
> At this moment (before the reboot after 180 seconds), ping requests also 
> lead
> to "FS_ENET ERROR(s) 0x12" but ARP requests are still answered correctly.
>
> I get the same behavior if I use FCC2 instead of FCC1.
>
> Any idea would be greatly appreciated.
>
> Best regards,
> R?mi
>
>
> Tcpdump:
> 1 0.000000    da:b0:4e:0f:0a:26     Broadcast             ARP      Who
> has 192.168.0.1?  Tell 192.168.0.42
> 2 0.000032    Giga-Byt_72:7c:b6     da:b0:4e:0f:0a:26     ARP
> 192.168.0.1 is at 00:20:ed:72:7c:b6
> 3 0.000209    192.168.0.42          192.168.0.1           Portmap  V2
> GETPORT Call (Reply In 4) NFS(100003) V:2 UDP
> 4 0.000467    192.168.0.1           192.168.0.42          Portmap  V2
> GETPORT Reply (Call In 3) Port:2049
>
> 5 4.996926    Giga-Byt_72:7c:b6     da:b0:4e:0f:0a:26     ARP      Who
> has 192.168.0.42?  Tell 192.168.0.1
> 6 4.997151    da:b0:4e:0f:0a:26     Giga-Byt_72:7c:b6     ARP
> 192.168.0.42 is at da:b0:4e:0f:0a:26
>
> 7 9.293063    192.168.0.1           192.168.0.42          ICMP
> Echo (ping) request
> 8 10.292965   192.168.0.1           192.168.0.42          ICMP
> Echo (ping) request
> 9 11.292976   192.168.0.1           192.168.0.42          ICMP
> Echo (ping) request
> [...other ping...]
> 12 20.394112   Giga-Byt_72:7c:b6     Broadcast             ARP
> Who has 192.168.0.42?  Tell 192.168.0.1
> 13 20.394337   da:b0:4e:0f:0a:26     Giga-Byt_72:7c:b6     ARP
> 192.168.0.42 is at da:b0:4e:0f:0a:26
>
> Boot:
> [    0.000000] Linux version 2.6.27-rc7 (gcc version 4.2.2) #3 Tue Sep
> 30 17:30:39 CEST 2008
> ...
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000000 -> 0x00008000
> [    0.000000]   Normal   0x00008000 -> 0x00008000
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x00008000
> [    0.000000] paging_init done
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 32512
> [    0.000000] Kernel command line: root=/dev/nfs rw
> nfsroot=192.168.0.1:/opt/eldk-4.2/ppc_6xx
> ip=192.168.0.42:192.168.0.1:192.168.0.1:255.255.255.0:dmyx:eth0:off
> console=ttyCPM0,115200n8
> [    0.000000] IP-Config: Parameter #0: `192.168.0.42'
> [    0.000000] IP-Config: Parameter #1: `192.168.0.1'
> [    0.000000] IP-Config: Parameter #2: `192.168.0.1'
> [    0.000000] IP-Config: Parameter #3: `255.255.255.0'
> [    0.000000] IP-Config: Parameter #4: `dmyx'
> [    0.000000] IP-Config: Parameter #5: `eth0'
> [    0.000000] IP-Config: Parameter #6: `off'
> [    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
> [    0.000000] clocksource: timebase mult[c0e6b75] shift[22] registered
> [    0.000392] console [ttyCPM0] enabled
> [    0.189357] Dentry cache hash table entries: 16384 (order: 4, 65536 
> bytes)
> [    0.197491] Inode-cache hash table entries: 8192 (order: 3, 32768 
> bytes)
> [    0.232601] Memory: 127044k/131072k available (2508k kernel code,
> 3884k reserved, 92k data, 119k bss, 144k init)
> [    0.243001] SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0,
> CPUs=1, Nodes=1
> [    0.250648] Calibrating delay loop... 41.34 BogoMIPS (lpj=82688)
> [    0.333226] Mount-cache hash table entries: 512
> [    0.342369] net_namespace: 288 bytes
> [    0.346805] NET: Registered protocol family 16
> [    0.382394] NET: Registered protocol family 2
> [    0.419811] IP route cache hash table entries: 1024 (order: 0, 4096 
> bytes)
> [    0.428192] TCP established hash table entries: 4096 (order: 3, 32768 
> bytes)
> [    0.435713] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.442368] TCP: Hash tables configured (established 4096 bind 4096)
> [    0.448703] TCP reno registered
> [    0.463908] NET: Registered protocol family 1
> [    0.522188] RPC:       creating workqueue nfsiod
> [    0.530731] RPC:       registering /proc/net/rpc
> [    0.535382] RPC:       registering /proc/net/rpc/nfs
> [    0.540622] JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
> [    0.550555] msgmni has been set to 248
> [    0.554665] io scheduler noop registered
> [    0.558480] io scheduler anticipatory registered (default)
> [    0.564036] io scheduler deadline registered
> [    0.568701] io scheduler cfq registered
> [    1.199635] ttyCPM0 at MMIO 0xc905ca90 (irq = 16) is a CPM UART
> [    1.231991] brd: module loaded
> [    1.247199] loop: module loaded
> [    1.254228] eth0: fs_enet: da:b0:4e:0f:0a:26
> [    1.261053] eth1: fs_enet: b6:e1:11:b2:0b:22
> [    1.269971] CPM2 Bitbanged MII: probed
> [    1.276396] i2c /dev entries driver
> [    1.285576] TCP cubic registered
> [    1.288787] NET: Registered protocol family 17
> [    1.294319] RPC:       creating workqueue rpciod
> [    1.299932] RPC:       registering /proc/net/rpc
> [    1.304679] svc: Adding svc transport class 'tcp'
> [    1.309280] svc: Adding svc transport class 'udp'
> [    1.314193] RPC: Registered udp transport module.
> [    1.318798] RPC: Registered tcp transport module.
> [    1.327533] IP-Config: Entered.
> [    1.832825] IP-Config: eth0 UP (able=1, xid=de9a95b6)
> [    2.839908] IP-Config: Complete:
> [    2.842777]      device=eth0, addr=192.168.0.42,
> mask=255.255.255.0, gw=192.168.0.1,
> [    2.850513]      host=dmyx, domain=, nis-domain=(none),
> [    2.855885]      bootserver=192.168.0.1, rootserver=192.168.0.1, 
> rootpath=
> [    2.863596] Root-NFS: Mounting /opt/eldk-4.2/ppc_6xx on server
> 192.168.0.1 as root
> [    2.871169] Root-NFS:     rsize = 4096, wsize = 4096, timeo = 0, 
> retrans = 0
> [    2.878320] Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = 
> (30,60)
> [    2.885552] Root-NFS:     nfsd port = -1, mountd port = 0, flags = 
> 00000200
> [    2.892607] Looking up port of RPC 100003/2 on 192.168.0.1
> [    2.898164] RPC:       rpcb_getport_sync(192.168.0.1, 100003, 2, 17)
> [    2.904746] RPC:       set up transport to address addr=192.168.0.1
> port=111 proto=udp
> [    2.912641] RPC:       created transport c7853400 with 16 slots
> [    2.918616] RPC:       creating rpcbind client for 192.168.0.1
> (xprt c7853400)
> ...
> [    2.892607] Looking up port of RPC 100003/2 on 192.168.0.1
> ...
> (exactly identical to next request except the port number and no fs_enet 
> error)
> ...
> [    5.308767] Root-NFS: Portmapper on server returned 2049 as nfsd port
> [    5.315243] Looking up port of RPC 100005/1 on 192.168.0.1
> [    5.320808] RPC:       rpcb_getport_sync(192.168.0.1, 100005, 1, 17)
> [    5.327404] RPC:       set up transport to address addr=192.168.0.1
> port=111 proto=udp
> [    5.335305] RPC:       created transport c7853400 with 16 slots
> [    5.341283] RPC:       creating rpcbind client for 192.168.0.1
> (xprt c7853400)
> [    5.348608] RPC:       creating UNIX authenticator for client c7895200
> [    5.355213] RPC:     0 looking up UNIX cred
> [    5.359459] RPC:       looking up UNIX cred
> [    5.363677] RPC:       allocating UNIX cred for uid 0 gid 0
> [    5.369325] RPC:       new task initialized, procpid 1
> [    5.374494] RPC:       allocated task c783c500
> [    5.379020] RPC:     2 __rpc_execute flags=0x280
> [    5.383684] RPC:     2 call_start rpcbind2 proc GETPORT (sync)
> [    5.389608] RPC:     2 call_reserve (status 0)
> [    5.394078] RPC:     2 reserved req c780b000 xid cc0a6feb
> [    5.399573] RPC:     2 call_reserveresult (status 0)
> [    5.404599] RPC:     2 call_allocate (status 0)
> [    5.409186] RPC:     2 allocated buffer of size 412 at c7983000
> [    5.415178] RPC:     2 call_bind (status 0)
> [    5.419388] RPC:     2 call_connect xprt c7853400 is not connected
> [    5.425679] RPC:     2 xprt_connect xprt c7853400 is not connected
> [    5.431937] RPC:     2 xprt_cwnd_limited cong = 0 cwnd = 256
> [    5.437670] RPC:     2 sleep_on(queue "xprt_pending" time 4294893603)
> [    5.444190] RPC:     2 added to queue c7853588 "xprt_pending"
> [    5.449939] RPC:     2 setting alarm for 5000 ms
> [    5.454675] RPC:       xs_connect scheduled xprt c7853400
> [    5.460155] RPC:     2 sync task going to sleep
> [    5.464810] RPC:       disconnected transport c7853400
> [    5.469949] RPC:     2 __rpc_wake_up_task (now 4294893611)
> [    5.475485] RPC:     2 disabling timer
> [    5.479202] RPC:     2 removed from queue c7853588 "xprt_pending"
> [    5.485458] RPC:       __rpc_wake_up_task done
> [    5.489926] RPC:       unx_free_cred c78edd00
> [    5.494450] RPC:       xs_bind4 0.0.0.0:0: ok (0)
> [    5.499138] RPC:       worker connecting xprt c7853400 to address:
> addr=192.168.0.1 port=111 proto=udp
> [    5.508664] RPC:     2 sync task resuming
> [    5.512595] RPC:     2 xprt_connect_status: connection broken
> [    5.518409] RPC:     2 call_connect_status (status -107)
> [    5.523794] RPC:     2 call_timeout (minor)
> [    5.528022] RPC:     2 call_bind (status 0)
> [    5.532280] RPC:     2 call_connect xprt c7853400 is connected
> [    5.538185] RPC:     2 call_transmit (status 0)
> [    5.542767] RPC:     2 xprt_prepare_transmit
> [    5.547091] RPC:     2 rpc_xdr_encode (status 0)
> [    5.551757] RPC:     2 marshaling UNIX cred c78ed800
> [    5.556776] RPC:     2 using AUTH_UNIX cred c78ed800 to wrap rpc data
> [    5.563292] RPC:       rpcb_encode_mapping(100005, 1, 17, 0)
> [    5.569024] RPC:     2 xprt_transmit(80)
> [    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12
> [    5.577958] RPC:       xs_udp_send_request(80) = 80
> [    5.582809] RPC:     2 xmit complete
> [    5.586425] RPC:     2 sleep_on(queue "xprt_pending" time 4294893640)
> [    5.592951] RPC:     2 added to queue c7853588 "xprt_pending"
> [    5.598754] RPC:     2 setting alarm for 10000 ms
> [    5.603537] RPC:     2 sync task going to sleep
> ... (other retries)
> [   35.795325] rpcbind: server 192.168.0.1 not responding, timed out
> [   35.881159] Root-NFS: Unable to get mountd port number from server,
> using default
> [   35.888727] Root-NFS: mountd port is 627
> [   35.892664] NFS: sending MNT request for server:/opt/eldk-4.2/ppc_6xx
> [   66.422513] NFS: failed to create RPC client, status=-5
> [   66.427765] Root-NFS: Server returned error -5 while mounting
> /opt/eldk-4.2/ppc_6xx
> [   66.435693] VFS: Unable to mount root fs via NFS, trying floppy.
> [   66.442262] VFS: Cannot open root device "nfs" or unknown-block(2,0)
> [   66.448655] Please append a correct "root=" boot option; here are
> the available partitions:
> [   66.457179] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(2,0)
> [   66.465454] Rebooting in 180 seconds..
>
> DTS soc parts:
>    soc@f0000000 {
>        #address-cells = <1>;
>        #size-cells = <1>;
>        device_type = "soc";
>        compatible = "fsl,mpc8280", "fsl,pq2-soc", "simple-bus";
>        ranges = <0x00000000 0xf0000000 0x00053000>;
>
>        // Temporary -- will go away once kernel uses ranges for 
> get_immrbase().
>        reg = <0xf0000000 0x00053000>;
>
>        cpm@119c0 {
>            #address-cells = <1>;
>            #size-cells = <1>;
>            #interrupt-cells = <2>;
>            compatible = "fsl,mpc8280-cpm", "fsl,cpm2", "simple-bus";
>            reg = <0x119c0 0x30>;
>            ranges;
>            clock-frequency = <290304000>;
>
>            muram@0 {
>                #address-cells = <1>;
>                #size-cells = <1>;
>                ranges = <0 0 0x10000>;
>
>                data@0 {
>                    compatible = "fsl,cpm-muram-data";
>                    reg = <0x0 0x2000 0x9800 0x800>;
>                };
>            };
>
>            brg@119f0 {
>                compatible = "fsl,mpc8280-brg", "fsl,cpm2-brg";
>                reg = <0x119f0 0x10 0x115f0 0x10>;
>                /*clock-frequency = <36288000>;  Do I need this ? */
>            };
> ...
>            fcc1: ethernet@11300 {
>                device_type = "network";
>                compatible = "fsl,mpc8280-fcc-enet",
>                             "fsl,cpm2-fcc-enet";
>                reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
>                interrupts = <32 8>;
>                interrupt-parent = <&PIC>;
>                phy-handle = <&PHY1>;
>                linux,network-index = <0>;
>                fsl,cpm-command = <0x12000300>;
>            };
> ...
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 30 Sep 2008 10:46:05 -0600
> From: embedded <embedded@akb.net>
> Subject: Re: FCC1 failing on large packet PINGS, while FCC2 is
> successful
> To: "Scott Wood" <scottwood@freescale.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID:
> <bfa0697f0809300946m3509f8b6r9720f38dde3e2ce1@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Actually, it may have been a simple fix.  Looking at the clocks. We
> noticed something a little awry;  Just rechecking the RM and the code
> we found that within ep8248.c, the clock setup code had the RX and TX
> clocks flipped.
>
> FCC1 RX CLK should be Clock 10
> FCC1 TX CLK should be Clock 11
>
> in: arch/powerpc/platforms/82xx/ep8248.c
> static void __init init_ioports(void)
>
> - cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
> - cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
>
> + cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_RX);
> + cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_TX);
>
> -Alan
>
>
> On Mon, Sep 29, 2008 at 8:43 AM, Scott Wood <scottwood@freescale.com> 
> wrote:
>> embedded wrote:
>>>
>>> We've found a way to get ping to fail all of the time by increasing
>>> the size of the ping messages.  When we use the max in Windows of
>>> 65500, every ping to the first FCC1 Ethernet is dropped.  However,
>>> when we ping with a size of 65500 to the second FCC2 Ethernet
>>> everything is fine and all echos are successful.
>>>
>>> In windows:
>>> ping -l 64000 172.24.100.11  -t
>>>
>>> It definitely seems to be a problem with the mpc, but I'm not sure
>>> where to look.  Board? KErnel? boot loader?  The two Ethernet devices
>>> should be configured identically, and looking through the kernel code,
>>> it seems that there aren't any preferred treatment differences.  Could
>>> the problem be in the bit-banging mdio control, or should I look
>>> within fs_enet?  We've got this reproducing on all of our boards and
>>> it could also reside in the board setup...
>>>
>>> Does anyone with experience on the ep8248 and/or mpc8272 family,
>>> fs_enet-* code have any ideas where I should look next?
>>
>> It looks very similar to what I was seeing on ep8248 -- the first 
>> ethernet
>> port would fail when attempting to receive back-to-back packets.  I 
>> didn't
>> look into it too closely since I thought it was probably a board issue (I
>> had only one, and the firmware never generated any traffic that resulted 
>> in
>> back-to-back receives).
>>
>> I'd be very interested if you ever figure out what's wrong.
>>
>> -Scott
>>
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 30 Sep 2008 11:49:33 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: FCC1 failing on large packet PINGS, while FCC2 is
> successful
> To: embedded <embedded@akb.net>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <48E2589D.8090406@freescale.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> embedded wrote:
>> Actually, it may have been a simple fix.  Looking at the clocks. We
>> noticed something a little awry;  Just rechecking the RM and the code
>> we found that within ep8248.c, the clock setup code had the RX and TX
>> clocks flipped.
>>
>> FCC1 RX CLK should be Clock 10
>> FCC1 TX CLK should be Clock 11
>
> D'oh!  Thanks for finding that.
>
>> in: arch/powerpc/platforms/82xx/ep8248.c
>> static void __init init_ioports(void)
>>
>> - cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
>> - cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
>>
>> + cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_RX);
>> + cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_TX);
>
> Acked-by: Scott Wood <scottwood@freescale.com>
>
> Post to linuxppc-dev@ozlabs.org and galak@kernel.crashing.org with a
> Signed-off-by.
>
> -Scott
>
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 30 Sep 2008 12:33:51 -0500
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup
> (100005/1)
> To: Remi Lefevre <rlefevre@gmail.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <48E262FF.9020108@freescale.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> Remi Lefevre wrote:
>> [    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12
>
> This is a transmit error; more detail can be found in the buffer 
> descriptor.
>
> Check your pin and clock configuration.
>
> -Scott
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 50, Issue 1
> ************************************************
> 
