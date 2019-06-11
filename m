Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CDC4321A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 07:28:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6472086D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 07:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6472086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NM6z2c5vzDqZS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 17:28:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bugzilla.kernel.org
 (client-ip=198.145.29.98; helo=mail.wl.linuxfoundation.org;
 envelope-from=bugzilla-daemon@bugzilla.kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.wl.linuxfoundation.org (mail.wl.linuxfoundation.org
 [198.145.29.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NM461K5hzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 17:25:57 +1000 (AEST)
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 829C62857B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 07:25:54 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id 767992873F; Tue, 11 Jun 2019 07:25:54 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 203839] Kernel 5.2-rc3 fails to boot on a PowerMac G4 3,6:
 systemd[1]: Failed to bump fs.file-max, ignoring: invalid argument
Date: Tue, 11 Jun 2019 07:25:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: christophe.leroy@c-s.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203839-206035-Acd6qHYi4L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203839-206035@https.bugzilla.kernel.org/>
References: <bug-203839-206035@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D203839

--- Comment #8 from Christophe Leroy (christophe.leroy@c-s.fr) ---
Argh !

CONFIG_SMP must (again) be the reason we missed it.

Can you please try the change below ?

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 1d5f1bd0dacd..f255e22184b4 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -752,6 +752,7 @@ __secondary_start:
        stw     r0,0(r3)

        /* load up the MMU */
+       bl      load_segment_registers
        bl      load_up_mmu

        /* ptr to phys current thread */

Thanks
Christophe

On 06/11/2019 12:32 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D203839
>=20
> --- Comment #6 from Erhard F. (erhard_f@mailbox.org) ---
> Created attachment 283183
>    --> https://bugzilla.kernel.org/attachment.cgi?id=3D283183&action=3Ded=
it
> bisect.log
>=20
> bisect took me a while due to quite some skips. Cherry-picking
> 397d2300b08cdee052053e362018cdb6dd65eea2 and
> 305d60012304684bd59ea1f67703e51662e4906a helped me complete it.
>=20
> # git bisect good | tee -a /root/bisect02.log
> 215b823707ce4e8e52b106915f70357fa474c669 is the first bad commit
> commit 215b823707ce4e8e52b106915f70357fa474c669
> Author: Christophe Leroy <christophe.leroy@c-s.fr>
> Date:   Fri Apr 26 16:23:36 2019 +0000
>=20
>      powerpc/32s: set up an early static hash table for KASAN.
>=20
>      KASAN requires early activation of hash table, before memblock()
>      functions are available.
>=20
>      This patch implements an early hash_table statically defined in
>      __initdata.
>=20
>      During early boot, a single page table is used.
>=20
>      For hash32, when doing the final init, one page table is allocated
>      for each PGD entry because of the _PAGE_HASHPTE flag which can't be
>      common to several virt pages. This is done after memblock get
>      available but before switching to the final hash table, otherwise
>      there are issues with TLB flushing due to the shared entries.
>=20
>      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>=20
> :040000 040000 abc24eb3c4ad3e4f2b1eb7b52c295c8b95d79a78
> c3b6114c26eb8e181abb3f1abc9b6ecc12292f4d M      arch
>

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
