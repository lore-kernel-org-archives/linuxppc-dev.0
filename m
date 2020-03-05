Return-Path: <SRS0=3HB0=4W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8810C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2020 12:28:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765392072A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2020 12:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765392072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Y95G0DwWzDqN5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2020 23:28:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=azl9=4w=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Y8z26mpCzDqkT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2020 23:22:54 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 206695] kmemleak reports leaks in drivers/macintosh/windfarm
Date: Thu, 05 Mar 2020 12:22:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mpe@ellerman.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206695-206035-aIyJTSKaE1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206695-206035@https.bugzilla.kernel.org/>
References: <bug-206695-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D206695

--- Comment #3 from mpe@ellerman.id.au ---
Can you try this patch?

diff --git a/drivers/macintosh/windfarm_pm112.c
b/drivers/macintosh/windfarm_pm112.c
index 4150301a89a5..a16f43a1def9 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -125,7 +125,7 @@ static int create_cpu_loop(int cpu)
 {
        int chip =3D cpu / 2;
        int core =3D cpu & 1;
-       struct smu_sdbp_header *hdr;
+       struct smu_sdbp_header *hdr, *hdr2;
        struct smu_sdbp_cpupiddata *piddata;
        struct wf_cpu_pid_param pid;
        struct wf_control *main_fan =3D cpu_fans[0];
@@ -141,9 +141,9 @@ static int create_cpu_loop(int cpu)
        piddata =3D (struct smu_sdbp_cpupiddata *)&hdr[1];

        /* Get FVT params to get Tmax; if not found, assume default */
-       hdr =3D smu_sat_get_sdb_partition(chip, 0xC4 + core, NULL);
-       if (hdr) {
-               struct smu_sdbp_fvt *fvt =3D (struct smu_sdbp_fvt *)&hdr[1];
+       hdr2 =3D smu_sat_get_sdb_partition(chip, 0xC4 + core, NULL);
+       if (hdr2) {
+               struct smu_sdbp_fvt *fvt =3D (struct smu_sdbp_fvt *)&hdr2[1=
];
                tmax =3D fvt->maxtemp << 16;
        } else
                tmax =3D 95 << 16;        /* default to 95 degrees C */
@@ -174,6 +174,10 @@ static int create_cpu_loop(int cpu)
                pid.min =3D fmin;

        wf_cpu_pid_init(&cpu_pid[cpu], &pid);
+
+       kfree(hdr);
+       kfree(hdr2);
+
        return 0;
 }

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=
