From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Jeff Koftinoff <jeffk@jdkoftinoff.com>, <havardk@xmms.org>
Subject: Re: Byte order in sound drivers
Date: Sun, 2 Dec 2001 18:17:24 +0100
Message-Id: <20011202171724.10074@smtp.wanadoo.fr>
In-Reply-To: <20011202095651.24942@smtp.wanadoo.fr>
References: <20011202095651.24942@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It depends on the HW you have. Most recent machines don't do HW
>byteswap, and so accept only big-endian samples. The way this is
>implemented in our driver currently is a bit weird though, the
>setformat ioctl won't fail when trying to set an LE format, but
>it will set the equivalent BE format. So the application is
>expected to read back the format to figure out what had to be
>done.

Well, the current dmasound behaviour is definitely broken. I'm
changing it now so that when asked for an _LE format on a chip
that do only _BE will return -EINVAL.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
