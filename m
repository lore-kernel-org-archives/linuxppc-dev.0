Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF2C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 20:16:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7276920659
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 20:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7276920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439n1K1VTtzDrV2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 07:16:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439myr63lBzDrL2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 07:14:12 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 439myn3XkTz9tyh6;
 Thu,  6 Dec 2018 21:14:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ihVLVx7cdeCk; Thu,  6 Dec 2018 21:14:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 439myn28CBz9tyh5;
 Thu,  6 Dec 2018 21:14:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BFF68B89D;
 Thu,  6 Dec 2018 21:14:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qQSpKWnuL71A; Thu,  6 Dec 2018 21:14:09 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7622D8B88E;
 Thu,  6 Dec 2018 21:14:05 +0100 (CET)
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
To: Daniel Thompson <daniel.thompson@linaro.org>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <77351ea7-e153-d293-1016-2dd45cf96fee@c-s.fr>
Date: Thu, 6 Dec 2018 21:14:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: Rich Felker <dalias@libc.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-sh@vger.kernel.org, x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, nios2-dev@lists.rocketboards.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>,
 kgdb-bugreport@lists.sourceforge.net, Ley Foon Tan <lftan@altera.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 06/12/2018 à 15:09, Daniel Thompson a écrit :
> On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
>> MIPS is the only architecture modifying arch_kgdb_ops during init.
>> This patch makes the init static, so that it can be changed to
>> const in following patch, as recommended by checkpatch.pl
>>
>> Suggested-by: Paul Burton <paul.burton@mips.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
>  From my side this is
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Since this is a dependency for the next patch I'd be happy to take via
> my tree... but would need an ack from the MIPS guys to do that.

Got an ack from MIPS:
Acked-by: Paul Burton <paul.burton@mips.com>

Included in commit text v2

Christophe

> 
> 
> Daniel.
> 
>> ---
>>   arch/mips/kernel/kgdb.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
>> index eb6c0d582626..31eff1bec577 100644
>> --- a/arch/mips/kernel/kgdb.c
>> +++ b/arch/mips/kernel/kgdb.c
>> @@ -394,18 +394,16 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>>   	return -1;
>>   }
>>   
>> -struct kgdb_arch arch_kgdb_ops;
>> +struct kgdb_arch arch_kgdb_ops = {
>> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> +	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
>> +#else
>> +	.gdb_bpt_instr = { break_op, 0x00, 0x00, spec_op << 2 },
>> +#endif
>> +};
>>   
>>   int kgdb_arch_init(void)
>>   {
>> -	union mips_instruction insn = {
>> -		.r_format = {
>> -			.opcode = spec_op,
>> -			.func	= break_op,
>> -		}
>> -	};
>> -	memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
>> -
>>   	register_die_notifier(&kgdb_notifier);
>>   
>>   	return 0;
>> -- 
>> 2.13.3
>>
