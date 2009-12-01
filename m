Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C049C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 04:22:32 +1100 (EST)
Received: from mail.mta.it (mail.mta.it [89.96.171.250])
	by rly06a.srv.mailcontrol.com (MailControl) with ESMTP id
	nB1GivYt002746
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2009 16:45:17 GMT
Message-ID: <4B1547E5.6050301@mta.it>
Date: Tue, 1 Dec 2009 17:44:21 +0100
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Recommended functions for accessing internal registers
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I see that throughout the kernel source, internal PPC registers are 
accessed through [in|out]_be[32|16|8]() functions. However, they are 
translated into 3 inline assembly instructions, one of which is an 
isync, which has a huge performance hit.
I tried using readl_be() which seems to be the right function according 
to the Documentation/ dir, but it is translated directly to in_be32(), 
so no luck.

Is it really necessary to use all those instructions? I know I could use 
a (volatile u32 *) variable to avoid subsequent read/writes to be 
optimized out, but it seems to be a deprecated use.

Thank you in advance,
Matteo
