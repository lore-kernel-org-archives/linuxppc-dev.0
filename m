Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614AC43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 13:30:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B382073B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 13:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47XLY66ySkzDqWh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 00:30:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=cxmp=2a=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47XLQX5sSBzDqWh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2019 00:25:08 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205183] PPC64: Signal delivery fails with SIGSEGV if between
 about 1KB and 4KB bytes of stack remain
Date: Tue, 10 Dec 2019 13:25:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dja@axtens.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205183-206035-fSQljhIXf2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205183-206035@https.bugzilla.kernel.org/>
References: <bug-205183-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205183

Daniel Axtens (dja@axtens.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dja@axtens.net

--- Comment #2 from Daniel Axtens (dja@axtens.net) ---
Hi, I'm starting to have a look at this for Daniel B.

So looking at the fault that fails, I see that it's a fault with the NIP in=
 the
_kernel_ that fails, rather than in userspace. Dumping stack we see:

[  118.917679] Call Trace:
[  118.917715] [c00000007b457820] [c000000000b71538] dump_stack+0xbc/0x104
(unreliable)
[  118.917719] [c00000007b457860] [c00000000006e8f0]
__do_page_fault+0x860/0xf90
[  118.917721] [c00000007b457940] [c00000000000af68]
handle_page_fault+0x10/0x30
[  118.917725] --- interrupt: 301 at handle_rt_signal64+0x180/0x13a0
                   LR =3D handle_rt_signal64+0x148/0x13a0
[  118.917726] [c00000007b457d30] [c000000000023d30]
do_notify_resume+0x2e0/0x410
[  118.917728] [c00000007b457e20] [c00000000000e4c4]
ret_from_except_lite+0x70/0x74

I'm still debugging, but it looks like handle_rt_signal64 attempts to reser=
ve a
stack frame for the signal, but computes a stack address that sits outside
valid stack space. Then when writing to it, it pagefaults, and because it's=
 not
a userland NIP, it refuses to expand the stack.

I'll keep you up to date.

Regards,
Daniel A

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
