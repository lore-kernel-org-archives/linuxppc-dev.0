Return-Path: <soheil.kdev@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBwnc6D8qzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 01:08:52 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id y45so2567091qty.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 07:08:52 -0700 (PDT)
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com.
 [209.85.223.182])
 by smtp.gmail.com with ESMTPSA id y195sm8482787ywy.97.2017.10.11.07.08.48
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Oct 2017 07:08:49 -0700 (PDT)
Received: by mail-io0-f182.google.com with SMTP id b186so2024959iof.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 07:08:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507716177.3792.35.camel@abdul.in.ibm.com>
References: <1507716177.3792.35.camel@abdul.in.ibm.com>
From: Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
Date: Wed, 11 Oct 2017 10:08:07 -0400
Message-ID: <CACSApva6SkJe8kj+3TKyD+67dJ8qX-HHRDpxRBQskFCqzd-Mfg@mail.gmail.com>
Subject: Re: [linux-next] [6f5b24e] WARNING: CPU: 0 PID: 10288 at
 net/ipv4/tcp_input.c:889 tcp_update_reordering+0x1c4/0x1e0
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
 Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 11, 2017 at 6:02 AM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> Hi,
>
> CPU OFF & ON in a loop on next kernel results in WARNING in dmesg.
>
> Machine Type: Power 8 PowerVM LPAR
> Kernel : 4.14.0-rc4-next-20171009
> Gcc : 6.3.1
> config : attached
> Test: CPU toggle
>
> WARN_ON was first introduced with the commit:
>
> commit 6f5b24eed0278136c29c27f2a7b3a2b6a202ac68
> Author: Soheil Hassas Yeganeh <soheil@google.com>
> Date:   Tue May 16 17:39:02 2017 -0400
>
>     tcp: warn on negative reordering values
>
>     Commit bafbb9c73241 ("tcp: eliminate negative reordering
>     in tcp_clean_rtx_queue") fixes an issue for negative
>     reordering metrics.
>
>     To be resilient to such errors, warn and return
>     when a negative metric is passed to tcp_update_reordering().
>
>     Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
>     Signed-off-by: Neal Cardwell <ncardwell@google.com>
>     Signed-off-by: Yuchung Cheng <ycheng@google.com>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index bbadd79..2fa55f5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -887,6 +887,9 @@ static void tcp_update_reordering(struct sock *sk,
> const int metric,
>         struct tcp_sock *tp = tcp_sk(sk);
>         int mib_idx;
>
> +       if (WARN_ON_ONCE(metric < 0))
> +               return;
> +

Thank you for your report, Abdul! This warning was added to find the
root cause of insanely high reordering in TCP, which luckily I believe
you have reproduced.

Yuchung had pointed out offline that we are using inconsistent types
in using in tcp_sacktag_state vs tcp_sock: int for reord and
fack_count in tcp_sacktag_state and u32 for their related fields in
tcp_sock. This is likely to be the culprit here.

Would you mind giving the following patch a try please? If that fixes
the issue for you, we will mail that as a fix. Thanks!

From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Wed, 11 Oct 2017 09:52:49 -0400
Subject: [PATCH net] tcp: fix type of fack_count and reord in sack_tag_state

This bug is found by Yuchung.

Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 net/ipv4/tcp_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d0682ce2a5d6..2fada7acbdc5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1132,8 +1132,8 @@ static bool tcp_check_dsack(struct sock *sk,
const struct sk_buff *ack_skb,
 }

 struct tcp_sacktag_state {
-       int reord;
-       int fack_count;
+       u32 reord;
+       u32 fack_count;
        /* Timestamps for earliest and latest never-retransmitted segment
         * that was SACKed. RTO needs the earliest RTT to stay conservative,
         * but congestion control should still get an accurate delay signal.
@@ -1209,7 +1209,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
                        u64 xmit_time)
 {
        struct tcp_sock *tp = tcp_sk(sk);
-       int fack_count = state->fack_count;
+       u32 fack_count = state->fack_count;

        /* Account D-SACK for retransmitted packet. */
        if (dup_sack && (sacked & TCPCB_RETRANS)) {
-- 
2.15.0.rc0.271.g36b669edcc-goog
