Message-Id: <200209051304.IAA10208@lists.linuxppc.org>
From: "" <slowforce@zju.edu.cn>
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 05 Sep 2002 21:00:55 +0800
Reply-To: "" <slowforce@zju.edu.cn>
Subject: ATM issue: one Host Four Nodes
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
We just have such a system to build.
                                ________
                                |      |
                            RX  | ATM  |_TX____________________________
  |---------------------------->| HOST |                              |
  |                             |      |                              |
  |                             |______|                              |
  |                                                                   |
  |      ________       ________        ________       ________       |
  |      |      |       |      |        |      |       |      |       |
  |   TX | ATM  | RX  TX| ATM  | RX   TX| ATM  | RX  TX| ATM  |  RX   |
  |------| NODE |<------| NODE |<-------| NODE |<------| NODE |<------|
         |      |       |      |        |      |       |      |
         |______|       |______|        |______|       |______|
             A              B               C              D
It's used to perform high speed data acqusition.
ATM HOST -- a pc with an ATM card
ATM NODE -- MPC860 with linux-2.4.4

The ATM HOST is responisble for sending controlling information to ATM NODEs
and receiving data from each NODEs.
The ATM NODE is responsible for performing data acqusition.

As the diagram show,ATM NODEs are connected one after another.
we use one VPI/VCI to identify one ATM NODE, so if the ATM HOST send the
control message to ATM NODE D, the message will touch  ATM NODE A、B、C first,
then ATM NODE D. In order to improve the system capacity and efficiency,
the ATM NODE A、B、C should ignore this message(not parse it) and send it
to the next node, in another words, this message should be bypassed in low
level(e.g. PHY level) by ATM NODE A、B、C. How can i get this point?
Any advice will be greatly appreciated!
Best Regards!
Li


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
