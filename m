Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69D3D67E2B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 23:04:12 +1000 (EST)
Date: Mon, 1 Aug 2005 14:04:07 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Tiago Dall'Agnol" <tdallagnol@parks.com.br>
Message-Id: <20050801140407.5b6e4d36.ajz@cambridgebroadband.com>
In-Reply-To: <42EA60E1.7040804@parks.com.br>
References: <20050729013303.33814.qmail@web40712.mail.yahoo.com>
	<42EA2A2E.5040708@parks.com.br>
	<20050729144015.09fec9fe.ajz@cambridgebroadband.com>
	<42EA34A1.7060600@parks.com.br>
	<20050729154359.1ac8f488.ajz@cambridgebroadband.com>
	<42EA60E1.7040804@parks.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: request_8xxirq
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 29 Jul 2005 14:01:21 -0300
"Tiago Dall'Agnol" <tdallagnol@parks.com.br> wrote:
> But this code doesn't help to find request_8xxirq. It just do the 
> opposite. This code defines request_irq to be request_8xxirq when 
> CONFIG_8xx is defined. But where is located the implementation of 
> request_8xxirq?
> 

See the code snippet in my last email.  The C preprocessor replaces 'int request_irq(...' with 'int
request_8xxirq(...' prior to compilation.


> Alex Zeffertt wrote:
> 
> >Maybe you're using a really old kernel.  In linux-2.4.4 it's in
> >arch/ppc/kernel/irq.c:
> >
> >-- snip --
> >#if (defined(CONFIG_8xx) || defined(CONFIG_8260))
> >/* Name change so we can catch standard drivers that potentially mess up
> > * the internal interrupt controller on 8xx and 8260.  Just bear with me,
> > * I don't like this either and I am searching a better solution.  For
> > * now, this is what I need. -- Dan
> > */
> >#define request_irq	request_8xxirq
> >
> >...
> >...
> >...
> >
> >int request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *),
> >	unsigned long irqflags, const char * devname, void *dev_id)
> >{
> >--/snip --
> >
> >
> >I don't know why it was done like this....
> >
> >Alex
> >
> >
> >On Fri, 29 Jul 2005 10:52:33 -0300
> >"Tiago Dall'Agnol" <tdallagnol@parks.com.br> wrote:
> >
> >  
> >
> >>Thank you Alex.
> >>
> >>But in my linux, this is different.
> >>What I have in that file is just
> >>
> >>extern int request_8xxirq(unsigned int irq,
> >>               void (*handler)(int, void *, struct pt_regs *),
> >>               unsigned long flags,
> >>               const char *device,
> >>               void *dev_id);
> >>
> >>And the request_8xxirq is declared as a
> >>
> >>EXPORT_SYMBOL(request_8xxirq);
> >>
> >>in arch/ppc/kernel/ppc_ksyms.c.
> >>
> >>I already tried to find out where the code that implements the function 
> >>is located, but it seems that it doesn't exist in my distribuction. 
> >>Maybe is it a "binary version"?
> >>
> >>Any other information will be apreciated ;-)
> >>
> >>Best Regards,
> >>Tiago
> >>
> >>Alex Zeffertt wrote:
> >>
> >>    
> >>
> >>>In linux-2.4 it's in 
> >>>
> >>>	include/asm-ppc/mpc8xx.h
> >>>
> >>>-- snip --
> >>>#define request_8xxirq request_irq
> >>>--/snip --
> >>>
> >>>And request_irq is in arch/ppc/kernel/irq.c
> >>>
> >>>Alex
> >>>
> >>>On Fri, 29 Jul 2005 10:07:58 -0300
> >>>"Tiago Dall'Agnol" <tdallagnol@parks.com.br> wrote:
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >>>>Hi,
> >>>>
> >>>>I had some problems with irq in my embedded system. I'm interested in 
> >>>>this function source code, but I didn't find it in my linux distribuction?
> >>>>
> >>>>Does anyone know where I can find it?
> >>>>
> >>>>Thanks a lot
> >>>>Tiago
> >>>>
> >>>>Manish Joshi wrote:
> >>>>
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>>>>Hi,
> >>>>>
> >>>>>I am working on an old code which uses  request_8xxirq() call which I 
> >>>>>can't find in latest kernel.
> >>>>>Has this been replaced by something else ?
> >>>>>
> >>>>>I see the references on net about replacing request_8xxirq()  with 
> >>>>>request_irq(). Can I do it ?
> >>>>>
> >>>>>TIA,
> >>>>>Manish
> >>>>>
> >>>>>
> >>>>>------------------------------------------------------------------------
> >>>>>Start your day with Yahoo! - make it your home page 
> >>>>><http://us.rd.yahoo.com/evt=34442/*http://www.yahoo.com/r/hs>
> >>>>>
> >>>>>------------------------------------------------------------------------
> >>>>>
> >>>>>_______________________________________________
> >>>>>Linuxppc-embedded mailing list
> >>>>>Linuxppc-embedded@ozlabs.org
> >>>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>>>
> >>>>>     
> >>>>>
> >>>>>          
> >>>>>
> >>>>-- 
> >>>>Tiago Dall'Agnol
> >>>>Pesquisa e Desenvolvimento
> >>>>Tel.: +55.51.470.05.64
> >>>>Fax.: +55.51.470.05.70
> >>>>e-mail: tdallagnol@parks.com.br
> >>>>www.parks.com.br
> >>>>
> >>>>_______________________________________________
> >>>>Linuxppc-embedded mailing list
> >>>>Linuxppc-embedded@ozlabs.org
> >>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>> 
> >>>
> >>>      
> >>>
> >>-- 
> >>    
> >>
> >
> >  
> >
> 
> -- 
> Tiago Dall'Agnol
> Pesquisa e Desenvolvimento
> Tel.: +55.51.470.05.64
> Fax.: +55.51.470.05.70
> e-mail: tdallagnol@parks.com.br
> www.parks.com.br
