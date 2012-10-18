Return-Path: <glikely@secretlab.ca>
Received: from mail-da0-f42.google.com (mail-da0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 610E62C0098
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 09:59:50 +1100 (EST)
Received: by mail-da0-f42.google.com with SMTP id z17so3108145dal.15
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 15:59:48 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CACxGe6uehfQZOxhtBfUYR47mQq+620A=pvpRM=9O8FoUX9eg7w@mail.gmail.com>
References: <5521875.6lkx8Qvfk5@ernie> <2594570.cnhHoOP5cq@ernie>
 <CACxGe6tdpCiZtpvrb7VUz9=mc6DqG6wO-Z5axaBMzuU2Y14GmA@mail.gmail.com>
 <3999612.yr3XeWjcOk@ernie>
 <CACxGe6uehfQZOxhtBfUYR47mQq+620A=pvpRM=9O8FoUX9eg7w@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Oct 2012 23:59:28 +0100
Message-ID: <CACxGe6sbHWcNZE+s66NRmEAkYLzpjrAXC=--042PuLuHttMH0w@mail.gmail.com>
Subject: Re: PROBLEM: Linux 3.6.2 fails to boot on IBM Cell
To: Dennis Schridde <devurandom@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2012 at 11:44 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Oct 18, 2012 at 10:59 PM, Dennis Schridde <devurandom@gmx.net> wrote:
>> Am Donnerstag, 18. Oktober 2012, 22:32:55 schrieb Grant Likely:
>>> Unfortunately the debug messages don't show up in the console log by
>>> default. Can you either send the output of 'dmesg' after booting, or
>>> add "loglevel=8" to the kernel boot parameters?
>> Here you go.
>>
>> I also see some lines like:
>> irq: no irq domain found for /axon@10000000000/plb5/pciex-utl@a00000a000004000
>> Is that also a problem?
>
> [cc'ing linuxppc-dev]
>
> Okay, so what is happening is that the function cbe_init_pm_irq() is
> trying to set up hwirq numbers 0x7e, 0x17e, 0x27e and continuing up
> every 0x100 to 0xff7e. This happens because that function is
> calculating the hwirq number used for_each_node, and shifts the node
> number up 8 bits to make up the upper bits of the hwirq number.
> However, according the the header file, only '0' and '1' are actual
> valid values for the upper bits.
>
> CONFIG_NODES_SHIFT = 8 for PowerPC 64, which accounts for the range 0..0xff.
>
> arch/powerpc/platforms/cell/interrupt.h defines the values of
> IIC_IRQ_NODE_SHIFT = 8 and IIC_IRQ_NODE_MASK 0x100.
>
> So, from the context, I assume the function is trying to set up a PM
> interrupt for each CPU in the Cell processor; and that there are 2 of
> them. for_each_node() knows nothing of this and dutifully tries to set
> up the irq for 256 processors; way beyond what is valid for the irq
> controller.
>
> Also, it should be noted that the irq does actually get set up by
> irqdomain.c, but because everything above 0x1ff is larger than the
> lookup table, it complains. The new code complains loudly (as you
> discovered) if someone tries to use a hwirq larger than the map where
> the old code didn't.
>
> Looks to me like the fix is to change for_each_node() to something as
> simple as "for (i = 0; i < 2; i++)"

As for the next failure seen in that log, it would appear that the
MPIC ->map hook, mpic_host_map(), is failing on some mappings, but it
does appear that it has some legitimate reasons for doing so. The
difference now is that I changed irqdomain code to complain about it.
That is probably an overreach, or at least it should be yelling quite
so much about it.

g.
