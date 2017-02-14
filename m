Return-Path: <cyrilbur@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMjss3qH3zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 11:27:13 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id f200so1530621itf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 16:27:13 -0800 (PST)
Message-ID: <1487031943.9122.1.camel@gmail.com>
Subject: Re: [PATCH v2] powerpc: Blacklist GCC 5.4 6.1 and 6.2
From: Cyril Bur <cyrilbur@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
Date: Tue, 14 Feb 2017 11:25:43 +1100
In-Reply-To: <20170213154437.GP21840@gate.crashing.org>
References: <20170213033536.8908-1-cyrilbur@gmail.com>
 <20170213154437.GP21840@gate.crashing.org>
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

On Mon, 2017-02-13 at 09:44 -0600, Segher Boessenkool wrote:
> Hi Cyril,
> 
> On Mon, Feb 13, 2017 at 02:35:36PM +1100, Cyril Bur wrote:
> > A bug in the -02 optimisation of GCC 5.4 6.1 and 6.2 causes
> > setup_command_line() to not pass the correct first argument to strcpy
> > and therefore not actually copy the command_line.
> 
> There is no such thing as an "-O2 optimisation".

Right, perhaps I should have phrased it as "One of the -O2 level
optimisations of GCC 5.4, 6.1 and 6.2 causes setup_command_line() to
not pass the correct first argument to strcpy and therefore not
actually copy the command_line, -O1 does not have this problem."

> 
> > At the time of writing GCC 5.4 is the most recent and is affected. GCC
> > 6.3 contains the backported fix, has been tested and appears safe to
> > use.
> 
> 6.3 is (of course) the newer release; 5.4 is a maintenance release of
> a compiler that is a year older.

Yes. I think the point I was trying to make is that since they
backported the fix to 5.x and 6.x then I expect that 5.5 will have the
fix but since it doesn't exist yet, I can't be sure. I'll add something
to that effect.

> 
> > +# - gcc-5.4, 6.1, 6.2 don't copy the command_line around correctly
> > +		echo -n '*** GCC-5.4 6.1 6.2 have a bad -O2 optimisation ' ; \
> > +		echo 'which will cause lost command_line options (at least).' ; \
> 
> Maybe something more like
> 
> "GCC 5.4, 6.1, and 6.2 have a bug that results in a kernel that does
> not boot.  Please use GCC 6.3 or later.".

"that may not boot" is more accurate, if it can boot without a
command_line param it might just do so.

> 
> Please mention the GCC PR # somewhere in the code, too?
> 

Sure.

Thanks,

Cyril

> 
> Segher
