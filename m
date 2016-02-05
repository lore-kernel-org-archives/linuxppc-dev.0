Return-Path: <keescook@google.com>
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F0391A0318
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 08:18:07 +1100 (AEDT)
Received: by mail-ig0-x234.google.com with SMTP id mw1so22471839igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 13:18:07 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CCD6FE5@AcuExch.aculab.com>
References: <1454619643-14444-1-git-send-email-keescook@chromium.org>
 <1454619643-14444-3-git-send-email-keescook@chromium.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CCD6FE5@AcuExch.aculab.com>
Date: Fri, 5 Feb 2016 13:18:04 -0800
Message-ID: <CAGXu5jJrFv5Y8Q_i3yFYBDmT0+pO05dS3ijB0gOn-huasxZWmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] lib: update single-char callers of strtobool
From: Kees Cook <keescook@chromium.org>
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Amitkumar Karwar <akarwar@marvell.com>,
 Nishant Sarmukadam <nishants@marvell.com>, Kalle Valo <kvalo@codeaurora.org>,
 Steve French <sfrench@samba.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 Joe Perches <joe@perches.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Daniel Borkmann <daniel@iogearbox.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2016 at 2:46 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Kees Cook
>> Sent: 04 February 2016 21:01
>> Some callers of strtobool were passing a pointer to unterminated strings.
>> In preparation of adding multi-character processing to kstrtobool, update
>> the callers to not pass single-character pointers, and switch to using the
>> new kstrtobool_from_user helper where possible.
>
> Personally I think you should change the name of the function so that the
> compiler (and linker) will pick up places that have not been changed.
> Relying on people to make the required changes will cause problems.

After the single-character users were pointed out, I looked for others
and there aren't any.

> The current code (presumably) treats "no", "nyet" and "nkjkkrkjrkjterkj" as false.
> Changing that behaviour will break things.

There's no change there. All three of those will still be "false".
Perhaps my changelog shouldn't say "unterminated" but rather
"character array".

> If you want to support "on" and "off", then maybe check for the supplied string
> starting with the character sequences "on\0" and "off\0" (as well as any others).
> This doesn't need the input string be '\0' terminated - since you match y and n
> without looking at the 2nd byte.
> You'd have to be extremely unlucky to get a page fault in the 3 bytes
> following an 'o' if the caller supplied a single byte buffer.

I'd prefer to keep the switch statement as short as possible, and I
don't want to do full string compares. And as you say, even fixing the
single-byte callers seems like a needless exercise, but seeing as how
it's a net clean-up, I think it's good they way I've got the series.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
