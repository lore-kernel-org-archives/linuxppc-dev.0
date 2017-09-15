Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv2SZ73m7zDql9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 03:29:02 +1000 (AEST)
Date: Fri, 15 Sep 2017 19:28:56 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tamara Diaconita <diaconitatamara@gmail.com>, Baoquan He
 <bhe@redhat.com>, Kamlakant Patel <kamlakant.patel@broadcom.com>, Jonathan
 Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>, Trond
 Myklebust <trond.myklebust@primarydata.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Ingo
 Molnar <mingo@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>, Paul Mackerras
 <paulus@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org, Bamvor Jian Zhang
 <bamvor.zhangjian@linaro.org>
Subject: Re: [PATCH 1/6] lib/cmdline.c: Add backslash support to kernel
 commandline parsing.
Message-ID: <20170915192856.1d5708b6@kitsune.suse.cz>
In-Reply-To: <20170915171409.GZ5426@ZenIV.linux.org.uk>
References: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
 <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
 <20170915171409.GZ5426@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Sep 2017 18:14:09 +0100
Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Fri, Sep 15, 2017 at 07:02:46PM +0200, Michal Suchanek wrote:
> 
> >  	for (i = 0; args[i]; i++) {
> > -		if (isspace(args[i]) && !in_quote)
> > +		if (isspace(args[i]) && !in_quote && !backslash)
> >  			break;
> > -		if (equals == 0) {
> > -			if (args[i] == '=')
> > -				equals = i;
> > +
> > +		if ((equals == 0) && (args[i] == '='))
> > +			equals = i;
> > +
> > +		if (!backslash) {
> > +			if ((args[i] == '"') || (args[i] == '\\'))
> > {
> > +				if (args[i] == '"')
> > +					in_quote = !in_quote;
> > +				if (args[i] == '\\')
> > +					backslash = 1;
> > +
> > +				memmove(args + 1, args, i);
> > +				args++;
> > +				i--;
> > +			}
> > +		} else {
> > +			backslash = 0;
> >  		}
> > -		if (args[i] == '"')
> > -			in_quote = !in_quote;
> >  	}  
> 
> ... and that makes for Unidiomatic Work With Strings Award for this
> September. Using memmove() for string rewrite is almost always bad
> taste; in this case it's also (as usual) broken.

Care to share how it is broken?

Thanks

Michal
