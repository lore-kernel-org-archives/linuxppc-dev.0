Return-Path: <timur.tabi@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 65512DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 07:18:34 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so2234443rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 12:18:31 -0800 (PST)
Message-ID: <ed82fe3e0811171218n2030535ena8bad87abd6149f@mail.gmail.com>
Date: Mon, 17 Nov 2008 14:18:31 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: udbg based backend for hvc_console
In-Reply-To: <20081024035434.GF4267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081024035434.GF4267@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 9:54 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:

One other thing ...

> --- working-2.6.orig/drivers/char/Makefile      2008-10-22 15:50:59.000000000 +1100
> +++ working-2.6/drivers/char/Makefile   2008-10-24 14:22:59.000000000 +1100
> @@ -50,6 +50,7 @@ obj-$(CONFIG_HVC_BEAT)                += hvc_beat.o
>  obj-$(CONFIG_HVC_DRIVER)       += hvc_console.o
>  obj-$(CONFIG_HVC_IRQ)          += hvc_irq.o
>  obj-$(CONFIG_HVC_XEN)          += hvc_xen.o
> +obj-$(CONFIG_HVC_UDBG)         += hvc_udbg.o

HVC console drivers must be compiled before hvc_console.o, so the
above should look like this:

obj-$(CONFIG_HVC_XEN)          += hvc_xen.o
obj-$(CONFIG_HVC_UDBG)         += hvc_udbg.o
obj-$(CONFIG_HVC_DRIVER)       += hvc_console.o
obj-$(CONFIG_HVC_IRQ)          += hvc_irq.o

see http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=938473b24636d77dc5e9c3f41090d071b6cf4389

-- 
Timur Tabi
Linux kernel developer at Freescale
