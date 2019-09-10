Return-Path: <SRS0=Blre=XF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B51C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 13:26:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C402067B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 13:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="afV9jy3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C402067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46SQlj0DgbzF0Qh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 23:26:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46SQXz0048zDrdj;
 Tue, 10 Sep 2019 23:16:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="afV9jy3e"; 
 dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 46SQXw5LXpz9s7T;
 Tue, 10 Sep 2019 23:16:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1568121409;
 bh=8YpvriWgZotmerko0J+/vGDj0I0pWRFk35pz5gDDI3E=;
 h=Subject:From:To:Cc:Date:From;
 b=afV9jy3e43LDgZZ6cCx9zYoP1i33CBwatneHIcRpDM/dYSvl+PlNywbzT+32oG8bn
 fEMIvS/EcUUFmz95slyme9PkgMYgwoPxm0MXKvlhgOpBJTLx8yJ+fD9kBATXOj0sLi
 nG6HuBAKzF/cRbGWpr+PY+ZZjgLNPMuG903ctQ4DgFMuPgXxDt1fq1bFFHmpCcU6RY
 kg0D3PZkrvxrSW/O7PyFz9OOIHTq218qDKrHhGyJxJFRkeGORToHoddoe+bLFs1/eP
 MVgPofN8mI0/qQ2RmkZQupFHsoohFs5gTiHM6Y7yW3C1MGAvBppA731Z70wSer0/Xn
 4tyf33YQYzK8w==
Received: by neuling.org (Postfix, from userid 1000)
 id 9362C2A01E8; Tue, 10 Sep 2019 23:16:48 +1000 (AEST)
Message-ID: <856d6efa0e9b4dd39030e7372a17e3dba2db2aef.camel@neuling.org>
Subject: CVE-2019-15030: Linux kernel: powerpc: data leak with FP/VMX 
 triggerable by unavailable exception in transaction
From: Michael Neuling <mikey@neuling.org>
To: oss-security <oss-security@lists.openwall.com>
Date: Tue, 10 Sep 2019 23:16:48 +1000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
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
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linuxppc-users <linuxppc-users@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Linux kernel for powerpc since v4.12 has a bug in it's TM handling wher=
e any
user can read the FP/VMX registers of a difference user's process. Users of=
 TM +
FP/VMX can also experience corruption of their FP/VMX state.

To trigger the bug, a process starts a transaction and reads a FP/VMX regis=
ter.
This transaction can then fail which causes a rollback to the checkpointed
state. Due to the kernel taking an FP/VMX unavaliable exception inside a
transaction and the kernel's incorrect handling of this, the checkpointed s=
tate
can be set to the FP/VMX registers of another process. This checkpointed st=
ate
can then be read by the process hence leaking data from one process to anot=
her.

The trigger for this bug is an FP/VMX unavailable exception inside a
transaction, hence the process needs FP/VMX off when starting the transacti=
on.
FP/VMX availability is under the control of the kernel and is transparent t=
o the
user, hence the user has to retry the transaction many times to trigger thi=
s
bug.=20

All 64-bit machines where TM is present are affected. This includes all POW=
ER8
variants and POWER9 VMs under KVM or LPARs under PowerVM. POWER9 bare metal
doesn't support TM and hence is not affected.

The bug was introduced in commit:
  f48e91e87e67 ("powerpc/tm: Fix FP and VMX register corruption")
Which was originally merged in v4.12

The upstream fix is here:
  https://git.kernel.org/torvalds/c/8205d5d98ef7f155de211f5e2eb6ca03d95a5a6=
0

The fix can be verified by running the tm-poison from the kernel selftests.=
 This
test is in a patch here:
https://patchwork.ozlabs.org/patch/1157467/
which should eventually end up here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/testing/selftests/powerpc/tm/tm-poison.c

cheers
Mikey





