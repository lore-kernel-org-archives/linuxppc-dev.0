Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1C2D1A1647
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 19:04:44 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 86F661402B6
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 19:04:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 18:04:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 039833578073
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 19:04:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB284eBv23199920
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 19:04:40 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB284dkJ024389
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 19:04:40 +1100
Message-ID: <547D728C.5070306@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 13:34:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH V3] powerpc, powernv: Add OPAL platform event driver
References: <1416921665-15855-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1416921665-15855-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2014 06:51 PM, Anshuman Khandual wrote:
> This patch creates a new OPAL platform event character driver
> which will give userspace clients the access to these events
> and process them effectively. Following platforms events are
> currently supported with this platform driver.
> 
> 	(1) Environmental and Power Warning (EPOW)
> 	(2) Delayed Power Off (DPO)
> 
> The user interface for this driver is /dev/opal_event character
> device file where the user space clients can poll and read for
> new opal platform events. The expected sequence of events driven
> from user space should be like the following.
> 
> 	(1) Open the character device file
> 	(2) Poll on the file for POLLIN event
> 	(3) When unblocked, must attempt to read PLAT_EVENT_MAX_SIZE size
> 	(4) Kernel driver will pass at most one opal_plat_event structure
> 	(5) Poll again for more new events
> 
> The driver registers for OPAL messages notifications corresponding to
> individual OPAL events. When any of those event messages arrive in the
> kernel, the callbacks are called to process them which in turn unblocks
> the polling thread on the character device file. The driver also registers
> a timer function which will be called after a threshold amount of time to
> shutdown the system. The user space client receives the timeout value for
> all individual OPAL platform events and hence must prepare the system and
> eventually shutdown. In case the user client does not shutdown the system,
> the timer function will be called after the threshold and shutdown the
> system explicitly.
> 
> Reviewed-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Changes in V3:
> - Rebased the patch against the mainline
> 
> Changes in V2:
> - Changed the function fetch_dpo_timeout
> - Export opal_platform_events.h for user space consumption
> - Posted here https://patchwork.ozlabs.org/patch/396725/
> 
> Original V1:
> - Original patch
> - Posted here http://patchwork.ozlabs.org/patch/394340/

Hey Michael,

Do you have any updates on this patch yet ? Thanks !
