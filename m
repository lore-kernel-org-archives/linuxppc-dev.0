Return-Path: <kyle@moffetthome.net>
Received: from mail-pz0-f47.google.com (mail-pz0-f47.google.com
 [209.85.210.47]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D251BB6F75
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 07:48:28 +1100 (EST)
Received: by pzk1 with SMTP id 1so7535683pzk.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 12:48:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322437884.23348.30.camel@pasglop>
References: <1322437884.23348.30.camel@pasglop>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 28 Nov 2011 15:48:04 -0500
Message-ID: <CAGZ=bqJZdN-gpeBW+EdE7Dd=qsNzhwbFr8hBCRqMM72VkT8W7g@mail.gmail.com>
Subject: Re: MPIC cleanup series
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 27, 2011 at 18:51, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Overall I really look your series. It doesn't quite apply cleanly
> anymore so I'll as you for a new shoot after you address the comments
> below, at which point, if you're fast enough, I'll stick it in -next :-)

Awesome! Thanks!

As I mentioned before, I have precious little of the hardware to test
this all on, so I hope I don't break anything.  At minimum I need to
do a final build-and-run test on my e500 boards before I send it out.
:-D


> Just a couple of comments on some of the patches:
>
> =C2=A0- 5/10: search for open-pic device-tree node if NULL
>
> The idea is fine, however most callers ignore the device-type and only
> compare on compatible, while you replace that with a match entry that
> seems to require matching on both. This is likely to break stuff. The
> "type" part of te march entry should be NULL I believe.

If you re-read that, the match table used if no of_node is passed in
has *two* separate entries, one of them with a "type" and the other
with a "compatible", as opposed to a single entry which matches both
"type" and "compatible".

There are a lot of callers which do:
  dnp =3D of_find_node_by_type(NULL, "open-pic");

So I doubt I can remove the "type" entry all together, unfortunately.


> =C2=A0- 9/10: cache the node
>
> of_node_get() is your friend.

Yes, I actually messed this one up in the prior patch too, thanks for
noticing.  It should all be fixed now.


> =C2=A0- 10/10: Makes me a bit nervous. It 'looks' right but I wouldn't be=
t on
> Apple device-trees being sane vs. chaining. I would like a test that
> doesn't do the cascade if the mpic is a primary to at least limit the
> risk of messup.

Oh, you mean to wrap that block like this?

if (mpic->flags & MPIC_SECONDARY) {
  virq =3D irq_of_parse_and_map(mpic->node, 0);
  ...
}

Sure, makes sense to me.  I've made that change.

Thanks for the review!

Cheers,
Kyle Moffett

--=20
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
