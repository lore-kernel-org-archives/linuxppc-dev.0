Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97031DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 07:56:55 +1000 (EST)
Message-ID: <46B8EAA1.8070003@garzik.org>
Date: Tue, 07 Aug 2007 17:56:49 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] ibmveth: Remove use of bitfields
References: <11864293333377-patch-mail.ibm.com>
	<200708061942.l76JgmxI031698@d03av01.boulder.ibm.com>
In-Reply-To: <200708061942.l76JgmxI031698@d03av01.boulder.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King wrote:
> Removes the use of bitfields from the ibmveth driver. This results
> in slightly smaller object code.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  linux-2.6-bjking1/drivers/net/ibmveth.c |   90 ++++++++++++++++----------------
>  linux-2.6-bjking1/drivers/net/ibmveth.h |   56 ++++++++-----------
>  2 files changed, 68 insertions(+), 78 deletions(-)

strong ACK :)

Though I also encourage you to avoid #defines for named constants, in 
favor of

enum {
	IBMVETH_BUF_VALID	= (1U << 31),
	IBMVETH_BUF_TOGGLE	= (1U << 30),
	IBMVETH_BUF_NO_CSUM	= (1U << 25),
	IBMVETH_BUF_CSUM_GOOD	= (1U << 24),
	IBMVETH_BUF_LEN_MASK	= 0x00FFFFFF,
};

This illustrates:

1) The "1 << n" notation is FAR easier to read and compare with data 
sheets.  You're just adding to the trouble by requiring the reviewer's 
brain to convert hex numbers to bits, even if most engineers can do this 
in their sleep.

2) The named constants are available to the C compiler, which is more 
friendly to debuggers.  It also supplies type information to the C compiler.

3) Similar to #2, wading through C pre-processor output is much easier 
when the symbols don't disappear.

These are recommendations, not requirements, but I've found these 
techniques superior to cpp in many other drivers.

	Jeff
