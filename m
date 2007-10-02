Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by ozlabs.org (Postfix) with ESMTP id D51E4DDE35
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:04:47 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4665470fkz
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:04:46 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 01/18] Virtex: Add uartlite bootwrapper driver
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 17:04:35 +0200
In-Reply-To: <20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Fri\, 28 Sep 2007 12\:15\:53 -0600")
Message-ID: <87ve9p36d8.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> +static int uartlite_open(void)
 Grant> +{
 Grant> +	/* Clear the RX FIFO */
 Grant> +	out_be32(reg_base + 0x0C, 0x2);
 Grant> +	return 0;
 Grant> +}
 Grant> +
 Grant> +static void uartlite_putc(unsigned char c)
 Grant> +{
 Grant> +	while ((in_be32(reg_base + 0x8) & 0x08) != 0); /* spin */
 Grant> +	out_be32(reg_base + 0x4, c);

RX, TX, STATUS and CONTROL defines for the registers would be nice for
readability.

-- 
Bye, Peter Korsgaard
