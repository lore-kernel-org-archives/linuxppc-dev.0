Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id CDAC5DDDAC
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 20:41:03 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so66910rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 01:41:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1234343703.9778.13.camel@localhost>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
Date: Wed, 11 Feb 2009 15:11:01 +0530
Message-ID: <f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
Subject: Re: request_irq return errno 38
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for your prompt reply ...

I am using kernel version 2.6.20 ...

May I know what raw IRQ means ? ? ? and what is the reason I cant map
raw_irq_number ???

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam

On 2/11/09, Michael Ellerman <michael@ellerman.id.au> wrote:
> On Wed, 2009-02-11 at 14:13 +0530, Vijay Nikam wrote:
> > Hello All,
> >
> > I have mpc8313erdb evaluation board and currently I am writing GPIO
> > driver. Actually it is just simple test driver.
> >
> > I did the irq_request in the driver init function, as request_irq
> > returns zero (0) if successful, otherwise -1 on error and errno
> > indicates the error. But when I load or insert the module using insmod
> > request_irq return with Return Value -38. I checked in errno.h file in
> > asm-generic and 38 means ENOSYS - Function not implemented.
> > Following is irq_request code:
> > ----------------------
> > ret = request_irq(74, interrupt_handler, SA_INTERRUPT | SA_SHIRQ ,
> > "gpio", &mydev);
> > if(ret)
> >     printk(KERN_INFO "Error in request_irq, value return = %d \n", ret);
> > ----------------------
> > NOTE: 74 is the Interrupt ID Number for GPIO Interrupt. this
> > information is from Processor User Manual.
> >
> > Following is the handler:
> > ---------------------
> > static int interrupt_handler(int irqn, void *dev_id)
> > {
> >     printk(KERN_INFO "Enter in interrupt handler\n");
> >     return IRQ_HANDLED;
> > }
> > --------------------
> >
> > Usually request_irq return EBUSY, EINVAL but in my case it returns
> > ENOSYS (errno 38). I tried to look information for this errno in
> > interrupt context but could not able to find anything useful or
> > understable. Could anyone please let me know why this specific errno
> > 38 generated in request_irq ? ? ? and what are the possiblities for
> > resolving this error ? ?  ?
>
> You don't mention what kernel version you're using. But you might be
> hitting the check in __setup_irq():
>
>        if (desc->chip == &no_irq_chip)
>                return -ENOSYS;
>
>
> That would make sense because you're trying to map a raw irq number,
> which doesn't work. You first need to call irq_create_mapping(), like:
>
> int virq;
> virq = irq_create_mapping(NULL, 74);
> rc = request_irq(virq, ...);
>
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone:  +61 2 6212 1183  (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
>
