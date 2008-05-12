Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 5FBD7DDF76
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 06:53:12 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1409098nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 13:53:09 -0700 (PDT)
Date: Tue, 13 May 2008 00:53:03 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Message-ID: <20080512205303.GA14198@zarina>
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 12, 2008 at 02:24:20PM -0500, Kumar Gala wrote:
>
> On May 12, 2008, at 1:52 PM, Anton Vorontsov wrote:
>
>> On MPC86xx the watchdog could be enabled only at power-on-reset, and
>> could not be disabled afterwards. We must ping the watchdog from the
>> kernel until the userspace handles it.
>>
>> MPC83xx CPUs are only differ in a way that watchdog could be disabled
>> once, but after it was enabled via software it becomes just the same
>> as MPC86xx.
>>
>> Thus, to support MPC86xx I added the kernel timer which pings the
>> watchdog until the userspace opens it.
>>
>> Since we implemented the timer, now we're able to implement proper
>> handling for the CONFIG_WATCHDOG_NOWAYOUT case, for MPC83xx and  
>> MPC86xx.
>>
>> Also move the probe code into subsys_initcall, because we want start
>> pinging the watchdog ASAP, and misc devices are available in
>> subsys_initcall.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/watchdog/Kconfig       |    4 +-
>> drivers/watchdog/mpc83xx_wdt.c |   63 +++++++++++++++++++++++++++++++ 
>> +++++----
>
> we should rename it to mpc8xxx_wdt.c

I don't see much sense in renaming the files just because the driver
now supports another line of processors... Do you really want the rename?
Please repeat if so.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
