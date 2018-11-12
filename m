Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 07:13:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53C921582
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 07:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="j1Q/+aFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53C921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42thmw1yyJzF25Y
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 18:13:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="j1Q/+aFJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::1; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="j1Q/+aFJ"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42thkL5QYfzF3H3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 18:11:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1542006657;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=kfIwnaEvid1mGmCyi5shKvMOFOGvLCEqOKMMZ+/YNpU=;
 b=j1Q/+aFJ8kYmwANo3dhJEXVFJ0vEG+KfH0f5M5ThWaiDk1SCdwtHRoN3X7Te9I/rtB
 dp5C8GmUkluxHE5Pvi9ClcLa1vfjEk43lPyQCtP0LxaMOTjoBJjh7pzorLunX7AByYF/
 +CWDQZt/8Op2C4s5gxqsyw65CiJx8zsrjt2a5aKGn4zP9rcfuROmeHHKPC0v28QSfxmW
 wWJyDyqR50IYtyROB7oJahlrNcY3gw9ds++mGAQaF9hP3hASsjDgeblLnjRexJ9uBp4j
 KT8V0ri+XgHLTKbeyFjLRB+KGQAhkXqDILrGbHXSNsExcTh1bNWiuLfGB9p7k/q5P8+H
 QLLA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkM2rafobnJ8vgXPzfz+bwWKblvlA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:3d38:a00b:5cd8:a6fe]
 by smtp.strato.de (RZmta 44.3 AUTH) with ESMTPSA id Z0624cuAC7AtBJh
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 12 Nov 2018 08:10:55 +0100 (CET)
Subject: Re: PA6T little endian mode: ppc64le kernels possible?
To: Olof Johansson <olof@lixom.net>
References: <00D47799-9ECA-4311-8AB3-38A2DE616385@xenosoft.de>
 <CAOesGMhYpqze9Yi39C8Ub4GyrWWfAe1y6HLjhS2RnsrK-LBmtg@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <5dbdedea-00fc-51d2-d3d9-4d379f1665dc@xenosoft.de>
Date: Mon, 12 Nov 2018 08:10:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMhYpqze9Yi39C8Ub4GyrWWfAe1y6HLjhS2RnsrK-LBmtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10 November 2018 at 8:20PM, Olof Johansson wrote:
 >
 >
 > On Sat, Nov 10, 2018 at 00:55 Christian Zigotzky 
<chzigotzky@xenosoft.de> wrote:
 >
 >     Hi All,
 >
 >     I read the following:
 >
 >     The part that is debatably the heart of the chip is a PowerPC 
core called the PA6T, a full blown 64-bit PPC with an FPU, VMX 
extensions and hypervisor support. It fully conforms to the PowerPC 2.04 
architecture spec, and can operate in both big and little-endian modes.
 >
 >     —-
 >
 >     Is it possible to boot a ppc64le kernel on the PA6T?
 >
 >
 > Nobody has done the work to get the kernel to work in little endian 
on these platforms. I wouldn't expect it to work without quite a bit of 
effort.
 >
 >
 > -Olof


Thank you for your answer.
