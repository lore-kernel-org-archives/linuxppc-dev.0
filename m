Date: Wed, 19 May 1999 06:47:42 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: ECP Parallel port on PReP patch
Message-ID: <Pine.BSI.3.96.990519064213.9839A-100000@usr01.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The below patch allows my 2.2.9 kernel on a Motorola PowerStack to recognize
the paralell port at 0x3bc as ECP.  However, I don't have any ECP devices to
test it with.  I'm sending it in the hopes that somebody can actually test
this, and if it works, at least add the prep_setup.c patch to vger and/or
Linus' tree.  I've talked to one of the parport_pc people about that patch,
but don't know if/when it will go in, but I figure we might a well find out
if it actually works.

------------ cut here ---------------

Index: arch/ppc/kernel/prep_setup.c
===================================================================
RCS file: /cvs/linux/linux/arch/ppc/kernel/prep_setup.c,v
retrieving revision 1.71
diff -c -r1.71 prep_setup.c
*** arch/ppc/kernel/prep_setup.c	1999/05/10 22:15:46	1.71
--- arch/ppc/kernel/prep_setup.c	1999/05/19 13:42:08
***************
*** 228,233 ****
--- 228,250 ----
  	outb(reg, SIO_CONFIG_RD);
  	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
  
+         /* Set up printer in ECP mode */
+         outb(0x04, SIO_CONFIG_RA);
+ 	reg = inb(SIO_CONFIG_RD);
+ 	reg = (reg & 0xFE) | 0x0E;
+ 	outb(reg, SIO_CONFIG_RD);
+ 	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
+         outb(0x02, SIO_CONFIG_RA);
+ 	reg = inb(SIO_CONFIG_RD);
+ 	reg = reg | 0x80;
+ 	outb(reg, SIO_CONFIG_RD);
+ 	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
+         outb(0x04, SIO_CONFIG_RA);
+ 	reg = inb(SIO_CONFIG_RD);
+ 	reg = (reg & 0xBF) | 0x20;
+ 	outb(reg, SIO_CONFIG_RD);
+ 	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
+ 
  	/*
  	 * We need to set up the NvRAM access routines early as prep_init
  	 * has yet to be called
Index: drivers/misc/parport_pc.c
===================================================================
RCS file: /cvs/linux/linux/drivers/misc/parport_pc.c,v
retrieving revision 1.29
diff -c -r1.29 parport_pc.c
*** drivers/misc/parport_pc.c	1999/05/10 23:22:25	1.29
--- drivers/misc/parport_pc.c	1999/05/19 13:42:15
***************
*** 770,781 ****
  		return 0;
  	}
  	((struct parport_pc_private *) (p->private_data))->ctr = 0xc;
  	if (p->base != 0x3bc) {
- 		if (!check_region(base+0x400,3)) {
- 			p->modes |= parport_ECR_present(p);	
- 			p->modes |= parport_ECP_supported(p);
- 			p->modes |= parport_ECPPS2_supported(p);
- 		}
  		if (!check_region(base+0x3, 5)) {
  			p->modes |= parport_EPP_supported(p);
  			p->modes |= parport_ECPEPP_supported(p);
--- 769,780 ----
  		return 0;
  	}
  	((struct parport_pc_private *) (p->private_data))->ctr = 0xc;
+ 	if (!check_region(base+0x400,3)) {
+ 		p->modes |= parport_ECR_present(p);	
+ 		p->modes |= parport_ECP_supported(p);
+ 		p->modes |= parport_ECPPS2_supported(p);
+ 	}
  	if (p->base != 0x3bc) {
  		if (!check_region(base+0x3, 5)) {
  			p->modes |= parport_EPP_supported(p);
  			p->modes |= parport_ECPEPP_supported(p);

----------- cut here --------------


----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
