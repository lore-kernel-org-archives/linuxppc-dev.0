Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 4946BDDF0C
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:12:40 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5324786wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:12:39 -0700 (PDT)
Message-ID: <fa686aa40710020812m8954a56t902e507a38da4235@mail.gmail.com>
Date: Tue, 2 Oct 2007 09:12:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 01/18] Virtex: Add uartlite bootwrapper driver
In-Reply-To: <87ve9p36d8.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181551.18608.88418.stgit@trillian.cg.shawcable.net>
	<87ve9p36d8.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
>  Grant> +static int uartlite_open(void)
>  Grant> +{
>  Grant> +       /* Clear the RX FIFO */
>  Grant> +       out_be32(reg_base + 0x0C, 0x2);
>  Grant> +       return 0;
>  Grant> +}
>  Grant> +
>  Grant> +static void uartlite_putc(unsigned char c)
>  Grant> +{
>  Grant> +       while ((in_be32(reg_base + 0x8) & 0x08) != 0); /* spin */
>  Grant> +       out_be32(reg_base + 0x4, c);
>
> RX, TX, STATUS and CONTROL defines for the registers would be nice for
> readability.

Good idea, I'll add a patch for that

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
