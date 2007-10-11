Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id CE6E9DE086
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 02:18:50 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so478069nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Oct 2007 09:18:49 -0700 (PDT)
Message-ID: <fa686aa40710110918n5e94c42ap320bca423e976c3d@mail.gmail.com>
Date: Thu, 11 Oct 2007 10:18:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: keng_629 <keng_629@126.com>
Subject: Re: mpc860T linux2.6.23 boot problem
In-Reply-To: <200710112331564685179@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200710112331564685179@126.com>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/11/07, keng_629 <keng_629@126.com> wrote:
>
>
> i have ported linux2.6.23 to mpc860t board use cpm smc1 as serial port.
> when i boot my kernel with ramdisk i find it stop after print"Loading
> Ramdisk to 07e20000, end 07fa4100 ... OK"
> i paste the logbuf as follow(include some test info),bootargs=/dev/ram rw.
> if i set the bootargs=console=ttyCPM0,9600 root=/dev/ram rw my kernel stop
> at the console setup period.

You do need to have the 'console=ttyCPM0..." line.  The system is
booting, so you are most of the way there.  The next step is to find
out *where* it is failing and try to get a backtrace.  If you've got a
debugger you can try halting the processor to see where the PC is
stuck.  That will tell you if you are stuck on a infinite loop
somewhere, or if the CPM driver is causing an oops.  (Look in
System.map for executable code addresses)

Cheers,
g.

