Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A3C8367BE1
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 08:17:20 +1100 (EST)
Message-ID: <45709BD4.80505@am.sony.com>
Date: Fri, 01 Dec 2006 13:17:08 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
	<Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
	<45705D79.6000107@am.sony.com>
	<Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
	<Pine.LNX.4.64.0612011242050.3695@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612011242050.3695@woody.osdl.org>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-sparse@vger.kernel.org,
	Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds wrote:
> Btw, try this stupid program, to see just how _strange_ gcc enums are.. A 
> sizeof of the enum is not the same as the size of the individual entries. 

Yes, interesting.  I think your comment regarding compatibility with other
compilers is the convincing one.

Another way is to change the encoding of the value such that it fits into
the range of an enum.  For this particular case, the values are actually
for a field in the high 3 bits, so I can just do the shift when the value
is used.

-Geoff
