Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F09918D.5070202@tataelxsi.co.in>
Date: Mon, 07 Jul 2003 20:58:13 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel hangs after serving interrupt
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We are facing a strange problem in mpc8260, linux kernel 2.4.1
I have written drivers for mpc8260 MCC. We are in the process of testing
them.
We are getting  a machine freeze after some 40k-50k write operations.
I have checked all the control paths, they are as follows.
1. Application (pppd)issue  a write call, traverses through kernel ppp
implementation and finally gets resolved to write() to the MCC controller.
2. As soon as the write call adds the buffer to the outgoing buffers, Tx
happens.
3. Tx interrupt handler is called which frees up the written data.
4. Tx interrupt handler returns.

Rx will happen as data is recieved. Rx and Tx runs with spin locks
acquired. And synchronization safe.

We traced the path using prink(). The board hangs after Tx interrupt
comlete or Rx complete interrupt. i.e, after printing "returning from Tx
" or "returning from Rx".
This hang is not present until some significant amount of time is passed
with heavy traffic.

Anybody faced any similar problems with kernel 2.4.1?
Any pointers/suggestions will be greatly apreciated.
Thanks,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
