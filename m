Return-Path: <SRS0=60rt=4S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27795C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 19:19:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF833214DB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 19:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF833214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48VtPC1vBYzDqHk
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 06:19:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=vxuw=4s=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48VtMJ3YqqzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2020 06:17:32 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 199471] windfarm_pm72 no longer gets automatically loaded when
 CONFIG_I2C_POWERMAC=y is set (regression)
Date: Sun, 01 Mar 2020 19:17:30 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-199471-206035-ld5HiCLjgD@https.bugzilla.kernel.org/>
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

--- Comment #10 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 287743
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D287743&action=3Dedit
bisect.log

Finally checked on that bug again and bisected it. The offending commit is:

# git bisect bad | tee -a ~/bisect02.log=20
af503716ac1444db61d80cb6d17cfe62929c21df is the first bad commit
commit af503716ac1444db61d80cb6d17cfe62929c21df
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Sun Dec 3 22:40:50 2017 +0100

    i2c: core: report OF style module alias for devices registered via OF

    The buses should honor the firmware interface used to register the devi=
ce,
    but the I2C core reports a MODALIAS of the form i2c:<device> even for I=
2C
    devices registered via OF.

    This means that user-space will never get an OF stype uevent MODALIAS e=
ven
    when the drivers modules contain aliases exported from both the I2C and=
 OF
    device ID tables. For example, an Atmel maXTouch Touchscreen registered=
 by
    a DT node with compatible "atmel,maxtouch" has the following module ali=
as:

    $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
    i2c:maxtouch

    So udev won't be able to auto-load a module for an OF-only device drive=
r.
    Many OF-only drivers duplicate the OF device ID table entries in an I2C=
 ID
    table only has a workaround for how the I2C core reports the module ali=
as.

    This patch changes the I2C core to report an OF related MODALIAS uevent=
 if
    the device was registered via OF. So for the previous example, after th=
is
    patch, the reported MODALIAS for the Atmel maXTouch will be the followi=
ng:

    $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
    of:NtrackpadT<NULL>Catmel,maxtouch

    NOTE: This patch may break out-of-tree drivers that were relying on this
          behavior, and only had an I2C device ID table even when the device
          was registered via OF. There are no remaining drivers in mainline
          that do this, but out-of-tree drivers have to be fixed and define
          a proper OF device ID table to have module auto-loading working.

    Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
    Tested-by: Dmitry Mastykin <mastichi@gmail.com>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

 drivers/i2c/i2c-core-base.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
