Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 035132BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 10:06:23 +1100 (EST)
Message-ID: <41BA2F63.8060305@mvista.com>
Date: Fri, 10 Dec 2004 16:21:07 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
References: <41B9A33A.21673.5DDD7F64@localhost>
In-Reply-To: <41B9A33A.21673.5DDD7F64@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Write Combining on PowerPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kendall Bennett wrote:

[snip]

> Does anyone know if it is possible to do something similar to Write 
> Combining for the PowerPC architecture, to speed up CPU access to the 
> linear framebuffer?

Yes, it is possible. First you will need to enable Store Gathering for 
the Sandpoint's MPC107 bridge. (Go to Platform options->Enable MPC10x 
store gathering). You will then need to set the page protections for the 
video memory such that _PAGE_GUARDED is removed. The hardware will not 
store gather to an area mapped guarded. There appears to be some code to 
support this in the PCI MMap routines, but I'm not familiar with the 
details.

		Randy Vinson
