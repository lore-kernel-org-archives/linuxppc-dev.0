Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbWh20K7rzDrJj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 21:30:10 +1000 (AEST)
Date: Mon, 21 Aug 2017 13:30:03 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Baoquan He <bhe@redhat.com>
Cc: linux-doc@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Viresh
 Kumar <viresh.kumar@linaro.org>, David Howells <dhowells@redhat.com>,
 Sylvain 'ythier' Hitier <sylvain.hitier@gmail.com>, Paul Mackerras
 <paulus@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Ingo Molnar
 <mingo@kernel.org>, Michael Neuling <mikey@neuling.org>, Jonathan Corbet
 <corbet@lwn.net>, Ilya Matveychikov <matvejchikov@gmail.com>, Mahesh J
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>, Rusty
 Russell <rusty@rustcorp.com.au>, Nicholas Piggin <npiggin@gmail.com>, Scott
 Wood <oss@buserror.net>, Jason Baron <jbaron@akamai.com>, "Steven Rostedt,
 " <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Jessica Yu <jeyu@kernel.org>, Tejun Heo
 <tj@kernel.org>, Oliver O'Halloran <oohall@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 3/4] lib/cmdline.c Remove quotes symmetrically.
Message-ID: <20170821133003.1855fc4e@kitsune.suse.cz>
In-Reply-To: <20170821102712.GF20615@x1>
References: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
 <0e0a8ad11e2c9c7db02baa1bbb5a30f429586854.1503000577.git.msuchanek@suse.de>
 <20170821102712.GF20615@x1>
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

On Mon, 21 Aug 2017 18:27:12 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 08/17/17 at 10:14pm, Michal Suchanek wrote:
> > Remove quotes from argument value only if there is qoute on both
> > sides.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>  
> 
> Sounds reasonable. Just for curiosity, do we have chance to pass in
> option with a single '"'?

No, we don't. Perhaps it would work if it was at the end of the
commandline.

next_arg checks that quoting is closed.

It was possible but undocumented with previous behavior - you would
place the quote in the middle and the closing quote at start or end so
that next_arg would remove the closing quote but not the one in the
middle.

It would be also possible with shell-like backslash escaping but that
is not implemented.

Thanks

Michal
