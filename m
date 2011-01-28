Return-Path: <oakad@yahoo.com>
Received: from web37603.mail.mud.yahoo.com (web37603.mail.mud.yahoo.com
	[209.191.87.86]) by ozlabs.org (Postfix) with SMTP id 508611007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 13:43:47 +1100 (EST)
Message-ID: <983577.58398.qm@web37603.mail.mud.yahoo.com>
Date: Thu, 27 Jan 2011 18:43:44 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [PATCH] gianfar: Fall back to software tcp/udp checksum on older
	controllers
To: Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20110127095100.GA5411@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, mlcreech@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > -=A0=A0=A0 =A0=A0=A0=0A> gfar_tx_checksum(skb, fcb);=0A> > +=A0=A0=A0 =
=A0=A0=A0 switch=0A> (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12))=0A> >=
 +=A0=A0=A0 =A0=A0=A0=0A> =A0=A0=A0 ? 1 : 0) {=0A> =0A> The switch construc=
tion is quite bizarre. ;-) Why not=0A> =0A=0AMy testing shows that even on =
broken chips unaligned packets are quite rare=0A(only some SYN packets seem=
 to be affected). So I tried to leave the=0Achecksum offload path as the mo=
st preferred one.=0A=0A=0A=0A      
