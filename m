Message-Id: <4.2.0.32.19990415155955.03c13080@mail.lauterbach.com>
Date: Thu, 15 Apr 1999 16:07:48 +0200
To: Gabriel Paubert <paubert@iram.es>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
Cc: costabel@wanadoo.fr, Tom Rini <tmrini@ntplx.net>,
        linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
In-Reply-To: <Pine.HPP.3.96.990415142127.1720A-100000@gra-ux1.iram.es>
References: <4.2.0.32.19990415110711.0410aa80@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:28 15.04.99 , Gabriel Paubert wrote:


>On Thu, 15 Apr 1999, Franz Sirl wrote:
>
>> The problem could be egcs, there's a known varargs bug on PPC, which
>> happens as soon you have more than 8-10 args. There's a testcase for this
>> in the egcs testsuite, gcc.c-torture/execute/980608-1.c, which still fails
>> in the development sources. I hope this will be resolved for egcs-1.2 if
>> the rewrite of the function epilogue/prologue to use RTL makes it in time...
>
>Is it related to alignment ? I've already been bitten by the fact that
>some alignment constraint has changed between versions of egcs: now
>doubles and long long are aligned on a 4 byte boundary when they are
>passed in the memory area, earlier versions enforced 8 byte alignment in
>these cases AFAIR.
>
>That's the kind of changes I positively hate :-(

Hmm, there was a change long ago I think. AFAIR it was due to ABI issues, 
but this has probably nothing to do with the bug in question here, which is 
a clear compiler bug. While setting up the function prologue it uses a 
variable which is not yet setup at this time. The net effect is that the 
prologue uses different offsets from the SP than the rest of the function :-(.

BTW, Gabriel, the latest gas snapshots (990413/14) contain a PPC related 
patch from you. Do you consider your patch a bugfix or an extension? I 
currently use the 990403 snapshot for R5 and don't wanna upgrade again 
before R5 release, unless it's a bugfix.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
