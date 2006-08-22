Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 317B667C03
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 20:13:14 +1000 (EST)
Date: Tue, 22 Aug 2006 14:13:07 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/6] [RFC] POWERPC: generic CPM2 peripherals rehaul with
	cpm2_map mechanism
Message-ID: <20060822141307.577fb551@localhost.localdomain>
In-Reply-To: <44DE379C.5030901@ru.mvista.com>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
	<20060812001029.6186.18474.stgit@localhost.localdomain>
	<44DE379C.5030901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 13 Aug 2006 00:18:36 +0400
Sergei Shtylyov wrote:

> Hello.
> 
> Vitaly Bordug wrote:
> 
> > Incorporating the new way of cpm2 immr access, introduced in the
> > previous patch, into CPM2 peripheral devices (fs_enet and
> > cpm_uart). Both ppc and powerpc approved working( real actions
> > taken in powerpc only, ppc just has a wrapper to keep init stuff
> > consistent).
> 
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> 
>     Hm, I got 4 rejects here. :-/
> 
> > diff --git a/arch/ppc/platforms/mpc8272ads_setup.c
> > b/arch/ppc/platforms/mpc8272ads_setup.c index 2a35fe2..d5d36c3
> > 100644 --- a/arch/ppc/platforms/mpc8272ads_setup.c
> > +++ b/arch/ppc/platforms/mpc8272ads_setup.c
> > @@ -103,7 +103,7 @@ static struct fs_platform_info mpc82xx_e
> >  	},
> >  };
> >  
> > -static void init_fcc1_ioports(void)
> > +static void init_fcc1_ioports(struct fs_platform_info*)
> >  {
> >  	struct io_port *io;
> >  	u32 tempval;
> 
>     This one get rejected as well.
> 
> > diff --git a/arch/ppc/platforms/mpc866ads_setup.c
> > b/arch/ppc/platforms/mpc866ads_setup.c index e12cece..5f130dc 100644
> > --- a/arch/ppc/platforms/mpc866ads_setup.c
> > +++ b/arch/ppc/platforms/mpc866ads_setup.c
> [...]
> > @@ -194,7 +194,7 @@ static void setup_scc1_ioports(void)
> >  
> >  }
> >  
> > -static void setup_smc1_ioports(void)
> > +static void setup_smc1_ioports(struct fs_uart_platform_info*)
> >  {
> >  	immap_t *immap = (immap_t *) IMAP_ADDR;
> >  	unsigned *bcsr_io;
> 
>     And this one...
> 
> > diff --git a/arch/ppc/platforms/mpc885ads_setup.c
> > b/arch/ppc/platforms/mpc885ads_setup.c index 5dfa4e6..bf388ed 100644
> > --- a/arch/ppc/platforms/mpc885ads_setup.c
> > +++ b/arch/ppc/platforms/mpc885ads_setup.c
> [...]
> > @@ -315,7 +315,7 @@ static void __init mpc885ads_fixup_scc_e
> >  	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
> >  }
> >  
> > -static void setup_smc1_ioports(void)
> > +static void setup_smc1_ioports(struct fs_uart_platform_info*)
> >  {
> >          immap_t *immap = (immap_t *) IMAP_ADDR;
> >          unsigned *bcsr_io;
> 
>      And this...
> 
> > diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
> > index bd6623a..220cc2d 100644
> > --- a/include/asm-ppc/cpm2.h
> > +++ b/include/asm-ppc/cpm2.h
> > @@ -1196,5 +1196,58 @@ #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0
> >  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
> >  #define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
> >  
> > +/* Clocks and GRG's */
> > +
> > +enum cpm_clk_dir {
> > +	CPM_CLK_RX,
> > +	CPM_CLK_TX,
> > +	CPM_CLK_RTX
> > +};
> > +
> > +enum cpm_clk_target {
> > +	CPM_CLK_SCC1,
> > +	CPM_CLK_SCC2,
> > +	CPM_CLK_SCC3,
> > +	CPM_CLK_SCC4,
> > +	CPM_CLK_FCC1,
> > +	CPM_CLK_FCC2,
> > +	CPM_CLK_FCC3
> > +};
> > +
> > +enum cpm_clk {
> > +	CPM_CLK_NONE = 0,
> > +	CPM_BRG1,	/* Baud Rate Generator  1 */
> > +	CPM_BRG2,	/* Baud Rate Generator  2 */
> > +	CPM_BRG3,	/* Baud Rate Generator  3 */
> > +	CPM_BRG4,	/* Baud Rate Generator  4 */
> > +	CPM_BRG5,	/* Baud Rate Generator  5 */
> > +	CPM_BRG6,	/* Baud Rate Generator  6 */
> > +	CPM_BRG7,	/* Baud Rate Generator  7 */
> > +	CPM_BRG8,	/* Baud Rate Generator  8 */
> > +	CPM_CLK1,	/* Clock  1 */
> > +	CPM_CLK2,	/* Clock  2 */
> > +	CPM_CLK3,	/* Clock  3 */
> > +	CPM_CLK4,	/* Clock  4 */
> > +	CPM_CLK5,	/* Clock  5 */
> > +	CPM_CLK6,	/* Clock  6 */
> > +	CPM_CLK7,	/* Clock  7 */
> > +	CPM_CLK8,	/* Clock  8 */
> > +	CPM_CLK9,	/* Clock  9 */
> > +	CPM_CLK10,	/* Clock 10 */
> > +	CPM_CLK11,	/* Clock 11 */
> > +	CPM_CLK12,	/* Clock 12 */
> > +	CPM_CLK13,	/* Clock 13 */
> > +	CPM_CLK14,	/* Clock 14 */
> > +	CPM_CLK15,	/* Clock 15 */
> > +	CPM_CLK16,	/* Clock 16 */
> > +	CPM_CLK17,	/* Clock 17 */
> > +	CPM_CLK18,	/* Clock 18 */
> > +	CPM_CLK19,	/* Clock 19 */
> > +	CPM_CLK20,	/* Clock 20 */
> > +	CPM_CLK_DUMMY
> > +};
> > +
> > +extern int cpm2_clk_setup(enum cpm_clk_target target, int clock,
> > int mode); +
> >  #endif /* __CPM2__ */
> >  #endif /* __KERNEL__ */
> 
>     And this file refuses to be patched altogether...
>     With these rejects fixed, everything seems fine, though.

The same note - the mis-sync because preceding fs_enet overhaul and update are missing before the stuff above.

Taking into accordance Kumar's opinion to put this on hold until the next kernel release, the whole thing should settle down pretty shortly hereby before upstream merge. Meanwhile, we'll catch up the issues and scrub
the code in general. Hopefully, with netdev things merged, we'll get back to the only powerpc.git base which will simplify following them up.



> 
> WBR, Sergei
> 
> 
