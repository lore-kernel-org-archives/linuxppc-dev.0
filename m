Return-Path: <tony.p.lee@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.198])
	by ozlabs.org (Postfix) with ESMTP id 3C4E92BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 08:40:51 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so5226964rnk
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 07 Oct 2004 15:40:43 -0700 (PDT)
Message-ID: <470b63970410071534422f6617@mail.gmail.com>
Date: Thu, 7 Oct 2004 15:34:00 -0700
From: Tony Lee <tony.p.lee@gmail.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
In-Reply-To: <41641222.6080405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <000001c4aace$245a5060$6500a8c0@PortatileLG>
	<35fb2e5904100508157a393ee2@mail.gmail.com>
	<4162C649.6060900@ru.mvista.com>
	<35fb2e590410051507367017a@mail.gmail.com>
	<41641222.6080405@ru.mvista.com>
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org,
	Luca Giuliani <l.giuliani@tiscali.it>
Subject: Re: Linux on Memec Virtex II Pro V4P7 Rev. 3
Reply-To: Tony Lee <tony.p.lee@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 06 Oct 2004 19:41:22 +0400, Andrei Konovalov
<akonovalov@ru.mvista.com> wrote:
> Jon Masters wrote:
> > On Tue, 05 Oct 2004 20:05:29 +0400, Andrei Konovalov
> > <akonovalov@ru.mvista.com> wrote:
> >
> >
> > While we're on this subject I will ask - do you also need something
> > like the nointr mods I pointed out in order to use sysace for writing
> > on that board? The hardware generates more interrupts than anything
> > documented suggests that it should and your driver dies horribly (or
> > is completely unreliable) unless I modify it as I mentioned. It's
> > probably a sysaceism.
> 
> Not too much to say about sysace at the moment.
> We do not use xsysace in our Memec 2VP7 design (this is a chip select
> issue with P160 flash and xsysace sitting on the same bus - we do
> not have HW engineer to do an IP to control the chip select inputs;
> by default both are tied to ground - always selected).
> With ML300 we've never seen this problem. I was just asked to try
> to enhance the xsysace driver performance - will use this opportunity
> to have a deeper look at the driver's internals.
> 

I have to use the non-interrupt mode in sysace.  I thought there were some
HW issue in our HW board (no ML 300).   Good to know other have the 
same problem.   We don't have ML300, otherwise, I will run the 
kernel with printk in the sysace driver to see that system ISR behavior
on write.  The problem I had was: I can not turn off the ISR when write
to the system (nor when send ID drive command).

 
Jon,  what kind of performance you got from the sysace?

When I copy 18 MB of ace file into sysace with Linux, the 
sync command took minutes to complete for me.

Sysace ISR should not be the issue, since there is no seeks
and all the IO is dirven from the kernel.


-- 
-Tony
