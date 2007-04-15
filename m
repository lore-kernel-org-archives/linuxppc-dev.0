Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B75D6DDE39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 06:00:23 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070415022914.GA5628@dellserver.lan>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aa6a7bd73be20ea11e3e98f87a66e478@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH dtc take 2] Fix reserve map output for asm format.
Date: Sun, 15 Apr 2007 14:59:44 -0500
To: Jerry Van Baren <gvb.uboot@gmail.com>,
 Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sometime around Sun Apr 15 12:29:14 EST 2007, Jerry Van Baren wrote:
> Add extra reserve map slots output for asm format (previously done for 
> dtb
>   output).
>
> Signed-off-by: Gerald Van Baren <vanbaren at cideas.com>
> ---
>
> Hi Jon, David,
>
> Here is a patch that fixes the asm output without the (unnecessary)
> calloc change.
>
> Best regards,
> gvb


The previous description had
> Use cmalloc to pre-zero memory (for dtb input) and handle dtb (binary)
>   input being shorter than the total blob length (result of putting
>   extra space in the blob).


Which at least said in the description the unrelated things it was 
doing.

>         while (sizeleft) {
> -               if (feof(f))
> -                       die("EOF before reading %d bytes of DT blob\n",
> -                           totalsize);
> +               if (feof(f)) {
> +                       WARNMSG("EOF after reading %d of %d bytes of 
> DT blob, assuming there is extra space in the blob.\n",
> +                           totalsize - sizeleft, totalsize);
> +                       break;
> +               }

I thnk the above should be an ERROR and cause failure without
the -f (force) option.

The total_size says how much data should be copied.  Anything
less and there is data missing.   Assuming zeros is wrong for
most sections (the exception being the memory reserve list
that had a terminating 0 entry within the read portion).

milton
