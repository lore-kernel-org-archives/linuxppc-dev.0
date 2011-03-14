Return-Path: <jgpobox@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 333F1B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 18:05:14 +1100 (EST)
Received: by vws16 with SMTP id 16so2133784vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 00:05:11 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4D7DBE23.10109@pobox.com>
Date: Mon, 14 Mar 2011 03:05:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: [PATCH][v3] driver/FSL SATA:Fix wrong Device Error Register usage
References: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1299655038-727-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, Ashish Kalra <B00888@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, meet2prabhu@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2011 02:17 AM, Prabhakar Kushwaha wrote:
> When a single device error is detected, the device under the error is indicated
> by the error bit set in the DER. There is a one to one mapping between register
> bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
> bit 1 represents PMP device 1 etc.
>
> Current implementation treats Device error register value as device number not
> set of bits representing multiple device on PMP. It is changed to consider bit
> level.
> No need to check for each set bit as all command is going to be aborted.
>
> Signed-off-by: Ashish Kalra<B00888@freescale.com>
> Signed-off-by: Prabhakar Kushwaha<prabhakar@freescale.com>
> ---
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)
>
>   This patch is already gone through review of linuxppc-dev mail list.
>   Making CC linuxppc-dev@lists.ozlabs.org
>
>   Changes for v2: Incorporated Sergei Shtylyov's comment
> 	- Put space after -
> 	- added a line
>   Changes for v3: Incorporated David Laight's comment
>   	- Condition check for dereg 0 for hardware error
>
>   drivers/ata/sata_fsl.c |    7 +++++--
>   1 files changed, 5 insertions(+), 2 deletions(-)

applied
