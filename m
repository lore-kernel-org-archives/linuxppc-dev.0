Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25910DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 21:13:45 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	l3DBDPNN023694
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Apr 2007 12:13:25 +0100
Message-ID: <461F65E3.1050004@computing.dundee.ac.uk>
Date: Fri, 13 Apr 2007 12:13:39 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Tri-mode auto-negotiation on ML405
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

Dear all,

I have the Xilinx TEMAC (kind of) working on an ML405 using an adapter.c 
file posted by Rick Moleres on 8th Feb 2007.  However, there are some 
serious issues with auto-negotiation:
1. link negotiation at startup is *very* slow - in the order of ten seconds
2. if no network is detected at the boot time the auto-negotiation runs 
through 1G, 100M, 10M before giving up.  I guess this leaves the PHY in 
a 10M state.  When I plug a link in the PHY says 10M.  I have 100M and 
1G links available (but no 10M link) neither work.
3. if a link is present boot time the auto-negotiation correctly chooses 
the link speed and the link appears to function.  If I unplug the link 
and replace it with a different speed the link will not function.  If 
the original link was 100M, the PHY identifies a 1G link as 100M and it 
does not work.  If the original link was 1G the PHY gives up altogether 
and no link is detected.
I guess this all makes sense: it just means that the PHY is not 
auto-negotiating the link speed.

Being a newbie at this and really not knowing what I am doing I tried 
adding a call to set_mac_speed in poll_gmii where a link carrier is 
detected (after it prints "link carrier restored").  This successfully 
renegotiated the link speed when a link was inserted, but only in 
certain cases.  If the link first inserted was 100M, or if there was no 
link present an inserted link of either 100M or 1G would renegotiate 
fine.  After having a 100M link, inserting a 1G link would *say* it had 
renegotiated, the PHY lights up and tells me the link is running at 1G, 
but nothing works.  Also, whenever this negotiation is going on, 
everything grinds to a halt.  After having a 1G link, inserting a 100M 
link would result in the PHY not even picking up the link, as before. 

I'm clearly barking up the wrong tree here, please can someone tell me 
The Right Way?

Many thanks in advance,
-- Peter


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
MailScanner thanks transtec Computers for their support.
