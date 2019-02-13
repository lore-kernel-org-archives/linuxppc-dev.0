Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1109CC282CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:11:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599BF222B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599BF222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zxfX10qZzDqH5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 22:11:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zxcQ4yyjzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:09:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43zxcQ2jp3z8svg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:09:26 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43zxcQ22Smz9s7h; Wed, 13 Feb 2019 22:09:26 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=emerson.com
 (client-ip=162.253.133.57; helo=n7.nabble.com;
 envelope-from=sachin.gosavi@emerson.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=emerson.com
X-Greylist: delayed 469 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Feb 2019 22:09:25 AEDT
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 43zxcP5LWwz9s7T
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2019 22:09:24 +1100 (AEDT)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id 1A66C9B50167
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2019 04:01:31 -0700 (MST)
Date: Wed, 13 Feb 2019 04:01:31 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1550055691105-0.post@n7.nabble.com>
Subject: Kernel panic when loading the IDE controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

I have been working on porting Linux-4.15.13 kernel on our existing MPC8270
processor board. For this exercise, I have used pq2fads as a reference
board, its associated device tree and used cuImage for building the kernel.
I am facing an issue with the generic IDE flash controller driver in the new
kernel source where it fails to detect the Flash controller connected to 2GB
NAND flash available on the board. We have used non-standard IO port
addresses for this driver in the older kernel and I have added the required
code in the new kernel to setup the set of addresses that we need as IO
ports. Also, modified the code in the drivers/ide/ source to use the
non-standard IO port address. However, during boot up while inserting the
module I continue to get the below errors.

[    4.116587] ide: forcing hda as a disk (3543/255/63)
[    4.184190] Probing IDE interface ide0...
[    4.226330] Machine check in kernel mode.
[    4.233809] Caused by (from SRR1=49030):
[    4.233826] Transfer error ack signal
[    4.249263] IN from bad port e000000e at 004123ef

I understand that this is an addressing issue but not sure exactly what am I
missing to fix the problem. Can you provide me your inputs on debugging this
issue?

Thanks,
Sachin.




--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
