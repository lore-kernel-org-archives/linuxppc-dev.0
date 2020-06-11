Return-Path: <SRS0=eRxT=7Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 19:46:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8F620792
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 19:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8F620792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49jZ9Y1rJdzDqqK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 05:46:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.230; helo=relay10.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49jZ6w1DPczDqWg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2020 05:44:05 +1000 (AEST)
Received: from [192.168.1.11] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr
 [90.112.45.105]) (Authenticated sender: alex@ghiti.fr)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id B3F6E240004;
 Thu, 11 Jun 2020 19:43:56 +0000 (UTC)
From: Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v5 2/4] riscv: Introduce CONFIG_RELOCATABLE
To: Jerome Forissier <jerome@forissier.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <Anup.Patel@wdc.com>, Atish Patra <Atish.Patra@wdc.com>,
 Zong Li <zong.li@sifive.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
References: <20200607075949.665-1-alex@ghiti.fr>
 <20200607075949.665-3-alex@ghiti.fr>
 <b588dd9e-dff8-3458-0c7d-149e3990bca7@forissier.org>
Message-ID: <43ef1623-2186-aa07-cfa5-d618aa4f09c0@ghiti.fr>
Date: Thu, 11 Jun 2020 15:43:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b588dd9e-dff8-3458-0c7d-149e3990bca7@forissier.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
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
Cc: Anup Patel <anup@brainfault.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Jerome,

Le 6/10/20 à 10:10 AM, Jerome Forissier a écrit :
> On 6/7/20 9:59 AM, Alexandre Ghiti wrote:
> [...]
>
>> +config RELOCATABLE
>> +	bool
>> +	depends on MMU
>> +	help
>> +          This builds a kernel as a Position Independent Executable (PIE),
>> +          which retains all relocation metadata required to relocate the
>> +          kernel binary at runtime to a different virtual address than the
>> +          address it was linked at.
>> +          Since RISCV uses the RELA relocation format, this requires a
>> +          relocation pass at runtime even if the kernel is loaded at the
>> +          same address it was linked at.
> Is this true? I thought that the GNU linker would write the "proper"
> values by default, contrary to the LLVM linker (ld.lld) which would need
> a special flag: --apply-dynamic-relocs (by default the relocated places
> are set to zero). At least, it is my experience with Aarch64 on a
> different project. So, sorry if I'm talking nonsense here -- I have not
> looked at the details.
>
>

It seems that you're right, at least for aarch64 since they specifically 
specify the --no-apply-dynamic-relocs option. I retried to boot without 
relocating at runtime, and it fails on riscv. Can this be arch specific ?

Thanks,

Alex

