From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Date: Sat, 23 Nov 2002 19:25:12 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
Message-ID: <20021124022512.GA13886@cuzco.az.mvista.com>
References: <20021121215050.GD6090@cuzco.az.mvista.com> <3DDD5924.3030506@embeddededge.com> <20021121221241.GE6090@cuzco.az.mvista.com> <3DDD5DE9.4030404@embeddededge.com> <20021121231855.GF6090@cuzco.az.mvista.com> <15838.54248.574661.759367@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15838.54248.574661.759367@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 23, 2002 at 12:03:36PM +1100, Paul Mackerras wrote:
> IMO you are right in thinking that we need to try to copy bytes one at
> a time after we get a read fault.  I think I would do the extra byte
> copy loop inline after the 99: label instead of jumping back the way
> you do.

By the time we get to 99:, r4 has already been zeroed.  We need to
insert the byte copy at 104:.  Now, to figure out how to do that without
duplicating code...  I won't be able to spend time on it until Monday.

Note that we also need to handle an unaligned fault in the initial
and final word copy loops.

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
