MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: RAMDISK problem 
Date: Wed, 19 Nov 2003 19:13:06 -0000
Message-ID: <DEF39A0710293E489D45B10E06645CBD02671C37@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have gone through the SDRAM initialisation, and the init sequence, on u-boot, and I dont seem to find any discrepancies.
I am using a Micron MTLSDT464HG-10EC3 DIMM, and I have it initialised as follows.

#define CFG_BR3_PRELIM  ((CFG_SDRAM_BASE & BRx_BA_MSK)  |\
			 BRx_PS_64                      |\
			 BRx_MS_SDRAM_P                 |\
			 BRx_V)

#define CFG_OR3_PRELIM  ((~(CFG_GLOBAL_SDRAM_LIMIT-1) & ORxS_SDAM_MSK) |\
      ORxS_PMSEL                     |\
      ORxS_BPD_4                     |\
      ORxS_ROWST_PBI0_A9             |\
      ORxS_NUMR_12)

#define CFG_PSDMR_PRELIM (PSDMR_BSMA_A14_A16  |\
      PSDMR_SDA10_PBI0_A9               |\
      PSDMR_RFRC_3_CLK                  |\
      PSDMR_PRETOACT_1W                 |\
      PSDMR_ACTTORW_1W                  |\
      PSDMR_LDOTOPRE_1C                 |\
      PSDMR_WRC_2C                      |\
      PSDMR_CL_2)

On the SDRAM init sequence

	*sdmr_ptr = sdmr | PSDMR_OP_PREA;
	*base = c;

	*sdmr_ptr = sdmr | PSDMR_OP_CBRR;
	for (i = 0; i < 8; i++)
		*base = c;

	*sdmr_ptr = sdmr | PSDMR_OP_MRW;
	*(base + CFG_MRS_OFFS) = c;	/* setting MR on address lines */

	*sdmr_ptr = sdmr | PSDMR_OP_NORM | PSDMR_RFEN;
	*base = c

I am setting the Mode Register Set Command to
#define CFG_MRS_OFFS	0x00000110

which sets:
Programmable burst mode
Burst Length = 4
Burst Type = Sequential (also tried interleaved)
CAS latency = 2

I have also confirmed that the uP is (Write) bursting from the first time write() is called (and even before that) by  measuring the pulse width on WEx, verifying that it's pulse is 4x the width of a normal write sequence.

I have also debugged further, and I got much closer to the exception point.

crd_load() 			(from ./init/do_mounts.c)
|_ gunzip()
   |_ inflate()
      |_ inflate_block()
         |_ inflate_dynamic()
            |_ inflate_codes()
               |_ flush_output()
                  |_ flush_window()
                     |_write(crd_outfd, window, outcnt)

The last function call before the exception seems to be writing a decompressed 32k'outcount' chunk of data pointed by  'window' onto a targey file specified by the crd_outfd file descriptor.

Notice the system ALLWAYS crashes after the 37th time the write() function is called.
This also points more onto a software/configuration fault than a burst problem with SDRAM (correct me if I am wrong)

Another problem is that write() function will invoke
static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)

Early in this call the assembly 'sc' instruction will be executed which prevents me from stepping through the call, and  finding out exactly at what point the exception occurs.

I would appeciate suggestions onto carrying out debugging from this point, or any other suggestions on how to fix the  problem.

Thanks in advance

Joao Vicente

> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Wednesday, November 12, 2003 7:46 PM
> To: Joao Vicente
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: RAMDISK problem
>
>
> Dear Joao,
>
> in message
> <DEF39A0710293E489D45B10E06645CBD026719AB@dub-msx1.spectelcorp
> .com> you wrote:
> >
> > The SDRAM parameters used for initialisation have been
> fully verified
>
> Parameters is one thing, the init sequence is  another  story.  Boith
> are  required,  or you will see strange crashes as soon as the system
> starts using burst mode heavily.
>
> > with this board, as we have used them with another RTOS, without any
> > problem.
>
> That does not mean anything. Really. We have seen boards that used to
> run pSOS+ for years without problem, but would crash  reliably  under
> Linux. The problems went away after fixing the RAM initialization.
>
> Your problem is a FAQ on the PPCboot / U-Boot mailing lists.
>
> > Aditionaly I ran the u-boot mtest utility on sections of the RAM to
> > ensure the configuration was good.
>
> Again, that doesn't mean anything, as this test performs simple  read
> / write cycles. It will not cause any accesses in burst mode.
>
> > I believe that rules out bad SDRAM configuration.
>
> I disagree. I've seen this too many times before.
>
> > I thought that could give me an idea if inflate was writing
> outside the
> > valid
> > virtual address range.
>
> I think you're on the wrong track. But I may be wrong, of course.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "Just Say No."   - Nancy Reagan
> "No."            - Ronald Reagan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
