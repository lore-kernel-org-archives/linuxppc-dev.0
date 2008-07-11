Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-ch1gw-5.online-age.net (ext-ch1gw-5.online-age.net
	[64.37.194.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0B398DE0F5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 19:00:03 +1000 (EST)
Received: from int-ch1gw-2.online-age.net (int-ch1gw-2 [3.159.232.66])
	by ext-ch1gw-5.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id m6B8bEgR006441 for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 04:37:14 -0400 (EDT)
Received: from cinmlef03.e2k.ad.ge.com (int-ch1gw-2 [3.159.232.66])
	by int-ch1gw-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m6B8bDWX029678 for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 04:37:14 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: mpc744x, Marvell mv6446x kernel guidance please
Date: Fri, 11 Jul 2008 09:37:06 +0100
Message-ID: <1CADFA951940554D86FBD8B24BBFF3A0019BEFBA@LONMLVEM08.e2k.ad.ge.com>
In-Reply-To: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
References: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
From: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
To: "Stephen Horton" <SHorton@kodiaknetworks.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 10 Jul 2008 22:46:49 -0500
"Stephen Horton" <SHorton@kodiaknetworks.com> wrote:
> Hello folks,
>=20
> In a current work project, I have inherited a compactPCI board that
has
> an mpc7447/7448 powerpc processor as well as a Marvell system
> controller, model mv64462 (stripped down mv64460). The board has a
> somewhat working Gentoo Linux port running on it from long ago and a
> company far far away (kernel version 2.6.9 built using arch/ppc). To
> prepare for an upcoming deployment, I would like to bring the OS
> up-to-date on this board with a newer kernel (targeting Gentoo 2008),
> but I am unsure of the approach to take. I am a software developer,
but
> normally do not work on kernel porting / board integration. I have
> researched the arch/ppc to arch/powerpc migration, but I'm a bit
> intimidated by the 'new' device tree symantics and other changes to
the
> stream. Here are some questions:
>=20
> 1.	Is it possible with the 2.6.24 (Gentoo 2008) kernel to still use
> arch/ppc for this platform architecture?  I've tried to get this to
> compile, but am having trouble with files from arch/powerpc getting
> pulled in; then I read some comments (from I believe this forum) that
> indicated that arch/ppc is not longer supposed to compile

I've had problems getting newer versions of the kernel compiling (using
the ppc arch) for some of our boards. It's going completely in the next
release cycle I believe, infact the powerpc git tree[1] no longer has a
"ppc" arch. Hence we are moving to powerpc.

> 2.	Does anyone have example code for this platform architecture?
> Any freebees I could use for creating my device tree?

These patches may provide a reasonable starting point:

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg18084.html

> 3.	Any advice of any kind?

Stick at it? - I've not long started kernel development and only had ppc
examples (for our boards), like you on an old kernel version (2.6.9 and
2.6.12) and what was in the kernel source. It's taken a while getting
familiar with the powerpc arch, but I'm beginning to see the benefits.

I'd suggest looking at the powerpc specific git tree. I use "stacked
git"[2] on top of this git tree and have found this a reasonably
productive way to work. Whilst learning and porting I can keep the base
up to date with "stg pull" (which peels off my changes, updates the git
tree and re-applies my changes). It also helps with creating well
formatted emails for submitting patches.

Hope this helps,

Martyn

[1] git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
[2] http://procode.org/stgit/

----
Martyn Welch MEng MPhil MIET
Principal Software Engineer

GE Fanuc Intelligent Platforms
Tove Valley Business Park, Towcester,
Northants, NN12 6PF, United Kingdom

Telephone: +44 (0) 1327 359444
Direct Dial: +44 (0) 1327 322748
Fax: +44 (0) 1327 322800
email: martyn.welch@gefanuc.com
web: www.gefanuc.com

GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
(3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB 729 849
476=20

GE Fanuc Intelligent Platforms Confidential and Proprietary. If you have
received this message in error please notify us immediately and
permanently remove it from your system and destroy any printed
hardcopies.   =20
