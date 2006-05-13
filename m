Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01FB8679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 May 2006 09:22:49 +1000 (EST)
In-Reply-To: <d7b8e9f80605130610v7e0fa0ffx64641c63c4487dfe@mail.gmail.com>
References: <d7b8e9f80605130610v7e0fa0ffx64641c63c4487dfe@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5D4F2E94-6295-4CA7-8226-8209FBE863FB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: board without RTC
Date: Sat, 13 May 2006 18:22:47 -0500
To: Joachim Denil <joachim.denil@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 13, 2006, at 8:10 AM, Joachim Denil wrote:

> Hello,
>
> Can someone tell me what the following functions should do in case  
> there is no RTC on the hardware board. My processor is a 405gpr.  
> Which of these i must implement. (maybe some code snippets...). I  
> think the most important one is calibrate_decr for it is necesary  
> to calibrate_delay function.
>
> Thanks...
>
> Joachim Denil
> Student
>
>
> long (*time_init)(void);
> int (*set_rtc_time)(unsigned long nowtime);
> unsigned long (*get_rtc_time)(void);
> unsigned char (*rtc_read_val)(int addr);
> void (*rtc_write_val)(int addr, unsigned char val);
> void (*calibrate_decr)(void);

You should only need time_init if you need to poke some registers or  
something to get the clocks going.  You are correct about  
calibrate_decr.  All the *rtc* you dont need to bother with.

- k
