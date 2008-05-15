Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CE3D7DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 10:16:15 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4F0CvbL002188
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 20:12:57 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4F0G9PC079096
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 18:16:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4F0G8CP027562
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 18:16:09 -0600
Date: Wed, 14 May 2008 17:16:07 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] list_for_each_rcu must die: networking
Message-ID: <20080515001607.GB20811@linux.vnet.ibm.com>
References: <20080424033849.GA4401@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080424033849.GA4401@linux.vnet.ibm.com>
Cc: shemminger@vyatta.com, kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	adobriyan@gmail.com, akpm@linux-foundation.org,
	balbir@linux.vnet.ibm.com, davem@davemloft.net, sri@us.ibm.com
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All uses of list_for_each_rcu() can be profitably replaced by the
easier-to-use list_for_each_entry_rcu().  This patch makes this change
for networking, in preparation for removing the list_for_each_rcu()
API entirely.

Updated to remove the two now-unused variables as noted by Dave Miller,
and also to fix my bonehead error detected by Kamalesh Babulal and
Alexey Dobriyan.  It now passes LTP on POWER.  And also has valid SOB.
Some days it just doesn't pay to get out of bed...

Acked-by: David S. Miller <davem@davemloft.net> (lkml.org/lkml/2008/4/23/448)
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 802/psnap.c     |    4 +---
 ipv4/af_inet.c  |    9 +++------
 ipv6/af_inet6.c |    9 +++------
 3 files changed, 7 insertions(+), 15 deletions(-)

diff -urpNa -X dontdiff linux-2.6.26-rc2/net/802/psnap.c linux-2.6.26-rc2-lfer-net/net/802/psnap.c
--- linux-2.6.26-rc2/net/802/psnap.c	2008-04-16 19:49:44.000000000 -0700
+++ linux-2.6.26-rc2-lfer-net/net/802/psnap.c	2008-05-14 13:38:13.000000000 -0700
@@ -30,11 +30,9 @@ static struct llc_sap *snap_sap;
  */
 static struct datalink_proto *find_snap_client(unsigned char *desc)
 {
-	struct list_head *entry;
 	struct datalink_proto *proto = NULL, *p;
 
-	list_for_each_rcu(entry, &snap_list) {
-		p = list_entry(entry, struct datalink_proto, node);
+	list_for_each_entry_rcu(p, &snap_list, node) {
 		if (!memcmp(p->type, desc, 5)) {
 			proto = p;
 			break;
diff -urpNa -X dontdiff linux-2.6.26-rc2/net/ipv4/af_inet.c linux-2.6.26-rc2-lfer-net/net/ipv4/af_inet.c
--- linux-2.6.26-rc2/net/ipv4/af_inet.c	2008-05-14 13:35:32.000000000 -0700
+++ linux-2.6.26-rc2-lfer-net/net/ipv4/af_inet.c	2008-05-14 13:46:26.000000000 -0700
@@ -267,7 +267,6 @@ static inline int inet_netns_ok(struct n
 static int inet_create(struct net *net, struct socket *sock, int protocol)
 {
 	struct sock *sk;
-	struct list_head *p;
 	struct inet_protosw *answer;
 	struct inet_sock *inet;
 	struct proto *answer_prot;
@@ -284,13 +283,12 @@ static int inet_create(struct net *net, 
 	sock->state = SS_UNCONNECTED;
 
 	/* Look for the requested type/protocol pair. */
-	answer = NULL;
 lookup_protocol:
 	err = -ESOCKTNOSUPPORT;
 	rcu_read_lock();
-	list_for_each_rcu(p, &inetsw[sock->type]) {
-		answer = list_entry(p, struct inet_protosw, list);
+	list_for_each_entry_rcu(answer, &inetsw[sock->type], list) {
 
+		err = 0;
 		/* Check the non-wild match. */
 		if (protocol == answer->protocol) {
 			if (protocol != IPPROTO_IP)
@@ -305,10 +303,9 @@ lookup_protocol:
 				break;
 		}
 		err = -EPROTONOSUPPORT;
-		answer = NULL;
 	}
 
-	if (unlikely(answer == NULL)) {
+	if (unlikely(err)) {
 		if (try_loading_module < 2) {
 			rcu_read_unlock();
 			/*
diff -urpNa -X dontdiff linux-2.6.26-rc2/net/ipv6/af_inet6.c linux-2.6.26-rc2-lfer-net/net/ipv6/af_inet6.c
--- linux-2.6.26-rc2/net/ipv6/af_inet6.c	2008-05-14 13:35:32.000000000 -0700
+++ linux-2.6.26-rc2-lfer-net/net/ipv6/af_inet6.c	2008-05-14 13:45:08.000000000 -0700
@@ -87,7 +87,6 @@ static int inet6_create(struct net *net,
 	struct inet_sock *inet;
 	struct ipv6_pinfo *np;
 	struct sock *sk;
-	struct list_head *p;
 	struct inet_protosw *answer;
 	struct proto *answer_prot;
 	unsigned char answer_flags;
@@ -101,13 +100,12 @@ static int inet6_create(struct net *net,
 		build_ehash_secret();
 
 	/* Look for the requested type/protocol pair. */
-	answer = NULL;
 lookup_protocol:
 	err = -ESOCKTNOSUPPORT;
 	rcu_read_lock();
-	list_for_each_rcu(p, &inetsw6[sock->type]) {
-		answer = list_entry(p, struct inet_protosw, list);
+	list_for_each_entry_rcu(answer, &inetsw6[sock->type], list) {
 
+		err = 0;
 		/* Check the non-wild match. */
 		if (protocol == answer->protocol) {
 			if (protocol != IPPROTO_IP)
@@ -122,10 +120,9 @@ lookup_protocol:
 				break;
 		}
 		err = -EPROTONOSUPPORT;
-		answer = NULL;
 	}
 
-	if (!answer) {
+	if (err) {
 		if (try_loading_module < 2) {
 			rcu_read_unlock();
 			/*
