Return-Path: <temerkhanov@yandex.ru>
Received: from smtp1.yandex.ru (smtp1.yandex.ru [213.180.200.14])
	by ozlabs.org (Postfix) with ESMTP id 7DA76DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 05:22:44 +1000 (EST)
Received: from ppp91-78-89-110.pppoe.mtu-net.ru ([91.78.89.110]:21302 "EHLO
	[10.0.0.10]" smtp-auth: "temerkhanov" TLS-CIPHER: <none> TLS-PEER-CN1:
	<none>) by mail.yandex.ru with ESMTP id S8372644AbYESSxV (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Mon, 19 May 2008 22:53:21 +0400
Message-ID: <4831CCA2.6000107@yandex.ru>
Date: Mon, 19 May 2008 22:53:22 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Instruction OCM
References: <012401c8b9c3$74b947c0$5e2bd740$@com>
In-Reply-To: <012401c8b9c3$74b947c0$5e2bd740$@com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

mojtaba wrote:
>
> Dear all,
>
> I cannot run Linux when I have an instruction OCM in my design but, 
> without instruction OCM everything is fine. I tried to do some 
> debugging. It seems that the Linux memory management unit has a 
> problem with that.  After entering the MMU initialization phase, it 
> suddenly jumps to address 0x00000700 it get stuck there. Is there 
> anybody who have tried a design with instruction OCM? Do I need to do 
> special configuration for the Linux kernel?
>
> Regards,
>
> Mojtaba
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
Address 0x700 means invalid opcode exception.
If instruction OCM is same as data OCM (I think it's so) then any MMU 
mapping is not applicable to this region at all as OCM controller 
decodes virtual addresses bypassing any MMU mappings.
In your situation MMU maps virtual address of OCM to physical address 
containing some random data and CPU tries to execute it. So you get 
invalid opcode exception.
