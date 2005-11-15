Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 86DE368746
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 23:37:56 +1100 (EST)
Message-ID: <005301c5e9e1$d4a69ed0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "zjznliang" <zjznliang_popo@163.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <20051115054109.CE1FD68763@ozlabs.org>
Date: Tue, 15 Nov 2005 07:40:55 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: Re: interrupts limit??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Hi ,linuxppc-embedded £¡
>
>   I have done the interrupt request by request_irq() on the Linux 2.4.25
,when typing the 'cat /proc/interrupts', I can see the information as follow
:
>
> /proc # cat interrupts
>            CPU0
>   2:       3420   8xx SIU   Edge      wbga_interrupt
>   5:          0   8xx SIU   Edge      CPM cascade
>  15:          0   8xx SIU   Edge      tbint
>  16:          0   CPM       Edge      error
>  20:        801   CPM       Edge      SMC1
>
> and I can see the number of wbga_interrupt is increasing. But a few
minutes later ,the number is locked at 128000 as follow:
>
> /proc # cat interrupts
>            CPU0
>   2:     128000   8xx SIU   Edge      wbga_interrupt
>   5:          0   8xx SIU   Edge      CPM cascade
>  15:          0   8xx SIU   Edge      tbint
>  16:          0   CPM       Edge      error
>  20:        833   CPM       Edge      SMC1
>
> and there is no wbga_interrupt any more....what's the matter with the
interrupt?why is 128000???
>
>

The problem is not /proc/interrupts, if that's what you're thinking.  The
number can go much
higher.  Believe what it's telling you:  Your driver has a problem and has
stopped generating
interrupts.

Mark Chambers
