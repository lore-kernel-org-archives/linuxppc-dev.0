Return-Path: <davej@codemonkey.org.uk>
Received: from arcturus.aphlor.org (arcturus.ipv6.aphlor.org
 [IPv6:2a03:9800:10:4a::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B95F1A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 09:49:30 +1100 (AEDT)
Date: Tue, 20 Jan 2015 16:40:33 -0500
From: Dave Jones <davej@codemonkey.org.uk>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2 06/12] selftests, powerpc: Add test for system wide
 DSCR default
Message-ID: <20150120214033.GA30240@codemonkey.org.uk>
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1421144560-15901-7-git-send-email-khandual@linux.vnet.ibm.com>
 <54B5384F.9010805@osg.samsung.com>
 <1421192671.10748.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421192671.10748.4.camel@ellerman.id.au>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuahkh@osg.samsung.com>, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 14, 2015 at 10:44:31AM +1100, Michael Ellerman wrote:

 > > Also, I would like to see the test results reports using
 > > kselftest.h - it can be separate patch in the interest of
 > > getting tests in.
 > 
 > Sorry but kselftest.h doesn't do anything useful for us.
 > 
 > We have existing test reporting that uses the subunit protocol.
 > 
 > I'm happy to convert that to TAP, or some other well defined output format, but
 > not to something ad-hoc like kselftest.h currently provides.

Something TAP-alike would also help reduce some of the spew from
tests that are going to fail.

eg, running execveat tests on a kernel that doesn't implement that
syscall currently spews around 20 lines of [FAIL].  Adding something
to the beginning of the test to set plan() accordingly if it detects
-ENOSYS could make that output a little cleaner.

That other projects (like jenkins, bug trackers etc) could consume
the output of the test runs would be a nice bonus.  I only recently
started looking at kselftests and was surprised at the amount
of variance we have in the way of printing 'Ok' '[OK]' 'ok...' etc.

	Dave
