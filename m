Date: Fri, 26 Feb 1999 00:16:21 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: "sean o'malley" <somalley@ed.mde.state.mi.us>
cc: "Robert G. Werner" <rwerner@lx1.microbsys.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Beowulf Who?
In-Reply-To: <v04003a05b2fb2d91923b@[204.22.210.180]>
Message-ID: <Pine.LNX.4.04.9902260008030.2737-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Feb 1999, sean o'malley wrote:

> 
> Okay, Im talking about a more sophisticated model than the basic clustering
> scenario you proposed.
> I think for your model maybe TCP/IP would be better.
> 
> I thinking something a bit more sophisticated and it may in fact it maybe
> called something quite different =)
> 
> what about a virtual computer that runs on the network, but is non-existent
> as an individual machine. It is made up of the entire network.. You can
> submit jobs to it and it will process them with the available resources of
> the entire network.
> 
> In this model with a firewire backbone, you basically use the network as
> the machines bus you can drop harddrives on the network as well as stack of
> ram (of which you dont need tcp/ip to utilize ie you give your harddrive an
> ip number? *ponders*)  The virtual machine will basically steal individual
> cycles from machines to process its information.  Not in big chunks but in
> rather tiny chunks thus the worry about network overhead.

The think about fast and Gigabit ethernet is the cheap availability of
*switches* which allow machines to use the full bandwidth available on a
100 MB link to talk to any other machine connected to the switch. This
also improves latency since the machine doesn't have to wait until
everyone else quits talking.

Now, if you want to drop extra disks on the Network, look at Fibre channel
and UMN's GFS filesystem. One can also get Fibre Channel switches so
scaling the size of a cluster is easy. http://gfs.lcse.umn.edu/

Until there are Firewire switches, I don't see it as much use for
clusters.

> 
> Basically its taking the SMP model and exploding it to a network.
> 
> No, it wont be as efficient as an SMP machine, nor as fast.  But lets say
> you work in an office building with 400 people and they each have their own
> computer.  You could get a lot of extra juice out of say your secretary's
> machine while she is off on lunch or taking a phone call or while your
> talking to her.
> 

It sounds like what you're actually thinking of is transparent process
migration and load balancing.. Take a look at
http://www.cnds.jhu.edu/mirrors/mosix/

> You also couldnt use TCP/IP for this model either because there is no
> "real" machine its existence is all the parts of the network, not one
> aspect of it.  You dont really want to assign harddrives IP numbers nor
> would you want to assign it to blocks of ram or scanners on the network
> when in fact you dont need them..
> 
> And yes I realize it is probably more impractical at this stage than
> functional, but it would be cool. =)
> 
> Sean
> 
> 
> >I'm sorry,  but I don't understand what you mean about Firewire begging for
> >clustering.  It is an interesting technology in concept but it hasn't been
> >implemented for much of anything but some cameras and maybe a hard drive or
> >two.  I know we are no where near having firwire working under Linux.
> >I think you will find that Firwire doesn't have a Price/performance ratio that
> >is adnvantageious over 100mb Ethernet and later Gb ethernet.  That technology
> >has been implemented,  is relatively mature and works under nearly all OSs.
> >Let's not get confused here,  paralale processing works best when each
> >node can
> >be given a chunk of the problem and associated data and then left alone.
> >Every
> >time the cluster has to hit the network for anything more than a small
> >message,
> >we lose performance relative to an SMP machine (internal data busses are
> >always
> >going to be faster than going out to the network).  Huge bandwidth isn't
> >really
> >the biggest constraint with clusters.  Breaking up the problem correctly is
> >much more important.
> >
> >Just because you use Firewire doesn't mean you aren't going to use TCP/IP.
> >That is up to the drivers and what your basic networking stack can support.  I
> >may be wrong on this but I haven't heard anything about Firewire requiring a
> >different protocol.  Seems like it would be a lot of work to make one up too,
> >especially as we have a very nice TCP/IP stack in Linux.
> >
> >Robert G. Werner
> >rwerner@lx1.microbsys.com
> >Impeach Conggress!!
> >
> >If the girl you love moves in with another guy once, it's more than enough.
> >Twice, it's much too much.  Three times, it's the story of your life.
> >
> >On Thu, 25 Feb 1999, sean o'malley wrote:
> >
> >[snip]
> 
> 
> 
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
