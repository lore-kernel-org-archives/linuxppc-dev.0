Date: Wed, 3 Dec 2003 10:25:18 -0500 (EST)
From: "Verberk, Bep" <verberk@nortelnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mtdcr and mfdcr macros
Message-ID: <Pine.LNX.4.44.0312030959380.3107-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'd like a sanity check on a change I am considering to
these macros....

I had some difficulty executing these macros
(found in include/asm/processor.h) in a loop, eg:

#define DMA0_BANKS 	4
#define DCRN_DMA0_BASE	0x100
#define DCRN_DMA0_CR(bank)  (DCRN_DMA0_BASE + (8 * (bank)))

		for(i=0;i<DMA0_BANKS;i++){
			dma0_cr = mfdcr(DCRN_DMA0_CR(i));
			CLEARBITS(dma0_cr, DMA0_CR_PCE);
			mtdcr(DCRN_DMA0_CR(i), dma0_cr);
		};


compiling results in the assembler error
/tmp/cca8HPJ4.s:282: Error: undefined symbol `i' in operation

Compiling with the -E to see what the pre-processor is generating
--
for(i=0;i< 4 ;i++) {
     	dma0_cr = ({unsigned int rval;
	asm volatile("mfdcr %0," "(0x100 + (8 * (i)))"
		  : "=r" (rval)); rval;}) ;
        ( dma0_cr  =  dma0_cr  |   0x00000008  ) ;
        asm volatile("mtdcr " "(0x100 + (8 * (i)))" ",%0"
		: : "r" (  dma0_cr )) ;
};

Looking at the definition of mtdcr and mfdcr in processor.h
--
#define mfdcr(rn)       ({unsigned int rval; \
                        asm volatile("mfdcr %0," __stringify(rn) \
                                     : "=r" (rval)); rval;})
#define mtdcr(rn, v)    asm volatile("mtdcr " __stringify(rn) ",%0" \
				: : "r" (v))

I was suspicious that the use of __stringify was buggering up my
index parameter. I made a slight tweak to these macros to take
(rn) as a numeric input param.

#define mfdcr(rn)       ({unsigned int rval; \
                        asm volatile("mfdcr %0, %1" \
                                     : "=r" (rval) \
				     : "n" (rn));  \
				rval;})

#define mtdcr(rn, v)    asm volatile("mtdcr %1 ,%0" \
				: : "r" (v), "n" (rn));


Testing this morning so far seems to indicate the new version is
working for me, but my usage is fairly limited. Am I missing
anything ??

Cheers,

--
Bep Verberk
verberk@nortelnetworks.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
