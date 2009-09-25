Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 183D6B7BA6
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 21:42:54 +1000 (EST)
Received: from mail.mta.it (mail.mta.it [89.96.171.250])
	by rly03a.srv.mailcontrol.com (MailControl) with ESMTP id
	n8PB73tu024296
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 12:07:04 +0100
Message-ID: <4ABCA454.5030807@mta.it>
Date: Fri, 25 Sep 2009 13:07:00 +0200
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: e300 (MPC5121) dlmzb
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was trying to insert an optimized strlen() function using the 
following code taken from the ibm site on an MPC5121, but it crashes the 
kernel.
Is it because it's an unsupported op, or because I'm missing some needed 
steps?

Thank you,
Matteo

_GLOBAL(strlen)
    addi   r4,0,8    // Load byte count of 8
    mtxer  r4        // Set byte count for load string
    xor    r4,r4,r4  // r4 = 0, r4 == accumulator
1:
    lswx   r5,r3,r4  // load string into r5 & r6
    dlmzb. r12,r5,r6 // find NULL byte and record in r7.
    add    r4,r4,r12 // Update accumulator.
    beq    1b        // Loop if NULL not found.
    addi   r3,r4,-1  // Subtract 1 for NULL byte.
    blr              // Return length
