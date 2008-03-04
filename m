Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth15.prod.mesa1.secureserver.net (unknown [64.202.165.26])
	by ozlabs.org (Postfix) with SMTP id 4A511DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 10:34:52 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1516.1204637021.17968.linuxppc-embedded@ozlabs.org>
Subject: Virtual device hdlc0 asks to que packet!
Date: Tue, 4 Mar 2008 15:33:37 -0800
Message-ID: <000301c87e50$2bbdc680$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <mailman.1516.1204637021.17968.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

Background MPC8360, using a T1 PHY as an HDLC device.

Developing my hdlc driver, and was writing a simple send utility. To test it
out. Things seem well when I had massive delays in between the write() or
sendot(), and I was able to attain 100+Kbytes/sec. However, when I replaced
the simple usleeps(xxx) with select statements, suddenly I started getting a
ton of these messages.

"Virtual device hdlc0 asks to que packet!"

Along with dropped or non-sent data.

In my driver I am tracking the available TX buffers, and issue a
netif_stop_que() statement inside the start_xmit() call, with a
corresponding netif_wake_que() in the tx_handler.

Is there something else that needs to be done in order to make a select
statement wait for the socket to not be busy? It seems that it always
returns immediately with no timeout.

I guess the other pieces of the scenario are as follows:

* Using 'sethdlc hdlc0 hdlc' for the mode, so no IP stack is used.
* Opening the socket to the hdlc device directly to the device itself, i.e.
no port number socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

I have used both sendto() and write() to pass data down, and they both
return as if all the data has been sent, i.e. I never get an error.

-Russ
