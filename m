Date: Thu, 25 Feb 1999 14:30:40 -0800 (PST)
From: "Robert G. Werner" <rwerner@lx1.microbsys.com>
To: "sean o'malley" <somalley@ed.mde.state.mi.us>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Beowulf Who?
In-Reply-To: <v04003a05b2fb2d91923b@[204.22.210.180]>
Message-ID: <Pine.LNX.3.96.990225141405.10782F-100000@lx1.microbsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I like your idea of a large virtual machine (in fact that is the theory behind
one whole strand of clustering development).  Currnetly this can be done with a
specic kind of problem: i.e. one that breaks up in to nice chuncks that each
individual machine can work on whithout too much input from other machines.
Once you start doing any sort of processing where the individual boxes in the
cluster need to be exchanging lots of data constantly,  you would probably be
better off spending the money to dedicate one SMP box to the task. 
Again,  the big issue with problems that clusters address is not network
bandwidth.  In fact,  If I read the Beowulf howto correctly,  there are many
cases where increasing the bandwidth available to a cluster can drasticlaly
degrade its performance relative to the investment you just made in networking
HW.
Whatever the case,  you can treat a Beowulf cluster as a single virtual machine
for purposes of running some apps as it stands now.  This doesn't mean that all
of the memory in the cluster is pooled (networks aren't and won't ever be fast
enough for this IMHO).  But a program that is able to breakitself into numerous
sub chuncks can then send one of those chuncks to each node in the cluster for
actual processing.  This could work just dandy on a typical office lan with a
bunch of machines runing linux with the PVM libs and the Beowulf extensions.
With a bit of creative scripting,  you could easily dedicate unused processor
cycles to cluster tasks.  However,  this would only be useful,  really,  when
the network was quiet so that latencies (not bandwidth) were low and the
computers could rapidly pass messages back and forth.
Apple and others have talked big about how Firwire will make an intresting
Networking option.  I don't think so because by the time such HW is finalized
and implemented,  100/T ethernet will be very mature and GB ethernet may be
quite reasonable too.  
Price/performance of Ethernet is always going to be hard to beat because of its
wide use and off the shelf status.  Firewire hasn't even been convincingly
implemented as a storage transmission technology let alone a networking one.
Finally,  until Linux and other Unixen have drivers for Firewire, the whole
discussion of this technology for networking is moot anyway.

Robert G. Werner
rwerner@lx1.microbsys.com
Impeach Conggress!!

If the girl you love moves in with another guy once, it's more than enough.
Twice, it's much too much.  Three times, it's the story of your life.

On Thu, 25 Feb 1999, sean o'malley wrote:

> Okay, Im talking about a more sophisticated model than the basic clustering
> scenario you proposed.
[snip]


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
