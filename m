Date: Tue, 12 Dec 2000 15:59:51 +0100 (CET)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: "'linux-ppc Mailing-List'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Chaning multiple FECs into a loop?
In-Reply-To: <8B43573754BCD211B5970008C74B8126010F774B@RENEXCH3.rennes.thmulti.com>
Message-ID: <Pine.BSF.4.21.0012121533560.24656-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not to familiar with ethernet devices so I simply ask here.
We will soon have eight XPC855T controller boards in tight
confinement running off batteries. We need to synchronize these
controllers through ethernet broadcasts. We would rather not have
a hub embedded in there and seeking alternatives we se that the
TDK PHY can be put in `repeater´ mode where Rx is forwarded to Tx.

The documentation states that this can not be performed in full
duplex and something about collision detection between the Rx
data and MII data. I interpret that as the PHY will still operate
in half duplex mode interrupting Rx->Tx forwarding as soon as there
is data incoming over tha MII interface.

The question is, if we hook up the loop like illustrated below,
will this work with the PHY in repeater mode or will this be
oscillating and hence jamming itself?


+---> (uC[0]Rx , uC[0]Tx) -+
|                          |
| +------------------------+
| |
| +-> (uC[1]Rx , uC[1]Tx) -+
|                          |
| +------------------------+
| |
| +->         ...         -+
|                          |
| +------------------------+
| |
| +-> (uC[7]Rx , uC[7]Tx) -+
|                          |
+--------------------------+

--

  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
