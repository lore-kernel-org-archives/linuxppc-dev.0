Message-ID: <20010304210838.2272.qmail@kunk.jriver.com>
Subject: unregister netdevice problem in 2.4.x
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 4 Mar 2001 15:08:38 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a problem with rebooting the 2.4 kernels. As it going
down, it gets all the way to the reboot then spits out the following:

Please Standby While Rebooting the System.
unregister_netdevice: waiting for ax3 to become free: usage count=24
.

Repeats the unregister message once evey 10 secs or so.
Needless to say it never reboots. The usage count varies and
seems fairly random.

Now this kernel is using the ax25 driver and with the
latest versions of ax25 tools and utils. The system normally
has about 600 entries in the routing tables (it's a amprnet gateway).
There are 2 ethernet interfaces, 4 ax25 interfaces, a tunnel
interface and a ppp async interface.

Here is the ax25 exit code...

static void __exit ax25_exit(void)
{
        proc_net_remove("ax25_route");
        proc_net_remove("ax25");
        proc_net_remove("ax25_calls");
        ax25_rt_free();
        ax25_uid_free();
        ax25_dev_free();

        ax25_unregister_sysctl();
        unregister_netdevice_notifier(&ax25_dev_notifier);

        dev_remove_pack(&ax25_packet_type);

        sock_unregister(PF_AX25);
}

and a comment from net/core/dev.c

 *              Andrew Morton   :       Make unregister_netdevice wait indefinitely on dev->refcnt


I'm wondering if this is pointing to a deeper problem that I need
to dig out instead of doing the easy hack.

Any suggestions?

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
