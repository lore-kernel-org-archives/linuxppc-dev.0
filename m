From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH]: Bug in ppc32 ld.so
Date: Fri, 10 May 2002 20:33:20 +0200
Message-Id: <20020510183320.32333@smtp.wanadoo.fr>
In-Reply-To: <200205101830.DAA02518@mail.highway.ne.jp>
References: <200205101830.DAA02518@mail.highway.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On 10 May, Benjamin Herrenschmidt wrote:
>>
>>>Hi Anton,
>>>
>>>I saw:
>>>
>>>http://sources.redhat.com/ml/libc-alpha/2002-05/msg00052.html
>>>
>>>Thanks for posting that patch.  Have you by any chance alerted or sent
>>>similar mail to YDL dev lists, Debian dev lists, SuSE dev lists, and
>>>dev@linuxppc.
>>>
>>>This would be a nasty bug to track down and those distributions may want to
>>>know about this and get an udpated glibc-2.2.5 packages posted on their
>>>sites for those brave users who are using later 2.4 kernels?
>>>
>>>BTW, any idea when this change by Paul was introduced into the 2.4 kernel
>>>series (specifically which 2.4.XX kernel?).
>>
>> I submited a debian bug report with Anton message, Olaf (suse) is on
>> the linuxppc64 list and had the patch, YDL folks have or will have it
>> rsn (thanks to IRC magic ;)
>>
>
>just wait.

Well, I bet the guy who manage to actually _use_ such a hole is
probably an alien. I don't think you can seriously consider this
as a hole, but let's see how things go. In all cases, if that was
a security hole, then as Anton says, sparc64 and alpha are affected
too.

Let's fix ld.so, and separately see if the kernel bit is a security
hole or not.


>Kaoru
>-----------
>
>this is from geoffk
>> This is a potential security hole, it'd be better to fix it in the kernel.
>>
>
>> >From a performance viewpoint we do not want to icache synchronise all
>> zero pages we hand out. Its expensive. If a process creates code that
>> will be executed it should do the complete dcbst; sync; icbi; isync
>> sequence. I cant see how an application could gain information from a
>> stale icache, it cant read it.
>
>It can run it and look at the result.  That may be all the information
>it needs.
>
>Suppose, for instance, a process has generated an decryption function
>with the key embedded for performance reasons.  If this page gets
>swapped to disk, and then zeroed and handed to another process, and is
>still in the icache, then the new process has the ability to do a
>decryption it wouldn't otherwise be able to do.  It could be possible,
>under the right circumstances, for a malicious process to do this
>intentionally.
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
