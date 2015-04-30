Return-Path: <joel.stan@gmail.com>
Received: from mail-qc0-x22f.google.com (mail-qc0-x22f.google.com
 [IPv6:2607:f8b0:400d:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F21131A031D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 13:29:57 +1000 (AEST)
Received: by qcbii10 with SMTP id ii10so23260218qcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 20:29:54 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 30 Apr 2015 13:29:34 +1000
Message-ID: <CACPK8XeQjdmwFScvEDMo4ie7=-e6WfW0cvW=NMLqC+zpOOJeTg@mail.gmail.com>
Subject: ppc64le crash in dm on 4.1+
To: linuxppc-dev@lists.ozlabs.org, dm-devel@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I just booted 3d99e3fe13d473ac4578c37f477a59b829530764 (linus' tree as
of this morning) on a Tuletta and got the following:

[   41.409033] Unable to handle kernel paging request for data at
address 0x000000d0
[   41.409125] Faulting instruction address: 0xc000000000c29068
cpu 0x23: Vector: 300 (Data Access) at [c000000fe945f940]
    pc: c000000000c29068: free_rq_clone+0x38/0x100
    lr: c000000000c29060: free_rq_clone+0x30/0x100
    sp: c000000fe945fbc0
   msr: 9000000000009033
   dar: d0
 dsisr: 40000000
  current = 0xc000000fe93a9740
  paca    = 0xc00000000fe86900 softe: 0 irq_happened: 0x01
    pid   = 6682, comm = kdmwork-252:0
enter ? for help
[c000000fe945fc00] c000000000c292c8
dm_requeue_unmapped_original_request+0x58/0x130
[c000000fe945fc50] c000000000c2a4b8 map_request.isra.20+0xe8/0x2e0
[c000000fe945fcf0] c000000000c2a6e4 map_tio_request+0x34/0x80
[c000000fe945fd20] c0000000000a5300 kthread_worker_fn+0x100/0x1e0
[c000000fe945fd80] c0000000000a51dc kthread+0x10c/0x130
[c000000fe945fe30] c0000000000094ac ret_from_kernel_thread+0x5c/0xb0
--- Exception: 0  at 0000000000000000
23:mon>
23:mon> r
R00 = c000000000c29060   R16 = 0000000000000000
R01 = c000000fe945fbc0   R17 = 0000000000000000
R02 = c00000000138e220   R18 = 0000000000000000
R03 = 0000000000000000   R19 = 0000000000000000
R04 = f0000000037afe58   R20 = 0000000000000000
R05 = c000000fe91dbe00   R21 = 0000000000000000
R06 = c000000000138cd4   R22 = 0000000000000000
R07 = 0000000080000000   R23 = 0000000000000000
R08 = 00000000000000ff   R24 = 0000000000000000
R09 = 0000000000000000   R25 = 0000000000000000
R10 = 0000000000000001   R26 = 0000000000000000
R11 = c000000fe945fbf8   R27 = c000000fdffa03a8
R12 = c000000000138cb0   R28 = c000000fdffa0000
R13 = c00000000fe86900   R29 = c000000fdffa0000
R14 = c0000000000a50d8   R30 = c000000fcf090000
R15 = c000000fe5acbf00   R31 = c000000fe3ba0ec8
pc  = c000000000c29068 free_rq_clone+0x38/0x100
cfar= c000000000008458 slb_miss_realmode+0x4c/0x74
lr  = c000000000c29060 free_rq_clone+0x30/0x100
msr = 9000000000009033   cr  = 429b8942
ctr = c000000000138cb0   xer = 0000000020000000   trap =  300
dar = 00000000000000d0   dsisr = 40000000
23:mon> di %pc
c000000000c29068  e92900d0 ld r9,208(r9)
c000000000c2906c  2fa90000 cmpdi cr7,r9,0
c000000000c29070  419e0060 beq cr7,c000000000c290d0 # free_rq_clone+0xa0/0x100
c000000000c29074  e93e0008 ld r9,8(r30)
c000000000c29078  7fe3fb78 mr r3,r31
c000000000c2907c  e9290008 ld r9,8(r9)
c000000000c29080  e9290050 ld r9,80(r9)
c000000000c29084  f8410018 std r2,24(r1)
c000000000c29088  7d2903a6 mtctr r9
c000000000c2908c  7d2c4b78 mr r12,r9
c000000000c29090  4e800421 bctrl
c000000000c29094  e8410018 ld r2,24(r1)
c000000000c29098  e93d0138 ld r9,312(r29)
c000000000c2909c  e92900d0 ld r9,208(r9)
c000000000c290a0  2fa90000 cmpdi cr7,r9,0
c000000000c290a4  419e005c beq cr7,c000000000c29100 # free_rq_clone+0xd0/0x100

Cheers,

Joel
