Date: Sun, 2 Dec 2001 08:58:50 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
In-Reply-To: <20011202095108.3294@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.40.0112020854520.27544-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2 Dec 2001, Benjamin Herrenschmidt wrote:

> Could be one of my sleep.S changes, let me check...

I diff'd 2.4.16-ben0's sleep.S and 2.4.17-pre2-ben0's sleep.S, then
commented out the added stuff for register save/restore on 74x0 PPCs. That
seems to have corrected the problem - the system now wakes up correctly
from sleep, exactly as before. Any idea what's happening there? It looks
like that stuff shouldn't even be getting called for non-74x0 PPC
processors (/proc/cpuinfo IDs this system's CPU as a 750CX), so one of the
processor-type checks apparently isn't working quite right.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
