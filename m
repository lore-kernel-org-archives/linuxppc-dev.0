Return-Path: <chandru@in.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F18C0DEA64
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 02:51:23 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6PGocwJ008755
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 02:50:38 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6PGpNQ91712212
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 02:51:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6PGpMEa024397
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 02:51:22 +1000
From: Chandru <chandru@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4][V2] powerpc : add support for linux,
	usable-memory properties for drconf memory
Date: Fri, 25 Jul 2008 22:21:18 +0530
References: <200807080014.24910.chandru@in.ibm.com>
	<200807221431.49268.chandru@in.ibm.com>
	<18565.42340.817405.289271@cargo.ozlabs.ibm.com>
In-Reply-To: <18565.42340.817405.289271@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807252221.19389.chandru@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 22 July 2008 14:46:20 Paul Mackerras wrote:
> Chandru writes:
> 
> > Scan for linux,usable-memory properties in case of dynamic reconfiguration 
> > memory . Support for kexec/kdump.
> > 
> > Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
> 
> Could we *please* have a more comprehensive patch description that
> that?  Something which will help people coming along in two (or five
> or ten) years time to understand what problem exists in the code, how
> this patch solves it, and why this approach was chosen over any
> alternative approaches?
> 
> Thanks,
> Paul.
> 

Another alternate approach could be to create one 'linux,usable-drconf-memory' property and add all the usable memory regions into it, in a similar fashion to ibm,dynamic-memory property. For a given lmb in ibm,dynamic-memory , a corresponding usable-memory entry could be created which will contain 1 or more of (base,size) duple.  For each entry in this new 'linux,usable-drconf-memory' property, a counter within it will tell us how many (base,size) duple are available in it.  Some part of the current code may get duplicated. Let me go back and check if I can work on a patch for this approach .  

thx,
Chandru  
