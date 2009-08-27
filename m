Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 20A65B7B8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 22:09:01 +1000 (EST)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B69DDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 22:09:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7RC7wZW012132
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 06:07:58 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RC8n4Y252694
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 06:08:49 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7RC8mc4032457
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 06:08:49 -0600
Date: Thu, 27 Aug 2009 08:08:41 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] fix book E watchdog to take WDIOC_SETTIMEOUT arg in
	seconds
Message-ID: <20090827120841.GA25303@zod.rchland.ibm.com>
References: <4A8303C6.7070705@nortel.com>
	<20090827111458.GB29382@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090827111458.GB29382@infomag.iguana.be>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 27, 2009 at 01:14:58PM +0200, Wim Van Sebroeck wrote:
>Hi Chris,
>
>> The WDIOC_SETTIMEOUT argument is supposed to be a "seconds" value.
>> However, the book E wdt currently treats it as a "period" which is
>> interpreted in a board-specific way.
>> 
>> This patch allows the user to pass in a "seconds" value and the driver
>> will set the smallest timeout that is at least as large as specified
>> by the user.  It's been tested on e500 hardware and works as
>> expected.
>> 
>> The patch only modifies the CONFIG_FSL_BOOKE case, the CONFIG_4xx case
>> is left unmodified as I don't have any hardware to test it on.
>> 
>> Signed-off-by: Chris Friesen <cfriesen@nortel.com>
>
>Added with some small changes to keep checkpatch happy. (removed trailing spaces + changed sizeof(struct watchdog_info) to sizeof(ident) and changed some spaces in tabs).
>
>Now we only need someone that can look at the CONFIG_4xx cases still :-)

It seems the FSL watchdog is much more flexible than the one found in 4xx
cores.  On 4xx, you basically have 4 static choices that represent specific
times determined by the clock frequency.  I'm concerned that the lack of
granularity here will result in less than desirable behavior.

For example, with a 400MHz clock you would get choices of roughly:

5.2 ms
83.9 ms
1.34 s
21.47 s

Personally, I consider the first two options basically unusable.  Considering
the second two, if a user were to say "Set the timeout for 2 seconds" they
would then get a timeout of 21 seconds with the framework Chris' patch has
set up.  That doesn't really seem to be ideal to me.

josh
