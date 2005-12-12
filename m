Return-Path: <simon@baydel.com>
Received: from anchor-fallback-96.mail.demon.net
	(anchor-fallback-96.mail.demon.net [194.217.242.83])
	by ozlabs.org (Postfix) with ESMTP id 00233688A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 05:04:35 +1100 (EST)
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:1756 "EHLO
	anchor-post-33.mail.demon.net") by anchor-fallback-96.mail.demon.net
	with ESMTP id S1158340AbVLLRFe (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Mon, 12 Dec 2005 17:05:34 +0000
Received: from [80.176.67.250] (helo=baydel-adsl.demon.co.uk)
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1Elr7C-00092Q-CW
	for linuxppc-embedded@ozlabs.org; Mon, 12 Dec 2005 17:05:31 +0000
From: Simon Haynes <simon@baydel.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 12 Dec 2005 17:26:34 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512121726.34944.simon@baydel.com>
Subject: ibm emac driver update 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am running a Ebony board with linux-2.6.12-rc1 and I amd having intermittent 
network problems. Having searched the archives it would seem that the driver
for the IBM EMAC is buggy ? 

I have tried to patch my kernel with 

http://kernel.ebsname.net/emac/4xx_napi_emac.diff

I believe this is almost a total driver re-write. Is this correct ?

After having a couple of problems applying the patch, Kconfig and 
ibm_emac_core.c. I fixed up the original code and applied the patch.

On compilation the build fails with missing references to kzalloc,
which I guess I could easily fix with kmalloc and memset. 

However there is also an undefined field,  dcr_base, in the ocp_func_mal_data
structure.  This structure appears to be defined in include/asm/ibm_ocp.h and 
this file does not appear to be changed by the patch. I guess this patch is 
for a later kernel.

Can anyone point me in the direction of a suitable patch for this kernel ?

Many Thanks

Simon.
