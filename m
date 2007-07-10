Return-Path: <tmbinc@elitedvb.net>
Received: from mail.multimedia-labs.de (mail.multimedia-labs.de
	[82.149.226.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.multimedia-labs.de",
	Issuer "Multimedia Labs CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5028DDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:05:07 +1000 (EST)
Received: from localhost (localhost [127.0.0.172])
	by mail.multimedia-labs.de (Postfix) with ESMTP id 332FD1C8064
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 02:40:28 +0200 (CEST)
Received: from mail.multimedia-labs.de ([127.0.0.172])
	by localhost (mail [127.0.0.172]) (amavisd-new, port 10024) with LMTP
	id 02037-01-4 for <linuxppc-dev@ozlabs.org>;
	Tue, 10 Jul 2007 02:40:24 +0200 (CEST)
Received: from xpc823.intern.randgruppe.info (e176176217.adsl.alicedsl.de
	[85.176.176.217])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.multimedia-labs.de (Postfix) with ESMTP id BAAE01C803D
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 02:40:24 +0200 (CEST)
Received: from [10.0.0.75] (unknown [10.0.0.75])
	by xpc823.intern.randgruppe.info (Postfix) with ESMTP id C33E07021F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 02:45:15 +0200 (CEST)
Message-ID: <4692D5B1.2040209@elitedvb.net>
Date: Tue, 10 Jul 2007 02:41:21 +0200
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
References: <469270F3.4070206@austin.ibm.com> <46928691.2040008@austin.ibm.com>
	<18066.53384.449544.952545@cargo.ozlabs.ibm.com>
In-Reply-To: <18066.53384.449544.952545@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
>> Fix to correct a possible infinite loop or an always true check when the 
>> unsigned long counter "i" is used in
>> lmb_add_region() in the following for loop:
>> for (i = rgn->cnt-1; i >= 0; i--)
> Unfortunately this won't fix the bug.  Since rgn->cnt is unsigned
> long, the comparison will be done as an unsigned comparison even if i
> is signed.
> Instead, change the loop to go from rgn->cnt down to 1, and in the
> loop body, change all instances of "i+1" to "i", and "i" to "i-1".
What's about

i = rgn->cnt;
while (i--)
...
?

(or  for (i=rgn->cnt; i--; ), if you want a for-loop)


Felix
