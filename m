Message-ID: <29963-82182@sneakemail.com>
Date: Fri, 11 Jun 2004 09:07:13 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Head of linuxppc-2.4 broekn by davem patch
References: <1086934906.4820.2.camel@lucy.pep-kaufbeuren.de>
In-Reply-To: <1086934906.4820.2.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nickl Stefan.Nickl-at-kontron.com |PPC Linux Embedded| wrote:
> I already sent this patch to the list and to "davem" who
> commited the faulty version, but nobody seems to care...

Here is the exact same patch, packaged slightly differently
and re-sent, just in case it got lost in someone's inbox.
It is also possible that davem is thinking in terms of
changing the sk_buff definition t match this file. Either
way, something must be done.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/11 09:00:55-07:00 steve@wing.XXXXXXXXXX
#   The sk_rcvbuf member does not exist in struct sk_buff
#   as declared in linux-2.4 skbuff.h.
#
# net/ipv4/tcp_input.c
#   2004/06/11 09:00:53-07:00 steve@wing.XXXXXXXXXX +2 -2
#   The sk_rcvbuf member does not exist in struct sk_buff
#   as declared in linux-2.4 skbuff.h.
#
diff -Nru a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c      2004-06-11 09:01:35 -07:00
+++ b/net/ipv4/tcp_input.c      2004-06-11 09:01:35 -07:00
@@ -476,8 +476,8 @@
                                   16 + sizeof(struct sk_buff));
                         space *= rcvmem;
                         space = min(space, sysctl_tcp_rmem[2]);
-                       if (space > sk->sk_rcvbuf)
-                               sk->sk_rcvbuf = space;
+                       if (space > sk->rcvbuf)
+                               sk->rcvbuf = space;
                 }
         }


--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
