MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: RAMDISK problem 
Date: Thu, 20 Nov 2003 13:10:17 -0700
Message-ID: <8039970AF146314597457D3B51A68B382DC11B@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Joao Vicente" <joao.vicente@spectel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Thursday, November 20, 2003 11:27 AM
> To: Joao Vicente
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: RAMDISK problem
>
>
>
> In message
> <DEF39A0710293E489D45B10E06645CBD02671CA2@dub-msx1.spectelcorp
> .com> you wrote:
> >
> > My problem is that I dont really know what address the core
> is trying to write to when the exception occurs.
> > As I mentioned in the previous message, the write() calls
> _syscall3() macro which will perform the write operation, but
> early  in that macro the assembly 'sc' instruction is called.
> > As I cannot step through 'sc', I cannot go further on
> investigating at what write access the exception occurs.
>
> But you can set a breakpoint in the sc exception handler.
>
> > How do I even find out what is the start address of the
> file associated with the file descritor?
>
> Analyze at which offset the file starts  in  your  filesystem  image;
> find  out  the  load  address of the filesystem image in RAM; add the
> offset.
>
> Best regards,
>
> Wolfgang Denk

Hi Joao,

I assume you get a crash dump including the registers when it crashes.  If not, you need a better debugger (BDI2000).  If so, look at SRR0, SRR1, etc.  Please read the PowerPC 603e User's Manual (assuming that is applicable: I forgot which processor you are using).  For the 82xx (PPC603e core):
  SRR0 = effective address for resuming program execution
  SRR1 = MSR with some error identification bits

When you find the failure location, disassemble the memory leading up to the failure.  Figure out which registers are being used for a memory access when the crash occurred, and find what those registers contained in the crash dump.  That will tell you why the crash occurred (I'm guessing TEA, bit 13 in SRR1) and which address was at fault (load or store into a memory location, said memory location being one of the GPRs).

If your tools don't give you this information, you need to buy better tools.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
