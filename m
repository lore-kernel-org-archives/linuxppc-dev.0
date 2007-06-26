Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9ECF0DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 03:12:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l5QH7fca004151
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 13:07:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5QHCewi207334
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 11:12:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5QHCdje026968
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 11:12:39 -0600
Subject: Re: Katmai w/ DENX git - "init has generated signal 4" error
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Winiecki <stevewin@us.ibm.com>
In-Reply-To: <OFBF408254.9B235C85-ON87257306.0057DC6C-85257306.0057F0B4@us.ibm.com>
References: <OFBF408254.9B235C85-ON87257306.0057DC6C-85257306.0057F0B4@us.ibm.com>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 12:12:38 -0500
Message-Id: <1182877959.19501.17.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-26 at 12:02 -0400, Stephen Winiecki wrote:
> > I'm using the Denx linux-2.6-denx.git repository with a Katmai board. I 
> > want to boot off a disk (initialized w/ Debian 4.0).  I've installed a 
> > Promise Ultra133 Tx2 IDE controller card in the PCI slot, and configured 
> 
> > it in the kernel.    I boot this same disk w/ IDE card on other 4xx 
> boards 
> > without a problem (Bamboo w/ Denx 4.1 for example).  I am getting an 
> error 
> > "init has generated signal 4 but has no handler for it".
> 
> I believe the problem may be due to lack of HW FP on the processor(?). 
> Copying an embedded 440 RFS on disk works OK.

Signal 4 is SIGILL, which could be returned for float instructions I
suppose.  Try turning on CONFIG_MATH_EMULATION in your kernel config for
Katmai and see if the problem goes away.

josh
