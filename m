Return-Path: <daniel.ng1234@gmail.com>
Received: from mail-px0-f108.google.com (mail-px0-f108.google.com
	[209.85.216.108]) by ozlabs.org (Postfix) with ESMTP id 8DEB4DDFA9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 10:51:50 +1000 (EST)
Received: by pxi6 with SMTP id 6so2062027pxi.17
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 17:51:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090528123311.GA3112@pengutronix.de>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl> <20090528123311.GA3112@pengutronix.de>
Date: Fri, 29 May 2009 10:46:30 +1000
Message-ID: <547eba1b0905281746h970028br9685085d18dceb6e@mail.gmail.com>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27- "no_irq_chip"
	error
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 28, 2009 at 10:33 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> this is an example of how a simple 8313 Periodic Interval Timer (PIT) kernel driver
>> registers for the PIT IRQ (Interrupt ID 65)
>>
>> #define PIT_IRQ 65
>>
>>     virq = irq_create_mapping(NULL, PIT_IRQ);
>>     set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
>>
>>     if(request_irq(virq, (irq_handler_t)timerEvent, 0, "timer2", (void *)0)) {
>>         printk(KERN_ERR "request_irq() returned error for irq=%d virq=%d\n", PIT_IRQ, virq);
>>     }
>
> It is some time ago, but when I did something similar I needed the
> following patch in order to use NULL for irq_create_mapping(). Have a
> try, and if it is still needed (as it looks from a glimpse), then maybe
> we should get it merged?
>
> ===
>
> From: Wolfram Sang <w.sang@pengutronix.de>
> Subject: [PATCH] powerpc/cpm2: make cpm2_pic the default host
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  arch/powerpc/sysdev/cpm2_pic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
> index 78f1f7c..7a7d4e5 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -272,4 +272,5 @@ void cpm2_pic_init(struct device_node *node)
>                printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
>                return;
>        }
> +       irq_set_default_host(cpm2_pic_host);
>  }

Thanks guys.

I can confirm that Wolfram's patch above is required to get Norbet's
suggestion to work. Without the patch, I still get the original
symptoms. I have tested this on 2.6.27.19.

Daniel
