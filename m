Date: Thu, 25 Oct 2001 23:31:36 +0900 (JST)
Message-Id: <20011025.233136.74750056.tkoba@ike-dyn.ritsumei.ac.jp>
To: jeglin@4pi.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.13-pre5 crash when mounting proc
From: "KOBAYASHI R. Taizo" <tkoba@ike-dyn.ritsumei.ac.jp>
In-Reply-To: <p04330100b7f7f805ef9a@[24.163.33.28]>
References: <p04330100b7f7f805ef9a@[24.163.33.28]>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 21 Oct 2001 00:02:12 -0400
Stefan Jeglinski <jeglin@4pi.com> wrote:
Subject: 2.4.13-pre5 crash when mounting proc
> 6500, Linux/PPC 2KQ4 running 2.2.19, I compiled 2.4.13-pre5, rsynced
> from bk yesterday. On boot, when it gets to "mounting proc
> filesystem," I get a break into the mon debugger, but I have no
> keyboard response (so no backtrace). The info I can copy is:
>
> vector: 300 at pc = c02432fc lr = c00544e0 msr = b032 sp = c5dc3ef0
>
> plus some more that I'm not sure will help much. For this output
> alone, should I include System.map also?

My pb2400 got well again with following:
--- arch/ppc/lib/string.S.orig  Thu Oct 25 19:09:31 2001
+++ arch/ppc/lib/string.S       Thu Oct 25 23:17:39 2001
@@ -62,8 +62,7 @@
        .long   8 ## n ## 5b,9 ## n ## 1b;      \
        .long   8 ## n ## 6b,9 ## n ## 1b;      \
        .long   8 ## n ## 7b,9 ## n ## 1b;      \
-
-       .text
+.text

 CACHELINE_BYTES = L1_CACHE_LINE_SIZE
 LG_CACHELINE_BYTES = LG_L1_CACHE_LINE_SIZE

Taizo

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
