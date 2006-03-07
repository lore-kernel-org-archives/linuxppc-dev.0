Return-Path: <kevinko@arlut.utexas.edu>
Received: from ns4.arlut.utexas.edu (ns4.arlut.utexas.edu [207.200.28.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A6F8679E2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 09:13:01 +1100 (EST)
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	by ns4.arlut.utexas.edu (8.13.4/8.13.4) with ESMTP id k27LGE61055802
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 15:16:14 -0600 (CST)
Received: from ns5.arlut.utexas.edu (ns5.arlut.utexas.edu [10.4.1.6])
	by ns2.arlut.utexas.edu (8.13.4/8.13.4) with ESMTP id k27LG9FA047590
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Mar 2006 15:16:10 -0600 (CST)
Received: from mohave.arlut.utexas.edu (mohave.arlut.utexas.edu [10.8.16.38])
	by ns5.arlut.utexas.edu (8.13.4/8.13.4) with ESMTP id k27LG88D049353
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 7 Mar 2006 15:16:09 -0600 (CST)
Date: Tue, 7 Mar 2006 15:16:08 -0600 (CST)
From: Kevin Kleinosowski <kevinko@arlut.utexas.edu>
To: linuxppc-embedded@ozlabs.org
Subject: 440gx dma transfer with no data change at dest
Message-ID: <Pine.LNX.4.64.0603071505110.21479@mohave.arlut.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I am running a simple test with a software initiated DMA transfer from one 
bigphysarea allocated buffer to another bigphysarea allocated buffer. 
The destination buffer shows no data changes once the transfer is done.

However, I perform the same simple test using __get_dma_pages() rather 
then the bigphysarea_alloc_pages() and the destination does get the 
data transfer.

Is there a reason this should fail for bigphysarea?  I understand the low 
memory addresses needed for the DMA controller on some platforms, but I 
didnt think that limitation existed on the PPC.  Besides that, the 
bigphysarea returns low memory address anyway.  Anyone have an idea why? 
An old archive email had someone with a similar problem, but there were no 
follow-ups to the message.

I have linux 2.4.27-pre3 patched, ppc-linux-gcc (GCC) 3.3.3 (DENX ELDK 
3.1.1 3.3.3-9), U-Boot 1.1.2, and GMS 440gx board.

thanks,
Kevin
