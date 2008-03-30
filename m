Return-Path: <dwilson@fulcrummicro.com>
Received: from smtp.fulcrummicro.com (smtp.fulcrummicro.com [66.59.247.212])
	by ozlabs.org (Postfix) with ESMTP id 15987DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Mar 2008 12:23:29 +1000 (EST)
Received: from [192.168.4.42] (rrcs-64-183-149-178.west.biz.rr.com
	[64.183.149.178])
	by smtp.fulcrummicro.com (Postfix) with ESMTP id B4A88548358
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Mar 2008 19:13:52 -0700 (PDT)
Message-ID: <47EEF75B.2080506@fulcrummicro.com>
Date: Sat, 29 Mar 2008 19:13:47 -0700
From: Dan Wilson <dwilson@fulcrummicro.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 8543 console baud rate change problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are using ELDK 4.1, linux kernel 2.6.22 on an 8543 board with a Layer 
2 switch on it (i.e., the actual packet switching is done in an external 
chip, not by the 8543 itself).  One of our customers has encountered a 
strange issue with system console baud rate changes.  The system console 
is connected to a UART port on the 8543.


Here is the sequence of events:

+ powercycle unit at 115200

+ have ping session going
+ establish telnet session
+ have L2 traffic traversing the switch

+ switch baud rate to any other baud rate beside 38400
+ hit a few returns
+ switch baud rate back to 115200 and no problem

+ switch baud rate to 38400
+ type a few char
+ switch baud rate back to 115200
+ console is not responsive

+ existing ping session is still going
+ L2 traffic is still OK
+ telnet session disconnected and can not reconnect;
   telnet session is being served by linux ip stack

+ Had to power cycle to get everything back


Thanks!

Dan
