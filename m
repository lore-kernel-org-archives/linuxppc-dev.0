Message-ID: <01C2089A.A7A920A0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Join Multicast returns error ENODEV
Date: Fri, 31 May 2002 11:59:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I call setsockopt(IP_ADD_MEMBERSHIP), it fails.

I had multicast Join/Leave working very well with enet.c, but have
recently changed to using fec.c.  All ethernet comm works very well.
But, there's a problem with multicast now.

My kernel is v2.2.13.  uP is MPC860T

Here's the flow I see:

    My App:              setsockopt(...,IP_ADD_MEMBERSHIP,...);

    Kernel:
    ip_sockglue.c:      ip_setsockopt()
                                   ip_mc_join_group()

    igmp.c:                    ip_mc_join_group()
                                       if (!imr->imr_ifindex)
                                         in_dev = ip_mc_find_dev(imr);
                                       if (!in_dev)
                                         {
                                         iml = NULL;
                                         err = -ENODEV;
                                         goto done;
                                         }

Would anyone have any ideas?

Thanks,

ShutEye Thinkin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
