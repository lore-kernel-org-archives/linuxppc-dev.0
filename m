Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DF7BDDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:49:42 +1100 (EST)
Message-Id: <23257C1D-8894-4B19-8A44-1EBE04A8422D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081203192738.GA13035@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/5] powerpc/qe: Implement QE Pin Multiplexing API
Date: Wed, 17 Dec 2008 10:47:36 -0600
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192738.GA13035@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2008, at 1:27 PM, Anton Vorontsov wrote:

> With this API we're able to set a QE pin to the GPIO mode or a  
> dedicated
> peripheral function.
>
> The API relies on the fact that QE gpio controllers are registered. If
> they aren't, the API won't work (gracefully though).
>
> There is one caveat though: if anybody occupied the node->data  
> before us,
> or overwrote it, then bad things will happen. Luckily this is all in  
> the
> platform code that we fully control, so this should never happen.
>
> I could implement more checks (for example we could create a list of
> successfully registered QE controllers, and compare the node->data  
> in the
> qe_pin_request()), but this is unneeded if nobody is going to do silly
> things behind our back.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/qe.h     |   21 ++++
> arch/powerpc/sysdev/qe_lib/gpio.c |  195 ++++++++++++++++++++++++++++ 
> +++++++++
> 2 files changed, 216 insertions(+), 0 deletions(-)

applied to next

- k
