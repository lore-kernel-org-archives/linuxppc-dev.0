Message-ID: <3E64DB91.4050508@embeddededge.com>
Date: Tue, 04 Mar 2003 12:00:01 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Daniel Jacobowitz <drow@false.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <IGEFJKJNHJDCBKALBJLLMEMJFKAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Does this workaround also work for dcbz on kernel addresses?

It may, depending upon the silicon revision. :-)

IIRC, the real reason for this code is to work around errata in
some silicon versions where the DAR isn't loaded  properly.  In
addition, this also helps when we use kernel debuggers for setting
breakpoints when the text area is write enabled.

> Also, will the Pinned TLB feature for 860 help here?

It will only for the static data area of the kernel.  If you have
vmalloc()'ed pages you can stumble across the same errors.

> Yes I am sure it's very hard to debug and probably over my head :-(
> I will try a litte bit more though and see very it takes me.

If nothing else, you are learning more than you bargained for. ;-)


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
