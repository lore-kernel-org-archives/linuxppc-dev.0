Message-ID: <3DC2BAD9.5020907@embeddededge.com>
Date: Fri, 01 Nov 2002 12:33:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dc* (Data Cache)  instructions in mem*() and *_page() functions
 not used on 8xx
References: <IGEFJKJNHJDCBKALBJLLAEIPFHAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Dan, could you add the missing code for 8xx to detect the exception conditions when
> the cache instructions faulted? I would like to give it a try.

It's not very high on my list of things to do.  As I recall, the VM fault
handler may need knowledge of a dcbz fault and use a different method to
determine the address.  I also have this funny feeling that it isn't a
restartable operation, so we may have to emulate the instruction when
the fault occurs.

I know you can write a test that would show this to be a performance
benefit, which would just copy/zero lots of data, but that's not a real
world application.

IMHO, it's lots of work for little, if any, gain.  It has some specific
uses in specialized applications, but I don't think it's a general speed up
solution.

 > Maybe add a new CONFIG option to allow 8xx to use these optimizations when
> explicitly enabled.

How would you know when to do this?  It seldom appeared in any errata
so you couldn't know for certain if a particular chip version would
allow this.  I suspect people (like I have chosen to do) will just never
use the optimization because the software will always work in this case.
I don't like solutions that depend on luck or trial and error.

I'll do some research into this again, it's been many years since I
thought about it.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
