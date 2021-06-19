Return-Path: <SRS0=x5jM=LN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21DAC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 08:26:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A93611ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 08:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A93611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G6TQl0MMDz3c4Q
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jun 2021 18:26:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PsAb9mCt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PsAb9mCt; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G6TQD0NrTz2ym4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jun 2021 18:25:55 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id D6EE361059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jun 2021 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624091151;
 bh=4Atzuhe/mhtUw9yky+bVwQapLDDO08LJohppsZpnnJc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=PsAb9mCtbFyzw2Qe0LihiNf9ekPFZdTCepb0sM2U8oJV0OYnH/ylMF9MGVTNNdwPf
 xYKmi96xzsIAAkqTncqKzdO/H6YgETpioj4JnPmrNfjH/cLcqWtOvWgaJp6VvxJEdU
 u6gXo4/urfMFhIE1rVN9J5ZcLtLiVIGjiYyYn7OHibKgN5XOqj+KjakjuMzwTxhKVM
 rvlCVtYT0JbKd4YGMD/AkWiIH8JKFOoxV12k2pnjRBTmjrRl6eGfjVtK5f4DdQASFG
 X/j7laevfcqoCA1z6XUhhSvu2KC0iNY+L6WFBTxXgFVzbQlyLS4QTr6jJzQA9vlF1k
 f0bhoc6Oj4YDQ==
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205099] KASAN hit at raid6_pq: BUG: Unable to handle kernel
 data access at 0x00f0fd0d
Date: Sat, 19 Jun 2021 08:25:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205099-206035-rLL8MCl7A5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205099-206035@https.bugzilla.kernel.org/>
References: <bug-205099-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205099

--- Comment #33 from Erhard F. (erhard_f@mailbox.org) ---
I can tell you in the next few weeks, as soon as my G4 MDD gets its' overha=
ul
with the serviced PSU.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
