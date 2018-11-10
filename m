Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A003C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 08:58:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8722920858
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 08:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ouOrkbGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8722920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42sWBb2C7PzDrS2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:57:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="ouOrkbGO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::10; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="ouOrkbGO"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42sW7z3bvFzF3g7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 19:55:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541840140;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:Message-Id:Subject:Date:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=oyCz38EIAm1S8LD4u1t7eRTwjli1i5sAnDgM5SIQuMc=;
 b=ouOrkbGOsmurTamMW9VQD53Rk0kQ8iTLsebJOwwrUt+jXU5CseFZ5yN4w7zR5jCjCQ
 34zPQWIjHEJ4qh5UeSfvRKrNBwfsob1TZuw9h7ZHcxCFTCuqN2MESOWjtvH2t1MMJV81
 xOsLD1l8YKQnyvHQhTbV2Dfv/7dp+ZBwEOnsF35VcVK2T1PuOYJS1OwSIZkQWI2TsQmw
 h2oZebdg0qK4Mr+pdfrDygUDPNNXcNa125kV4l2cePHaNj7QVGJz7qsNHGgfibWSCc0y
 IRYE1g6xdqlK6azIVo5n6mX7X0iNOjdWUUxloJ38bEBrPcCPJtb23k50Q4kbi/P58GTV
 TdmQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exnpklfsPAcEXIhf+TXXpH3idDH6jgw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:d03d:a726:13a5:bb77]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cuAA8tO5kv
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Sat, 10 Nov 2018 09:55:24 +0100 (CET)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Sat, 10 Nov 2018 09:55:24 +0100
Subject: PA6T little endian mode: ppc64le kernels possible?
Message-Id: <00D47799-9ECA-4311-8AB3-38A2DE616385@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org, olof@lixom.net, mpe@ellerman.id.au
X-Mailer: iPhone Mail (15G77)
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

Hi All,

I read the following:

The part that is debatably the heart of the chip is a PowerPC core called th=
e PA6T, a full blown 64-bit PPC with an FPU, VMX extensions and hypervisor s=
upport. It fully conforms to the PowerPC 2.04 architecture spec, and can ope=
rate in both big and little-endian modes.

=E2=80=94-

Is it possible to boot a ppc64le kernel on the PA6T?

Thanks,
Christian=
