Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A581DDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 04:35:49 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l93IZiKq026643
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 14:35:44 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l93IZi0s428508
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 12:35:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l93IZhcE015357
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 12:35:44 -0600
Date: Wed, 3 Oct 2007 13:35:43 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: fix crash in rtas during early boot.
Message-ID: <20071003183543.GR4338@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


RTAS messages can occur very early during boot, before the error
message buffer has been allocated. The current code will lead to 
a null-pointer deref. Explicitly protect against this.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>
----

Andy Whitcroft's crash was appearently due to firmware complaining
about lost power, (actually, lost power supply redundancy!), which
occurred very early during boot. 

    Type                00000040 (EPOW)
    Status:             bypassed new
    Residual error from previous boot.
    EPOW Sensor Value:  00000002
    EPOW warning due to loss of redundancy.
    EPOW general power fault.

I've no clue why firmware thought it was OK to report this 
during one of the earliest calls to RTAS; I'm still investiigating 
that.

 arch/powerpc/platforms/pseries/rtasd.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/platforms/pseries/rtasd.c	2007-09-26 15:06:49.000000000 -0500
+++ linux-2.6.23-rc8-mm1/arch/powerpc/platforms/pseries/rtasd.c	2007-10-03 11:58:09.000000000 -0500
@@ -235,6 +235,12 @@ void pSeries_log_error(char *buf, unsign
 		return;
 	}
 
+	/* During early boot, the log buffer hasn't been allocted yet. */
+	if (rtas_log_buf == NULL) {
+		spin_unlock_irqrestore(&rtasd_log_lock, s);
+		return;
+	}
+
 	/* call type specific method for error */
 	switch (err_type & ERR_TYPE_MASK) {
 	case ERR_TYPE_RTAS_LOG:
