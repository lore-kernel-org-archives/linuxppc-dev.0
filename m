Message-ID: <01C208B6.2C66F450.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Join Multicast returns error ENODEV
Date: Fri, 31 May 2002 15:16:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Before, when using enet.c,  I used to call setsockopt()
as follows (this worked fine):

  The 1st 4 bytes of tmp64 = the multicast addr 230.0.0.3
  The next 4 bytes of tmp64 = 0.0.0.0

  setsockopt(sd,IPPROTO_IP,IP_ADD_MEMBERSHIP,(const INT_8*) &tmp64,8);
	.
	.
	.
    if ((recLength = recvfrom(sd,(UINT_8*)
recBuff,sizeof(MSGPKT),MSG_DONTWAIT,(struct sockaddr*) 0,0)) > 0)
      {
      //Process recd pkt.
      }



Now, since using fec.c, I found that I can successfully call
setsockopt() if I put the local IP addr in the next 4 bytes as follows:

  The 1st 4 bytes of tmp64 = the multicast addr 230.0.0.3
  The next 4 bytes of tmp64 = 192.168.11.15

  setsockopt(sd,IPPROTO_IP,IP_ADD_MEMBERSHIP,(const INT_8*) &tmp64,8);
	.
	.
	.
    if ((recLength = recvfrom(sd,(UINT_8*)
recBuff,sizeof(MSGPKT),MSG_DONTWAIT,(struct sockaddr*) 0,0)) > 0)
      {
      //Process recd pkt.
      }


But, I never rec any pkts.


Any ideas, anyone?

Thanks,

ShutEye Thinkin



-----Original Message-----
From:	Steven Vacca [SMTP:svacca@valcom.com]
Sent:	Friday, May 31, 2002 12:00 PM
To:	LinuxEmbeddedMailList (E-mail)
Subject:	Join Multicast returns error ENODEV

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
