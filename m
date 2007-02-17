Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3661FDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Feb 2007 07:27:35 +1100 (EST)
Message-ID: <45D76532.2090508@garzik.org>
Date: Sat, 17 Feb 2007 15:27:30 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2, resend] gianfar: don't duplicate gfar_error()
References: <200702151656.01313.sshtylyov@ru.mvista.com>
In-Reply-To: <200702151656.01313.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> It was hardly necessary to repeat most of the code from gfar_error() in
> gfar_interrupt(), especially having some inconsistencies between the two.
> So, make the gfar_interrupt() just call gfar_error(), and not acknowledge
> the interrupts itself as gfar_{receive/transmit/error}() do it anyway.
> While at it, also clarify/cleanup debug messages in gfar_error()...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch survived netperf stressing on MPC8540ADS realtime kernel. :-)
> 
> Sorry, forgot to remove the obsolete regs argument from gfar_error() call,
> call, so the previous version wasn't even compilable -- I've tested the patch
> in the older kernel. Resending now with better placed comments which you won't
> have to edit out... :-<
> 
>  drivers/net/gianfar.c |   85 ++++++++------------------------------------------
>  1 files changed, 15 insertions(+), 70 deletions(-)

applied.  thanks for resending with your comments moved after the "---" 
terminator
