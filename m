Message-ID: <67505026E29DD311A9AA00508B7315F350A56D@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'Daris A Nevil'" <dnevil@snmc.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: HDLC/PPP Driver
Date: Mon, 23 Oct 2000 13:30:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you, Darvis!

I was able to get your driver to load, configured, and pinging on the 860T.
Now, let me see if I can explain what happened.

I only wanted 1 SCC chanel, SCC2. I know you said that would not matter
until I actually configured hdlcppp2, but I think it did in the init in the
for {} where you go through all the PPP_HDLC_CHANNELS, because I am already
using SCC1, SCC3 and SCC4 at this point in other drivers.

It appears the line
dev->base_addr = (unsigned long)&cp->scc[i];
was the culprit.

I just forced i to 1 and used one PPP_HDLC_CHANNEL and my problems went
away. I was confused with this line a little because other drivers
initialize there drivers differently. Feel free to expand if you like

dev->base_addr = (unsigned long)&cp->scc[1];

The other indices with i were fine in the loop because i uses your
SCC_Params array which is fine.

Thought you would be interested.
Thank you, again. This kind of stuff makes my day and I enjoy learning from
the group.
--Julia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
