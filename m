Message-ID: <3DBEA8F9.8030304@embeddededge.com>
Date: Tue, 29 Oct 2002 10:27:53 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dc* (Data Cache)  instructions in mem*() and *_page() functions
 not used on 8xx
References: <IGEFJKJNHJDCBKALBJLLAEGMFHAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>>I found that on 8xx these are not used. Why? Are there 8xx variants that can't handle them?
>>Do 860 work with these?

The TLB/Exception side effects of using these instructions in the 8xx varied
with different silicon versions.  Rather than have a bunch of unique code for
different silicon revisions (and in some cases the side effects didn't occur
at all so the instructions couldn't be used) it is just easier to not use the
instructions.  Any performance gained by using these instructions was lost
in the special exception handling.

>>Also, why is not dcbtst(write a cache line) used

Because dcbtst performs a load operation on a line you know is going to
replaced.  That generates unnecessary bus traffic and is why the dcbz is
used instead.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
