Message-Id: <m112Abc-0000WZC@tri-yann.crf.canon.fr>
Date: Thu, 8 Jul 1999 11:36:36 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: PREP IDE support is broken
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Do anyone used PREP boards using IDE disk!!! I do.
Months ago soemone from Moto posted a mail fixing IDE
support. With the introduction of machine dependendent
function pointers for ide byte handling, someone broke 
it again.

here is the fix
  -------------------------------- cut here ---------------------
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

  ------------------------------------------------------------------- 

-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
