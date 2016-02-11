Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9753D1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 19:42:33 +1100 (AEDT)
Date: Thu, 11 Feb 2016 09:42:30 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160211084230.GB29683@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1455176897.2885.12.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 11, 2016 at 06:48:17PM +1100, Balbir Singh wrote:
> On Wed, 2016-02-10 at 17:25 +0100, Torsten Duwe wrote:
> > +
> > +echo "int func() { return 0; }" | \
> > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > +
> > +leaf_toc_result=$?
> > +
> 
> leaf_toc_result failed for me with gcc 5. I'll try and grab gcc-6
> and give the patches a spin

Don't bother. _All_ gccs are broken in that respect currently.
AFAIK Anton is working on this. You have to fake the test, like
static int a; return a++;

Gcc fails to set the TOC for profiled "leaf" functions, where it
thinks no global/static symbols are referenced.

	Torsten
