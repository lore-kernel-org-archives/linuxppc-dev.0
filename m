Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id AA000B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 08:41:23 +1000 (EST)
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 8EFC88330
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 00:17:26 +0200 (CEST)
Date: Tue, 27 Jul 2010 00:17:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC][PATCH] kconfig: implement select with values
Message-ID: <20100726221717.GA22439@merkur.ravnborg.org>
References: <20100720043706.3813715a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100720043706.3813715a.sfr@canb.auug.org.au>
Cc: Michal Marek <mmarek@suse.cz>, Francis Galiegue <fgaliegue@gmail.com>,
	Andi Kleen <ak@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>,
	linux-kbuild@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Li Zefan <lizf@cn.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Vadim Bendebury <vbendeb@google.com>, Nir Tzachar <nir.tzachar@gmail.com>,
	Trevor Keith <tsrk@tsrk.net>, Jiri Kosina <jkosina@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, Cheng Renquan <crquan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 04:37:06AM +1000, Stephen Rothwell wrote:
> This is a fairly brute force approach to allowing a Kconfig "select"
> to specify an excplicit value for the selected config sybmol.
> 
> The syntax of select is changed to:
> 
> 	"select" <symbol> [<expr>] ["if" expr]
> 
> The approach taken is to add a list of <value, dependency expression>
> pairs to the symbol and check them whenever the reverse depends (from
> a current-style select) are checked.

I do not see the need for this feature.
I have read most of the postings in the defconfig battle and
I saw Linus' select suggestion.

But we can do almost all of this today (or tomorrow).

Consider following Kconfig file:

    config USB_SUPPORT
            def_bool n

    config NET
            def_bool y

    source arch/x86/Kconfig

We use the feature that we can specify the same
config option several times.
And the first default value that is "visible"
will be used.

So it allows us to enable and disable any option.

And if we for example want to set a specific LOG_BUF_SHIFT
we use the same trick:

    config LOG_BUF_SHIFT
            int
            default 14


Now in the original suggestion of Linus he used:

    KBUILD_KCONFIG=Mykconfig make allnoconfig

And "allnoconfig" would make the modified defaults useless.

But the soon-to-be-introduced alldefconfig is more sensible.

alldefconfig uses default values for everything.

So with alldefconfig I think we have all the features we need
to create sensible default configs in the Kconfig language.

And therefore I do not see the need for the extension to select.
For the same reason I did not look closer at the implementation.

	Sam
