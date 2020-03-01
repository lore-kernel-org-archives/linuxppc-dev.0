Return-Path: <SRS0=60rt=4S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568CC3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 19:16:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A2F214DB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 19:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A2F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48VtLB6wmWzDqvy
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 06:16:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=vxuw=4s=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48VtHx6VQ2zDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2020 06:14:37 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 199471] windfarm_pm72 no longer gets automatically loaded when
 CONFIG_I2C_POWERMAC=y is set (regression)
Date: Sun, 01 Mar 2020 19:14:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-199471-206035-1lDaQGpvxP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199471-206035@https.bugzilla.kernel.org/>
References: <bug-199471-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D199471

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #275503|0                           |1
        is obsolete|                            |
 Attachment #275505|0                           |1
        is obsolete|                            |

--- Comment #9 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 287741
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D287741&action=3Dedit
kernel .config (kernel 4.16, PowerMac G5 11,2)

With the attached kernel .config the G5 7,3 and the G5 11,2 automatically l=
oad
the suitable windfarm module on kernel <4.17. Starting from kernel 4.17
windfarm core needs to be CONFIG_WINDFARM=3Dy to automacitally load the sui=
table
windfarm module, CONFIG_WINDFARM=3Dm is no longer sufficient.

Needed for 4.16.x to automatically load the suitable windfarm module:
# grep -i wind .config
CONFIG_WINDFARM=3Dm
CONFIG_WINDFARM_PM81=3Dm
CONFIG_WINDFARM_PM72=3Dm
CONFIG_WINDFARM_RM31=3Dm
CONFIG_WINDFARM_PM91=3Dm
CONFIG_WINDFARM_PM112=3Dm
CONFIG_WINDFARM_PM121=3Dm

Needed for >=3D4.17.x to automatically load the suitable windfarm module:
# grep -i wind .config
CONFIG_WINDFARM=3Dy
CONFIG_WINDFARM_PM81=3Dm
CONFIG_WINDFARM_PM72=3Dm
CONFIG_WINDFARM_RM31=3Dm
CONFIG_WINDFARM_PM91=3Dm
CONFIG_WINDFARM_PM112=3Dm
CONFIG_WINDFARM_PM121=3Dm

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
