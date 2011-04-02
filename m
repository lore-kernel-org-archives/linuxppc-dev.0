Return-Path: <sa212+lppc@cyconix.com>
Received: from queue01.mail.zen.net.uk (queue01.mail.zen.net.uk [212.23.3.234])
	by ozlabs.org (Postfix) with ESMTP id 961ABB6F99
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 11:41:05 +1100 (EST)
Received: from [212.23.3.142] (helo=smarthost03.mail.zen.net.uk)
	by queue01.mail.zen.net.uk with esmtp (Exim 4.63)
	(envelope-from <sa212+lppc@cyconix.com>) id 1Q5ocH-0002gC-4B
	for linuxppc-dev@lists.ozlabs.org; Sat, 02 Apr 2011 00:23:01 +0000
Received: from 82-70-243-134.dsl.in-addr.zen.co.uk ([82.70.243.134]
	helo=[127.0.0.1]) by smarthost03.mail.zen.net.uk with esmtps
	(TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63)
	(envelope-from <sa212+lppc@cyconix.com>) id 1Q5ocD-0000ts-En
	for linuxppc-dev@lists.ozlabs.org; Sat, 02 Apr 2011 00:22:57 +0000
Message-ID: <4D966C5C.9030409@cyconix.com>
Date: Sat, 02 Apr 2011 01:22:52 +0100
From: Evan Lavelle <sa212+lppc@cyconix.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: halt/reset on assert?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'd like to use an assert macro in a device driver for an MPC870 using 
ppcboot; something like:

#define MY_ASSERT(expr)                                         \
    do {                                                         \
       if(!(expr)) {                                             \
          printk(                                                \
             KERN_EMERG                                          \
             "assertion failure: %s, line %d\n",                 \
             __FILE__, __LINE__);                                \
          asm(--ppc halt/reset?)                                 \
       }                                                         \
    } while(0)

However, I've got no idea how to halt or reset the processor here. 
Anyone happen to know?

Thanks -

Evan
