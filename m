Date: Tue, 23 Oct 2001 12:29:48 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Dave Ray <g4tinker@yahoo.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, almost 
In-Reply-To: <20011023182151.64337.qmail@web13103.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110231224250.7493-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Oct 2001, Dave Ray wrote:

> However for this debugging I'm leaving esound off and
> I should still be able to get terminal beeps and play
> mp3's from gqmpeg. All audio programs happily run,
> without complaint, but no sound comes out. When I try
> to adjust volume I get the syslog errors. I'm stumped
> and open to any suggestions.

What errors are those? Nothing you've posted so far looks like an error to
me.

> Oct 19 20:53:48 garuda kernel: tumbler:no device

That's from not having a devnode for "amp-mute", "headphone-mute" or
"headphone-detect". I don't think that's a problem.

> Oct 19 20:53:48 garuda kernel: i2c-keywest: Ack Status
> on addr expected but got: 0x09 on addr: 0x34

That's just because the tas3001 driver code (the mixer for the
Tumbler/Texas) is searching all available I2C buses, and the first one
doesn't have what it's looking for.

> I suspect that the driver is failing to open the real
> hardware and registering a dummy device.

I suspect your mixer app is opening the wrong mixer devnode.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
