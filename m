In-Reply-To: <Pine.LNX.4.60.0407081923190.2164@localhost.localdomain>
References: <Pine.LNX.4.60.0407081923190.2164@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DFC8D6BB-D145-11D8-B95B-003065F9B7DC@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: SMC1, ethernet on SCC3 and patches to allow this
Date: Thu, 8 Jul 2004 21:18:24 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 8, 2004, at 8:28 PM, Robert P. J. Day wrote:

> but there's no reference to a patch that lets me get away with this.

There is a microcode patch, but the 8xx drivers aren't written to look
for it and work with it.  It's not terribly hard to do, but there isn't
a
generic solution because the relocation is also dependent upon
the other devices you may be using withe the CPM.

> surely others might want to have console SMC1 and ethernet SCC3.

I have not come across anyone that has done this.  "Normally," the
configurations use SCC2 for Ethernet and SCC3 for other uses.
The patch most commonly used on these processors is for the USB,
and you can't load multiple patches.

> ....  how
> is it done?  (i mean, short of configuring the console on SMC2, which
> is not an option here.)

You are going to have to get the microcode patch for this processor
CPM rom version (make sure it matches), and update the uart driver
to know about the relocation patch.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
