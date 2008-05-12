Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id C63F5DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 00:03:25 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so1885246wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 07:03:22 -0700 (PDT)
Message-ID: <fa686aa40805120703k61e26022lf43aa826a159ccca@mail.gmail.com>
Date: Mon, 12 May 2008 08:03:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Nick <ndroogh@rogers.com>
Subject: Re: MPC5200b external interrupt registration problem
In-Reply-To: <169407.5661.qm@web88102.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169407.5661.qm@web88102.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 9, 2008 at 12:49 PM, Nick <ndroogh@rogers.com> wrote:
> Hi,
>
>  I am writing a driver to service an interrupt from our fpga.  I am calling request_irq in the open
>  function of my driver.  The fpga is connected to external interrupt 1.  I am using interrupt
>  number 65 in the request_irq but the function is failing.  I traced to a function called setup_irq
>  in file /kernel/irq/manage.c.  It fails because at this line: if (desc->chip == &no_irq_chip) .
>  Is 65 the wrong interrupt number?  What do I need to do to properly setup for external interrupts?

What kernel version are you using?
Are you using arch/ppc or arch/powerpc?

There has been a major shift in embedded powerpc support in the last
year.  Now, instead of hard coding the peripheral list in the platform
code, the devices are described in an OpenFirmware style device tree.
(See arch/powerpc/boot/dts/lite5200b.dts).

You need to add a node to the tree for your device and specify the
interrupt there.  Then use either of_irq_map_one() or
irq_of_parse_and_map() to get something that you can pass to
request_irq().

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
