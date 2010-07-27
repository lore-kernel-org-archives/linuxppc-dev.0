Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 7DA3BB6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 16:45:30 +1000 (EST)
Date: Tue, 27 Jul 2010 08:45:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC][PATCH] kconfig: implement select with values
Message-ID: <20100727064523.GA25872@merkur.ravnborg.org>
References: <20100720043706.3813715a.sfr@canb.auug.org.au>
	<20100726221717.GA22439@merkur.ravnborg.org>
	<AANLkTikP3nZd-LionO27vsinjXz=upKbDZeErSD4CAfz@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikP3nZd-LionO27vsinjXz=upKbDZeErSD4CAfz@mail.gmail.com>
Cc: Michal Marek <mmarek@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andi Kleen <ak@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>,
	linux-kbuild@vger.kernel.org, Linus <torvalds@linux-foundation.org>,
	Li Zefan <lizf@cn.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Vadim Bendebury <vbendeb@google.com>, Nir Tzachar <nir.tzachar@gmail.com>,
	Francis Galiegue <fgaliegue@gmail.com>,
	Trevor Keith <tsrk@tsrk.net>, Jiri Kosina <jkosina@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, Cheng Renquan <crquan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Cute.  I didn't know this was possible.  I'll give it a try and see
> how it works for me.  Do override config options also pickup
> select/depends constraints applied by later definitions?  I think that
> would be necessary to kick out warnings when a defconfig selection
> isn't actually achievable.

kconfig allows one to add more properties to a config
symbol by defining the symbol again.

So:
config FOO
	bool
	prompt "foo prompt"
	default y
	help
	  Help text

Is the same as:
config FOO
	bool

config FOO
	prompt "foo prompt"

config FOO
	default y

config FOO
	help
	  help text

The abvoe four lines can be located in different files.

And likewise kconfig allows the same property to be
specified twice or more.

So it is OK to say:

config BAR
	tristate "bar prompt"
	default m
	default y

Here kconfig just picks the first default is see.

And the example in my original mail uses the feature
that we can specify several defaults - and kconfig uses the first.


For choices the same is possible but then you need to use
a named choice - something that no one does today in the kernel.

choice CHOICE_X86_CPU
	default M386

endchoice

Here we change the default to M386 which becomes the
selected if we use "alldefconfig".

[Note: It does not work until we use named choices in arch/x86/Kconfig.cpu]

> 
> > Now in the original suggestion of Linus he used:
> >
> >    KBUILD_KCONFIG=Mykconfig make allnoconfig
> >
> > And "allnoconfig" would make the modified defaults useless.
> >
> > But the soon-to-be-introduced alldefconfig is more sensible.
> >
> > alldefconfig uses default values for everything.
> 
> I basically used defconfig in the prototype that I posted.  I think it
> works well for me, and I've got it integrated into the build targets
> (just like Stephen's earlier patch) without having to do a
> KBUILD_KCONFIG trick.

"defconfig" with an empty file gives same config as "alldefconfig" so
it makes sense. But we wanted to drop the use of defconfig files
in favour of files with Kconfig syntax.
So alldefconfig is just a better fit here.

[The above btw. also makes "savedefconfig" less usefull].

	Sam
