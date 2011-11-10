Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id DA1EBB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 20:17:23 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 05636-06 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 10 Nov 2011 09:17:19 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 1/5] [ppc] Process dynamic relocations for kernel
Date: Thu, 10 Nov 2011 09:15:38 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEB5@saturn3.aculab.com>
In-Reply-To: <4EBB3794.9050309@in.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Suzuki Poulose" <suzuki@in.ibm.com>,
 "Josh Poimboeuf" <jpoimboe@linux.vnet.ibm.com>
Cc: Nathan Miller <nathanm2@us.ibm.com>, Josh Poimboeuf <jpoimboe@us.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> >> How about using clean_dcache_range() to flush the range runtime
> >> address range [ _stext, _end ] ? That would flush the entire
> >> instructions.
> >
> > Wouldn't that result in more cache flushing than the original
solution?
> >
> > For example, my kernel is 3.5MB.  Assuming a 32 byte cache line
size,
> > clean_dcache_range(_stext, _end) would result in about 115,000
dcbst's
> > (3.5MB / 32).
>=20
> Oops ! You are right. We could go back to the=20
> clean_dcache_all() or the
> initial approach that you suggested. (dcbst).

Maybe clean_dcache_range() itself should limit the range
to the size of the cache?
I suspect that code can easily know the cache size.

	David
