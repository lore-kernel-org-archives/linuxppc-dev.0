Return-Path: <tmbinc@elitedvb.net>
Received: from mail.multimedia-labs.de (mail.multimedia-labs.de
	[82.149.226.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.multimedia-labs.de",
	Issuer "Multimedia Labs CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1C89E67A3F
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 00:55:00 +1000 (EST)
Received: from localhost (localhost [127.0.0.172])
	by mail.multimedia-labs.de (Postfix) with ESMTP id 5361F1C812E
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:22:49 +0200 (CEST)
Received: from mail.multimedia-labs.de ([127.0.0.172])
	by localhost (mail [127.0.0.172]) (amavisd-new, port 10024) with LMTP
	id 04386-01-2 for <linuxppc-dev@ozlabs.org>;
	Fri, 12 May 2006 16:22:47 +0200 (CEST)
Received: from xpc823.intern.randgruppe.info (e176171165.adsl.alicedsl.de
	[85.176.171.165])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.multimedia-labs.de (Postfix) with ESMTP id AAB5B1C80AF
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:22:47 +0200 (CEST)
Received: from [10.0.0.75] (unknown [10.0.0.75])
	by xpc823.intern.randgruppe.info (Postfix) with ESMTP id 1710270373
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 16:23:54 +0200 (CEST)
Message-ID: <44649A59.5050608@elitedvb.net>
Date: Fri, 12 May 2006 16:23:21 +0200
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: 2.6 vs 2.4
References: <7cb1293c0605112351y658460a0x8b793ea12004dbfc@mail.gmail.com>
	<1147442231.9412.9.camel@localhost.localdomain>
In-Reply-To: <1147442231.9412.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Wolfgang Denk has a good listing of issues to consider betn linux 2.4
>>vs 2.6 for ppc82xx based platforms
>>(http://www.denx.de/wiki/Know/Linux24vs26).
>> Would this recommendation still hold?
>> Are there any patches, developments in this area?
> The main open question is: is somebody still maintaining the 8xx kernel
> port ?
The 4xx port has the same problem.

When we switched from 2.4 to 2.6, IDE performance ("hdparm -t" to have a
single number) was reduced by about 25% (even after trying to finetune
the IDE driver - the time between the end of one transfer and the begin
of the next transfer was just too long to saturate the harddisk).

Because of my lack of knowledge of the block device layer's internals I
wasn't able to track that down. My initial plan was to build a trace
using the RiscTrace environment, to see any instruction executed between
requests, but my company moved away from PPC4xx hardware
(unfortunately), so I was never able to complete this. I still believe
that other platforms have the same problems.

On a 300MHz embedded mips machine, saturating a 100MBit network link via
ftp is not easy. Our old 252MHZ PPC machines never performed better than
around 5MB/s (but had a non-DMA NIC, which however could be satured in
theory with about 70% cpu load, based on the bus bandwidth. Why are the
remaining 30% not enough to do IDE DMA and the TCP overhead? Memory
performance? But why did we had better numbers with 2.4 then?).

On that mips machine, both IDE and network support DMA (agreed, it's a
RTL8139, so it requires another memcpy), and memcpy() performance is
>100MB/s. Where is the bottleneck? And, much more important: how do
measure it?

I'm sorry that I can't really much do anything else than complaining,
but all my attempts to track down the problems were futile. I'm not sure
if testing "ftp performance" (as a completely non-synthetic benchmark -
FTP speed is/was a real issue on our platform) is "the right test", but
it's one of the things where i personally want linux to become better.

Or is this just a misconfiguration? Are there mysterious IO scheduler
default parameters which are just suboptimal for our case?

regards,
Felix
