From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mediabay hotswap, tun naming patches (2.4)
Date: Sun, 20 Jan 2002 22:02:34 +0100
Message-Id: <20020120210234.19509@smtp.wanadoo.fr>
In-Reply-To: <20020120143900.588a4949.jpgarcia@execpc.com>
References: <20020120143900.588a4949.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>ide_register() calls the arch's preferred init_hwif_ports.  Until
>recently, we could set this according to ppc platform using a member of
>the ppc_md (IIRC) structure.  This member was eliminated.  When we had
>it, at one point it was changed to have a generic (PC?) init_hwif_ports
>rather than the pmac one that mediabay needed.  I rack this up to
>possibly people forgetting that some systems have hot swap, but no
>matter.  The assumption that the member stood for was that differing
>platforms /needed/ a custom call, which is not true.  There are a few
>chips on startup and only media bays in runtime that need it.  They are
>the exception, not the rule.  (PCMCIA i think needs the generic call)
>Basically, I think that any old ide hardware driver should be able to
>call ide_register, and anyone who is unique hardware must work only a
>little harder to call their proper unique function.

I just noticed that change in _devel, it will cause problems with
ide_unregister() as well. I have to check what the best fix is, I
beleive ide-pmac should override the still-existing ppc_md. hook
when inited. The generic function will set wrong pointers, but those
will be overriden by the platform-specific one installed by ide-pmac.

Not pretty but should work.

Also, doing it from within ide-pmac will probably help toward making
ide-pmac moduleable ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
