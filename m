Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 7D6C0B7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 22:28:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Floating point in the kernel
Date: Fri, 11 Dec 2009 12:28:41 +0100
References: <20091210131311.78cab78c@lappy.seanm.ca>
	<200912102235.47985.arnd@arndb.de>
	<20091210191719.0516b46b@lappy.seanm.ca>
In-Reply-To: <20091210191719.0516b46b@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912111228.42231.arnd@arndb.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 December 2009, Sean MacLennan wrote:
> Found it. We are calling sock_sendmsg, which is definitely a call that
> can block! The receive side is done in a thread (which does no floating
> point ;), but the send was called directly from the "evil FP thread".
> 
> It looks like under light load, you tend to get away with it, so our
> trivial testing did not catch it. And most of our warp users do RTP via
> asterisk, so this RTP path was not really tested.
> 
> I really appreciate the input, the comments convinced me I was going
> in the wrong direction and forced me to look harder. I am going to back
> out the two patches I sent and fix this properly instead.

Glad to hear you found it.

As a general remark though, both the usage of sockets and of floating
point are a really strong hint that the stuff you are doing should be
in user space instead, which would have saved you a lot of time in
debugging. If you do something like this again, make sure to get the
partitioning of the code between code in kernel and user space right.
If in doubt, just ask on the mailing list.

	Arnd <><
