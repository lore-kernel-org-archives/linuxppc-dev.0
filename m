Return-Path: <julian.calaby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 6FCA1DDF58
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 13:00:21 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3112963rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 18:00:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090120011945.GA23380@oksana.dev.rtsoft.ru>
References: <496A89A1.8050302@gmail.com>
	<646765f40901191650v5320f5e4tcc5fb7da0555ade1@mail.gmail.com>
	<20090120011945.GA23380@oksana.dev.rtsoft.ru>
Date: Tue, 20 Jan 2009 13:00:19 +1100
Message-ID: <646765f40901191800y27530acaw74edc01abdd13e68@mail.gmail.com>
Subject: Re: [PATCH] mb862xx: Restrict compliation of platform driver to PPC
From: Julian Calaby <julian.calaby@gmail.com>
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
	Matteo Fortini <m.fortini@selcomgroup.com>, linux-kernel@vger.kernel.org,
	Krzysztof Helt <krzysztof.h1@poczta.fm>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 12:19, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> Should be Anatolij. ;-)

Who is the first person on the list, I guess he's missed this or isn't
reading his email.

> But I'm interested in this driver as well.
>
> FWIW, the patch looks OK, except for the long lines in the commit log.

I don't expect this to be applied as is. There is a better fix out
there, but I don't know the hardware so I'm not sure what it is.

> Also you'd better mention exact build error in the commit log.

Essentially it's a huge list of missing definitions for functions
which aren't defined for SPARC. I'll reply with it if you really want
it, however they look to be PPC specific. If they were generic I would
have simply included the correct files so that it compiled, rather
than this nasty hack.

It also appears that these functions are not defined in the headers
that this driver includes.

> (Btw, we'd better fix the build for sparc instead of adding another
> "depends on". Could anybody point to some recent, working sparc cross
> toolchain? Last time I googled for it I found only some prehistoric
> versions that I didn't bother to try...)

Before we commit to fixing this properly, is it really worth it? Is
this hardware ever likely to be used with SPARC?

Given that there are PCI and OF versions of the driver, it seems to me
that this is available as a PCI expansion card, and as a graphics chip
built into some PPC motherboards. The initial commit says: "Lime GDC
support is known to work on PPC440EPx based lwmon5 and MPC8544E based
socrates embedded boards, both equipped with Lime GDC." so I'm
guessing that this graphics chip is designed for embedded boards. I
can find references to it's use in embedded automotive applications on
Google but I can't find any reference to the Fujitsu LIME (MB86276)
and SPARC on Google.

Note that the PCI version of this driver compiles fine with both
allyesconfig and allmodconfig.

If you're sure you want to do this, I'd check out crosstool for a
SPARC cross-complier.

Two other things:
1. SPARC32 and SPARC64 can be compiled with the same compiler.
2. These two platforms have slightly different OpenFirmware interfaces
- so fixing it for both of these will be a pain.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: https://sites.google.com/site/juliancalaby/
