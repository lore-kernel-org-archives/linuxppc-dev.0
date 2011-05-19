Return-Path: <ericvh@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABC69B6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 22:35:16 +1000 (EST)
Received: by bwz10 with SMTP id 10so2615870bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 05:35:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110519110105.GB25179@zod.rchland.ibm.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<20110519110105.GB25179@zod.rchland.ibm.com>
Date: Thu, 19 May 2011 07:35:11 -0500
Message-ID: <BANLkTi=08fugm=kpP7LNQc+eRaOuOYR1-w@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC] Mainline BG/P platform support
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 6:01 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Wed, May 18, 2011 at 04:24:49PM -0500, Eric Van Hensbergen wrote:
>>
>>I'll be maintaining the patchset in my kernel.org repository
>>(/pub/scm/linux/kernel/git/ericvh/bluegene.git) under the bluegene
>>branch with the source repos (zepto, kittyhawk, ibmcn) available in
>>respective branches. =A0Ben - if you would prefer me to send pull request=
s
>>once we get rolling, I can switch to that -- otherwise I'll stick to
>>just submitting patches to the list assuming you'll pull them when they
>>become acceptable. =A0Thanks for your attention reviewing these patches.
>
> This is going to get slightly messy if there are lots of changes in
> platforms/44x and/or head_44x.S. =A0Most 4xx changes go through my tree,
> and I'm happy to pull from your tree once things get off the ground. =A0W=
e
> just need to make sure and coordinate as we go.
>

I'm fine with processing the changes through your tree.  Most of the items
with conflicts are in this series, so hopefully it won't be too messy (outs=
ide
of some Makefile and Kconfig changes which are much easier to merge)
after this.  So, should I base changes on:
http://git.kernel.org/?p=3Dlinux/kernel/git/jwboyer/powerpc-4xx.git;a=3Dsho=
rtlog;h=3Drefs/heads/next
or:
http://git.kernel.org/?p=3Dlinux/kernel/git/benh/powerpc.git;a=3Dshortlog;h=
=3Drefs/heads/next

There are some important questions on code organization which it would
probably be a good idea to discuss at some point -- in particular what I
should do about the device drivers.  Pretty much every driver except for
the ethernet is particular to this platform.  IIRC some of the embedded
platforms have the SOC drivers in the platforms directory -- but it doesn't
seem like you've done this with 4xx so I was gonna just place them in
the appropriate drivers/* directory.  The other question is that there are
a number of patches which involve communication which a somewhat
substantial firmware layer.  You can get an idea of the existing patch's
code organization by looking at:

http://git.kernel.org/?p=3Dlinux/kernel/git/ericvh/bluegene.git;a=3Dcommit;=
h=3Dbee9f329eeef6c8eb95c35de4c5d22a0c05a1b3e

Its important to point out that I am going through and cleaning up as I
go, so not everything from that patch will make the cut as is (or perhaps
even at all) -- but that should help identify where potential conflicts are
as well as potentially out of place code.

>>
>>+LINUX FOR POWERPC BLUEGENE/P
>>+M: =A0 =A0Eric Van Hensbergen <ericvh@gmail.com>
>>+W: =A0 =A0http://bg-linux.anl-external.org/wiki/index.php/Main_Page
>>+L: =A0 =A0bg-linux@lists.anl-external.org
>>+T: =A0 =A0git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/blueg=
ene.git
>>+S: =A0 =A0Maintained
>>+F: =A0 =A0arch/powerpc/platforms/44x/bgp*
>
> This should probably be the last patch in the series. =A0You have a file
> pattern listed for files that don't exist at all in any of the other
> patches you submitted :).
>

Yeah, I wondered about that, its just I hate patch series intro messages wi=
th
no patch, and I figured this was a good way out of it.  It also adds
the relevant
info as far as mailing lists and wiki pages where folks can go for more inf=
o --
but if folks have a problem with it I'll kill it until we get
everything else in.

     -eric
