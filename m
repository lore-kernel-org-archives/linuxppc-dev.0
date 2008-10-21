Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9593DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 16:18:15 +1100 (EST)
Message-ID: <48FD65F0.9070000@pobox.com>
Date: Tue, 21 Oct 2008 01:17:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Fix new MAL feature handling
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<1224133010.8157.543.camel@pasglop>
	<20081016143840.GA29805@yoda.jdub.homelinux.org>
	<1224546221.7654.196.camel@pasglop>
In-Reply-To: <1224546221.7654.196.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-10-16 at 10:38 -0400, Josh Boyer wrote:
>> On Thu, Oct 16, 2008 at 03:56:50PM +1100, Benjamin Herrenschmidt wrote:
>>>> drivers/net/ibm_newemac/mal.c: In function 'mal_txeob':
>>>> drivers/net/ibm_newemac/mal.c:284: error: implicit declaration of function 'mtdcri'
>>>> drivers/net/ibm_newemac/mal.c:284: error: 'SDR0' undeclared (first use in this function)
>>>> drivers/net/ibm_newemac/mal.c:284: error: (Each undeclared identifier is reported only once
>>>> drivers/net/ibm_newemac/mal.c:284: error: for each function it appears in.)
>>>> drivers/net/ibm_newemac/mal.c:285: error: implicit declaration of function 'mfdcri'
>>>> drivers/net/ibm_newemac/mal.c: In function 'mal_rxeob':
>>>> drivers/net/ibm_newemac/mal.c:302: error: 'SDR0' undeclared (first use in this function)
>>> That's annoying, I'll have a look.
>> Support for new features needed by the PPC 405EZ boards
>> introduced some errors in the MAL and EMAC feature handling.
>> This broke 'allmodconfig' builds as CONFIG_PPC_DCR_NATIVE is
>> not set for those.
>>
>> This patch fixes these errors by wrapping the code in the
>> appropriate #ifdefs.
>>
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Jeff, this breaks build, I'll put it in powerpc.git for a merge today,

ACK
