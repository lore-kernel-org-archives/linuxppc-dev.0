From: Jesper Skov <jskov@cygnus.co.uk>
Message-ID: <13982.64423.455552.730846@lassi.cygnus.co.uk>
Date: Fri, 15 Jan 1999 08:26:15 +0000 (GMT)
To: Cort Dougan <cort@persephone.cs.nmt.edu>
Cc: Alan Cox <alan@cymru.net>, linuxppc-dev@lists.linuxppc.org,
        Jes.Sorensen@cern.ch, linux-apus@sunsite.auc.dk
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
In-Reply-To: <Pine.LNX.3.96.990114145156.7359A-100000@persephone.cs.nmt.edu>
References: <199901142052.UAA24588@snowcrash.cymru.net>
	<Pine.LNX.3.96.990114145156.7359A-100000@persephone.cs.nmt.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Cort" == Cort Dougan <cort@persephone.cs.nmt.edu> writes:

Cort> That's my rationale for doing the sync and eieio in the mb().
Cort> That way, we're guaranteed no races no matter what assumptions
Cort> someone makes about the x86 when adding barriers to their driver
Cort> code.  Is that unreasonable?

Cort> Alan} x86 and most other processors dont have the notion of a store
Cort> Alan} barrier and an i/o barrier beign different

IMHO, it is unreasonable. Why should the majority of PPC drivers run
with suboptimal performance because of bad programmer assumptions?

I'd suggest changing mb() (or whatever an appropriate name would be)
to 'eieio'. MP code and generic drivers that expect inter-CPU
synchronization to happen when using this macro should be fixed.


...but then, what do I know? :)

Jesper

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
