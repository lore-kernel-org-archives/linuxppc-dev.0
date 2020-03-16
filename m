Return-Path: <SRS0=ASHh=5B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A1C0044D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444E720409
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444E720409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48h4Q05jxBzDqWG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 05:21:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=0a+e=5b=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48h4Df16VyzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2020 05:13:38 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 206669] Little-endian kernel crashing on POWER8 on heavy
 big-endian PowerKVM load
Date: Mon, 16 Mar 2020 18:13:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: glaubitz@physik.fu-berlin.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206669-206035-5S7BEUrz3g@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206669-206035@https.bugzilla.kernel.org/>
References: <bug-206669-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D206669

--- Comment #12 from John Paul Adrian Glaubitz (glaubitz@physik.fu-berlin.d=
e) ---
Another crash:

watson login: [17667512263.751484] BUG: Unable to handle kernel data access=
 at
0xc000000ff06e4838
[17667512263.751507] Faulting instruction address: 0xc00000000017a778
[17667512263.751513] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751517] Faulting instruction address: 0xc0000000002659a0
[17667512263.751521] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751525] Faulting instruction address: 0xc0000000002659a0
[17667512263.751529] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751533] Faulting instruction address: 0xc0000000002659a0
[17667512263.751537] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751541] Faulting instruction address: 0xc0000000002659a0
[17667512263.751545] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751548] Faulting instruction address: 0xc0000000002659a0
[17667512263.751552] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751556] Faulting instruction address: 0xc0000000002659a0
[17667512263.751560] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751564] Faulting instruction address: 0xc0000000002659a0
[17667512263.751569] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751574] Faulting instruction address: 0xc0000000002659a0
[17667512263.751578] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751583] Faulting instruction address: 0xc0000000002659a0
[17667512263.751587] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751591] Faulting instruction address: 0xc0000000002659a0
[17667512263.751596] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751600] Faulting instruction address: 0xc0000000002659a0
[17667512263.751604] Thread overran stack, or stack corrupted
[17667512263.751608] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[17667512263.751612] Faulting instruction address: 0xc0000000002659a0
[17667512263.751615] Thread overran stack, or stack corrupted
[17667512263.751618] BUG: Unable to handle kernel data access at
0xc0000007f9070c08
[ 1835.743178] BUG: Unable to handle unknown paging fault at 0xc000000000c4=
b363
[ 1835.743180] Faulting instruction address: 0x00000000
[17667512263.751633] Faulting instruction address: 0xc0000000002659a0
[ 1835.743195] Oops: Kernel access of bad area, sig: 11 [#1]
[ 1835.743198] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA PowerNV
[ 1835.743203] Modules linked in:
[17667512263.751652] Thread overran stack, or stack corrupted
[ 1835.743205]

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
