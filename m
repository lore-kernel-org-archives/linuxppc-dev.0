Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 180982BDD3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 01:32:19 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0410080840520.6091@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080840520.6091@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7D7D70F5-193F-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 11:34:06 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: next pass of cleaning up micropatch.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 8:44 AM, Robert P. J. Day wrote:
> + *  Shortcut macros for patching code.
>   */
> +
> +#define PATCH2000 \
> +	dp = (uint *)(commproc->cp_dpmem); \
> +	for (i=0; i<(sizeof(patch_2000)/4); i++) \
> +		*dp++ = patch_2000[i];
> +
> +#define PATCH2E00 \
> +	dp = (uint *)&(commproc->cp_dpmem[0x0e00]); \
> +	for (i=0; i<(sizeof(patch_2e00)/4); i++) \
> +		*dp++ = patch_2e00[i];
> +
> +#define PATCH2F00 \
> +	dp = (uint *)&(commproc->cp_dpmem[0x0f00]); \
> +	for (i=0; i<(sizeof(patch_2f00)/4); i++) \
> +		*dp++ = patch_2f00[i];

Please get rid of these macros and place the code where it
belongs.  They add no value and just make it harder to
read the code and understand what it does.

Thanks.


	-- Dan
