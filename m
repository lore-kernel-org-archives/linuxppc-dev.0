Return-Path: <linasvepstas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 784C3DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 02:21:24 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2540213pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 07:21:22 -0800 (PST)
Message-ID: <3ae3aa420801140721g3381b3d3u28b7b30fbaebe88@mail.gmail.com>
Date: Mon, 14 Jan 2008 09:21:22 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <20080114052402.GA23786@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
	<20080110162120.GA4831@lixom.net>
	<3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
	<4786923E.9090902@austin.ibm.com> <20080111012641.GX14201@localdomain>
	<3ae3aa420801110857l5e43fd56s5bd1c24ffac939f3@mail.gmail.com>
	<20080114052402.GA23786@lixom.net>
Cc: lkessler@us.ibm.com, linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	mahuja@us.ibm.com, strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 13/01/2008, Olof Johansson <olof@lixom.net> wrote:
>
> How do you expect to have it in full production if you don't have all
> resources available for it? It's not until the dump has finished that you
> can return all memory to the production environment and use it.

With the PHYP dump, each chunk of RAM is returned for
general use immediately after being dumped; so its not
an all-or-nothing proposition.  Production systems don't
often hit 100% RAM use right out of the gate, they often
take hours or days to get there, so again, there should
be time to dump.

> This can very easily be argued in both direction, with no clear winner:
> If the crash is stress-induced (say a slashdotted website), for those
> cases it seems more rational to take the time, collect _good data_ even
> if it takes a little longer, and then go back into production. Especially
> if the alternative is to go back into production immediately, collect
> about half of the data, and then crash again. Rinse and repeat.

Again, the mode of operation for the phyp dump  is that you'll
always have all of the data from the *first* crash, even if there
are multiple crashes. That's because the the as-yet undumped
RAM is not put back into production.

> really surprises me that there's no way to reset a device through PHYP
> though. Seems like such a fundamental feature.

I don't know who said that; that's not right. The EEH function
certainly does allow you to halt/restart PCI traffic to a particular
device and also to reset the device.  So, yes, the pSeries
kexec code should call into the eeh subsystem to rationalize
the device state.

> I think people are overly optimistic if they think it'll be possible
> to do all of this reliably (as in with consistent performance) without
> a second reboot though.

The NUMA issues do concern me. But then, the whole virtualized,
fractional-cpu, tickless operation stuff sounds like a performance
tuning nightmare to begin with.

> At least without similar amounts of work being
> done as it would have taken to fix kdump's reliability in the first place.

:-)


> Speaking of reboots. PHYP isn't known for being quick at rebooting a
> partition, it used to take in the order of minutes even on a small
> machine. Has that been fixed?

Dunno.  Probably not.

>  If not, the avoiding an extra reboot
> argument hardly seems like a benefit versus kdump+kexec, which reboots
> nearly instantly and without involvement from PHYP.

OK, let me tell you what I'm up against right now.
I'm dealing with sporadic corruption on my home box.

About a month ago, I bought a whizzy ASUS M2NE
motherboard & an AMD64 2-core cpu, and two sticks
of RAM, 1GB per stick. I have one new hard drive,
SATA, and one old hard drive, from my old machine,
the PATA.  The two disks are mirrored in a RAID-1
config. Running Ubuntu.

During install/upgrade a month ago, I noticed some of
the install files seemed to have gotten corrupted, but
that downloading them again got me a working version.
This put a serious frown on my face: maybe a bad ethernet
card or connection !?

Two weeks ago, gcc stopped working one morning, although
it worked fine the night before. I'd done nothing in the interim
but sleep. Reinstalling it made it work again. Yesterday,
something else stopped working.  I found the offending
library, I compared file checksums against a known-good
version, and they were off. (!!!) Disk corruption?

Then apt-get stopped working. The /var/lib/dpkg/status file
had randomly corrupted single bytes. Its ascii, I hand
repaired it; it had maybe 10 bad bytes out of 2MB total size.

I installed tripwire. Between the first run of tripwire, and the
second, less than an hour later, it reported several dozen
files have changed checksums. Manual inspection of some
of these files against known-good versions show that, at least
this morning, that's no longer the case.

System hasn't crashed in a month, since first boot.  So
what's going on? Is it possible that one of the two disks
is serving up bad data, which explains the funny checksum
behaviour? Or maybe its bad RAM, so that a fresh disk
read shows good data?  If its bad ram, why doesn't the
system crash?  I forced fsck last night, fsck came back
spotless.

So ... moral of the story: If phyp is doing some sort of
hardware checks and validation, that's great. I wish I could
afford a pSeries system for my home computer, because
my impression is that they are very stable, and don't do
things like data corruption.  I'm such a friggin cheapskate
that I can't bear to spend many thousands instead of many
hundreds of dollars. However, I will trade a longer boot
for the dream of higher reliability.

--linas
