Subject: Kernel TCP performance profiling (was Re: Help with string.S)
To: dan@embeddededge.com (Dan Malek)
Date: Fri, 18 Aug 2000 12:10:57 +1000 (EST)
Cc: dan@netx4.com,
        linuxppc-dev@lists.linuxppc.org (Linux PowerPC developers mailing list)
In-Reply-To: <399C3CD7.51CCB044@embeddededge.com> from "Dan Malek" at Aug 17, 2000 03:28:23 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000818021057.5347F219@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Graham Stoney wrote:
> .....  I've been doing some 2.2.13
> kernel profiling on the 860, and __copy_tofrom_user is coming up as a
> hotspot.

Dan Malek writes:
> In what kind of test?

Reading data from a TCP connected socket at full speed over the FEC and just
dropping it, to measure the maximum theoretical TCP throughput.  I added
/proc/profile support to the ppc kernel (it was missing) to see where the
time was going; the patch to do this is available at:
    http://members.xoom.com/greyhams/linux/patches/2.2/profile.patch

Here are the top ten functions output from readprofile:
  3490 total                                      0.0050
   972 csum_partial_copy_generic                  6.5676
   754 __copy_to_user                             2.4481
   129 do_lost_interrupts                         2.0156
   113 kfree                                      0.1519
    94 tcp_recvmsg                                0.0625
    85 kmalloc                                    0.1250
    74 alloc_skb                                  0.2534
    73 fec_enet_rx                                0.1393
    64 tcp_rcv_established                        0.0370
    62 tcp_v4_rcv                                 0.0686

The count values on the left are in jiffies, and those on the right are in
jiffies per instruction (I think real time would be more useful!).  I split
__copy_tofrom_user so it would appear seperately in the profile as
__copy_to_user and __copy_from_user.

It shows that almost half the time in TCP reception is consumed in:

1. checksuming & copying the data into the socket buffer in
   csum_partial_copy_generic (called from fec_enet_rx->eth_copy_and_sum->
   csum_partial_copy->csum_partial_copy_generic),
and
2. copying the result out to the user (called from sys_read->sock_read->
   sock_recvmsg->tcp_recvmsg->memcpy_toiovec->copy_to_user->__copy_to_user)

I've got this crazy idea that the FEC could DMA directly to the skb to
eliminate the first copy.  Pity the FEC can't calculate IP checksums for us,
but eliminating the copy should make it go faster even though tcp_v4_rcv
would then need to calculate the checksum in software.  Would you like to tell
me why this won't work before I spend hours trying to implement it? :-)

> > I tried dropping in the new improved version from
> > linux-2.4.0-test7-pre4, and none of the 8xx mods are in there: it'l only
> > work for 32 byte cache lines.
>
> Hmmm....I check it into the FSM BK tree a long time ago.

Anyone know how/when these propagate to the stuff on kernel.org?

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
