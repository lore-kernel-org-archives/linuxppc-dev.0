Return-Path: <annamaya@yahoo.com>
Received: from web53804.mail.yahoo.com (web53804.mail.yahoo.com
	[206.190.36.199]) by ozlabs.org (Postfix) with SMTP id 60B3F67A66
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jan 2005 02:47:11 +1100 (EST)
Message-ID: <20050120154704.62155.qmail@web53804.mail.yahoo.com>
Date: Thu, 20 Jan 2005 07:47:04 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Hans Schillstrom <hans.schillstrom@pwav.com>
In-Reply-To: <1106218826.7900.405.camel@hawk.allgon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Input to the timerclk on the MPC8280
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks a lot for the reply. I have some more questions
on this. When and where in U-Boot do you set the value
of BRGC1? Can I do this somewhere in board_init() or
do I have to do it earlier, like in cpu_init? And I
will have to set the values in the DIV16 and CD to
produce an output of 4Mhz or 32Khz. Is that correct?

BTW, how was this ever done on the MPC8260? I dont see
any code in U-Boot for an 8260 board that does sothing
similar?

--- Hans Schillstrom <hans.schillstrom@pwav.com>
wrote:

> Hi,
> I have the same problem on MPC8270,
> and solved it two parts in u-boot:
> - Setup you PC[26] to somtething else than TMCLK ex.
> g,p. I/O
>     then you an automatic selecttion of BRG1 as
> source.
>     
> - Write a proper value in BRGC1 and make sure that 
>     bit 16-17 is 0 for selection of CPM as clock
> source.
> 
> and then you have to "move around the brgs" in
> (2.6.10)
> drivers/serial/cpm_uart/cpm_uart_cpm2.c
> 
> I moved smc 1&2 to brg7 & 8
> scc1 to brg2 etc
> scc4 ext clk (48MHz for USB)
> 
> void smc1_lineif(struct uart_cpm_port *pinfo)
> {
> 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
> 
> 	/* SMC1 is only on port D */
> 	io->iop_ppard |= 0x00c00000;
> 	io->iop_pdird |= 0x00400000;
> 	io->iop_pdird &= ~0x00800000;
> 	io->iop_psord &= ~0x00c00000;
> #ifndef CONFIG_RCB8270
> 	/* Wire BRG1 to SMC1 */
> 	cpm2_immr->im_cpmux.cmx_smr &= 0x0f;
> 	pinfo->brg = 1;
> #else
>         /* Wire BRG7 to SMC1 */
>         cpm2_immr->im_cpmux.cmx_smr &= 0x0f;
>         cpm2_immr->im_cpmux.cmx_smr |= 0x10;  /* BRG
> 7 */
>         pinfo->brg = 7;
> #endif
> }
> 
> I guess you can do it in many ways ...
> 
> Any one that knows why SMC1 & SMC2 gets the same BRG
> as SCC1 & SCC2
> 
> Regards
> /Hans
>  
> On Wed, 2005-01-19 at 23:08, annamaya wrote:
> > I've asked this question on this forum before but
> it
> > did not get answered. I tried asking the same
> question
> > in the U-Boot forum with no results. So, I am
> going to
> > try this again.
> > 
> > According to section 4.1.2 on Page 4-4 in the
> MPC8280
> > User's Manual, one should be able to use a
> combination
> > of  external clocks on Port C pins 25, 26, 27 and
> 29,
> > the CPM cloak and BRG1 to generate a 32KHz or a
> 4MHz
> > clock. I am unable to find  any code in u-boot or
> any
> > other place that initializes any of these pins to
> be
> > external clocks. And as for BRG1, I believe it is
> > being used for the SMC clock.
> > 
> > I am unable to understand how this is done. Can we
> > have a timerclk input WITHOUT an external clock
> > signal? Can I just use the CPM clock to generate
> this?
> > How is this being done in U-Boot now?
> > 
> > Thanks much for your help. I really need an answer
> to
> > this. 
> > 
> > 
> > 		
> > __________________________________ 
> > Do you Yahoo!? 
> > Yahoo! Mail - now with 250MB free storage. Learn
> more.
> > http://info.mail.yahoo.com/mail_250
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> >
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250
