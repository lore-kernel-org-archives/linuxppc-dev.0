Return-Path: <SRS0=4hcN=S7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA1C43219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Apr 2019 16:14:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB3420673
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Apr 2019 16:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB3420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44t8qJ3cF4zDqDW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2019 02:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44t8Vd4xf4zDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2019 01:59:36 +1000 (AEST)
Received: from [192.168.1.110] ([77.9.18.117]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MauJJ-1gnRUd2VPH-00cTXC; Mon, 29 Apr 2019 17:59:00 +0200
Subject: Re: [PATCH 37/41] drivers: tty: serial: 8250: simplify io resource
 size computation
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 linux-kernel@vger.kernel.org
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-38-git-send-email-info@metux.net>
 <ba6dd5fa-36f1-902d-1ab4-c99e6a5ea3c2@physik.fu-berlin.de>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <7cec8c1a-a0a1-e76c-5c1f-a93c591d38b1@metux.net>
Date: Mon, 29 Apr 2019 17:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ba6dd5fa-36f1-902d-1ab4-c99e6a5ea3c2@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CLf6r+MSAE0A4USN6XIxWhLYiiz7bFAjEZVPWrDPzur1ECJt0Dg
 WbYbQxU9nNzapCPvww6NjJvdrqK+oNAJiHa6aeJbsi2v+NNA3fVkvAbLsn9n9KHoQGVfEzu
 N+fU79yInZYR1o784E8xzkrBIVHBDIoXmbRCOVD9oIABn/6VuVCGtjTlkSJlu3jg09HB7dD
 Ufze2K3kEFv4OnGLo+gYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c27b6UNW+M4=:Grv1CtdyDBcKDa6l5mVHjZ
 /D5eSBrMPo3nbal/qhD4JNTHZyIPmW+9PmXzwasR3bvmu01e4+e2/3REGNSHwZxpkqLIGKodv
 ngYXgywcAOndcT8KE1/CuZofSYrmrAtEKQg5qlBJvr+2yLpZxHva3ZCySbjq4tELVZUuPdKzR
 mEH6F8OQyT3xrEHoSc7e2QtCnWzxPxFbLx0iNnVNMfYEGoWKwVYyxWCWBQfwyRiy8Xls39WN3
 SDVgbyj7EImrGH9tgrtGkiwmjLoL4/Rb+O7KV8WFUCUwFDWfAapwIjNLi4DG1uD5qSVby6tg8
 xebSwSzH897s+7rcBH8fktM61frzzF2LtbCrjUQtxgWEGx8HmSycnqiNvsA8b9j7qHIY7PS2q
 P7j9mNJIltvQ9EZfT6EKeoPPPiKUb7Qxnq/lT1j6urv1655S1aqXVqGiR52p6pxci7e3STqFq
 WLToNwpFIBh0RZPtK0M9x1ljflXL2VYftmJO9JDAV7pDfMAtZq9tFP6PY8qaSELxX4LLivmvk
 PYlcrryV6+L1vAC2u/2tmg4poWrAgzzJi7UHbVCRwJPsx/voMQs4qhjp/yoCaND9PsJR2WD75
 Gi4sG/UZDQuUBmgY0L4oojNnw35PQrvO23nhJNHyzfGWEOdREVFSfAezaxcTHB6jH/olj6znw
 FQyJnUtrLFo04vaUyAW1Ja2Z09d8ocw78d4WnTdL4e95OakfRdw1InQcZq+Ldjbg1Gd6rRu7c
 KFOAwvaPDDf7d09bUPEBh9UlXxdk27dus0wWpVdGd3IBTsygMbjdJgUTyjA=
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
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org,
 linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org,
 vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org,
 khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com,
 matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 27.04.19 15:03, John Paul Adrian Glaubitz wrote:
> On 4/27/19 2:52 PM, Enrico Weigelt, metux IT consult wrote:
>> Simpily io resource size computation by setting mapsize field.
>     ^^^^
> Here's a typo

thx. fixed.

--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
