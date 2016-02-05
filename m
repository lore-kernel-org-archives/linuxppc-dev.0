Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 094201A0243
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 21:49:53 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
CC: Amitkumar Karwar <akarwar@marvell.com>, Nishant Sarmukadam
 <nishants@marvell.com>, Kalle Valo <kvalo@codeaurora.org>, Steve French
 <sfrench@samba.org>, "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, Joe Perches <joe@perches.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Daniel Borkmann <daniel@iogearbox.net>, Michael Ellerman
 <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Martin
 Schwidefsky" <schwidefsky@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] lib: update single-char callers of strtobool
Date: Fri, 5 Feb 2016 10:46:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCD6FE5@AcuExch.aculab.com>
References: <1454619643-14444-1-git-send-email-keescook@chromium.org>
 <1454619643-14444-3-git-send-email-keescook@chromium.org>
In-Reply-To: <1454619643-14444-3-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kees Cook
> Sent: 04 February 2016 21:01
> Some callers of strtobool were passing a pointer to unterminated strings.
> In preparation of adding multi-character processing to kstrtobool, update
> the callers to not pass single-character pointers, and switch to using th=
e
> new kstrtobool_from_user helper where possible.

Personally I think you should change the name of the function so that the
compiler (and linker) will pick up places that have not been changed.
Relying on people to make the required changes will cause problems.

The current code (presumably) treats "no", "nyet" and "nkjkkrkjrkjterkj" as=
 false.
Changing that behaviour will break things.

If you want to support "on" and "off", then maybe check for the supplied st=
ring
starting with the character sequences "on\0" and "off\0" (as well as any ot=
hers).
This doesn't need the input string be '\0' terminated - since you match y a=
nd n
without looking at the 2nd byte.
You'd have to be extremely unlucky to get a page fault in the 3 bytes
following an 'o' if the caller supplied a single byte buffer.

	David
