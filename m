Return-Path: <SRS0=Sk7F=Y7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E31C5DF61
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 08:51:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9367720679
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 08:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9367720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477xvz2RmDzF6HL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 19:51:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=wsnh=y7=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477xpw42cBzF6FS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2019 19:47:04 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205201] Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
Date: Thu, 07 Nov 2019 08:46:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chzigotzky@xenosoft.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205201-206035-LLASS7fcZq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205201-206035@https.bugzilla.kernel.org/>
References: <bug-205201-206035@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D205201

--- Comment #7 from Christian Zigotzky (chzigotzky@xenosoft.de) ---
Unfortunately this patch doesn't solve the issue.=20

Error message:

    [    6.041163] bttv: driver version 0.9.19 loaded
    [    6.041167] bttv: using 8 buffers with 2080k (520 pages) each for
capture
    [    6.041559] bttv: Bt8xx card found (0)
    [    6.041609] bttv: 0: Bt878 (rev 17) at 1000:04:05.0, irq: 19, latenc=
y:
128, mmio: 0xc20001000
    [    6.041622] bttv: 0: using: Typhoon TView RDS + FM Stereo / KNC1 TV
Station RDS [card=3D53,insmod option]
    [    6.042216] bttv: 0: tuner type=3D5
    [    6.111994] bttv: 0: audio absent, no audio device found!
    [    6.176425] bttv: 0: Setting PLL: 28636363 =3D> 35468950 (needs up to
100ms)
    [    6.200005] bttv: PLL set ok
    [    6.209351] bttv: 0: registered device video0
    [    6.211576] bttv: 0: registered device vbi0
    [    6.214897] bttv: 0: registered device radio0
    [  114.218806] bttv 1000:04:05.0: overflow 0x00000000ff507000+4096 of D=
MA
mask ffffffff bus mask df000000
    [  114.218848] Modules linked in: rfcomm bnep tuner_simple tuner_types
tea5767 tuner tda7432 tvaudio msp3400 bttv tea575x tveeprom videobuf_dma_sg
videobuf_core rc_core videodev mc btusb btrtl btbcm btintel bluetooth
uio_pdrv_genirq uio ecdh_generic ecc
    [  114.219012] [c0000001ecddf720] [80000000008ff6e8]
.buffer_prepare+0x150/0x268 [bttv]
    [  114.219029] [c0000001ecddf860] [80000000008fff6c] .bttv_qbuf+0x50/0x=
64
[bttv]

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
