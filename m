Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.25])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 00C8A67BBC
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 07:50:41 +1100 (EST)
Date: Fri, 1 Dec 2006 12:50:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
In-Reply-To: <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612011242050.3695@woody.osdl.org>
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
	<Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
	<45705D79.6000107@am.sony.com>
	<Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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



On Fri, 1 Dec 2006, Linus Torvalds wrote:
> 
> But at times, some of the gcc extensions aren't necessarily that well 
> defined or thought out, or simply not worth it. The extended type system 
> for enums in gcc is just basically messy, and it doesn't really offer you 
> anything important.

Btw, try this stupid program, to see just how _strange_ gcc enums are.. A 
sizeof of the enum is not the same as the size of the individual entries. 

Notice also how the size of the enum entry is _not_ tied to the type of 
the expression it had, but literally to its _value_. The size of "one" 
ends up being 4, even though it was initialized with a "1ll" value.

So with gcc-enums, you CANNOT get a sane type result.

In contrast, if you want sane types, you could easily do

	#define one (1ull)
	#define other (0x10000ull)
	#define strange (0x100000000ull)

and they'd all have the same type (and having the same type means that 
they act the same in expressions - you get the same expression type in 
mixing these values, _unlike_ the insane gcc enum cases)

		Linus

---
enum hello {
	one = 1ll,
	other = 0x10000,
	bigval = 0x1000000000000ll,
};

int main(int argc, char **argv)
{
	printf("%zu %zu %zu %zu\n",
		sizeof(enum hello),
		sizeof(one),
		sizeof(other),
		sizeof(bigval));
	return 0;
}
