Message-ID: <3E3A3EE9.7000608@imc-berlin.de>
Date: Fri, 31 Jan 2003 10:16:25 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	laurent.pinchart@capflow.com
Subject: Re: was: FEC on MPC860T & race condition
References: <3E395B40.9090506@imc-berlin.de> <3E39898E.5060804@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> Steven Scholz wrote:
>
>> You, Laurent, told us about a race condition.
>> You, Dan, first claimed, it was already fix but mentioned later that
>> the patch
>> was somehow lost.
>
>
> IIRC, it was the usual problem of having it fixed in only one of the
> two 2.4 trees.  I ensured both trees were made up to date.
>

There is still no fix in linuxppc_2_4_devel!

>> Now I have this problem as well and realised that in 2.4.20 the
>> "mii_link_interrupt interrupt handler is still registered before the
>> PHY chip is initialized".
>
> The link interrupt is board design and PHY dependent.  I don't think there
> is any one "right" way to initialize this interrupt handler.  If you have
> something that isn't working to your liking, we may have to extend the
> MII logic in some way to accomodate this.  Keep in mind that the existing
> driver is likely working with other boards, and you don't want to break
> those configurations.

There is a race condition!
Lucky you if you never see it! :o)
But fair enough. If more people had this problem, the fix would be in the trees
by now.

How about adding something like CONFIG_FEC_LATE_ENABLE_PHY or so. Of course with
a help text in Documentation/Configure.help so that people having that problem
could easily enable that. And for the rest (although this might be the majority)
everythings stays as it it.


Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
