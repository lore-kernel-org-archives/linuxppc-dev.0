Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5B1A367BAF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 23:07:42 +1000 (EST)
Date: Thu, 17 Aug 2006 08:02:54 -0500
From: Milton Miller <miltonm@bga.com>
To: jiehanca@yahoo.com.cn, linuxppc-embedded@ozlabs.org,
Subject: Re: boot kernel 2.6.18 is hang???
Message-Id: <311558197741190cde74.1726956429.miltonm@bga.com>
In-Reply-To: <20060816091103.75046.qmail@web15105.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On  Wed Aug 16 2006 04:11:03 AM CDT, jie han wrote:
> I am trying to take a working embedded linux system from kernel 2.4 to 
> 2.6. The hardware is a custom board using a mpc8270vr processor.
> The working system uses u-boot 1.1.4 with linux kernel 2.4.24.
> 
> I am using the same u-boot and I am trying to port linux kernel 2.6.18. 
> I believe I have done everything required to get the kernel booting. However, the kernel 
> seems to hang after being uncompressed. Here is what I see after running 
> bootm from u-boot:
...
> log_buf context is
> OLT=> md 1b9d60 100
> 001b9d60: c020c0a4 00004000 00000000 ffffffff    . ....@.........
> 001b9d70: 00000001 c01b9d74 c01b9d74 00000001    .......t...t....
> 001b9d80: c01b9d80 c01b9d80 ffffffff 61637175    ............acqu
> 001b9d90: 6972655f 636f6e73 6f6c655f 73656d00    ire_console_sem.
> 001b9da0: 63616c6c 5f636f6e 736f6c65 5f647269    call_console_dri
> 001b9db0: 76657273 00000000 ffffffff 00000001    vers............
>
> Any ideas would be appreciated.

On 2.6, log_buf is a pointer so that the kernel can switch to a different
sized dynamically allocated buffer on command line request.   You
can just follow it to find out what to read, or just lookup __logbuf
which is the initial value and used when you don't specify a new size.

milton
