Message-Id: <m11P42n-0000X2C@tri-yann.crf.canon.fr>
Date: Thu, 9 Sep 1999 15:15:17 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: paubert@iram.es
CC: Simone.Piccardi@fi.infn.it, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.HPX.4.10.9909091001450.9440-100000@gra-ux1.iram.es>
	(message from Gabriel Paubert on Thu, 9 Sep 1999 10:12:07 +0200
	(METDST))
Subject: Re: A question about zImage when booting from HD
References: <Pine.HPX.4.10.9909091001450.9440-100000@gra-ux1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Gabriel" == Gabriel Paubert <paubert@iram.es> writes:

Gabriel> On Mon, 6 Sep 1999, Simone Piccardi wrote:

Gabriel> Well, I don't think so. I'm also very surprised since I have a very
Gabriel> similar setup and I have never seen this command fail (NetBoot is another
Gabriel> story), the length in /dev/sda3 is correct. 

Gabriel> What is your verssion of PPCBug ? 

Gabriel> Can you try PBOOT;A and PBOOT;V ? 

Gabriel> 	Regards,
Gabriel> 	Gabriel.


I had a lot of problem on MPC750 to have PBOOT working with the
same archive than via the NBO command. The reason was a byte swapping
problem in the IDE low level command.

What is actually at vger does not work on my board. I have to patche the kernel
with the following patch :

*** ./arch/ppc/kernel/prep_setup.c~	Fri Jun  4 22:30:47 1999
--- ./arch/ppc/kernel/prep_setup.c	Tue Jul  6 17:00:39 1999
***************
*** 629,641 ****
  void
  prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
  {
! 	_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  void
  prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
  {
! 	_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  int
--- 629,641 ----
  void
  prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
  {
! 	ide_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  void
  prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
  {
! 	ide_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  int
***************
*** 688,693 ****
--- 688,694 ----
  void
  prep_ide_fix_driveid(struct hd_driveid *id)
  {
+   	ppc_generic_ide_fix_driveid(id);
  }
  
  __initfunc(void




-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
