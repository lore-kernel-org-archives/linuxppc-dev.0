Message-ID: <2B0D01F974CBD211B9150000F8085A1E036873AA@itexchsrv2.phx.mcd.mot.com>
From: Hewitt Ian-MCG30344 <Ian.Hewitt@motorola.com>
To: VALETTE Eric <valette@crf.canon.fr>, paubert@iram.es
Cc: Simone.Piccardi@fi.infn.it, linuxppc-dev@lists.linuxppc.org
Subject: RE: A question about zImage when booting from HD
Date: Thu, 9 Sep 1999 13:28:43 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Hello,

     I have seen this on our boards in the lab and at customers.
It seems to be related to left over data on the drive.  In other
words, if you have a disk with this problem and you zero out the 
beginning of the disk (by specifically writing blocks of 0's to
the drive for the first couple hundred blocks), this issue goes 
away.  I have not had any time to track down why this is a problem,
but obviously some non zero value in an inopportune place is 
causing a problem.  Either in the partition table, of the
boot block of the partition. (Of course, I always use /dev/sda1 
as the boot partition, so my above fix didn't help narrow that
down any)

     Unfortunately, this is very destructive (unless you do it
when installing), you could experiment with less brute force 
methods.  I would be curious to know what you find out.  Good Luck. 


Ian Hewitt
Systems Engineer
Motorola Computer Group

> -----Original Message-----
> From: VALETTE Eric [mailto:valette@crf.canon.fr]
> Sent: Thursday, September 09, 1999 9:15 AM
> To: paubert@iram.es
> Cc: Simone.Piccardi@fi.infn.it; linuxppc-dev@lists.linuxppc.org
> Subject: Re: A question about zImage when booting from HD
> 
> 
> 
> >>>>> "Gabriel" == Gabriel Paubert <paubert@iram.es> writes:
> 
> Gabriel> On Mon, 6 Sep 1999, Simone Piccardi wrote:
> 
> Gabriel> Well, I don't think so. I'm also very surprised 
> since I have a very
> Gabriel> similar setup and I have never seen this command 
> fail (NetBoot is another
> Gabriel> story), the length in /dev/sda3 is correct. 
> 
> Gabriel> What is your verssion of PPCBug ? 
> 
> Gabriel> Can you try PBOOT;A and PBOOT;V ? 
> 
> Gabriel> 	Regards,
> Gabriel> 	Gabriel.
> 
> 
> I had a lot of problem on MPC750 to have PBOOT working with the
> same archive than via the NBO command. The reason was a byte swapping
> problem in the IDE low level command.
> 
> What is actually at vger does not work on my board. I have to 
> patche the kernel
> with the following patch :
> 
> *** ./arch/ppc/kernel/prep_setup.c~	Fri Jun  4 22:30:47 1999
> --- ./arch/ppc/kernel/prep_setup.c	Tue Jul  6 17:00:39 1999
> ***************
> *** 629,641 ****
>   void
>   prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
>   {
> ! 	_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
>   }
>   
>   void
>   prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
>   {
> ! 	_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
>   }
>   
>   int
> --- 629,641 ----
>   void
>   prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
>   {
> ! 	ide_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
>   }
>   
>   void
>   prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
>   {
> ! 	ide_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
>   }
>   
>   int
> ***************
> *** 688,693 ****
> --- 688,694 ----
>   void
>   prep_ide_fix_driveid(struct hd_driveid *id)
>   {
> +   	ppc_generic_ide_fix_driveid(id);
>   }
>   
>   __initfunc(void
> 
> 
> 
> 
> -- 
>    __                 
>   /  `                   	Eric Valette
>  /--   __  o _.          	Canon CRF - Communication Dept
> (___, / (_(_(__         	Rue de la touche lambert
> 				35517 Cesson-Sevigne  Cedex
> 				FRANCE
> Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
> E-mail: valette@crf.canon.fr	http://www.crf.canon.fr
> 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
