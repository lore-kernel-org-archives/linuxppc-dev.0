Return-Path: <derek@knosof.co.uk>
Received: from queue03-winn.ispmail.ntl.com (queue03-winn.ispmail.ntl.com
	[81.103.221.57]) by ozlabs.org (Postfix) with ESMTP id 60A8867BB7
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 07:58:57 +1100 (EST)
Message-ID: <4570954F.70302@knosof.co.uk>
Date: Fri, 01 Dec 2006 20:49:19 +0000
From: Derek M Jones <derek@knosof.co.uk>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cast truncates bits from constant value (8000000000000000 becomes
	0)
References: <4563D00D.4010704@am.sony.com>
	<Pine.LNX.4.62.0612011516120.28210@pademelon.sonytel.be>
	<Pine.LNX.4.64.0612010723190.3695@woody.osdl.org>
	<45705D79.6000107@am.sony.com>
	<Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612011215110.3695@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Linus,

>> One of the gcc maintainers (Andrew Pinski) told me to set it up that
>> way, so I figured it was safe.
> 
> It _is_ safe, as long as you stick to gcc, and as long as you don't mix 
> signs in your values, for example.
> 
> But we actually want to let people compile even the kernel with other 
> compilers than gcc. Most of the time, that means that we strongly 
> encourage those compiler people to support all the gcc extensions (let's 
> face it, standardization is good, and open standards work better than 
> closed ones, and gcc is the most widely spread open and portable compiler 
> BY FAR, so it would be stupid to _not_ do that).

The C++ Standard explicitly supports enumeration constants not
having type int.  See sentence 858 of
http://www.coding-guidelines.com/cbook/cbook1_0b.pdf
for a discussion of the issues (plus some other sentences).

C compiler vendors, at least those who extend the language, are more
likely to want to follow the C++ rules (which are documented) than the
gcc rules (which are poorly documented).

The C++ way of doing things is also likely to be followed by vendors
whose C compiler is enabled by a command line switch on their C++
compiler (eg, at least one vendor based in Seattle).

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
