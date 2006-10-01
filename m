Return-Path: <jsteve17@yahoo.com>
Received: from web33402.mail.mud.yahoo.com (web33402.mail.mud.yahoo.com
	[68.142.206.134]) by ozlabs.org (Postfix) with SMTP id 73D6267BEF
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Oct 2006 12:30:32 +1000 (EST)
Message-ID: <20061001023030.83671.qmail@web33402.mail.mud.yahoo.com>
Date: Sat, 30 Sep 2006 19:30:30 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: Re: Linux not booting consistantly
To: Muruga Ganapathy <gmuruga@gdatech.com>, Stefan Roese <sr@denx.de>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <200609301538.k8UFcBs05081@sierra.gdatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, my initial finding (that it was hanging after
do_init_bootmem) was incorrect.  I enabled the early
serial debug interface in the kernel, and it is
failing when initializing the PCI busses.  So I tried
typing "pci 0" in U-Boot, and I get
"pci_bus_to_hose(): failed" for busses 1 and 2 (0
returns fine).  If I comment out the board's pci_init
function, the kernel will boot every time, though it
crashes when it tries to probe the pci busses (as
expected).  So it seems to be an issue in my U-Boot
configuration or bootstrap settings.

Thanks for the help though!

--- Muruga Ganapathy <gmuruga@gdatech.com> wrote:

> 
> I would like to suggest to check the (quality of)
> clocks to memory
> under  
> 
> a. normal condition ( before loading the linux)
> b. during the linux booting
> 
> Usually the clock needs to be buffered if it needs
> to drive
> more memory chips ( banks).
> 
> Another suggestion is to increase the cas latency to
> a higher 
> value in the memory controller. ( say from 2 to 2.5
> or to a higher
> values.
> 
> Also there are configuration registers to introduce
> wait states to 
> memory read and write cycles. So you may want to
> introduce more wait 
> states by programming the memory controller
> register.
> 
> Thanks
> G.Muruganandam
> 
> 
> 
> > I have been working with the hardware guys trying
> to
> > find any issues with the memory, and we haven't
> seen
> > anything yet, and we have talked to AMCC, and they
> > said  they couldn't see anything wrong with the
> > hardware.  I did do a post-mordum dump of the log
> > buffer, and this is what I get:
> > 
> > 001e40c4: 3c353e4c 696e7578 20766572 73696f6e   
> > <5>Linux version
> > 001e40d4: 20322e36 2e313520 28726f6f 74406c6f    
> > 2.6.15 (root@lo
> > 001e40e4: 63616c68 6f73742e 6c6f6361 6c646f6d   
> > calhost.localdom
> > 001e40f4: 61696e29 20286763 63207665 7273696f   
> ain)
> > (gcc versio
> > 001e4104: 6e20342e 302e3020 2844454e 5820454c    n
> > 4.0.0 (DENX EL
> > 001e4114: 444b2034 2e302034 2e302e30 29292023   
> DK
> > 4.0 4.0.0)) #
> > 001e4124: 38205475 65205365 70203236 2031373a    8
> Tue
> > Sep 26 17:
> > 001e4134: 34393a31 33204544 54203230 30360a3c   
> 49:13
> > EDT 2006.<
> > 001e4144: 343e4a4a 533a2057 41532048 4552454a   
> > 4>JJS: WAS HEREJ
> > 001e4154: 4a53324a 4a53334a 4a53335f 314a4a53   
> > JS2JJS3JJS3_1JJS
> > 001e4164: 345f4a4a 53345f31 5f4a4a53 345f325f   
> > 4_JJS4_1_JJS4_2_
> > 001e4174: 4a4a5334 5f335f4a 4a53345f 00000000   
> > JJS4_3_JJS4_....
> > 001e4184: 00000000 00000000    ........
> > 
> > I placed a few printks in arch/ppc/kernel/start.c
> and
> > found that it crashed right after
> do_init_bootmem(),
> > right after placing the first character of
> "_JJS4_1".
> > 
> >         printk("JJS3");
> >         parse_early_param();
> >         printk("JJS3_1");
> >         for (i = 0; i < 1000000; i++)
> >         {
> >                 if (i > 999999)
> >                 {
> >                         break;
> >                 }
> >         }
> > 
> >         printk("JJS4");
> >         /* set up the bootmem stuff with available
> > memory */
> >         do_init_bootmem();
> >         printk("_JJS4_1");
> >         if ( ppc_md.progress )
> > ppc_md.progress("setup_arch: bootmem", 0x3eab);
> >         printk("_JJS4_2");
> > 
> > 
> > When it does decide to work, most of the time it
> gets
> > through the whole kernel and everything runs fine,
> > though I have seen it hang after probing for PCI
> > devices a couple of times.  This looks like it is
> a
> > memory issue, but I don't know what else to try. 
> Does
> > anyone have any ideas?  I would appreciate any
> input.
> > 
> > Thanks,
> >    Jeff Stevens 
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> > http://mail.yahoo.com 
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> > 
> 
>
*************************************************************
> GDA Technologies, Inc.		
> 1010 Rincon Circle 
> San Jose CA, 95131
> Phone	(408) 432-3090
> Fax	(408) 432-3091
> 
> Accelerate Your Innovation	
>
**************************************************************
> 
> 
> =====
> This message contains information from GDA
> Technologies Inc and 
> affiliates, and is intended for the sole use of the
> individual and 
> entity to whom it is addressed. It may contain
> information, including 
> any attachments, that is privileged, confidential
> and exempt from 
> disclosure under applicable law. If you are not the
> intended addressee, 
> nor authorized to receive for the intended
> addressee, you are hereby 
> notified that you may not use, copy, disclose or
> distribute to anyone 
> the message or any information contained in the
> message. If you have 
> received this electronic transmission in error,
> please notify the 
> sender immediately by a "reply to sender only"
> message and destroy all 
> electronic and hard copies of the communication,
> including attachments.
> ====
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
