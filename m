Message-ID: <40F466C5.5010202@rossvideo.com>
Date: Tue, 13 Jul 2004 18:48:37 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: James Perkins <james@loowit.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: early UART mapping in head_44x.S
References: <40F452D6.9020806@rossvideo.com> <40F4621F.1000206@loowit.net>
In-Reply-To: <40F4621F.1000206@loowit.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


James Perkins wrote:

> ori won't clear the invalid bits, it just "or"s in the TS bit itself.
> What suprises me is that TLB 1 is being written twice. It may make more
> sense to change the second case
>
>         li      r0,1            /* TLB slot 1 */
>
> to
>        li      r0,2             /* TLB slot 2 */
>
> So that there is both a TS=0 and a TS=1 mapping, in TLB entry index 1
> and 2, respectively -- this will catch both the MSR[DS]=0 and MSR[DS]=1
> cases.

Yes I see now.  Your suggestion also works, and it seems more logical -
though I doubt anything in the early startup would ever do an access in
TS=1 virtual space... shortly after this the real MMU init is done and
it will overwrite all of these temporary mappings...

-Ralph

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
