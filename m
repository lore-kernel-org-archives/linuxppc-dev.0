From: Ryan Nielsen <ran@krazynet.com>
Date: Mon, 11 Oct 1999 20:03:46 -0700
To: Tom Rini <trini@kernel.crashing.org>
Cc: Eric Dorland <dorland@lords.com>, Elliot Lee <sopwith@redhat.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991011200346.A258@gondolin.asf>
References: <19991011154325.A14359@HSE-MTL-ppp4363.qc.sympatico.ca> <Pine.LNX.4.10.9910111308380.802-100000@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.10.9910111308380.802-100000@opus.bloom.county>; from Tom Rini on Mon, Oct 11, 1999 at 01:09:12 -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Mon, 11 Oct 1999, Eric Dorland wrote:
> 
> > It appears I spoke to soon about sound working perfectly. Whenever esd plays
> > a 16bit wav file, the sound plays at about half speed. Ugg. At least its not
> > static anymore. I'm going to see if I can track down why this is happening
> > (maybe its some on-the-fly endianess swaping slowing it down), but I don't
> > know sound code all that well, so anyone that does, please lend a hand.
> 
> Elliot has the old set of patches ported up to 0.2.15, and hopefully will
> be in 0.2.16 :)

Does this fix the problem Eric wrote about ?
Þere is a bug in dmasound.c that causes sound to be played at 22050 Hz
instead of (usually) 44100 Hz if a beep (from awacs_mksound) is played.

I thought this should happen only if the process is suspended, but I made
beeps with the console while mpg123 was playing.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
