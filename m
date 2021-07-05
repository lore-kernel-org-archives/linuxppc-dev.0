Return-Path: <SRS0=1zWh=L5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F2C07E99
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 14:20:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D376193E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Jul 2021 14:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D376193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJSXD03zmz3bXr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 00:20:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BbftnV3x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BbftnV3x; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJSWf3fzYz2yNF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jul 2021 00:20:14 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 8F8A561946
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jul 2021 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625494811;
 bh=WoF1xymSrDeDS3PwG5mBwaYw12WB7wIxGR/zhVZ3kHw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=BbftnV3xVYPSbNeQAr4lSArAdfUqrtyw97S1+7iTLtRVzQB64vy0fE2AR+z0wXwxa
 TU/PJM5yyG3izNKBwjJUF9Iqrrxprdm2ysDg6a7TVCas6pLjqAeJITE1/X2Sp2wyFk
 MM1lZA+VXh1421h0TsCN3z4ZWYqfAyeV4xX2eBuq77VxfmWXd2dLQWDDEqMlrT4zem
 HNS2qICZ2to2naLeLjElRjL0LaHElZPOJnpLhGJdx+/sYhKspIYm+49Lt3c23Kus6M
 edjNgpDOvTE2abHETtR9zeIeFEr4Ai4OZGQeJd2JB69mdYErqgr1U4t6Yi9OD2OUXu
 SiaxBZvhOSMQA==
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 213079] [bisected] IRQ problems and crashes on a PowerMac G5
 with 5.12.3
Date: Mon, 05 Jul 2021 14:20:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oohall@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213079-206035-hCAIREAe5h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213079-206035@https.bugzilla.kernel.org/>
References: <bug-213079-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D213079

--- Comment #13 from Oliver O'Halloran (oohall@gmail.com) ---
Hi,

I got a loaner G5 with an NVMe drive, but I haven't been able to replicate =
the
crash you're seeing. However, I think that's probably because I'm only read=
ing
from the NVMe since it's NTFS formatted and I didn't want to trash someone
else's files. I'm waiting for a new NVMe drive to arrive so I can do some
destructive testing which should hopefully replicate the bug.

In the meanwhile, can you try the patch above? That seems to fix bug which =
is
causing MSIs to be unusable. I'm not 100% sure why that woudld matter, but =
it's
possible the crashes are due to some other bug which doesn't appear when MS=
Is
are in use.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
