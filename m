Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (unknown [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 228DCDDF2F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 14:33:34 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HiNSj-0003rT-BG
	for linuxppc-embedded@ozlabs.org; Mon, 30 Apr 2007 06:26:10 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
	<528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
Date: Mon, 30 Apr 2007 06:26:08 +0200
In-Reply-To: <528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
	(Grant Likely's message of "Fri, 27 Apr 2007 12:49:26 -0600")
Message-ID: <87slai5vz3.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

>> instead? I'm using RedBoot on a virtex platform, and hence another
>> struct bd_info than the ML300/ML403.

GL> Alternate suggestion: Can we change virtex support to use the
GL> structure defined in ppcboot.h instead?  (I've actually got that
GL> change in my tree and was planning on posting it for review today
GL> or tomorrow).  bd_t is a stinking ugly mess, but things would be
GL> better if we standardize all virtex platforms on the stinking ugly
GL> mess shared by almost all the other ppc embedded board ports.

That's where the ugly mess pops up - RedBoot uses another
(incompatible) bd_t definition than U-boot, E.G:

typedef struct bd_info {
	unsigned int   bi_tag;        /* Should be 0x42444944 "BDID" */
	unsigned int   bi_size;       /* Size of this structure */
	unsigned int   bi_revision;   /* revision of this structure */
	unsigned int   bi_bdate;      /* bootstrap date, i.e. 0x11061997 */
	unsigned int   bi_memstart;   /* Memory start address */
	unsigned int   bi_memsize;    /* Memory (end) size in bytes */
	unsigned int   bi_intfreq;    /* Internal Freq, in Hz */
	unsigned int   bi_busfreq;    /* Bus Freq, in Hz */
	unsigned int   bi_cpmfreq;    /* CPM Freq, in Hz */
	unsigned int   bi_brgfreq;    /* BRG Freq, in Hz */
	unsigned int   bi_vco;        /* VCO Out from PLL */
	unsigned int   bi_pci_freq;   /* PCI Freq, in Hz */
	unsigned int   bi_baudrate;   /* Default console baud rate */
	unsigned int   bi_immr;       /* IMMR when called from boot rom */
	unsigned char  bi_enetaddr[6];
	unsigned int   bi_flashbase;  /* Physical address of FLASH memory */
	unsigned int   bi_flashsize;  /* Length of FLASH memory */
	int            bi_flashwidth; /* Width (8,16,32,64) */
	unsigned char *bi_cmdline;    /* Pointer to command line */
} bd_t;

I should probably migrate to U-boot anyway, but still ..

-- 
Bye, Peter Korsgaard
