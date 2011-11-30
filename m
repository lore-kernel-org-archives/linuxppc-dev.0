Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D595BB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 05:12:33 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 19591-06 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 30 Nov 2011 18:12:22 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/6] powerpc/boot: Add mfdcrx
Date: Wed, 30 Nov 2011 18:10:23 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEF3@saturn3.aculab.com>
In-Reply-To: <F91E9007-5DA5-4E3A-993E-EA680DE08D79@kernel.crashing.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
 "Tony Breeds" <tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > +#define mfdcrx(rn) \
> > +	({	\
> > +		unsigned long rval; \
> > +		asm volatile("mfdcrx %0,%1" : "=3Dr"(rval) : "g"(rn)); \
> > +		rval; \
> > +	})
>=20
> "g" is never correct on PowerPC, you want "r" here.  You can write
> this as a static inline btw, you only need the #define stuff when
> there is an "i" constraint involved.

I think you can still use static inlines even when a
constraint is one that requires a compile time constant.
eg (not ppc, but the "n" become part of the instruction
word):

static __inline__ uint32_t
custom_inic(const uint32_t op, uint32_t a, const uint32_t b)
{
    uint32_t result;

    __asm__ ( "custom\t%1, %0, %2, c%3"
        : "=3Dr" (result) : "n" (op), "r" (a), "n" (b));
    return result;
}

	David
