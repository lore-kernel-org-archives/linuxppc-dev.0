Message-Id: <4.2.0.32.19990415110711.0410aa80@mail.lauterbach.com>
Date: Thu, 15 Apr 1999 11:16:31 +0200
To: costabel@wanadoo.fr
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
Cc: Tom Rini <tmrini@ntplx.net>, linuxppc-dev@lists.linuxppc.org,
        bug-gnuplot@dartmouth.edu
In-Reply-To: <37158D29.132CCFC1@wanadoo.fr>
References: <Pine.LNX.4.05.9904141910410.487-100000@pc.wackyland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:54 15.04.99 , Martin Costabel wrote:
>> > Or could someone find out what's wrong with the fprintf function in
>> > LinuPPC? Note that this is not specific for one version of glibc. I
>> > tried it on several from glibc-961212 to glibc-2.1.1-3a. Same result.
>>
>> It failed under the old libs?
>
>Yes, I compiled gnuplot-3.7 under glibc-961212 (rev 1o, IIRC), and the
>result was the same. I managed to track the problem down to the fprintf
>call, but I don't know enough C and glibc to go any further.

The problem could be egcs, there's a known varargs bug on PPC, which 
happens as soon you have more than 8-10 args. There's a testcase for this 
in the egcs testsuite, gcc.c-torture/execute/980608-1.c, which still fails 
in the development sources. I hope this will be resolved for egcs-1.2 if 
the rewrite of the function epilogue/prologue to use RTL makes it in time...

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