> NDSC860: md 17e13c
> 0017e13c: 3c353e4c 696e7578 20766572 73696f6e    <5>Linux version
> 0017e14c: 20322e36 2e32332d 72633220 28726f6f     2.6.23-rc2 (roo
> 0017e15c: 74406368 656e7375 6b656e67 29202867    t@chensukeng) (g
> 0017e16c: 63632076 65727369 6f6e2034 2e302e30    cc version 4.0.0
> 0017e17c: 20284445 4e582045 4c444b20 342e3120     (DENX ELDK 4.1
> 0017e18c: 342e302e 30292920 23332054 6875204f    4.0.0)) #3 Thu O
> 0017e19c: 63742031 31203137 3a32333a 32312043    ct 11 17:23:21 C
> 0017e1ac: 53542032 3030370a 3c373e45 6e746572    ST 2007.<7>Enter
> 0017e1bc: 696e6720 6164645f 61637469 76655f72    ing add_active_r
> 0017e1cc: 616e6765 28302c20 302c2033 32373638    ange(0, 0, 32768
> 0017e1dc: 29203020 656e7472 69657320 6f662032    ) 0 entries of 2
> 0017e1ec: 35362075 7365640a 3c343e5a 6f6e6520    56 used.<4>Zone
> 0017e1fc: 50464e20 72616e67 65733a0a 3c343e20    PFN ranges:.<4>
> 0017e20c: 20444d41 20202020 20202020 20202020     DMA
> 0017e21c: 2030202d 3e202020 20333237 36380a3c     0 ->    32768.<
> 0017e22c: 343e2020 4e6f726d 616c2020 20202020    4>  Normal
> NDSC860:
> 0017e23c: 33323736 38202d3e 20202020 33323736    32768 ->    3276
> 0017e24c: 380a3c34 3e4d6f76 61626c65 207a6f6e    8.<4>Movable zon
> 0017e25c: 65207374 61727420 50464e20 666f7220    e start PFN for
> 0017e26c: 65616368 206e6f64 650a3c34 3e656172    each node.<4>ear
> 0017e27c: 6c795f6e 6f64655f 6d61705b 315d2061    ly_node_map[1] a
> 0017e28c: 63746976 65205046 4e207261 6e676573    ctive PFN ranges
> 0017e29c: 0a3c343e 20202020 303a2020 20202020    .<4>    0:
> 0017e2ac: 20203020 2d3e2020 20203332 3736380a      0 ->    32768.
> 0017e2bc: 3c373e4f 6e206e6f 64652030 20746f74    <7>On node 0 tot
> 0017e2cc: 616c7061 6765733a 20333237 36380a3c    alpages: 32768.<
> 0017e2dc: 373e2020 444d4120 7a6f6e65 3a203235    7>  DMA zone: 25
> 0017e2ec: 36207061 67657320 75736564 20666f72    6 pages used for
> 0017e2fc: 206d656d 6d61700a 3c373e20 20444d41     memmap.<7>  DMA
> 0017e30c: 207a6f6e 653a2030 20706167 65732072     zone: 0 pages r
> 0017e31c: 65736572 7665640a 3c373e20 20444d41    eserved.<7>  DMA
> 0017e32c: 207a6f6e 653a2033 32353132 20706167     zone: 32512 pag
> NDSC860:
> 0017e33c: 65732c20 4c49464f 20626174 63683a37    es, LIFO batch:7
> 0017e34c: 0a3c373e 20204e6f 726d616c 207a6f6e    .<7>  Normal zon
> 0017e35c: 653a2030 20706167 65732075 73656420    e: 0 pages used
> 0017e36c: 666f7220 6d656d6d 61700a3c 373e2020    for memmap.<7>
> 0017e37c: 4d6f7661 626c6520 7a6f6e65 3a203020    Movable zone: 0
> 0017e38c: 70616765 73207573 65642066 6f72206d    pages used for m
> 0017e39c: 656d6d61 700a3c34 3e427569 6c742031    emmap.<4>Built 1
> 0017e3ac: 207a6f6e 656c6973 74732069 6e205a6f     zonelists in Zo
> 0017e3bc: 6e65206f 72646572 2e202054 6f74616c    ne order.  Total
> 0017e3cc: 20706167 65733a20 33323531 320a3c35     pages: 32512.<5
> 0017e3dc: 3e4b6572 6e656c20 636f6d6d 616e6420    >Kernel command
> 0017e3ec: 6c696e65 3a20726f 6f743d2f 6465762f    line: root=/dev/
> 0017e3fc: 72616d20 72770a3c 343e5049 44206861    ram rw.<4>PID ha
> 0017e40c: 73682074 61626c65 20656e74 72696573    sh table entries
> 0017e41c: 3a203531 3220286f 72646572 3a20392c    : 512 (order: 9,
> 0017e42c: 20323034 38206279 74657329 0a3c343e     2048 bytes).<4>
> NDSC860:
> 0017e43c: 44656372 656d656e 74657220 46726571    Decrementer Freq
> 0017e44c: 75656e63 79203d20 31383735 30303030    uency = 18750000
> 0017e45c: 302f3630 20667020 69732033 31323530    0/60 fp is 31250
> 0017e46c: 30302062 696e666f 2d3e6269 5f696e74    00 binfo->bi_int
> 0017e47c: 66726571 20697320 35300a3c 343e7462    freq is 50.<4>tb
> 0017e48c: 5f746963 6b735f70 65725f6a 69666679    _ticks_per_jiffy
> 0017e49c: 203d2031 32353030 0a3c343e 436f6e73     = 12500.<4>Cons
> 0017e4ac: 6f6c653a 20636f6c 6f757220 64756d6d    ole: colour dumm
> 0017e4bc: 79206465 76696365 20383078 32350a3c    y device 80x25.<
> 0017e4cc: 363e636f 6e736f6c 65205b74 7479305d    6>console [tty0]
> 0017e4dc: 20656e61 626c6564 0a3c363e 44656e74     enabled.<6>Dent
> 0017e4ec: 72792063 61636865 20686173 68207461    ry cache hash ta
> 0017e4fc: 626c6520 656e7472 6965733a 20313633    ble entries: 163
> 0017e50c: 38342028 6f726465 723a2034 2c203635    84 (order: 4, 65
> 0017e51c: 35333620 62797465 73290a3c 363e496e    536 bytes).<6>In
> 0017e52c: 6f64652d 63616368 65206861 73682074    ode-cache hash t
> NDSC860:
> 0017e53c: 61626c65 20656e74 72696573 3a203831    able entries: 81
> 0017e54c: 39322028 6f726465 723a2033 2c203332    92 (order: 3, 32
> 0017e55c: 37363820 62797465 73290a3c 343e4d65    768 bytes).<4>Me
> 0017e56c: 6d6f7279 3a203132 36353230 6b206176    mory: 126520k av
> 0017e57c: 61696c61 626c6520 28313130 386b206b    ailable (1108k k
> 0017e58c: 65726e65 6c20636f 64652c20 3338346b    ernel code, 384k
> 0017e59c: 20646174 612c2038 306b2069 6e69742c     data, 80k init,
> 0017e5ac: 20306b20 68696768 6d656d29 0a3c363e     0k highmem).<6>
> 0017e5bc: 534c5542 3a204765 6e736c61 62733d32    SLUB: Genslabs=2
> 0017e5cc: 322c2048 57616c69 676e3d31 362c204f    2, HWalign=16, O
> 0017e5dc: 72646572 3d302d31 2c204d69 6e4f626a    rder=0-1, MinObj
> 0017e5ec: 65637473 3d342c20 43505573 3d312c20    ects=4, CPUs=1,
> 0017e5fc: 4e6f6465 733d310a 3c373e43 616c6962    Nodes=1.<7>Calib
> 0017e60c: 72617469 6e672064 656c6179 206c6f6f    rating delay loo
> 0017e61c: 702e2e2e 2034392e 31352042 6f676f4d    p... 49.15 BogoM
> 0017e62c: 49505320 286c706a 3d393833 3034290a    IPS (lpj=98304).
> NDSC860:
> 0017e63c: 3c343e4d 6f756e74 2d636163 68652068    <4>Mount-cache h
> 0017e64c: 61736820 7461626c 6520656e 74726965    ash table entrie
> 0017e65c: 733a2035 31320a3c 343e6166 74657220    s: 512.<4>after
> 0017e66c: 63686563 6b5f6275 67732829 3b0a3c34    check_bugs();.<4
> 0017e67c: 3e616674 65722061 6370695f 6561726c    >after acpi_earl
> 0017e68c: 795f696e 69742829 3b0a3c34 3e696e74    y_init();.<4>int
> 0017e69c: 6f207374 61746963 20696e74 205f5f69    o static int __i
> 0017e6ac: 6e697420 6b65726e 656c5f69 6e697428    nit kernel_init(
> 0017e6bc: 766f6964 202a2075 6e757365 64290a3c    void * unused).<
> 0017e6cc: 343e6265 666f7265 20646f5f 62617369    4>before do_basi
> 0017e6dc: 635f7365 74757028 293b0a3c 363e6368    c_setup();.<6>ch
> 0017e6ec: 65636b69 6e672069 6620696d 61676520    ecking if image
> 0017e6fc: 69732069 6e697472 616d6673 2e2e2e69    is initramfs...i
> 0017e70c: 74206973 6e277420 286e6f20 6370696f    t isn't (no cpio
> 0017e71c: 206d6167 6963293b 206c6f6f 6b73206c     magic); looks l
> 0017e72c: 696b6520 616e2069 6e697472 640a3c34    ike an initrd.<4
> NDSC860:
> 0017e73c: 3e467265 65696e67 20696e69 74726420    >Freeing initrd
> 0017e74c: 6d656d6f 72793a20 31353532 6b206672    memory: 1552k fr
> 0017e75c: 6565640a 3c353e56 46533a20 4469736b    eed.<5>VFS: Disk
> 0017e76c: 2071756f 74617320 6471756f 745f362e     quotas dquot_6.
> 0017e77c: 352e310a 3c343e44 71756f74 2d636163    5.1.<4>Dquot-cac
> 0017e78c: 68652068 61736820 7461626c 6520656e    he hash table en
> 0017e79c: 74726965 733a2031 30323420 286f7264    tries: 1024 (ord
> 0017e7ac: 65722030 2c203430 39362062 79746573    er 0, 4096 bytes
> 0017e7bc: 290a3c36 3e696f20 73636865 64756c65    ).<6>io schedule
> 0017e7cc: 72206e6f 6f702072 65676973 74657265    r noop registere
> 0017e7dc: 640a3c36 3e696f20 73636865 64756c65    d.<6>io schedule
> 0017e7ec: 7220616e 74696369 7061746f 72792072    r anticipatory r
> 0017e7fc: 65676973 74657265 640a3c36 3e696f20    egistered.<6>io
> 0017e80c: 73636865 64756c65 72206465 61646c69    scheduler deadli
> 0017e81c: 6e652072 65676973 74657265 640a3c36    ne registered.<6
> 0017e82c: 3e696f20 73636865 64756c65 72206366    >io scheduler cf
> NDSC860:
> 0017e83c: 71207265 67697374 65726564 20286465    q registered (de
> 0017e84c: 6661756c 74290a3c 363e5365 7269616c    fault).<6>Serial
> 0017e85c: 3a204350 4d206472 69766572 20245265    : CPM driver $Re
> 0017e86c: 76697369 6f6e3a20 302e3032 20240a3c    vision: 0.02 $.<
> 0017e87c: 363e6370 6d5f7561 72743a20 5741524e    6>cpm_uart: WARN
> 0017e88c: 494e473a 206e6f20 55415254 20646576    ING: no UART dev
> 0017e89c: 69636573 20666f75 6e64206f 6e20706c    ices found on pl
> 0017e8ac: 6174666f 726d2062 7573210a 3c363e63    atform bus!.<6>c
> 0017e8bc: 706d5f75 6172743a 20746865 20647269    pm_uart: the dri
> 0017e8cc: 76657220 77696c6c 20677565 73732063    ver will guess c
> 0017e8dc: 6f6e6669 67757261 74696f6e 2c206275    onfiguration, bu
> 0017e8ec: 74207468 6973206d 6f646520 6973206e    t this mode is n
> 0017e8fc: 6f206c6f 6e676572 20737570 706f7274    o longer support
> 0017e90c: 65642e0a 3c343e69 6e746f20 63706d5f    ed..<4>into cpm_
> 0017e91c: 75617274 5f696e69 745f706f 72746465    uart_init_portde
> 0017e92c: 73632876 6f696429 3b0a3c34 3e616674    sc(void);.<4>aft
> NDSC860:
> 0017e93c: 65722063 706d5f75 6172745f 706f7274    er cpm_uart_port
> 0017e94c: 735b5541 52545f53 4d43315d 2e736d63    s[UART_SMC1].smc
> 0017e95c: 70203d20 2663706d 702d3e63 705f736d    p = &cpmp->cp_sm
> 0017e96c: 635b305d 3b0a3c34 3e616674 65722063    c[0];.<4>after c
> 0017e97c: 706d5f75 6172745f 706f7274 735b5541    pm_uart_ports[UA
> 0017e98c: 52545f53 4d43315d 2e736d63 75700a3c    RT_SMC1].smcup.<
> 0017e99c: 343e6166 74657220 63706d5f 75617274    4>after cpm_uart
> 0017e9ac: 5f706f72 745f6d61 705b6370 6d5f7561    _port_map[cpm_ua
> 0017e9bc: 72745f6e 722b2b5d 203d2055 4152545f    rt_nr++] = UART_
> 0017e9cc: 534d4331 3b0a3c36 3e43504d 20756172    SMC1;.<6>CPM uar
> 0017e9dc: 745b305d 3a616c6c 6f636275 660a3c36    t[0]:allocbuf.<6
> 0017e9ec: 3e616674 65722063 706d5f64 70616c6c    >after cpm_dpall
> 0017e9fc: 6f632864 706d656d 737a2c20 38293b0a    oc(dpmemsz, 8);.
> 0017ea0c: 3c363e61 66746572 2063706d 5f647072    <6>after cpm_dpr
> 0017ea1c: 616d5f61 64647228 64705f6f 66667365    am_addr(dp_offse
> 0017ea2c: 74293b0a 3c363e61 66746572 204c315f    t);.<6>after L1_
> NDSC860:
> 0017ea3c: 43414348 455f414c 49474e0a 3c363e61    CACHE_ALIGN.<6>a
> 0017ea4c: 66746572 20666972 73742069 66200a3c    fter first if .<
> 0017ea5c: 363e7365 636f6e64 20666972 73742069    6>second first i
> 0017ea6c: 66200a3c 363e4350 4d207561 72745b30    f .<6>CPM uart[0
> 0017ea7c: 5d3a696e 69746264 0a3c363e 656e6420    ]:initbd.<6>end
> 0017ea8c: 6f662074 68652063 706d5f75 6172745f    of the cpm_uart_
> 0017ea9c: 696e6974 62640a3c 363e4350 4d207561    initbd.<6>CPM ua
> 0017eaac: 72745b30 5d3a696e 69745f73 6d630a3c    rt[0]:init_smc.<
> 0017eabc: 363e636f 6d706c65 74652076 6f696420    6>complete void
> 0017eacc: 63706d5f 75617274 5f696e69 745f736d    cpm_uart_init_sm
> 0017eadc: 630a3c36 3e747479 43504d30 20617420    c.<6>ttyCPM0 at
> 0017eaec: 4d4d494f 20307866 66303030 61383020    MMIO 0xff000a80
> 0017eafc: 28697271 203d2032 30292069 73206120    (irq = 20) is a
> 0017eb0c: 43504d20 55415254 0a3c343e 52414d44    CPM UART.<4>RAMD
> 0017eb1c: 49534b20 64726976 65722069 6e697469    ISK driver initi
> 0017eb2c: 616c697a 65643a20 31362052 414d2064    alized: 16 RAM d
> NDSC860:
> 0017eb3c: 69736b73 206f6620 31303234 304b2073    isks of 10240K s
> 0017eb4c: 697a6520 31303234 20626c6f 636b7369    ize 1024 blocksi
> 0017eb5c: 7a650a3c 363e6d69 63653a20 50532f32    ze.<6>mice: PS/2
> 0017eb6c: 206d6f75 73652064 65766963 6520636f     mouse device co
> 0017eb7c: 6d6d6f6e 20666f72 20616c6c 206d6963    mmon for all mic
> 0017eb8c: 650a3c34 3e616674 65722064 6f5f6261    e.<4>after do_ba
> 0017eb9c: 7369635f 73657475 7028293b 0a3c353e    sic_setup();.<5>
> 0017ebac: 52414d44 49534b3a 20436f6d 70726573    RAMDISK: Compres
> 0017ebbc: 73656420 696d6167 6520666f 756e6420    sed image found
> 0017ebcc: 61742062 6c6f636b 20300a3c 343e5646    at block 0.<4>VF
> 0017ebdc: 533a204d 6f756e74 65642072 6f6f7420    S: Mounted root
> 0017ebec: 28657874 32206669 6c657379 7374656d    (ext2 filesystem
> 0017ebfc: 292e0a3c 343e4672 6565696e 6720756e    )..<4>Freeing un
> 0017ec0c: 75736564 206b6572 6e656c20 6d656d6f    used kernel memo
> 0017ec1c: 72793a20 38306b20 696e6974 0a000000    ry: 80k init....
> 0017ec2c: 00000000 00000000 00000000 00000000    ................
> NDSC860:
>
>  ________________________________
>
> keng_629
> 2007-10-11
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
