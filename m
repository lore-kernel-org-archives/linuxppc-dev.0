Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.25])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF34B67BE2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 08:19:43 +1100 (EST)
Date: Fri, 1 Dec 2006 13:19:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
In-Reply-To: <20061201210011.GE3078@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612011309480.3695@woody.osdl.org>
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
	<Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
	<45705D79.6000107@am.sony.com>
	<Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
	<4570954F.70302@knosof.co.uk>
	<20061201210011.GE3078@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Pinski <Andrew_Pinski@PlayStation.Sony.Com>,
	Derek M Jones <derek@knosof.co.uk>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-sparse@vger.kernel.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Fri, 1 Dec 2006, Al Viro wrote:
> 
> "C++ way of doing things" is hardly an endorsement.  _IF_ we are changing
> the way enum works, might as well do it sanely and have the type of
> enumeration constant same as that of expression initializing it (with
> usual implicit initializers).  But yes, that explicitly changes semantics -
> enum { A = 0L, B, C }; will have A, B and C long, not int.  Direct
> contradiction with C90/C99...

Well, the C++ definition at least means that enumerated names have the 
same types _after_ the enumaration is closed (ie the example I sent out 
will at least give the same value for the sizeof() of everything).

So the C++ definition is a lot saner than what gcc does now.

On the other hand, I do agree that "keeping the enumerated type the same 
as the initializer expression type" is _also_ a sane situation. And it's 
better than the C++ situation in the sense that at least the sizes are 
_consistent_ (which C++ is not - the size AT DEFINITION time is 
potentially different from the size AFTER the definition).

So in the C++ world, you have the odd situation that

	enum strange {
		one = (char) 1,
		other = sizeof(one),
	};

we will actually end up with

	other != sizeof(one)

AFTER the declaration (because when "other" got its value, "one" had a 
type of "char", but _after_ the declaration, "one" will have a type of 
"size_t" or "int" or whatever, because the final type of "one" depends on 
the type of the enumerator.

So the C++ definition is really odd, but it's better than what gcc does, 
because at least all the values end up having a common type at the end.

The version where all the values _keep_ their types all the time, and you 
can force them to be whatever you want (by just making sure the 
initializer expression has the right type) is the most flexible one and at 
least doesn't have inconsistencies like the above example, but it's 
neither what gcc nor the C++ standard (or any older C standard, for that 
matter) actually says.

Anyway, because of all this, enum types are a mess. sparse warns if you 
can't fit it in an "int", which is the traditional and fairly dependable 
old C behaviour, and basically says "extended integer types for enums are 
flaky as hell - warn about them!"

		Linus
