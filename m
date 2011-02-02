Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0546EB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 08:55:56 +1100 (EST)
Received: by iye19 with SMTP id 19so445967iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 02 Feb 2011 13:55:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1296682842.2349.730.camel@pasglop>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
	<AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
	<1296682842.2349.730.camel@pasglop>
Date: Wed, 2 Feb 2011 15:55:53 -0600
Message-ID: <AANLkTi=xM5qt4sic-YBD87Znt0vVOyX2yOyhODhtKNqC@mail.gmail.com>
Subject: Re: BootX
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

I know you are VERY busy. I appreciate your taking the time to reply.

Since I'm am still using this thing I'll take a stab at trying to
track it down. I just posted the FYI to see if I could trigger some
thoughts (like your post).

With a 4.3.5 compiled mesh, it fails a lot of early stuff like getting
cache info? I don't remember the full list because it fails to find
the root fs and does the reboot in 180 seconds thing (I still have in
a back corner of my brain the serial console xmon boot stuff and will
probably eventually try that).

I am hopeful that since it (at least so far) always fails that it
might not be THAT bad to track down. That coupled with some knowledge
of what the compilers are doing differently can hopefully help track
it down.

Thanks!

kevin

On Wed, Feb 2, 2011 at 3:40 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> That's interesting... That driver is really nasty, we probably have a
> bug in it that's exposed by optimizations done by more recent compilers
> but it's not going to be trivial to figure out I'm afraid. I at least
> have very dim memories of mesh and how it operates...
>
> One thing to be careful of with Mesh is that the DMA engine, while
> supposedly cache coherent, has shown in the past to have issues when
> DMA'ing to unaligned memory locations. This shouldn't be a problem with
> normal block transfers but we may have to be careful with things like
> inquiry, mode pages, sense requests etc...
>
> Ben.
>
