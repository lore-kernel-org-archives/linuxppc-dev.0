Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE7D4B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 05:15:42 +1100 (EST)
Received: by iwb12 with SMTP id 12so2128341iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 10:15:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1295591723.2148.281.camel@pasglop>
References: <1295591723.2148.281.camel@pasglop>
Date: Fri, 21 Jan 2011 12:15:30 -0600
Message-ID: <AANLkTikd14Kw02nzde19FsR9JUGA=c-xzVVXpkGLoUjf@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix some 6xx/7xxx CPU setup functions
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 21, 2011 at 12:35 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Some of those functions try to adjust the CPU features, for example
> to remove NAP support on some revisions. However, they seem to use
> r5 as an index into the CPU table entry, which might have been right
> a long time ago but no longer is. r4 is the right register to use.
Can you quantify 'a long time ago'? Is this compiler dependent?
>
> This probably caused some off behaviours on some PowerMac variants
> using 750cx or 7455 processor revisions.
what about a 750gx?
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Can somebody with one of these PowerMacs test this ? I only managed to
> find a 7448 which not directly affected...
>
I have a GigE (PowerMac 3,4?) with an upgrade card that has a pair of
7455s on it and an 8600 with a 750GX cpu card. I can probably test
this on the GigE. It is running 2.6.36. Is that recent enough? The
8600 is not cooperating.

The GigE is running 2.6.36 compiled with 4.3.5 built from sources. It
seems to run fine.
_______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
