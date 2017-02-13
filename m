Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vM5sg61xCzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 11:24:55 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 19so6228412pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 16:24:55 -0800 (PST)
Message-ID: <1486945408.2733.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc: Blacklist GCC 5.4 6.1 and 6.2
From: Cyril Bur <cyrilbur@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: akshay.adiga@linux.vnet.ibm.com
Date: Mon, 13 Feb 2017 11:23:28 +1100
In-Reply-To: <6f4d7111-6747-db55-c2c0-10aefa009f6d@c-s.fr>
References: <20170210053115.20565-1-cyrilbur@gmail.com>
 <6f4d7111-6747-db55-c2c0-10aefa009f6d@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-10 at 08:48 +0100, Christophe LEROY wrote:
> 
> Le 10/02/2017 à 06:31, Cyril Bur a écrit :
> > A bug in the -02 optimisation of GCC 5.4 6.1 and 6.2 causes
> > setup_command_line() to not pass the correct first argument to strcpy
> > and therefore not actually copy the command_line.
> > 
> > A workaround patch was proposed: http://patchwork.ozlabs.org/patch/673130/
> > some discussion ensued.
> > 
> > A GCC bug was raised: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71709
> > The bug has been fixed in 7.0 and backported to GCC 5 and GCC 6.
> > 
> > At the time of writing GCC 5.4 is the most recent and is affected. GCC
> > 6.3 contains the backported fix, has been tested and appears safe to
> > use.
> > 
> > Heavy-lifting-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> >  arch/powerpc/Makefile | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 31286fa7873c..a4b886694391 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -414,6 +414,15 @@ checkbin:
> >  		echo -n '*** Please use a different binutils version.' ; \
> >  		false ; \
> >  	fi
> > +	@if test "$(cc-version)" = "0504" \
> > +		|| test "$(cc-version)" = "0601" \
> > +		|| test "$(cc-version)" = "0602" ; then \
> > +		echo -n '*** GCC-5.4 6.1 6.2 have a bad -O2 optimisation ' ; \
> > +		echo 'which will cause lost commandline options (at least).' ; \
> > +		echo '*** Please use a different GCC version.' ; \
> > +		false ; \
> > +	fi
> > +
> 
> According to the GCC bug report, this bug applies to powerpc64le
> Why force all targets to not use those versions of GCC ?
> 

True, I'll double check on BE, these days BE does suffer from, "oops I
didn't check that". If it is only LE, I'll add another condition.

Thanks,

Cyril

> Christophe
