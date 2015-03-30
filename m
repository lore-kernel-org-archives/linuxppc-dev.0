Return-Path: <olaf@aepfle.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2F841A0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 00:39:43 +1100 (AEDT)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0F63714007F
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2015 00:39:41 +1100 (AEDT)
Date: Mon, 30 Mar 2015 15:09:18 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: nouveau regression on G5 Dual Core
Message-ID: <20150330130918.GA25748@aepfle.de>
References: <20150328125916.GA29649@aepfle.de>
 <20150328135449.GA29661@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150328135449.GA29661@aepfle.de>
Cc: Ben Skeggs <bskeggs@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 28, Olaf Hering wrote:

> On Sat, Mar 28, Olaf Hering wrote:
> 
> > I just updated the kernel from some 3.18 based state to 4.0-rc5+. The
> 
> 3.19 is already broken, will bisect next week.

After a first run I was able to boot prior the first bad commit, which caused a
crash on boot.  Now I have to find the commit which actually allows boot again,
but with the white screen.

Ben, was ad4a362635353f7ceb66f4038269770fee1025fa tested on a pmac?

Olaf

root@g5:~/work/kernel/linux # git bisect log 
git bisect start
# good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
git bisect good b2776bf7149bddd1f4161f14f79520f17fc1d71d
# bad: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
git bisect bad bfa76d49576599a4b9f9b7a71f23d73d6dcff735
# good: [54850e73e86e3bc092680d1bdb84eb322f982ab1] zram: change parameter from vaild_io_request()
git bisect good 54850e73e86e3bc092680d1bdb84eb322f982ab1
# bad: [dab363f938a53ddaee60bfecc1aebdbb3d3af5f0] Merge tag 'staging-3.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad dab363f938a53ddaee60bfecc1aebdbb3d3af5f0
# good: [26178ec11ef3c6c814bf16a0a2b9c2f7242e3c64] x86: mm: consolidate VM_FAULT_RETRY handling
git bisect good 26178ec11ef3c6c814bf16a0a2b9c2f7242e3c64
# good: [1b4bcf1fedbe7dcd98d9d35dfc947f033a398c4d] staging: comedi: addi_tcw.h: provide generic defines for the ADDI-DATA TCW
git bisect good 1b4bcf1fedbe7dcd98d9d35dfc947f033a398c4d
# good: [030794a368946b98a8252d3172f5f2a1b0e4fb0e] drm/exynos: Fix DSI resuming fail because power domain being off
git bisect good 030794a368946b98a8252d3172f5f2a1b0e4fb0e
# bad: [59ea90543f57a40827d7d1e528d657b8cc7161b1] drm/i915: Implement GPU reset for 915/945
git bisect bad 59ea90543f57a40827d7d1e528d657b8cc7161b1
# bad: [37025602f6abc5919c7d5a8517bc7d6ea08acc57] drm/nouveau/platform: add GPU speedo information to nouveau platform
git bisect bad 37025602f6abc5919c7d5a8517bc7d6ea08acc57
# good: [33f86ff62c4368c8d6bf3c76dc2fa416e3f90213] Merge branch 'amdkfd-next-3.19' of git://people.freedesktop.org/~gabbayo/linux into drm-next
git bisect good 33f86ff62c4368c8d6bf3c76dc2fa416e3f90213
# bad: [1f89b4756fb83f385ac0e277b092774c01a5ab9c] drm/gm204/disp: initial support
git bisect bad 1f89b4756fb83f385ac0e277b092774c01a5ab9c
# bad: [c2c2f6cb79141ca22f84c36887fd867373c35c4e] drm/nouveau/bios: fetch images beyond the first one in the rom
git bisect bad c2c2f6cb79141ca22f84c36887fd867373c35c4e
# good: [9c8af882bf1230bb85c1dbf67e0dde6888223ceb] drm: Add adv7511 encoder driver
git bisect good 9c8af882bf1230bb85c1dbf67e0dde6888223ceb
# good: [4894f6628e1ae04b2cc6222df692364c1ac1250f] drm/nouveau: a, somehow, missed hunk of "fix regression on agp boards"
git bisect good 4894f6628e1ae04b2cc6222df692364c1ac1250f
# bad: [ad4a362635353f7ceb66f4038269770fee1025fa] drm/nouveau/bios: split out shadow methods
git bisect bad ad4a362635353f7ceb66f4038269770fee1025fa
# good: [e8972421623cd10a12cc7343da029b58777fdd2f] drm/nouveau/bios: fix thinko when parsing extdev table
git bisect good e8972421623cd10a12cc7343da029b58777fdd2f
# first bad commit: [ad4a362635353f7ceb66f4038269770fee1025fa] drm/nouveau/bios: split out shadow methods

Olaf
