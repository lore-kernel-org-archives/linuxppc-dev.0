Date: Sun, 17 Nov 2002 14:00:26 -0800
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v548)
Cc: <linuxppc-dev@lists.linuxppc.org>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
From: Tim Seufert <tas@mindspring.com>
In-Reply-To: <002801c28e4c$79219d60$0200a8c0@telia.com>
Message-Id: <FA8676EA-FA77-11D6-AE66-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday, November 17, 2002, at 07:17  AM, Joakim Tjernlund wrote:

>> CTR and the instructions which operate on it
>> (such as bdnz) were put into the PPC architecture mainly as an
>> optimization opportunity for loops where the loop variable is not used
>> inside the loop body.
>
> loop variable not USED or loop variable not MODIFIED?

Not used.  CTR cannot be specified as the source or destination of most
instructions.  In order to access its contents you have to use special
instructions that move between it and a normal general purpose register.

>> Here's a summary of when gcc will compile
>> that crc32 loop with use of CTR and bdnz (note that -O3 or above
>> automatically turn on -funroll-loops, so I saw no point in testing
>> those levels):
>>
>>            -O1    -O2    -O1 -funroll-loops    -O2 -funroll-loops
>> 2.95.4    no     no     no                    no
>> 3.1       no     yes    yes                   yes
>
> hmm, looks like I should upgrade gcc to 3.1 or possibly 3.2. However
> I think that gcc >=3.0 has changed the ABI for C++, which is bad for
> me.

Sooner or later you're going to want to, though.  :)

> Is 2.95.x still maintained? Maybe this optimization could be added
> to that branch.

I don't know.  It probably is to some extent, just because there are
plenty of people in the same boat with you on the C++ ABI changes.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
