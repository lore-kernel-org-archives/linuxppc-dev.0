Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 401C2DDEE0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 00:47:32 +1000 (EST)
Message-ID: <46BC7A7C.6000409@freescale.com>
Date: Fri, 10 Aug 2007 09:47:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Soohyung Cho <xfree@paran.com>
Subject: Re: [PATCH 2/4] mpc83xx: Power Management support
References: <1186728172263333.40.nmailpop03@nmailpop03>
In-Reply-To: <1186728172263333.40.nmailpop03@nmailpop03>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Soohyung Cho wrote:
>>+void fsl_sleep_device(struct fsl_sleep_platform_data *data) {
>>+	if (clock_regs && data->sccr_mask) {
>>+		unsigned long flags;
>>+		u32 sccr;
> 
> 
> Your && operation between clock_regs and sccr_mask seems to be a little bit
> mistake,
> cause type is different.

Hmm?  It's logical AND, not binary.  There's no need for the types to be 
the same.

> (clock->regs->sccr && data->sccr_mask) looks fine.

Except that that would be wrong.  I'm checking to make sure that the 
registers were found, not anything about the contents of the register.

-Scott
