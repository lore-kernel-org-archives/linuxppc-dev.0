Reply-To: <tschaefer@giga-stream.de>
From: =?iso-8859-1?Q?Thomas_Sch=E4fer?= <tschaefer@giga-stream.de>
To: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: Linux 2.4.24 on PQ2FADS
Date: Tue, 9 Mar 2004 14:24:39 +0100
MIME-Version: 1.0
Message-ID: <FIEJJAKAABLMHFKFECNJIELHHAAA.tschaefer@giga-stream.de>
In-reply-to: <OFFBAA77BB.483BA1A8-ONC1256E52.00468D91@uk.marconicomms.com>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stefano,

just a wild guess:

check the cpu_specs[] array in your arch/ppc/kernel/cputable.c file. It
cshould ontain something like this entry for your 8275 CPU:

    {	/* 82xx (Hip7 603e cores) */
	0xffff0000, 0x80820000, "82xx (Hip7)",
	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
	CPU_FTR_CAN_NAP,
	COMMON_PPC,
	32, 32,
	__setup_cpu_603
    }

The CPU ID (0x80820000 in this case) must match your 8275 CPU ID.
Otherwise, generic PPC will be assumed which leads to strange behaviour
as soon as the MMU will be enabled by the kernel.

second guess:

Because of the random errors you described I would check the SDRAM
settings of the board:
- check ALL settings of the memory controller against the settings
  described in the data sheet of your SDRAM.
- check memory controller initialization sequence against the sequence
  described in the data sheet of the SDRAM and the memory controller of
  the CPU
- if both are correct: check signal integrity on your board

hope this helps.

Best regards,

Thomas Schaefer

> Von: Stefano Gaiotto
> Gesendet: Dienstag, 9. M=E4rz 2004 13:53
> Betreff: Linux 2.4.24 on PQ2FADS
>
> I'm trying to have Linux 2.4.24 working on my evaluation board
> PQ2FADS-VR with ppc8275, but I'm suffering of a lot of instability
> problems. The Boot-loader I use is Uboot-1.0.0 witch initialise
> correctly the board at speed 66,133,199 and correctly fills bd_info
> struct. But when I issue the command "=> bootm 100000" I observe every
> time a different behaviour: sometimes I don't see anything, sometimes
> the board stops in "Calibrating delay loop", sometimes after having
> written the line:
>
> Memory: 30936k available (984k kernel code, 344k data, 52k init, 0k
> highmem)
>
> Or the line
>
> POSIX conformance testing by UNIFIX
>
> Only occasionally it reaches the init program (stopping here).
>
> The same behaviour I observed with the images delivered by the
> Arabella distribution!
>
> Do you have any suggestion? MMU? Cache? Hardware?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
