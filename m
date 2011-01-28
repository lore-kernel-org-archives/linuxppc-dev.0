Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id BCFBEB70F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 20:08:23 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 00747-03 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 09:08:12 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/7] PowerPC: add unlikely() to BUG_ON()
Date: Fri, 28 Jan 2011 09:05:59 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2D@saturn3.aculab.com>
In-Reply-To: <4D41B213.4070606@caviumnetworks.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "David Daney" <ddaney@caviumnetworks.com>, "Coly Li" <bosong.ly@taobao.com>
Cc: Wang Cong <xiyou.wangcong@gmail.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Yong Zhang <yong.zhang0@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > +#define __BUG_ON(x) do {					\
> >   	if (__builtin_constant_p(x)) {				\
> >   		if (x)						\
> >   			BUG();					\
> > @@ -85,6 +86,8 @@
> >   	}							\
> >   } while (0)
> >
> > +#define BUG_ON(x) __BUG_ON(unlikely(x))
> > +

>From my experiments, adding an 'unlikely' at that point isn't
enough for non-trivial conditions - so its presence will
give a false sense the the optimisation is present!
In particular 'if (unlikely(x && y))' needs to be
'if (unlikely(x) && unlikely(y))' in order to avoid
mispredicted branches when 'x' is false.

Also, as (I think) in some of the generated code quoted,
use of __builtin_expect() with a boolean expression can
force some versions of gcc to generate the integer
value of the expression - rather than just selecting the
branch instructions that statically predict the
normal code path.

Sometimes I've also also had to add an asm() statement
that generates no code in order to actually force a
forwards branch (so it has something to place at the
target).

(I've been counting clocks ....)

	David
