Mime-Version: 1.0
Message-Id: <p04330101b842de27485b@[24.163.44.170]>
In-Reply-To: <20011216215948.15249@smtp.wanadoo.fr>
References: <p04330107b84297e5c096@[24.163.44.170]>
 <20011216215948.15249@smtp.wanadoo.fr>
Date: Sun, 16 Dec 2001 18:31:32 -0500
To: <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: ethtool failure with tulip 21143
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >How "broken" is it? With the card in the 6500, the tulip driver sort
>>of works, sometimes. The only error message I get out of it ever is
>>
>>Internal fault: The skbuff addresses do not match in tulip_rx [plus hex
>>output]
>
>Which match my idea about broken cache coherency on 6400/6500 machines
>and possibly other derivatives (5x00 ?).

A long time ago (2.2.13 or so), I could not use another card on the
6500 for very long with the de4x5 driver as well. At that time, Paul
provided a patch for the de4x5 driver which fixed the problem. He
also described the issue as a cache coherency problem.

>de4x5 has a tweak to align descriptors so that only one exist per
>cache line. This solved the problem for some 6400 users, but
>that tweak must be enabled by hacking the driver a bit.

Well, I wonder if that was the fix that Paul put in. Some time ago
(early 2.4) I tried the de4x5 driver with this Farallon 10/100 card
but it worked even more poorly than the tulip driver of that time did.


>Try defining CACHE_ALIGN to CAL_32LONG, and DESC_ALIGN to u32 dummy[4]
>(as in the commented out example).

I will look at the de4x5 code again and try this. It's all vaguely
familiar to me... Thanks much!


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
