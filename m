Return-Path: <brking@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1132167DC5
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 10:57:09 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kABNv3LC010529
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 18:57:03 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kABNv3cB299780
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 16:57:03 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kABNv2x0013267
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 16:57:02 -0700
Message-ID: <4556631C.1070308@us.ibm.com>
Date: Sat, 11 Nov 2006 17:56:12 -0600
From: Brian King <brking@us.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: ipr SATA support is causing problems
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>	<45549962.108@us.ibm.com>
	<17749.1504.630761.341652@cargo.ozlabs.ibm.com>
In-Reply-To: <17749.1504.630761.341652@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: James.Bottomley@SteelEye.com, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	akpm@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> How hard would it be to make the SATA bits conditionally compiled in,
> depending on CONFIG_ATA?

I took a look at doing this. It got a bit messy with a bunch of ifdefs,
then I realized that doing this would break module dependencies. If
ipr does not depend on CONFIG_ATA, then libata will not automatically
get loaded (or built into initrd's) when ipr is needed.

The best way I can see to accomplish your desired goal is to do something
like the fusion driver did and separate out the sas bits from the scsi
bits and essentially end up with multiple ipr modules. Unfortunately,
this is not 2.6.19 material, but I could start working on it if you
thought it sounded like a reasonable direction.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
