Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B816CB6F0F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 11:17:21 +1100 (EST)
Date: Thu, 10 Dec 2009 19:17:19 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Floating point in the kernel
Message-ID: <20091210191719.0516b46b@lappy.seanm.ca>
In-Reply-To: <200912102235.47985.arnd@arndb.de>
References: <20091210131311.78cab78c@lappy.seanm.ca>
	<1260476379.16132.224.camel@pasglop>
	<20091210153359.3a480488@lappy.seanm.ca>
	<200912102235.47985.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Found it. We are calling sock_sendmsg, which is definitely a call that
can block! The receive side is done in a thread (which does no floating
point ;), but the send was called directly from the "evil FP thread".

It looks like under light load, you tend to get away with it, so our
trivial testing did not catch it. And most of our warp users do RTP via
asterisk, so this RTP path was not really tested.

I really appreciate the input, the comments convinced me I was going
in the wrong direction and forced me to look harder. I am going to back
out the two patches I sent and fix this properly instead.

Cheers,
   Sean
