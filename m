Return-Path: <michael.heltne@gmail.com>
Received: from mail-qc0-x22b.google.com (mail-qc0-x22b.google.com
 [IPv6:2607:f8b0:400d:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DD0B2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 22:18:07 +1000 (EST)
Received: by mail-qc0-f171.google.com with SMTP id q2so190837qch.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 05:17:59 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Apr 2013 14:17:59 +0200
Message-ID: <CANtoAtNsjMdgdpj31myTDUBy_sbMk4nvgBzir_2ZHnSgsgZ=JQ@mail.gmail.com>
Subject: flush_icache_range on AMCC 44x targets
From: Mike <michael.heltne@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=bcaec51d2ee0f89a1b04db92fda2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec51d2ee0f89a1b04db92fda2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

i was reading trough arch/powerpc/kernel/misc32.S looking at the icbi and
iccci instructions, from whats on print in
http://s.eeweb.com/members/kvks_kumar/answers/1356585717-PPC440_UM2013.pdf(page
272) iccci should be used once in the power-on / reset routine, and
as far as flush_icache_range goes presumably before icbi is called?

So should not flush_icache_range go
#ifdef CONFIG_44x
iccci    0, r0
#endif
icbi    0,r6

arch/powerpc/kernel/misc32.S:
/*
 * Write any modified data cache blocks out to memory
 * and invalidate the corresponding instruction cache blocks.
 * This is a no-op on the 601.
 *
 * flush_icache_range(unsigned long start, unsigned long stop)
 */
_KPROBE(__flush_icache_range)
BEGIN_FTR_SECTION
    blr                /* for 601, do nothing */
END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
    li    r5,L1_CACHE_BYTES-1
    andc    r3,r3,r5
    subf    r4,r3,r4
    add    r4,r4,r5
    srwi.    r4,r4,L1_CACHE_SHIFT
    beqlr
    mtctr    r4
    mr    r6,r3
1:    dcbst    0,r3
    addi    r3,r3,L1_CACHE_BYTES
    bdnz    1b
    sync                /* wait for dcbst's to get to ram */
#ifndef CONFIG_44x
    mtctr    r4
2:    icbi    0,r6
    addi    r6,r6,L1_CACHE_BYTES
    bdnz    2b
#else
    /* Flash invalidate on 44x because we are passed kmapped addresses and
       this doesn't work for userspace pages due to the virtually tagged
       icache.  Sigh. */
    iccci    0, r0
#endif
    sync                /* additional sync needed on g4 */
    isync
    blr


Best regards
-Mike

--bcaec51d2ee0f89a1b04db92fda2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br></div>i was reading trough =
arch/powerpc/kernel/misc32.S looking at the icbi and iccci instructions, fr=
om whats on print in <a href=3D"http://s.eeweb.com/members/kvks_kumar/answe=
rs/1356585717-PPC440_UM2013.pdf">http://s.eeweb.com/members/kvks_kumar/answ=
ers/1356585717-PPC440_UM2013.pdf</a> (page 272) iccci should be used once i=
n the power-on / reset routine, and as far as flush_icache_range goes presu=
mably before icbi is called?<br>
</div><br></div>So should not flush_icache_range go<br></div>#ifdef CONFIG_=
44x<br><div>iccci=A0=A0=A0 0, r0<br></div><div>#endif<br></div><div>icbi=A0=
=A0=A0 0,r6<br><br>arch/powerpc/kernel/misc32.S:<br><div><div>/*<br>=A0* Wr=
ite any modified data cache blocks out to memory<br>
=A0* and invalidate the corresponding instruction cache blocks.<br>=A0* Thi=
s is a no-op on the 601.<br>=A0*<br>=A0* flush_icache_range(unsigned long s=
tart, unsigned long stop)<br>=A0*/<br>_KPROBE(__flush_icache_range)<br>BEGI=
N_FTR_SECTION<br>
=A0=A0=A0 blr=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* for 601, do nothing=
 */<br>END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)<br>=A0=A0=A0 li=A0=A0=
=A0 r5,L1_CACHE_BYTES-1<br>=A0=A0=A0 andc=A0=A0=A0 r3,r3,r5<br>=A0=A0=A0 su=
bf=A0=A0=A0 r4,r3,r4<br>=A0=A0=A0 add=A0=A0=A0 r4,r4,r5<br>=A0=A0=A0 srwi.=
=A0=A0=A0 r4,r4,L1_CACHE_SHIFT<br>
=A0=A0=A0 beqlr<br>=A0=A0=A0 mtctr=A0=A0=A0 r4<br>=A0=A0=A0 mr=A0=A0=A0 r6,=
r3<br>1:=A0=A0=A0 dcbst=A0=A0=A0 0,r3<br>=A0=A0=A0 addi=A0=A0=A0 r3,r3,L1_C=
ACHE_BYTES<br>=A0=A0=A0 bdnz=A0=A0=A0 1b<br>=A0=A0=A0 sync=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 /* wait for dcbst&#39;s to get to ram */<br>#ifndef=
 CONFIG_44x<br>=A0=A0=A0 mtctr=A0=A0=A0 r4<br>
2:=A0=A0=A0 icbi=A0=A0=A0 0,r6<br>=A0=A0=A0 addi=A0=A0=A0 r6,r6,L1_CACHE_BY=
TES<br>=A0=A0=A0 bdnz=A0=A0=A0 2b<br>#else<br>=A0=A0=A0 /* Flash invalidate=
 on 44x because we are passed kmapped addresses and<br>=A0=A0=A0 =A0=A0 thi=
s doesn&#39;t work for userspace pages due to the virtually tagged<br>
=A0=A0=A0 =A0=A0 icache.=A0 Sigh. */<br>=A0=A0=A0 iccci=A0=A0=A0 0, r0<br>#=
endif<br>=A0=A0=A0 sync=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* additiona=
l sync needed on g4 */<br>=A0=A0=A0 isync<br>=A0=A0=A0 blr<br><br><br></div=
><div>Best regards<br></div><div>-Mike<br></div></div></div></div>

--bcaec51d2ee0f89a1b04db92fda2--
