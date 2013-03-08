Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 3ED6F2C0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 22:13:33 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 12684-09 for <linuxppc-dev@lists.ozlabs.org>;
 Fri,  8 Mar 2013 11:13:29 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] drivers/tty/hvc: fixup original commit:
 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b
Date: Fri, 8 Mar 2013 11:11:47 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7182@saturn3.aculab.com>
In-Reply-To: <1362714364.6977.4.camel@pasglop>
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
 <51395D2C.6040007@asianux.com> <1362714364.6977.4.camel@pasglop>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Chen Gang" <gang.chen@asianux.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg KH <gregkh@linuxfoundation.org>,
 wfp5p@virginia.edu, tklauser@distanz.ch, linuxppc-dev@lists.ozlabs.org,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, 2013-03-08 at 11:38 +0800, Chen Gang wrote:
> >   originally I did not notice src buf len and dest buf len are the =
same.
> >     so origianlly, it is not a bug issue, it is only for beautify =
code.
> >     and now, using strcpy is better.
>=20
> Being the same len doesn't mean it's safe to use strcpy ... the source
> might be missing the 0 terminator. In this specific case though, I
> believe the source string comes was itself populated with strlcpy
> (at least since your patch 6b6680c4ea3952af8ae76915cbca41245147741b) =
so
> strcpy is indeed safe but using strlcpy doesn't hurt does it ?

Using strlcpy() also stops someone else having to check it
again in a few years time.

	David
