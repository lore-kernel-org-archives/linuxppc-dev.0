Return-Path: <msuresh@gamebox.net>
Received: from smtp-out.hotpop.com (smtp-out.hotpop.com [38.113.3.61])
	by ozlabs.org (Postfix) with ESMTP id B95B467A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 04:58:14 +1000 (EST)
Received: from gamebox.net (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 58A311069DE8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 18:37:04 +0000 (UTC)
Message-ID: <4266A320.20102@gamebox.net>
Date: Thu, 21 Apr 2005 00:14:48 +0530
From: Suresh Chandra Mannava <msuresh@gamebox.net>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
References: <4219A711.80204@gamebox.net> <421B666B.205@mvista.com>
In-Reply-To: <421B666B.205@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Marvell 64360, MPSC Serial Console Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Mr. Mark,

We designed a board with PPC 7410 and Marvell 64360 bridge.  We  
successfully  ported u-boot and Linux on to this board.

Thanks for your support.

We faced a problem in MPSC serial console part.  The problem is,  in 
Serial console data is received once after 32 characters are typed.

Any thing less than  32 characters  is not  echoed or not transmitted 
till the 32 character count is reached.

After carefully reviewing the code. We found that the receive buffer 
size is initialised to 32 bytes.
We made a small correction in the code by making the receive buffer size 
to 1
rxre->bufsize = 1;

After this modification, we got beautiful serial console working fine.

Here is the part of the code from "mpsc.c"

Function name "mpsc_init_rings"

    for (i = 0; i < MPSC_RXR_ENTRIES; i++) {
        rxre = (struct mpsc_rx_desc *)dp;

    /*    rxre->bufsize = cpu_to_be16(MPSC_RXBE_SIZE);*/ 
        rxre->bufsize = 1;  /* Modified Line*/
        rxre->bytecnt = cpu_to_be16(0);
        rxre->cmdstat = cpu_to_be32(SDMA_DESC_CMDSTAT_O |
                        SDMA_DESC_CMDSTAT_EI |
                        SDMA_DESC_CMDSTAT_F |
                        SDMA_DESC_CMDSTAT_L);
        rxre->link = cpu_to_be32(dp_p + MPSC_RXRE_SIZE);
        rxre->buf_ptr = cpu_to_be32(bp_p);

        dp += MPSC_RXRE_SIZE;
        dp_p += MPSC_RXRE_SIZE;
        bp += MPSC_RXBE_SIZE;
        bp_p += MPSC_RXBE_SIZE;
    }


Once again thank you very much for your support.

Regards,
Suresh Chandra Mannava
