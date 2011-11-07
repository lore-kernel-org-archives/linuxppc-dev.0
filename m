Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 694A1B6F80
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 21:52:46 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <bounces@nabble.com>) id 1RNMVx-0008QS-GL
 for linuxppc-dev@ozlabs.org; Mon, 07 Nov 2011 02:33:17 -0800
Message-ID: <32788715.post@talk.nabble.com>
Date: Mon, 7 Nov 2011 02:33:17 -0800 (PST)
From: suggest <harshalshete@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: suspecting ibm_newemac driver problem.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello All,

I am using ppc460ex based custom board.
using linux 2.6.30.2 kernel on this board it has ibm_newemac driver in it.

I am using this board as a iSCSI target which has RAID system behind it.

                                               ||
                                               ||                    ||                      
||
      n/w driver (ibm_newemac)    ||    n/w layer   ||    iSCSI Target  ||  
RAID
                                               ||                    ||                      
||

The problem i am facing is when i start iometer based i/o.
I am doing i/o with following specifications.

Workload type : All in one.
no of outstanding i/o : 32.
no of worker threads : 8.

With this kind of workload n/w stucks in between. and board becomes
unresponsive.
If i try to ping to the board then ping fails with 100% packet loss.

While debugging the issue i found out that
sock->sk_state_change callback is called from the TCP layer and state of the
socket is not TCP_ESTABLISHED in the iSCSI target driver.

So i am assuming that this is a problem related to n/w driver.

Did anyone faced similar kind of issue before? Please point me in right
direction.


Thanks and Regards,
Harshal Shete.
-- 
View this message in context: http://old.nabble.com/suspecting-ibm_newemac-driver-problem.-tp32788715p32788715.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
