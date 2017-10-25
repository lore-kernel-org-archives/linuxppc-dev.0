Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMRHF59D9zDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:30:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, Matthew Wilcox <mawilcox@microsoft.com>
Cc: "linuxppc-dev\@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "linux-s390\@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] bitmap: Fix optimization of bitmap_set/clear for
 big-endian machines
In-Reply-To: <20171025084602.GC25140@fergus.ozlabs.ibm.com>
References: <20171025065726.GA25140@fergus.ozlabs.ibm.com>
 <MWHPR21MB08455F1374F717DBA20B7798CB440@MWHPR21MB0845.namprd21.prod.outlook.com>
 <20171025084602.GC25140@fergus.ozlabs.ibm.com>
Date: Wed, 25 Oct 2017 12:30:24 +0200
Message-ID: <87y3nzzfi7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Wed, Oct 25, 2017 at 07:39:48AM +0000, Matthew Wilcox wrote:
>> Hang on, don't tell me you found this by inspection. Are you not
>> running the bitmap testcase, enabled by CONFIG_TEST_BITMAP? Either
>> that should be producing an error, or there's a missing test case, or
>> your inspection is wrong ...

Oops.

  [    1.907533] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 1359
  [    1.907596] set not equal 0 8
  [    1.907640] set not __equal 0 8
  [    1.907684] clear not equal 0 8
  [    1.907728] clear not __equal 0 8
  [    1.907772] set not equal 0 16
  [    1.907816] set not __equal 0 16
  [    1.907861] clear not equal 0 16
  [    1.907905] clear not __equal 0 16
  [    1.907949] set not equal 0 24
  [    1.907993] set not __equal 0 24
  [    1.908038] clear not equal 0 24
  [    1.908082] clear not __equal 0 24
  ...
  [ snip ~30,000 lines ]
  ...
  [    3.345729] set not equal 1008 8
  [    3.345773] set not __equal 1008 8
  [    3.345818] clear not equal 1008 8
  [    3.345863] clear not __equal 1008 8

  [    3.345909] test_bitmap: all 460506 tests passed
                              ^^^^^^^^^^^^^^^^^^^^^^^
                              O_o

With the patch:

  [    1.904393] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 1359
  [    1.916270] test_bitmap: all 460506 tests passed

cheers
