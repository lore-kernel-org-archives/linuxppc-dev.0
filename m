Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id CE07ADDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 05:28:03 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so5044440wxd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 10:28:01 -0800 (PST)
Message-ID: <fa686aa40802121028l75c1a150obea8a72975af121a@mail.gmail.com>
Date: Tue, 12 Feb 2008 11:28:01 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Nick <ndroogh@rogers.com>
Subject: Re: DTS question - MPC5200b
In-Reply-To: <47B1D943.6020708@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B1D943.6020708@rogers.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 10:37 AM, Nick <ndroogh@rogers.com> wrote:
> Hi,
>
> I need some help.  I am trying to access timer 7 on the MPC5200B
> processor.  I have the DTS file setup like this
>
>         gpt@670 {    // General Purpose Timer
>           device_type = "gpt";
>             compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>             cell-index = <7>;
>             reg = <670 10>;
>             interrupts = <1 10 0>;
>             interrupt-parent = <&mpc5200_pic>;
>         };
>
> I have timers 0 to 6 defined the same way except the cell-index reflects
> the timer number.
>
> In my platform file where I am doing my board setup, I tried the  following.
>
> timer7 = mpc52xx_find_and_map ("mpc5200b-gpt");

Don't use find_and_map; it was a stupid API that I never should have written.

Instead, use for_each_compatible_node() or for_each_matching_node() to
iterate over them until you find the one with the correct reg address.

Then you can use of_iomap() to map the device registers.

> How do I specify the timer based on the cell-index?

Match on the reg property instead of cell-index; I'll probably be
dropping the cell-index property from future 5200 device trees because
it just ends up duplicating information already provided by reg.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
