Return-Path: <stern@rowland.harvard.edu>
Received: from ida.rowland.org (ida.rowland.org [192.131.102.52])
	by ozlabs.org (Postfix) with SMTP id D6B1767A6D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2005 05:53:56 +1100 (EST)
Date: Thu, 17 Mar 2005 13:47:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0503171343450.855-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Make sleep/wakeup work with USB on
 powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Mar 2005, Paul Mackerras wrote:

> I am currently using this patch on my powerbook to fix the problems
> that USB was causing with sleep and wakeup.  Basically one of the USB
> controllers was getting a spurious wakeup immediately when put it
> into the suspend state.  This would cause the resume routine to be run
> after we had turned off the device, causing a machine check.

Is this just a hardware glitch or does it go deeper?

> Also we had some races where we would turn off the clock to the apple
> OHCI cell(s) and then try to access them.  With this patch, sleep and
> wakeup are quite reliable.  The patch is against 2.6.11.

Aside from the ppc-specific portions, the changes you made to hcd-pci.c 
resemble those I just posted in

http://lists.osdl.org/pipermail/linux-pm/2005-March/000616.html

(meant for the gregkh-2.6 USB development tree).

Alan Stern
