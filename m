Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C123A67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 18:32:07 +1000 (EST)
Date: Tue, 14 Jun 2005 09:31:56 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Samuel Osorio Calvo" <samuel.osorio@nl.thalesgroup.com>
Message-Id: <20050614093156.38297bbf.ajz@cambridgebroadband.com>
In-Reply-To: <s2adccfe.092@scms1.sc.signaal.nl>
References: <s2adccfe.092@scms1.sc.signaal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: multicast disabled on 8260_io/fcc_enet.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mon, 13 Jun 2005 18:14:06 +0200
"Samuel Osorio Calvo" <samuel.osorio@nl.thalesgroup.com> wrote:

> Hi all!
> 
> I was playing with a mpc8260 board and the latest ELDK version, 3.1.1
> (linux 2.4.25) and face a strange behaviour:
> 
> I was trying to make multicast work and everything seemed to be ok
> (/proc/net/igmp, /proc/net/dev_mcast), making a local ping to
> 224.0.0.1 returns localhost as part of the group, etc....BUT it was
> not possible to contact the board to the group it had joined from the
> network. I was digging into the kernel drivers and found a strange
> return statement just in teh start of the funciton set_multicast_list
> (arround line 1471 of the file mentioned in the subject of the mail).
> I moved the return to the end of the function and everything worked
> perfectly.
> 
> My question is wether the return statement was moved at the starting
> of the function due to some bug of the set_multicast_list code or it
> was just a typo???
> 


According to

	http://ozlabs.org/pipermail/linuxppc-embedded/2005-May/018529.html

it would seem that multicast is not correctly implemented and has been
effectively commented out.  This also stops promisc mode working.  I
have removed the return in my source tree and promisc mode now works
fine. I can't say whether multicast works.  Maybe you could just give it
a try and see what happens....

Alex
