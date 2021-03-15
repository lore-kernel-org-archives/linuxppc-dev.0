Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7504C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 08:11:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9060F64E81
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 08:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9060F64E81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzTf71F7Bz303b
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 19:11:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzTdn46mpz2xfZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 19:11:22 +1100 (AEDT)
Received: from [192.168.0.2] (unknown [95.90.234.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7A96A20645D6F;
 Mon, 15 Mar 2021 09:11:13 +0100 (CET)
Subject: Re: VIO bus not initialized
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <41c04182-20c1-6124-a221-90aef704e310@molgen.mpg.de>
 <87mtv44zut.fsf@mpe.ellerman.id.au>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <90e6a559-0908-684c-9156-5f3da2b02e38@molgen.mpg.de>
Date: Mon, 15 Mar 2021 09:11:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87mtv44zut.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dear Michael,


Thank you very much for your response.


Am 15.03.21 um 08:53 schrieb Michael Ellerman:
> Paul Menzel writes:

>> On the POWER8 system IBM S822LC, Linux 5.12-rc2+ logs the errors below.
> 
> That's a bare metal system, you can see that from the line "Using
> PowerNV machine description" in the boot log.
> 
>>       $ dmesg --level=err
>>       [    1.555668] Driver 'hvc_console' was unable to register with bus_type 'vio' because the bus was not initialized.
>>       [    1.558434] Driver 'tpm_ibmvtpm' was unable to register with bus_type 'vio' because the bus was not initialized.
>>       $ grep VIO /boot/config-5.12.0-rc2+
>>       CONFIG_IBMVIO=y
> 
> The "vio" bus is not a real bus, it's a fake bus we use for hypervisor
> provided devices in LPARs (guests).
> 
> So on bare metal machines there is no vio bus, the devices that would
> appear on the vio bus are found via other mechanisms.

Thank you for the explanation. Two questions:

1.  Could a bare metal system be detected, and the VIO “be skipped”?
2.  Should the log level be changed to notice or info then, as it’s an 
expected failure?

[…]


Kind regards,

Paul
