Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3mkt441QzDt23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:40:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: process.c: fix Kconfig typo
In-Reply-To: <CAD3Xx4KqNbpjognpyC=NVqFQ0wH+uc+vQU23PP99625ufCLZnA@mail.gmail.com>
References: <20161005055726.5614-1-valentinrothberg@gmail.com>
 <1475708074.735.2.camel@gmail.com> <878ttby7vh.fsf@concordia.ellerman.id.au>
 <CAD3Xx4KqNbpjognpyC=NVqFQ0wH+uc+vQU23PP99625ufCLZnA@mail.gmail.com>
Date: Wed, 26 Oct 2016 21:40:37 +1100
Message-ID: <87y41bwfyy.fsf@concordia.ellerman.id.au>
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

Valentin Rothberg <valentinrothberg@gmail.com> writes:

> On Wed, Oct 26, 2016 at 7:52 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Cyril Bur <cyrilbur@gmail.com> writes:
>>
>>> On Wed, 2016-10-05 at 07:57 +0200, Valentin Rothberg wrote:
>>>> s/ALIVEC/ALTIVEC/
>>>>
>>>
>>> Oops, nice catch
>>>
>>>> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
>>>
>>> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
>>
>> How did we not notice? Sounds like we need a new selftest.
>>
>> Looks like this should have:
>>
>> Fixes: dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware transactional memory in use")
>>
>>
>> And I guess I need to start running checkkconfigsymbols.py on every
>> commit.
>
> Happy to find a new user :-)  You can also run the script on a range
> of commits via '--diff commitA..commitB', which can safe some time.

Yeah I just discovered that, very useful.

But my instinct was to do:

$ ./scripts/checkkconfigsymbols.py --diff HEAD^^^..HEAD

Which didn't work, the regexp is a bit tight, fixed by:

diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbols.py
index a32e4da4c117..3820f00b066a 100755
--- a/scripts/checkkconfigsymbols.py
+++ b/scripts/checkkconfigsymbols.py
@@ -88,7 +88,7 @@ def parse_options():
     if args.commit and args.diff:
         sys.exit("Please specify only one option at once.")
 
-    if args.diff and not re.match(r"^[\w\-\.]+\.\.[\w\-\.]+$", args.diff):
+    if args.diff and not re.match(r"^[\w\-\.\^]+\.\.[\w\-\.\^]+$", args.diff):
         sys.exit("Please specify valid input in the following format: "
                  "\'commit1..commit2\'")
 


cheers
