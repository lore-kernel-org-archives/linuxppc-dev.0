Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyHW06Xv6zDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 10:27:24 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id r68so2365468pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 17:27:24 -0700 (PDT)
Date: Thu, 21 Sep 2017 09:27:17 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Andy Whitcroft <apw@canonical.com>
Subject: Re: [RFC][PATCH v2 7/7] checkpatch: add pF/pf deprecation warning
Message-ID: <20170921002717.GA773@jagdpanzerIV.localdomain>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170920162910.32053-8-sergey.senozhatsky@gmail.com>
 <1505929138.12311.5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1505929138.12311.5.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/20/17 10:38), Joe Perches wrote:
> On Thu, 2017-09-21 at 01:29 +0900, Sergey Senozhatsky wrote:
> > We deprecated '%pF/%pf' printk specifiers, since '%pS/%ps' is now smart
> > enough to handle function pointer dereference on platforms where such
> > dereference is required.
> > 
> > checkpatch warning example:
> > 
> > WARNING: Use '%pS/%ps' instead. This pointer extension was deprecated: '%pF'
> 
> If this series is accepted,  I think this message
> is unclear and would prefer something like:

sure, can tweak the patch.

[..]
>  			if ($bad_extension ne "") {
>  				my $stat_real = raw_line($linenr, 0);
> +				my $ext_type = "Invalid";
> +				my $use = "";
>  				for (my $count = $linenr + 1; $count <= $lc; $count++) {
>  					$stat_real = $stat_real . "\n" . raw_line($count, 0);
>  				}
> +				if ($bad_extension =~ /p[Ff]/i) {
						I think /i is not necessary here

> +					$ext_type = "Deprecated";
> +					$use = " - use %pS instead";
> +					$use =~ s/pS/ps/ if ($bad_extension =~ /pf/);
							ok, handy :)

	-ss
