From: "Andrei Konovalov" <akonovalov@ru.mvista.com>
To: "Scott Anderson" <scott_anderson@mvista.com>,
	"Stephen Williams" <612dlag102@sneakemail.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SystemACE but not V2PRO
Date: Fri, 2 Apr 2004 22:10:33 +0300
Message-ID: <BFEIKPFELDOAPHBBKCBPAEDLCAAA.akonovalov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <30B3D487-84CC-11D8-A2BE-000A959CAB7C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've looked at this patch.
At first glance it looks OK, but I'd like to think a little bit more about
it.
I'll come back on Monday, or Tuesday (in worst case).

Thanks,
Andrei

> -----Original Message-----
> From: Scott Anderson [mailto:scott_anderson@mvista.com]
> Sent: Friday, April 02, 2004 8:36 PM
> To: Stephen Williams
> Cc: linuxppc-embedded@lists.linuxppc.org; Andrei Konovalov
> Subject: Re: SystemACE but not V2PRO
>
>
> Hi there,
> The current ML300 maintainer is Andrei Konovalov
> <akonovalov@ru.mvista.com>
> (cc'ed on this message).  I'm guessing he didn't reply to your message
> last week because he's swamped, but hopefully having this directly
> addressed to him will prompt a response.
>
>    Scott
>
> On Apr 1, 2004, at 6:38 PM, Stephen Williams wrote:
>
> >
> > The attached patch is my spin at getting the existing xsysace
> > block driver working on systems that have SystemACE chips, but
> > do not use Virtex-II-Pro chips. The adapter.c file assumes that
> > the system ace halt will halt the processor. This is not the
> > case in general, so this patch ifdefs that part of the code out
> > using CONFIG_VIRTEX_II_PRO.
> >
> > This is only part of the story for getting the systemace
> > working in general, but the remaining bits are configuration
> > issues, not code/driver support.
> >
> > Question: Who is the maintainer for this section of code? It
> > is maybe MonteVista?
> > --
> > Steve Williams                "The woods are lovely, dark and deep.
> > steve at XXXXXXXXXX           But I have promises to keep,
> > http://www.XXXXXXXXXX         and lines to code before I sleep,
> > http://www.picturel.com       And lines to code before I sleep."
> > Index: drivers/block/xilinx_sysace/adapter.c
> > ===================================================================
> > RCS file:
> > /cvsroot/linuxppc_2_4_devel/drivers/block/xilinx_sysace/adapter.c,v
> > retrieving revision 1.3
> > diff -p -u -r1.3 adapter.c
> > --- drivers/block/xilinx_sysace/adapter.c	30 Oct 2003 00:32:49
> > -0000	1.3
> > +++ drivers/block/xilinx_sysace/adapter.c	2 Apr 2004 02:27:37 -0000
> > @@ -74,7 +74,9 @@ MODULE_LICENSE("GPL");
> >  static const int dont_spin = 0;
> >
> >  static u32 save_BaseAddress;	/* Saved physical base address */
> > +#ifdef CONFIG_VIRTEX_II_PRO
> >  static void (*old_restart) (char *cmd) = NULL;	/* old
> ppc_md.restart
> > */
> > +#endif
> >
> >  static unsigned char heads;
> >  static unsigned char sectors;
> > @@ -277,6 +279,13 @@ proc_cleanup(void)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_VIRTEX_II_PRO
> > +/*
> > + * The XSysAce_ResetCfg function causes the SystemACE to reset the
> > + * Xilinx chain that is attached to it. If I am a Virtex II Pro, then
> > + * presumably that includes me. Thus, The ResetCfg will ultimately
> > + * reset me, the processor, end of story.
> > + */
> >  static void
> >  xsysace_restart(char *cmd)
> >  {
> > @@ -285,6 +294,7 @@ xsysace_restart(char *cmd)
> >  	/* Wait for reset. */
> >  	for (;;) ;
> >  }
> > +#endif
> >
> >  /*
> >   * The code to handle the block device starts here.
> > @@ -725,8 +735,10 @@ cleanup(void)
> >  	iounmap((void *) cfg->BaseAddress);
> >  	cfg->BaseAddress = save_BaseAddress;
> >
> > +#ifdef CONFIG_VIRTEX_II_PRO
> >  	if (old_restart)
> >  		ppc_md.restart = old_restart;
> > +#endif
> >  }
> >
> >  static int __init
> > @@ -837,9 +849,11 @@ xsysace_init(void)
> >  	       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
> >  	       size / 2);
> >
> > +#ifdef CONFIG_VIRTEX_II_PRO
> >  	/* Hook our reset function into system's restart code. */
> >  	old_restart = ppc_md.restart;
> >  	ppc_md.restart = xsysace_restart;
> > +#endif
> >
> >  	if (proc_init())
> >  		printk(KERN_WARNING "%s: could not register /proc
> interface.\n",
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
