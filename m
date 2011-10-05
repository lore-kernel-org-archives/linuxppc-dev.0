Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id AAA3DB6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 03:13:01 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 06620-07 for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 17:06:17 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: scheduling while atomic:
Date: Wed, 5 Oct 2011 17:05:18 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE6F@saturn3.aculab.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE014A35@HYD-MKD-MBX4.wipro.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <smitha.vanga@wipro.com>,
	<scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not entirely relevant to the error you are seeing,
but your ISR is:

>	irqreturn_t cpld_irq_handler(int irq, void * dev_id, struct
pt_regs *regs)
>	{
>		wake_up(&cpld_intr_wait);
>		atomic_inc(&cpld_intr_data); /* incrementing this will
indicate the poll() that the interrupt is occured */
>		return 0;
>	}

You need to set 'cpld_intr_data' before clling wake_up() otherwise
the sleeping process might run on another cpu before the data item
changes.

You also don't need to use the 'atomic' functions.
Writing to a 'volatile' data item is sufficent.
You don't want to count interrupts, just mark they have happened.

Maybe your problem it that the ISR doesn't do anything to
cause the hardware to drop its IRQ.

	David
