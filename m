Date: Wed, 3 Apr 2002 13:24:45 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 merge warning
Message-ID: <20020403132444.T6003@altus.drgw.net>
References: <20020402230411.G6003@altus.drgw.net> <15530.40918.517084.226235@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15530.40918.517084.226235@argo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Apr 03, 2002 at 04:23:18PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 03, 2002 at 04:23:18PM +1000, Paul Mackerras wrote:
> Troy Benjegerdes writes:
>
> > I'm getting close to a point where I want to start merging appropriate
> > things from the linuxppc_2_4_galileo tree on source.mvista.com into
> > 2_4_devel.
>
> I'll be interested to see it - I'm in code review mode at the moment. :)

Good, can you review drivers/char/gt64260_mpsc.{c,h} for me then?

I want to change the filenames to 'gt642xx_mpsc' in the hopes that the
same driver can be used on the MIPS gt64240 brige chips. Other than that,
I'd say this driver is ready to go..  It works and it's pretty clean.

>
> > The first thing I'm going to do is a moderately large cleanup to
> > drivers/net/gt64260_eth.c.
>
> Good.  Can you get rid of the config option for the MAC address?
> Please? :)  I suggest that we define a BI_MAC_ADDRESS bi_rec type
> which is used to pass in a default MAC address for the system, and we
> use that (single) MAC address for all the ethernet interfaces on the
> system which don't have any way to find out a MAC address for that
> specific interface.
>
> Paul.

Yeah, the config option needs to die. I'm waiting for

a) benh to get his new bi_rec implementation done,

b) get this damn driver working on SMP

Also, I'd need to have two BI_MAC_ADDRESS records, since I need to be able
to pass the mac addresses of both ethernets from the firmware for the
board I have.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
