Return-Path: <per.hallsmark@t2data.se>
Received: from t2data.se (unknown [212.247.174.226])
	by ozlabs.org (Postfix) with ESMTP id 40B3767A45
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 01:40:21 +1100 (EST)
Received: from webmail ([192.168.1.7]) by t2data.se (t2data.se [172.16.0.3])
	(MDaemon.PRO.v7.2.2.R) with ESMTP id md50000103321.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 03 Feb 2005 15:29:04 +0100
Date: Thu, 3 Feb 2005 15:29:00 +0100
Sender: Per Hallsmark <per.hallsmark@t2data.se>
From: Per Hallsmark <per.hallsmark@t2data.se>
To: linuxppc-embedded@ozlabs.org
Message-ID: <41FFBC75@webmail>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Subject: Question about cpm reset on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Working with a board using hdlc over SCC channel (852T) and kernel 2.4.21,
in the cpm reset code in arch/ppc/8xx_io/commproc.c it's like:

void
m8xx_cpm_reset()
{
        volatile immap_t         *imp;
        volatile cpm8xx_t       *commproc;
        pte_t                   *pte;


        imp = (immap_t *)IMAP_ADDR;
        commproc = (cpm8xx_t *)&imp->im_cpm;

 
#ifdef CONFIG_UCODE_PATCH
        /* Perform a reset.
        */
        commproc->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);


        /* Wait for it.
        */
        while (commproc->cp_cpcr & CPM_CR_FLG);


        cpm_load_patch(imp);
#endif
     .......

In our case, CONFIG_UCODE_PATCH is not defined so the commproc is never
reseted during reboot. Could it be that the #ifdef CONFIG_UCODE_PATCH
should just be around the cpm_load_patch command?
The CONFIG_UCODE_PATCH seems to point this to be i2c/spi patch, but
shouldn't a reset go to cpm in anycase?

/Per
