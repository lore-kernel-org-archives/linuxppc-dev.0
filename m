Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D002DDF59
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 09:20:26 +1000 (EST)
Date: Fri, 12 Sep 2008 03:20:15 +0400
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <963384709.20080912032015@emcraft.com>
To: "prodyut hazarika" <prodyuth@gmail.com>
Subject: Re[2]: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB
	for
In-Reply-To: <49c0ff980809111537n6ff426f9w6a7629588051ac10@mail.gmail.com>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809111537n6ff426f9w6a7629588051ac10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Prodyut,

Thanks for your comments. Some answers below.

On Friday, September 12, 2008 you wrote:

>>        /*
>>         * Create WS1. This is the faulting address (EPN),
>>         * page size, and valid flag.
>>         */
>> -       li      r11,PPC44x_TLB_VALID | PPC44x_TLB_4K
>> +       li      r11,PPC44x_TLB_VALID | PPC44x_TLBE_SIZE
>>        rlwimi  r10,r11,0,20,31                 /* Insert valid and page =
size*/
>>        tlbwe   r10,r13,PPC44x_TLB_PAGEID       /* Write PAGEID */
>>

> Change
>>        rlwimi  r10,r11,0,20,31                 /* Insert valid and page =
size*/
> to
>>        rlwimi  r10,r11,0,PPC44x_PTE_ADD_M1,31                 /* Insert =
valid and page size*/

 Agree. We'll fix this.

 I guess this works for us, because we used the large EPN mask here
which covered more bits in EPN field of TLB entries, than it was
required for 16/64/256K PAGE_SIZE cases:

TLB Word 0 / bits 0..21:   EPN (Effective Page Number) [from 4 to 22 bits]
TLB Word 0 / bit 22 :      V (Valid bit) [1 bit]
TLB Word 0 / bits 24..27 : SIZE (Page Size) [4 bits]

 Thus, doing 'rlwimi' we masked our V/SIZE bits and cleared EPN for
all 4/16/64/256K PAGE_SIZE cases.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
