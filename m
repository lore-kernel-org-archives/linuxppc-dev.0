Return-Path: <roland@redhat.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id CE91ADDF20
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 19:31:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
In-Reply-To: Andreas Schwab's message of  Monday,
	7 July 2008 09:49:57 +0200 <je8wwet9p6.fsf@sykes.suse.de>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
	<je8wwet9p6.fsf@sykes.suse.de>
Message-Id: <20080707093151.8798A154246@magilla.localdomain>
Date: Mon,  7 Jul 2008 02:31:51 -0700 (PDT)
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

> That will make it part of the kernel ABI, since the mapping depends on
> the running kernel, doesn't it?

Well, not the permanent ABI in the sense that AT_* et al are.  This
mapping must agree among all users sharing the same ld.so.cache file.
That is all.  So if you were to change the meaning of a bit that was
used before with a different string, then you could not have the
conflicting ld.so.conf.d files both installed at the same time
(ldconfig will complain and fail).  If you wanted to have two kernels
both installed that disagree on the string for a given bit, then you'd
have to switch the ld.so.conf.d files and re-run ldconfig when you
switch which kernel you're booting.

There are 32 bits free now.  One can anticipate that reassigning a bit
would come up only after these are exhausted.  With prudent use, this
will take a very long time to happen.  Then the oldest CPU type string
might be retired to reuse its bit.  It seems unlikely that there will
be a single installation (root directory) that really needs to have
installed both a kernel optimized for the oldest CPU model known and a
kernel optimized for the newest CPU model known.  If there is, we can
worry about it then.  

At any rate, the point remains that these bit assignments are not part
of any published userland ABI one has to think about in all the ways
that the real ABI implies.  There is nowhere that has to know them or
will ever consider them, except the kernel with the vDSO image built
inside and the ld.so.conf.d file that goes with it.


Thanks,
Roland
