Return-Path: <roland@redhat.com>
Received: from QMTA02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id CA61BDDEF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 10:31:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
In-Reply-To: Benjamin Herrenschmidt's message of  Tuesday,
	8 July 2008 08:56:33 +1000 <1215471393.8970.157.camel@pasglop>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
	<je8wwet9p6.fsf@sykes.suse.de>
	<20080707093151.8798A154246@magilla.localdomain>
	<je63rirp1x.fsf@sykes.suse.de> <1215471393.8970.157.camel@pasglop>
Message-Id: <20080708003127.6D3B9154244@magilla.localdomain>
Date: Mon,  7 Jul 2008 17:31:27 -0700 (PDT)
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > The kernel does not have to come from the same place as the root
> > filesystem.  You may want to run a new kernel with an old filesystem, or
> > vice-versa.

Well, it's not like these bits are really going to change in practice.  My
point was just that this is a far "softer" ABI than the general kernel-user
contract.  Sorry if my being precise about things gives you indigestion.

> I agree, I'm pretty dubious here...

Dubious about whether the dsocaps bit assignments are "part of the ABI"?
Fine.  Let's talk again when you've used up 32 bits and want to figure out
what to do next.

Dubious about whether dsocaps is the right thing to do?  I think you are
overlooking what the actual kernel-user compatibility reality is here.

Firstly, what is the "risk" in the "gone wrong" case?  The risk is that a
DSO load via ld.so.cache will overlook a /lib/power99/foo.so match and get
a /lib/foo.so match instead because ldconfig doesn't know about "power99".
If foo.so wasn't in ld.so.cache at all, there is no problem.
If you used LD_LIBRARY_PATH, there is no problem.
If you used dlopen with an explicit file name (has /), there is no problem.

What happens if you boot a kernel that uses dsocaps with the new string
"power99", but you are missing the ld.so.conf.d file to match your kernel?
Then a DSO load via ld.so.cache will overlook "power99" matches.

How do you fix it?
Install the right (tiny text) file, and run ldconfig.

What happens now if you are using a new kernel that supplies a new string
"power99" in AT_PLATFORM or another auxv element used the same way, but
with an old root filesystem (say one including any glibc that exists today)?
Then a DSO load via ld.so.cache will overlook "power99" matches.

How do you fix it?
You add a bit assignment in the glibc sources, recompile glibc,
install a new whole glibc package.  (Conceivably if you are extremely
careful you can manage to redo an otherwise completely identical
build to the glibc on your old system and replace only ld{64,}.so.1
and ldconfig.)  Then run the new ldconfig.

In short, if you use a root filesystem from before kernels started using
the new string, then you will degenerate to default-platform library
matches from loads via ld.so.cache (i.e. /lib/foo.so, not /lib/somecpu/foo.so).
If you want to do better than that for this case, it's intractable using
AT_PLATFORM, and simple using dsocaps (probably simpler than booting a
special kernel was).

I haven't figured out what in this old-vs-new picture you think AT_PLATFORM
or something else like it would ever buy you.


Thanks,
Roland
