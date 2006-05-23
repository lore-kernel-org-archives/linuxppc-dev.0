Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C6769679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 01:11:29 +1000 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k4NFBPs05788
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 May 2006 20:11:25 +0500
Date: Tue, 23 May 2006 19:11:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: UART DRIVER on 2.6.15
Message-ID: <20060523191126.2d54583d@vitb.ru.mvista.com>
In-Reply-To: <3348e5d9925e49e2badcd00d615156b4@pobox.sk>
References: <3348e5d9925e49e2badcd00d615156b4@pobox.sk>
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

On Tue, 23 May 2006 14:02:49 +0200
"Ladislav Klenovič" <lk99336@pobox.sk> wrote:

> Hi,
> just a simple question, is uart driver for kernel 2.6.15 complete. 
> There are some parts like:
>  void scc1_lineif(struct uart_cpm_port *pinfo)
> {
>         /* XXX SCC1: insert port configuration here */
>         pinfo->brg = 1;
> }
> ....
> that seems to incomplete. Am I able to do something with SCC1 with the current cpm_uart code?
> 
> Maybe stupid question, is there any way (is it possible) to import old uart driver from kernel 2.4.x to kernel 2.6.x
> 

It is clear, that per-board tune-up is too specific to be kept within drivers/ and now it is accomplished in the board setup code. 

Just have a look at arch/ppc/platforms/mps866ads_setup.c The thing you'll have to do is implement the pin tune-up for your board in a function, and set the callback pointer to it - it will be executed at the time UART initializes its resources.

-- 
Sincerely, 
Vitaly
