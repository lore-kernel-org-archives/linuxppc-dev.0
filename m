Subject: RE: Question on the fs choice
From: David Woodhouse <dwmw2@infradead.org>
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Cc: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>,
	linuxppc-embedded@lists.linuxppc.org, "'wd@denx.de'" <wd@denx.de>
In-Reply-To: <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com>
References: <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com>
Content-Type: text/plain
Message-Id: <1084444177.4426.2472.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 13 May 2004 11:29:37 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-05-12 at 20:00 -0500, Zajac Adam-AAZ004 wrote:
> Gerald, Wolfgang,
>
> Thank you for your prompt response to my post.

Adam, please do something about your mail software if you're going to
use it in public. It is not correctly inserting References: or
In-Reply-To: headers, and is thus causing your reply to be disassociated
from the thread to which you're replying. This isn't polite behaviour in
a public forum. Gerald, that goes for you too.

Please also ensure that you trim the context of your reply to include
only those parts of the original message which are _absolutely_
necessary. You seem to have included far more of the previous posting
than you needed to.

> To cut the long story short I personally believe (based on the number of
> stress tests we perform on our target platforms) that modern compact flash
> cards (e.g. SDCFB-xx-201 series) can be safely used as a main storage medium
> for commercial applications.

That's an interesting report -- thanks. It's useful to know that the
quality of implementation of CF devices is improving almost to the point
where one can consider using them in production.

> Resolving a file system corruption upon an unexpected power failure should
> just be the matter of selecting one of the journaling systems (ext3, XFS,
> ReiserFS etc.). BTW, we're still evaluating which FS to choose and by far
> Ext3 looks like the best candidate due to its backward compatibility with
> Ext2.

The problem here is that you reduce the lifetime of the flash
significantly. Each write of a journalled sector actually gets written
to the 'disk' twice -- once to the journal and then again to the real
location in the file system. If you're doing data journalling, you
therefore halve the lifetime.

This is a fundamental problem with the CF mode of operation. The CF
firmware implements a pseudo-filesystem on the flash, used to 'emulate'
a normal block device. The high-end cards, as you report, at least
manage to implement this pseudo-filesystem in a way which is resilient
to power failure. Other cards have been observed to do it less
competently.

On top of that journalling pseudo-fs, you are putting another
journalling file system. Whatever you do in this situation, you are not
making optimal use of the underlying flash.

You don't even have a mechanism to 'delete' a sector from the underlying
CF device. Once you've filled the device with data once, the underlying
pseudo-fs has to keep copying around the data from sectors which are
actually _unused_ by the top-level file system.

Whatever FS you choose to put at the top of this particular stack, it
can never be as efficient as a real file system directly on the flash
can be.

> Coming back to the CF card discussion subject, does anybody know how the
> "power failure" scenario is resolved at such commercial platforms as pocket
> pc's and digital cameras utilizing CF cards?

They offer a way to reformat the file system on the flash card :)

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
