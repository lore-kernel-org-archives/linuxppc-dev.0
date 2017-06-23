Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv8SW0cWbzDqy9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 16:59:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: DNS (?) not working on G5 (64-bit powerpc) (was [net-next, v3,
 3/3] udp: try to avoid 2 cache miss on dequeue)
In-Reply-To: <1498166297.111795.1018373424.5E414246@webmail.messagingengine.com>
References: <87shisqihz.fsf@concordia.ellerman.id.au>
 <1498165026.2503.21.camel@redhat.com>
 <1498166297.111795.1018373424.5E414246@webmail.messagingengine.com>
Date: Fri, 23 Jun 2017 16:59:06 +1000
Message-ID: <87r2ybp4ud.fsf@concordia.ellerman.id.au>
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

Hannes Frederic Sowa <hannes@stressinduktion.org> writes:

> On Thu, Jun 22, 2017, at 22:57, Paolo Abeni wrote:
>>=20
>> Can you please check if the following patch fixes the issue? Only
>> compiled tested here.
>>=20
>> Thanks!!!
>> ---
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index 067a607..80d89fe 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -1446,16 +1446,19 @@ static struct sk_buff
>> *__first_packet_length(struct sock *sk,
>> =C2=A0{
>> =C2=A0	struct sk_buff *skb;
>> =C2=A0
>> -       while ((skb =3D skb_peek(rcvq)) !=3D NULL &&
>> -       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0udp_lib_checksum_compl=
ete(skb)) {
>> -               __UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS,
>> -                               IS_UDPLITE(sk));
>> -               __UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
>> -                               IS_UDPLITE(sk));
>> -               atomic_inc(&sk->sk_drops);
>> -               __skb_unlink(skb, rcvq);
>> -               *total +=3D skb->truesize;
>> -               kfree_skb(skb);
>> +       while ((skb =3D skb_peek(rcvq)) !=3D NULL) {
>> +               if (udp_lib_checksum_complete(skb)) {
>> +                       __UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS,
>> +                                       IS_UDPLITE(sk));
>> +                       __UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
>> +                                       IS_UDPLITE(sk));
>> +                       atomic_inc(&sk->sk_drops);
>> +                       __skb_unlink(skb, rcvq);
>> +                       *total +=3D skb->truesize;
>> +                       kfree_skb(skb);
>> +               } else {
>> +                       udp_set_dev_scratch(skb);
>
> It needs a "break;" here.
>
>> +               }
>> =C2=A0	}
>> =C2=A0	return skb;
>> =C2=A0}

That works!

$ wget google.com
--2017-06-23 16:56:31--  http://google.com/
Resolving proxy.pmdw.com (proxy.pmdw.com)... 10.1.2.3
Connecting to proxy.pmdw.com (proxy.pmdw.com)|10.1.2.3|:3128... connected.
Proxy request sent, awaiting response... 302 Found
Location: http://www.google.com.au/?gfe_rd=3Dcr&ei=3Dn7tMWeb9JYPr8wfg4LXYAQ=
 [following]
--2017-06-23 16:56:31--  http://www.google.com.au/?gfe_rd=3Dcr&ei=3Dn7tMWeb=
9JYPr8wfg4LXYAQ
Reusing existing connection to proxy.pmdw.com:3128.
Proxy request sent, awaiting response... 200 OK
Length: unspecified [text/html]
Saving to: =E2=80=98index.html=E2=80=99


The patch had whitespace issues or something and I had to apply it by
hand, here's what I actually tested.

cheers

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 067a607917f9..d3227c1bbe8e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1446,16 +1446,20 @@ static struct sk_buff *__first_packet_length(struct=
 sock *sk,
 {
 	struct sk_buff *skb;
=20
-	while ((skb =3D skb_peek(rcvq)) !=3D NULL &&
-	       udp_lib_checksum_complete(skb)) {
-		__UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS,
-				IS_UDPLITE(sk));
-		__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
-				IS_UDPLITE(sk));
-		atomic_inc(&sk->sk_drops);
-		__skb_unlink(skb, rcvq);
-		*total +=3D skb->truesize;
-		kfree_skb(skb);
+	while ((skb =3D skb_peek(rcvq)) !=3D NULL) {
+		if (udp_lib_checksum_complete(skb)) {
+			__UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS,
+					IS_UDPLITE(sk));
+			__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS,
+					IS_UDPLITE(sk));
+			atomic_inc(&sk->sk_drops);
+			__skb_unlink(skb, rcvq);
+			*total +=3D skb->truesize;
+			kfree_skb(skb);
+		} else {
+			udp_set_dev_scratch(skb);
+			break;
+		}
 	}
 	return skb;
 }
