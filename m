Message-ID: <3C0AADA8.8050304@waitaki.otago.ac.nz>
Date: Mon, 03 Dec 2001 11:39:36 +1300
From: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Jeff Koftinoff <jeffk@jdkoftinoff.com>, havardk@xmms.org
Subject: Re: Byte order in sound drivers
References: <3C099A81.6040506@waitaki.otago.ac.nz> <20011202095651.24942@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>>The most recent release of XMMS (0.9.5) works correctly for me for both
>>MP3 and WAV files, but not CD audio for which the input plugin returns
>>sound in the native endian-ness.
>>
>
>So far, I had MP3s working but not WAV nor cdread (blank noise in both
>cases). I didn't yet try 0.9.5 though.
>

I should mention I was using the "xmms-cdread" plugin from
ftp://mud.stack.nl/pub/OuterSpace/willem, along with the ide-scsi
driver, to get cd audio going. The built in XMMS "cdaudio" plugin didn't
work for my Ti 500.

>>It depends on the HW you have. Most recent machines don't do HW
>>byteswap, and so accept only big-endian samples. The way this is
>>implemented in our driver currently is a bit weird though, the
>>setformat ioctl won't fail when trying to set an LE format, but
>>it will set the equivalent BE format. So the application is
>>expected to read back the format to figure out what had to be
>>done.
>
>
>Well, the current dmasound behaviour is definitely broken. I'm
>changing it now so that when asked for an _LE format on a chip
>that do only _BE will return -EINVAL.
>

Interesting, thanks for looking at that. I wonder if the USB audio
driver has the same problem, since I get exactly the same behaviour with
my sound sticks.

regards

Bryce.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
