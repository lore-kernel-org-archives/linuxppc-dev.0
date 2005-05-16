Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp05.mail.mci.yahoo.co.jp (ybbsmtp05.mail.mci.yahoo.co.jp
	[210.80.241.154]) by ozlabs.org (Postfix) with SMTP id 83491679F7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 16:52:03 +1000 (EST)
Message-ID: <42884448.6040505@ybb.ne.jp>
Date: Mon, 16 May 2005 15:57:12 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <427BDBCF.8030908@ybb.ne.jp>
	<b8b42fd26b024d5e26060a508600f631@freescale.com>
In-Reply-To: <b8b42fd26b024d5e26060a508600f631@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar:

I'm sorry that the reply becomes slow.

Kumar Gala wrote:
>>
> 
> Any reason you moved this code into DecrementerHandler?
> 
>>   /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>>          START_EXCEPTION(0x1000, Decrementer)
>>  -       NORMAL_EXCEPTION_PROLOG
>> -       lis     r0,TSR_PIS@h
>> -       mtspr   SPRN_TSR,r0             /* Clear the PIT exception */
>>  -       addi    r3,r1,STACK_FRAME_OVERHEAD
>> -       EXC_XFER_LITE(0x1000, timer_interrupt)
>> +       b    DecrementerHandler
>>
Current PIT exception handler is too big.
If it is not moved, compilation is failed with relocation error.
Because current PIT handler overwrites WDT handler's codes, the compiler 
can not relocate PIT and WDT handler correctly.
