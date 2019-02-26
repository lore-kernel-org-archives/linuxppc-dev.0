Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A02C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 20:36:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7774F21852
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 20:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=email.cz header.i=@email.cz header.b="dkJ+BOB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7774F21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4489Zd3JPnzDqMC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 07:36:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=email.cz
 (client-ip=2a02:598:a::78:89; helo=mxb1.seznam.cz;
 envelope-from=jaydee@email.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=email.cz header.i=@email.cz header.b="dkJ+BOB4"; 
 dkim-atps=neutral
X-Greylist: delayed 845 seconds by postgrey-1.36 at bilbo;
 Wed, 27 Feb 2019 03:28:01 AEDT
Received: from mxb1.seznam.cz (mxb1.seznam.cz [IPv6:2a02:598:a::78:89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4484410WqQzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 03:27:57 +1100 (AEDT)
Received: from email.seznam.cz
 by email-smtpc8b.ko.seznam.cz (email-smtpc8b.ko.seznam.cz [10.53.13.225])
 id 5290acd756f85862521e6696; Tue, 26 Feb 2019 17:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=beta;
 t=1551198473; bh=HNPtOGnWggSHluXs1AhNBMfvymYo+7oaB8qz4iPDYX4=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
 Content-Type:Content-Transfer-Encoding;
 b=dkJ+BOB4/GMtZKXw86Kwiog5OdFR5j1PL1toRCfzMGSCVcbyWyj/qN4qfzxIzTxaQ
 PqvnaKmNeb/m4PQaa7StS4P6EqXrBTvQ7v0IRpmaopXkejnZPwMyAX51HVoXkYf/5h
 IsYYYxC84WSLihPkzUDUuzhjxFNNAemsHMKh3zN0=
Received: from unknown ([::ffff:46.226.16.253])
 by email.seznam.cz (szn-ebox-4.5.348) with HTTP;
 Tue, 26 Feb 2019 17:13:33 +0100 (CET)
From: "Jakub Drnec" <jaydee@email.cz>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: PROBLEM: monotonic clock going backwards on ppc64
Date: Tue, 26 Feb 2019 17:13:33 +0100 (CET)
Message-Id: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.43)
X-Mailer: szn-ebox-4.5.348
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 27 Feb 2019 07:33:00 +1100
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

Hi all,

I think I observed a potential problem, is this the correct place to repor=
t it? (CC me, not on list)

[1.] One line summary: monotonic clock can be made to decrease on ppc64
[2.] Full description:
Setting the realtime clock can sometimes make the monotonic clock go back =
by over a hundred years.
Decreasing the realtime clock across the y2k38 threshold is one reliable w=
ay to reproduce.
Allegedly this can also happen just by running ntpd, I have not managed to=
 reproduce that other
than booting with rtc at >2038 and then running ntp.
When this happens, anything with timers (e.g. openjdk) breaks rather badly=
.

[3.] Keywords: gettimeofday, ppc64, vdso
[4.] Kernel information
[4.1.] Kernel version: any (tested on 4.19)
[4.2.] Kernel .config file: any
[5.] Most recent kernel version which did not have the bug: not a regressi=
on
[6.] Output of Oops..: not applicable
[7.] Example program which triggers the problem
--- testcase.c
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>

long get_time() {
  struct timespec tp;
  if (clock_gettime(CLOCK_MONOTONIC, &tp) !=3D 0) {
    perror("clock_gettime failed");
    exit(1);
  }
  long result =3D tp.tv_sec + tp.tv_nsec / 1000000000;
  return result;
}

int main() {
  printf("monitoring monotonic clock...\n");
  long last =3D get_time();
  while(1) {
    long now =3D get_time();
    if (now < last) {
      printf("clock went backwards by %ld seconds!\n",
        last - now);
    }
    last =3D now;
    sleep(1);
  }
  return 0;
}
---
when running
# date -s 2040-1-1
# date -s 2037-1-1
program outputs: clock went backwards by 4294967295 seconds!

[8.] Environment: any ppc64, currently reproducing on qemu-system-ppc64le =
running debian unstable
[X.] Other notes, patches, fixes, workarounds:
The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettime=
ofday.S.
(possibly because some values used in the calculation are only 32 bit?)
Slightly silly workaround: 
nuke the "cmpwi cr1,r3,CLOCK_MONOTONIC" in __kernel_clock_gettime
Now it always goes through the syscall fallback which does not have the sa=
me problem.

Regards,
Jakub Drnec
