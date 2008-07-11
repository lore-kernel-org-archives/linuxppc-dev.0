Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id E85E9DE1C3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 07:05:18 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4035697wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 14:05:16 -0700 (PDT)
Date: Fri, 11 Jul 2008 15:05:14 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Juliana Su <js084@bucknell.edu>
Subject: Re: insmod: unresolved symbol XIo_In32/XIo_Out32
Message-ID: <20080711210514.GB18239@secretlab.ca>
References: <48776D93.5080504@bucknell.edu>
	<20080711183117.GD15321@secretlab.ca>
	<4877B04A.8090801@bucknell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4877B04A.8090801@bucknell.edu>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 03:11:06PM -0400, Juliana Su wrote:
> Hi,
>
> Thanks for your reply! I am new to creating loadable kernel modules, so  
> I hope you do not mind some more questions... How can I get the XIo_*  
> helper routines to compile into the kernel or export them with  
> EXPORT_SYMBOL( )? In my c file (my driver file from which I create the  
> object file), I made sure to include xio.h, which is where XIo_In32 and  
> XIo_Out32 are defined (see below section from xio.h).

Add an EXPORT_SYMBOL() line to the location where the io accessors are
implemented.  However, you'd probably be better just to replace xio.h
implementation with macros that just map them to the in_be32() and
out_be32() macros.

g.
