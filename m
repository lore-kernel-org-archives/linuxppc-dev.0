Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthfx518MzDr2B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:06:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>,
 linux-next  <linux-next@vger.kernel.org>
Subject: DNS (?) not working on G5 (64-bit powerpc) (was [net-next, v3,
 3/3] udp: try to avoid 2 cache miss on dequeue)
In-Reply-To: <07dec63bc32dc574202e8e981292f0bdb2c144b0.1497026892.git.pabeni@redhat.com>
Date: Thu, 22 Jun 2017 23:06:32 +1000
Message-ID: <87shisqihz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo wrote:
> when udp_recvmsg() is executed, on x86_64 and other archs, most skb
> fields are on cold cachelines.
> If the skb are linear and the kernel don't need to compute the udp
> csum, only a handful of skb fields are required by udp_recvmsg().
> Since we already use skb->dev_scratch to cache hot data, and
> there are 32 bits unused on 64 bit archs, use such field to cache
> as much data as we can, and try to prefetch on dequeue the relevant
> fields that are left out.
>=20
> This can save up to 2 cache miss per packet.
>=20
> v1 -> v2:
>   - changed udp_dev_scratch fields types to u{32,16} variant,
>     replaced bitfiled with bool
>=20
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Acked-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 103 insertions(+), 11 deletions(-)

This appears to break wget on one of my machines.

Networking in general is working, I'm able to SSH in, but then I can't
do a wget.

eg:

$ wget google.com
--2017-06-22 22:45:39--  http://google.com/
Resolving proxy.pmdw.com (proxy.pmdw.com)... failed: Temporary failure in n=
ame resolution.
wget: unable to resolve host address =E2=80=98proxy.pmdw.com=E2=80=99

$ host proxy.pmdw.com
proxy.pmdw.com is an alias for raven.pmdw.com.
raven.pmdw.com has address 10.1.2.3

$ wget google.com
--2017-06-22 22:52:08--  http://google.com/
Resolving proxy.pmdw.com (proxy.pmdw.com)... failed: Temporary failure in n=
ame resolution.
wget: unable to resolve host address =E2=80=98proxy.pmdw.com=E2=80=99

Maybe host is using TCP but the man page says it doesn't?


Everything is OK if I boot back to the previous commit 0a463c78d25b
("udp: avoid a cache miss on dequeue"):

$ wget google.com
--2017-06-22 23:00:01--  http://google.com/
Resolving proxy.pmdw.com (proxy.pmdw.com)... 10.1.2.3
Connecting to proxy.pmdw.com (proxy.pmdw.com)|10.1.2.3|:3128... connected.
Proxy request sent, awaiting response... 302 Found
Location: http://www.google.com.au/?gfe_rd=3Dcr&ei=3DUb9LWbPbLujDXrH1uPgE [=
following]
--2017-06-22 23:00:01--  http://www.google.com.au/?gfe_rd=3Dcr&ei=3DUb9LWbP=
bLujDXrH1uPgE
Reusing existing connection to proxy.pmdw.com:3128.
Proxy request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: =E2=80=98index.html=E2=80=99

index.html                      [ <=3D>                                    =
   ]  11.37K  --.-KB/s    in 0.001s=20=20

2017-06-22 23:00:01 (22.0 MB/s) - =E2=80=98index.html=E2=80=99 saved [11640]

$ uname -a
Linux 4.12.0-rc4-gcc6-00988-g0a463c7 #88 SMP Thu Jun 22 22:55:12 AEST 2017 =
ppc64 GNU/Linux


Haven't had time to debug any further. Any ideas?

cheers
