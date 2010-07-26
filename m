Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id D56A8B70BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 08:47:23 +1000 (EST)
Received: by gya1 with SMTP id 1so1142097gya.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Jul 2010 15:47:21 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100726221717.GA22439@merkur.ravnborg.org>
References: <20100720043706.3813715a.sfr@canb.auug.org.au>
	<20100726221717.GA22439@merkur.ravnborg.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 16:47:01 -0600
Message-ID: <AANLkTikP3nZd-LionO27vsinjXz=upKbDZeErSD4CAfz@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: implement select with values
To: Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Sam,

On Mon, Jul 26, 2010 at 4:17 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Jul 20, 2010 at 04:37:06AM +1000, Stephen Rothwell wrote:
>> This is a fairly brute force approach to allowing a Kconfig "select"
>> to specify an excplicit value for the selected config sybmol.
>>
>> The syntax of select is changed to:
>>
>> =A0 =A0 =A0 "select" <symbol> [<expr>] ["if" expr]
>>
>> The approach taken is to add a list of <value, dependency expression>
>> pairs to the symbol and check them whenever the reverse depends (from
>> a current-style select) are checked.
>
> I do not see the need for this feature.
> I have read most of the postings in the defconfig battle and
> I saw Linus' select suggestion.
>
> But we can do almost all of this today (or tomorrow).
>
> Consider following Kconfig file:
>
> =A0 =A0config USB_SUPPORT
> =A0 =A0 =A0 =A0 =A0 =A0def_bool n
>
> =A0 =A0config NET
> =A0 =A0 =A0 =A0 =A0 =A0def_bool y
>
> =A0 =A0source arch/x86/Kconfig
>
> We use the feature that we can specify the same
> config option several times.
> And the first default value that is "visible"
> will be used.
>
> So it allows us to enable and disable any option.
>
> And if we for example want to set a specific LOG_BUF_SHIFT
> we use the same trick:
>
> =A0 =A0config LOG_BUF_SHIFT
> =A0 =A0 =A0 =A0 =A0 =A0int
> =A0 =A0 =A0 =A0 =A0 =A0default 14

Cute.  I didn't know this was possible.  I'll give it a try and see
how it works for me.  Do override config options also pickup
select/depends constraints applied by later definitions?  I think that
would be necessary to kick out warnings when a defconfig selection
isn't actually achievable.

g.

>
>
> Now in the original suggestion of Linus he used:
>
> =A0 =A0KBUILD_KCONFIG=3DMykconfig make allnoconfig
>
> And "allnoconfig" would make the modified defaults useless.
>
> But the soon-to-be-introduced alldefconfig is more sensible.
>
> alldefconfig uses default values for everything.

I basically used defconfig in the prototype that I posted.  I think it
works well for me, and I've got it integrated into the build targets
(just like Stephen's earlier patch) without having to do a
KBUILD_KCONFIG trick.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
