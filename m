Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 64796DE151
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 04:31:21 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3995387wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 11:31:20 -0700 (PDT)
Date: Fri, 11 Jul 2008 12:31:17 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Juliana Su <js084@bucknell.edu>
Subject: Re: insmod: unresolved symbol XIo_In32/XIo_Out32
Message-ID: <20080711183117.GD15321@secretlab.ca>
References: <48776D93.5080504@bucknell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48776D93.5080504@bucknell.edu>
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

On Fri, Jul 11, 2008 at 10:26:27AM -0400, Juliana Su wrote:
> Hi,
>
> Is anybody familiar with the following error?
>
> insmod: unresolved symbol XIo_In32
> insmod: unresolved symbol XIo_Out32
>
> I am trying to write a device driver for a Custom IP and get it to run  
> on a Xilinx ML310's Linux OS. I am using Xilinx EDK 10.1 and MontaVista  
> Linux version 2.4.20_mvl31-ml300. I ran into this error when trying to  
> load my module into the kernel. When I try to load the module using  
> insmod on the ".o" file, the module refuses to load and gives me the  
> unresolved symbol error message. I actually stumbled upon an older  
> posting from June 2006 on this mailing list that described a similar  
> problem, but those suggestions did not help me. Maybe two years later,  
> there are more ideas/suggestions/solutions to this problem?

I can't help much with the 2.4 montavista kernel, but I can say that the
error means that the XIo_* helper routines are either not compiled into
the kernel or are not exported with EXPORT_SYMBOL().  The XIo_* routines
are hooks used by Xilinx cross platform device drivers to make the
actual accesses to hardware.  If they are not implemented, then you need
to create them yourself.

g.
