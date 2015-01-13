Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D7041A06D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 10:44:32 +1100 (AEDT)
Message-ID: <1421192671.10748.4.camel@ellerman.id.au>
Subject: Re: [PATCH V2 06/12] selftests, powerpc: Add test for system wide
 DSCR default
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>
Date: Wed, 14 Jan 2015 10:44:31 +1100
In-Reply-To: <54B5384F.9010805@osg.samsung.com>
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1421144560-15901-7-git-send-email-khandual@linux.vnet.ibm.com>
 <54B5384F.9010805@osg.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-13 at 08:22 -0700, Shuah Khan wrote:
> On 01/13/2015 03:22 AM, Anshuman Khandual wrote:
> > This patch adds a test case for the system wide DSCR default
> > value, which when changed through it's sysfs interface must
> > be visible to all threads reading DSCR either through the
> > privilege state SPR or the problem state SPR. The DSCR value
> > change should be immediate as well.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > ---
> >  tools/testing/selftests/powerpc/Makefile           |   2 +-
> >  tools/testing/selftests/powerpc/dscr/Makefile      |  17 +++
> >  tools/testing/selftests/powerpc/dscr/dscr.h        | 120 ++++++++++++++++++++
> >  .../selftests/powerpc/dscr/dscr_default_test.c     | 121 +++++++++++++++++++++
> >  4 files changed, 259 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/powerpc/dscr/Makefile
> >  create mode 100644 tools/testing/selftests/powerpc/dscr/dscr.h
> >  create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_default_test.c
> 
> Could you please add a .gitignore for powerpc targets as we
> discussed earlier. It can be separate patch.

I can do that.
 
> Also, I would like to see the test results reports using
> kselftest.h - it can be separate patch in the interest of
> getting tests in.

Sorry but kselftest.h doesn't do anything useful for us.

We have existing test reporting that uses the subunit protocol.

I'm happy to convert that to TAP, or some other well defined output format, but
not to something ad-hoc like kselftest.h currently provides.

cheers
