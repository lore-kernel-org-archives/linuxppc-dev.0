Date: Sun, 20 Jan 2002 14:39:00 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mediabay hotswap, tun naming patches (2.4)
Message-Id: <20020120143900.588a4949.jpgarcia@execpc.com>
In-Reply-To: <20020120202122.2637@smtp.wanadoo.fr>
References: <20020120134827.15bedeb6.jpgarcia@execpc.com>
	<20020120202122.2637@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 20 Jan 2002 21:21:21 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> I don't fully understand your patch here. What you do is exactly what
> ide_register() does, I see no difference between what your patch does
> and what the unpatched code does.

ide_register() calls the arch's preferred init_hwif_ports.  Until recently, we could set this according to ppc platform using a member of the ppc_md (IIRC) structure.  This member was eliminated.  When we had it, at one point it was changed to have a generic (PC?) init_hwif_ports rather than the pmac one that mediabay needed.  I rack this up to possibly people forgetting that some systems have hot swap, but no matter.  The assumption that the member stood for was that differing platforms /needed/ a custom call, which is not true.  There are a few chips on startup and only media bays in runtime that need it.  They are the exception, not the rule.  (PCMCIA i think needs the generic call)  Basically, I think that any old ide hardware driver should be able to call ide_register, and anyone who is unique hardware must work only a little harder to call their proper unique function.

Basically, ide_register() is for normal IDE interfaces, and that is just more correct for other drivers to be able to assume that.  We need to explicitly handle unique hardware than to assume that uniqueness is the norm.  all IDE busses are found at boot and those that need it are handled with the pmac function explicitly rather than relying on ide_register() anyway.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
