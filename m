Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URI_NO_WWW_BIZ_CGI autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE0ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 04:05:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BDD20645
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 04:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="YhNrZSW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BDD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42d5fD5GyGzDrhR
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 15:05:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="YhNrZSW9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::4; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="YhNrZSW9"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42d5bk4jl0zDrcY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2018 15:03:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1540094590;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:Message-Id:Subject:Date:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=/8oeOf1G8h8KLV4Nd0EZABCJ5OLGO21xbPB99KWk2DY=;
 b=YhNrZSW9z1U5w+uNevGRcDNfWQfGGzpdT0AzqYWmAdGurUlFUxaTIgUXvvAytEW1fA
 1u295G3bLKL/gFinRZ90qkHIvEylBmnsheG4nzE3gNGexA0jQJJ5bWNedl0kbEj1nN77
 2IKeXSdzmxqY13Q40UYW12CyOmnfHGcHULXQWrlRCT0Q4u/FCLIuaP39LPzvjO3Z1dsu
 6JzQMJTRv4LGmO0Ay8OYT5cj7DOgtcr3N6tcwkJ4ZY5AzDP+ciQiDEZC45kpyzdFzyxd
 AO+TaT1RYuQ9iMC13tyB8NfO8c8MRsbVv9Hp7oZAgNHattVsHkfdUZ4mZvxF0wBGtoTS
 2lGA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4tFIFSaQ9BUYXIIL2Ig3"
X-RZG-CLASS-ID: mo00
Received: from [10.75.136.238] by smtp.strato.de (RZmta 44.3 DYNA|AUTH)
 with ESMTPSA id Z0624cu9L43ASAK
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 21 Oct 2018 06:03:10 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Sun, 21 Oct 2018 06:03:10 +0200
Subject: FSL/NXP P5020: USB problems with the latest Git kernel
Message-Id: <A994D5E8-201D-407D-8666-C7E83A7659FC@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
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

Hi Scott,

Many thanks for the hint. We will test it.

http://forum.hyperion-entertainment.biz/viewtopic.php?f=3D58&t=3D4138&p=3D45=
818#p45818

Cheers,
Christian

Sent from my iPhone

On 21. Oct 2018, at 00:55, Scott Wood <oss@buserror.net> wrote:

On Wed, 2018-08-29 at 18:30 -0500, Scott Wood wrote:
On Tue, 2018-08-28 at 20:13 +0100, Darren Stevens wrote:
Hello Scott

On 27/08/2018, Scott Wood wrote:
On Mon, 2018-08-27 at 20:15 +0200, Christian Zigotzky wrote:
Hello,

Our users tested the RC1 of kernel 4.19 on their P5020 boards today.
Unfortunately the USB bug still exists. With mem values bigger than
4096M,
the USB mouse and keyboard doesn't work. With the bootarg mem=3D4096M,
the
USB
devices work without any problems. Please compile the RC1 and test it
on
your P5020 board. There is a problem with the memory management since
22/08/18.=20

I just tested 4.19-rc1 on a T4240 and got a similar problem with
MMC.  MMC
and
USB on these chips both have a 32-bit DMA limitation.  I'll look into
it.

I've run a bisect locally on my system and found the following bad commit:

# first bad commit: [1b1eeca7e4c19fa76d409d4c7b338dba21f2df45] init: allow
initcall tables to be emitted using relative references

I can't see why this would fail though, and it only seems to affect fsl
machines, and on mine it killed the onboard sata as well.

Hope this helps.


The patch is changing the order of initcalls.  swiotlb_setup_bus_notifier()
and corenet_gen_publish_devices() are both machine_arch_initcall(), and if
the
latter happens before the former, then the bus notifier gets missed and
swiotlb doesn't get used.

While it would be nice to fix this ordering dependency at some point, the
change was reverted on PPC by commit ff69279a44e9ba876466 ("powerpc: disable=

support for relative ksymtab references").

-Scott

