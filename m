Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5087067BB6
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 08:00:23 +1100 (EST)
Date: Fri, 1 Dec 2006 21:00:11 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Derek M Jones <derek@knosof.co.uk>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
Message-ID: <20061201210011.GE3078@ftp.linux.org.uk>
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
	<Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
	<45705D79.6000107@am.sony.com>
	<Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
	<4570954F.70302@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4570954F.70302@knosof.co.uk>
Cc: Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>,
	linux-sparse@vger.kernel.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 01, 2006 at 08:49:19PM +0000, Derek M Jones wrote:
> The C++ Standard explicitly supports enumeration constants not
> having type int.  See sentence 858 of
> http://www.coding-guidelines.com/cbook/cbook1_0b.pdf
> for a discussion of the issues (plus some other sentences).
> 
> C compiler vendors, at least those who extend the language, are more
> likely to want to follow the C++ rules (which are documented) than the
> gcc rules (which are poorly documented).
> 
> The C++ way of doing things is also likely to be followed by vendors
> whose C compiler is enabled by a command line switch on their C++
> compiler (eg, at least one vendor based in Seattle).

"C++ way of doing things" is hardly an endorsement.  _IF_ we are changing
the way enum works, might as well do it sanely and have the type of
enumeration constant same as that of expression initializing it (with
usual implicit initializers).  But yes, that explicitly changes semantics -
enum { A = 0L, B, C }; will have A, B and C long, not int.  Direct
contradiction with C90/C99...
