To: bhup_sah@yahoo.com
Subject: Re: problem in booting kernel
Message-ID: <1052488487.3ebbb32797e53@pop-mail.india.tejasnetworks.com>
Date: Fri, 09 May 2003 19:24:47 +0600 (IST)
From: Anil Giri <anil@india.tejasnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Bhupi,


        I can't see any kernel early boot message.


The kernel is hanging just after entering start_kernel function.


Precisely in in "setup_arch ($command_line); " command. And still no message


On console


any problem with commnad ntering start_kernel function.




Command line: console=ttyS0,9600 root=/dev/ram


Is there any problem with my command line??


Any Comments...




-Anil






-----Original Message-----


From: bhupinder sahran [mailto:bhup_sah@yahoo.com]


Sent: Friday, May 09, 2003 1:44 AM


To: Anil Giri


Subject: RE: FW: problem in booting kernel




Hi




Looks like ur serial port intialization is not good.


U r saying it goes till start_kernel mean it has


intialized all BAT registers & MMU.




Now u do not know what is the value in program counter


when it is hanging.




Right now confusion is if the issue is with serial


port or some exception is happening.




Before start_kernel early boot message should come.


Can u  see in the platform specific  setup.c & see if


early serial port intialization is OK.




Try out some of the above stuff & mail me




Bhupi


Linux+Hypertransport -->Silicon


www.gdatech.com


Good after beer -- Linux














--- Anil Giri <anil@india.tejasnetworks.com> wrote:


> Hi Bhupi,


>       That didn't worked, but on debugging I found that


> it goes till


> Start_kernel and after that goes in some loop. I


> can't see any message on


> console


> Though there r few printk statements in the C


> function. Is there any problem


> with printk


> Statements.


>


> -Anil


>


>


> -----Original Message-----


> From: bhupinder sahran [mailto:bhup_sah@yahoo.com]


> Sent: Thursday, May 08, 2003 9:12 PM


> To: Anil Giri; linuxppc-embedded@lists.linuxppc.org


> Cc: bhup_sah@yahoo.com


> Subject: Re: FW: problem in booting kernel


>


> Hi


>


> console=ttyS0 is good but why again console=tty.


> That might be the issue.


> When u r paasing parameters from ppcboot, why


> console


> is eqated two times.


>


> U should only say console=ttyS0 , 9600


>


> So console=tty is not correct............


> Try out this...


>


> Bhupi


> Linux+Hypertransport --> Silicon


> www.gdatech.com


> Good after beer -- Linux


>


>


> --- Anil Giri <anil@india.tejasnetworks.com> wrote:


> >


> > Hi Bhupi,


> >        How can i configure my serial port?? and no


> i


> > don;t use JTAG debugger.


> > i m stuck with the problem for a long time...


> >


> >


> > Following is the console output...


> > ===========================================


> >       Initializing...


> >   CPU:   XPC860xxZPnnD4 at 66 MHz: 4 kB I-Cache 4


> kB


> > D-Cache FEC present


> >   Board:  103-PCALTC101-E  AF-4402-20-0041


> >   Ethernet Address : 00:04:95:05:00:0e


> >   27/ 1/ 0 22:46:47


> >   DRAM:  (128 MB SDRAM) 128 MB


> >   FLASH: 16 MB


> > *** Warning - bad CRC, using default environment


> >


> >   Input:  serial


> >   Output: serial


> >


> > Hit any key to stop autoboot:  0


> > ## Starting application at 0x40080000 ...


> > loaded at:     40080000 40089368


> > relocated to:  00180000 00189368


> > board data at: 07F3FE48 07F40000


> > relocated to:  00200100 002002B8


> > zimage at:     40086000 40123741


> > initrd at:     40123741 4037909A


> > relocated to:  07DAA000 07FFF959


> > avail ram:     00201000 07DAA000


> >


> > Linux/PPC load: console=ttyS0,9600 console=tty0


> > root=/dev/ram mem=480


> > Uncompressing Linux...done.


> > Now booting the kernel


> > ================================================


> >


> > -Anil


> >


> >


> >


> > >


> > > -----Original Message-----


> > > From: bhupinder sahran


> [mailto:bhup_sah@yahoo.com]


> > > Sent: Wednesday, May 07, 2003 9:22 PM


> > > To: Anil Giri;


> > linuxppc-embedded@lists.linuxppc.org


> > > Subject: Re: problem in booting kernel


> > >


> > > Hi


> > > >From the inuts u have given it is very tough to


> > find


> > > out. But let me ask u some of the questions.


> > >


> > > 1. One possiblity is that ur serial port is not


> > > configured properly & u are not seeing any


> message


> > > from the console port.


> > >


> > > 2. IF u are having the JTAG debugger find out


> the


> > > value in Program conuter & see where it matches


> in


> > > System.map.


> > >


> > > So tell me the PC value then it might be


> possible


> > to


> > > catch the problem


> > >


> > > Thanx


> > > Bhupi


> > > Linux+Hypertransport -->Silicon


> > > www.gdatech.com


> > > Good after beer ---Linux


> > >


> > >


> > > --- Anil Giri <anil@india.tejasnetworks.com>


> > wrote:


> > > >


> > > > Hi,


> > > >


> > > >


> > > >    I m trying to boot kernel for linux-2.4.18


> > > > (MPC860 processor), but it


> > > >


> > > >


> > > > hangs after "Now booting the kernel"  message.


> > What


> > > > could be the reason???


> > > >


> > > >


> > > > also on debugging i found negative value for


> > > > register R3 instead of ptr to


> > > >


> > > >


> > > > board info data. Other register settings were


> > ok.


> > > >


> > > >


> > > > Any imputs...


> > > >


> > > >


> > > >


> > > >


> > > > -Anil


> > > >


> > > >


> > > >


> > >


> > >


> > >


> > >


> >




> >


>


>






>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
