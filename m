Subject: Re: AW: AW: Linux 2.4.24 on PQ2FADS
To: <tschaefer@giga-stream.de>
Cc: "" Stefano Gaiotto " <Stefano.Gaiotto" <Stefano.Gaiotto@marconi.com>,
	"<linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFEE670FCC.A0230905-ONC1256E53.002ECBF0@uk.marconicomms.com>
From: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Date: Wed, 10 Mar 2004 14:59:12 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes Thomas,

MPC8280, '8275 and '8270 are all 0.13um (HiP7) members of PowerQUICCII
family.
Using your entry in cputable (o that in patch 2.4.25!...) I achieve working
stability in my board, in fact it reaches every time
the NFS root mounting point.
But I till have problems with the corrupted stamps I showed you!
Is not an overlapping memory problem as you suggested me, I'm investigating
about that.

Thank you,
      Stefano Gaiotto





Thomas Schäfer <tschaefer@giga-stream.de> on 09/03/2004 17:43:16

Please respond to <tschaefer@giga-stream.de>

To:    "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
cc:    <linuxppc-embedded@lists.linuxppc.org>

Subject:    AW: AW: Linux 2.4.24 on PQ2FADS


Stefano,

> -----Ursprüngliche Nachricht-----
> Von: Stefano Gaiotto [mailto:Stefano.Gaiotto@marconi.com]
> Gesendet: Dienstag, 9. März 2004 17:05
> An: tschaefer@giga-stream.de
> Cc: Stefano Gaiotto <Stefano.Gaiotto; <linuxppc-embedded
> Betreff: Re: AW: Linux 2.4.24 on PQ2FADS
>
>
>
>
> Thomas,
>
> I had not an entry for Hip7 such that you send me! Thak you very much for
> your help.

I'm not sure if MPC8275 is actually a HIP7 core. We used a MPC8280 on our
boards. It is important that the CPU ID is correct in the cputable file. In
our case, with the missing CPU ID the board always hang in the init
program.

> I'm going to chek my SDRAM initialization because, now, I see corrupted
> stamps, like these:
>
> ## Booting image at 00100000 ...
>    Image Name:   2.2.4 Kernel for PQ2FADS
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    571353 Bytes = 558 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
>                                                       ÀLinux
> version 2.4.24
> (gai
> otto@gexs22) (gcc version 3.3.2) #5 Tue Mar 9 17:00:09 CET 2004
>                                                                ÀADS setup
> arch
> ÀO
> n node 0 totalpages: 8192
>                          Àzone(0): 8192 pages.
>                                               Àzone(1): 0 pages.
>
> Àzone(2): 0
> page
> s.
>   ÀKernel command line: root=/dev/nfs rw
> nfsroot=172.16.246.111:/home/gaiotto/fa
> dsroot nobats ip=172.16.119.3
>  ÀÀÀÀ$                 ÀADS init IRQ. NR_IRÀÀÀÀÀ
>

Maybe that your load address (0x100000) is too low and is overwritten when
the kernel is uncompressed....

Best regards,

Thomas


>
> Regards,
>       Stefano
>
>
>
>
>
>
> Thomas Schäfer <tschaefer@giga-stream.de> on 09/03/2004 14:24:39
>
> Please respond to <tschaefer@giga-stream.de>
>
> To:    "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
> cc:    <linuxppc-embedded@lists.linuxppc.org>
>
> Subject:    AW: Linux 2.4.24 on PQ2FADS
>
>
> Hi Stefano,
>
> just a wild guess:
>
> check the cpu_specs[] array in your arch/ppc/kernel/cputable.c file. It
> should
> contain something like this entry for your 8275 CPU:
>
>     { /* 82xx (Hip7 603e cores) */
>       0xffff0000, 0x80820000, "82xx (Hip7)",
>       CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
>       CPU_FTR_CAN_NAP,
>       COMMON_PPC,
>       32, 32,
>       __setup_cpu_603
>     }
>
> The CPU ID (0x80820000 in this case) must match your 8275 CPU ID.
> Otherwise, generic PPC
> will be assumed which leads to strange behaviour as soon as the
> MMU will be
> enabled by
> the kernel.
>
> second guess:
>
> Because of the random errors you described I would check the
> SDRAM settings
> of the board:
> - check ALL settings of the memory controller against the settings
> described in the
>   data sheet of your SDRAM.
> - check memory controller initialization sequence against the sequence
> described in the
>   data sheet of the SDRAM and the memory controller of the CPU
> - if both are correct: check signal integrity on your board
>
> hope this helps.
>
> Best regards,
>
> Thomas Schaefer
>
> > -----Ursprüngliche Nachricht-----
> > Von: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]Im Auftrag von
> > Stefano Gaiotto
> > Gesendet: Dienstag, 9. März 2004 13:53
> > An: linuxppc-embedded@lists.linuxppc.org
> > Betreff: Linux 2.4.24 on PQ2FADS
> >
> >
> >
> > Dear colleagues,
> >
> > I'm trying to have Linux 2.4.24 working on my evaluation board
> PQ2FADS-VR
> > with ppc8275, but I'm suffering of a lot of instability problems.
> > The Boot-loader I use is Uboot-1.0.0 witch initialise correctly
> the board
> > at speed 66,133,199 and correctly fills bd_info struct.
> > But when I issue the command "=> bootm 100000" I observe every time a
> > different behaviour: sometimes I don't see anything, sometimes the
board
> > stops in "Calibrating delay loop", sometimes after having written
> > the line:
> >
> > Memory: 30936k available (984k kernel code, 344k data, 52k init, 0k
> > highmem)
> >
> > Or the line
> >
> > POSIX conformance testing by UNIFIX
> >
> > Only occasionally it reaches the init program (stopping here).
> >
> > The same behaviour I observed with the images delivered by the Arabella
> > distribution!
> >
> > Do you have any suggestion? MMU? Cache? Hardware?
> >
> > Thanks in advance for your advice.
> >
> > With best regards,
> >
> > Stefano
> >
> >
>
>
>
>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
