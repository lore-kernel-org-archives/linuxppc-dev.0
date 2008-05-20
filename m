Return-Path: <temerkhanov@yandex.ru>
Received: from smtp7.yandex.ru (smtp7.yandex.ru [213.180.200.45])
	by ozlabs.org (Postfix) with ESMTP id B57EBDE071
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 21:11:30 +1000 (EST)
Received: from cifronik.21th.com ([62.16.86.116]:38787 "EHLO
	satanklaus.cifronic.local" smtp-auth: "temerkhanov" TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by mail.yandex.ru with ESMTP id S738521AbYETLL0
	(ORCPT <rfc822;linuxppc-embedded@ozlabs.org>);
	Tue, 20 May 2008 15:11:26 +0400
From: Temerkhanov <temerkhanov@yandex.ru>
To: "mojtaba" <kernelppc@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Instruction OCM
Date: Tue, 20 May 2008 15:11:25 +0400
References: <012401c8b9c3$74b947c0$5e2bd740$@com> <4831CCA2.6000107@yandex.ru>
	<016b01c8ba5a$9a621000$cf263000$@com>
In-Reply-To: <016b01c8ba5a$9a621000$cf263000$@com>
MIME-Version: 1.0
Message-Id: <200805201511.25957.temerkhanov@yandex.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Reply-To: temerkhanov@cifronik.ru
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 20 May 2008 13:19:26 mojtaba wrote:
> Thank you for your email. But what is the solution to that? I have seen
> this in a thesis:
>
> "when using the OCM buses to connect memory, we can only use virtual memory
> as long as the virtual address is the same as the physical address, which
> is conceptually
> the same as using a system without MMU. Therefore porting Linux to a
> system based on an OCM memory system is not possible"
>
> http://ce.et.tudelft.nl/publicationfiles/1367_700_thesis.pdf
>
> Is that right? What do you suggest?
>


Getting OCM-based devices (and even memory) to work in Linux is possible. All 
you need is to setup a mapping with virtual addresses equal to physical (some  
info can be found here: 
http://courses.ece.uiuc.edu/ece412/MP_Files/mp2/20060623-XUP-Linux-Tutorial-REVISION-FINAL.pdf)

Furthermore, if you really need to get the code running from OCM, I'd suggest 
to setup such MMU mapping for OCM region very early - it can be done in 
initial_mmu function at head_4xx.S. Look at line 936 (#if 
defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE))
 - that's very good point to start.

Regards, Sergey Temerkhanov
